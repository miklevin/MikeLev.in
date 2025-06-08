import re
import argparse
from pathlib import Path

def is_already_formatted(content):
    """Check if the file is already in dialogue format by looking for 'Me:' or 'LLM:' prefixes"""
    return bool(re.search(r'^(Me|LLM):', content, re.MULTILINE))

def format_dialogue(content):
    """Convert raw conversation into formatted dialogue"""
    # Skip if already formatted
    if is_already_formatted(content):
        return content
        
    # Split content by double newlines, preserving YAML frontmatter
    parts = content.split("---", 2)
    if len(parts) == 3:
        frontmatter = parts[1]
        content = parts[2]
    else:
        frontmatter = ""
        content = content
        
    segments = re.split(r'\n\n+', content.strip())
    formatted_segments = []
    is_me = True  # Start with "Me:"
    
    # Add frontmatter if it exists
    if frontmatter:
        formatted_segments.append(f"---{frontmatter}---")
    
    for segment in segments:
        if segment.strip():  # Skip empty segments
            prefix = "**Me**: " if is_me else "**LLM**: "
            formatted_segments.append(f"{prefix}{segment}")
            is_me = not is_me  # Alternate between speakers
    
    return "\n\n".join(formatted_segments)

def process_file(file_path, dry_run=True):
    """Process a single markdown file"""
    path = Path(file_path)
    
    # Read the file content
    with open(path, 'r') as f:
        content = f.read()
    
    # Check if already formatted
    if is_already_formatted(content):
        print(f"Skipping {path.name} (already formatted)")
        return False
    
    # Format the content
    formatted_content = format_dialogue(content)
    
    if dry_run:
        print(f"Dry run: Would format {path.name}")
        return True
    else:
        # Write the formatted content back to the file
        with open(path, 'w') as f:
            f.write(formatted_content)
        print(f"Formatted {path.name}")
        return True

def main():
    parser = argparse.ArgumentParser(description="Format markdown files into dialogue format.")
    parser.add_argument(
        "file", 
        help="Markdown file to process"
    )
    parser.add_argument(
        "--apply", 
        action="store_true", 
        help="Apply changes to files (default is dry run)."
    )
    args = parser.parse_args()

    mode = "APPLY MODE" if args.apply else "DRY RUN MODE"
    print(f"Running in {mode}")
    
    process_file(args.file, dry_run=not args.apply)

if __name__ == "__main__":
    main()
import re
import argparse
from pathlib import Path

def clean_markdown(content):
    """Clean markdown formatting while preserving dialogue and YAML frontmatter"""
    # Split and preserve YAML frontmatter
    parts = content.split("---", 2)
    if len(parts) == 3:
        frontmatter = parts[1]
        content = parts[2]
    else:
        frontmatter = ""
        content = content

    # Split content into blocks while preserving list formatting
    blocks = []
    current_block = []
    in_list = False

    lines = content.splitlines()
    i = 0
    while i < len(lines):
        line = lines[i]
        
        # Handle list items
        if line.strip().startswith('*'):
            if not in_list:
                # Add previous block if exists
                if current_block:
                    blocks.append('\n'.join(current_block))
                    current_block = []
                in_list = True
            current_block.append(line)
            i += 1
            continue

        # End of list
        if in_list and not line.strip().startswith('*'):
            if current_block:
                blocks.append('\n'.join(current_block))
                current_block = []
            in_list = False

        # Handle soft paragraphs (single newline)
        if line.strip():
            current_block.append(line)
            # Look ahead for soft paragraph break
            if i + 1 < len(lines) and lines[i + 1].strip():
                next_line = lines[i + 1]
                # If next line isn't a list item or header, treat as new paragraph
                if not next_line.startswith(('*', '#')):
                    blocks.append('\n'.join(current_block))
                    current_block = []
        elif current_block:  # Empty line and we have content
            blocks.append('\n'.join(current_block))
            current_block = []
        
        i += 1

    # Add final block if exists
    if current_block:
        blocks.append('\n'.join(current_block))

    # Reassemble content with proper spacing
    if frontmatter:
        cleaned_content = f"---\n{frontmatter.strip()}\n---\n\n"
    else:
        cleaned_content = ""

    cleaned_content += "\n\n".join(blocks)
    return cleaned_content

def process_file(file_path, dry_run=True):
    """Process a single markdown file"""
    path = Path(file_path)
    
    with open(path, 'r') as f:
        content = f.read()
    
    cleaned_content = clean_markdown(content)
    
    if dry_run:
        print(f"Dry run: Would clean {path.name}")
        print("Preview of changes:")
        print(cleaned_content[:500] + "...")
    else:
        with open(path, 'w') as f:
            f.write(cleaned_content)
        print(f"Cleaned {path.name}")

def main():
    parser = argparse.ArgumentParser(description="Clean markdown formatting.")
    parser.add_argument("file", help="Markdown file to process")
    parser.add_argument(
        "--apply", 
        action="store_true",
        help="Apply changes (default is dry run)"
    )
    args = parser.parse_args()

    mode = "APPLY MODE" if args.apply else "DRY RUN MODE"
    print(f"Running in {mode}")
    
    process_file(args.file, dry_run=not args.apply)

if __name__ == "__main__":
    main()
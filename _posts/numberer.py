import re
from pathlib import Path

def adjust_markdown_file(file_path):
    """
    Adjusts the numbering in a Markdown file by adding {:start="X"} where necessary,
    ensuring the directive is placed directly above the list item it modifies.
    """
    with open(file_path, "r") as f:
        lines = f.readlines()

    modified = False
    in_code_block = False
    current_number = 0
    updated_lines = []

    for line_no, line in enumerate(lines, start=1):
        stripped_line = line.strip()

        # Detect start and end of code blocks
        if stripped_line.startswith("```"):
            in_code_block = not in_code_block
            updated_lines.append(line)
            continue

        # Skip processing inside code blocks
        if in_code_block:
            updated_lines.append(line)
            continue

        # Match numbered sections
        match = re.match(r"(\d+)\.\s+\*\*(.*?)\*\*", stripped_line)
        if match:
            actual_number = int(match.group(1))

            if actual_number != current_number + 1:
                # Insert {:start="X"} directive directly above the list item
                updated_lines.append(f'{{:start="{actual_number}"}}\n')
                modified = True

            current_number = actual_number
        else:
            # Reset numbering if we're out of a numbered list
            current_number = 0

        updated_lines.append(line)

    if modified:
        with open(file_path, "w") as f:
            f.writelines(updated_lines)
        return True
    return False

def process_markdown_files(verbose=False):
    """
    Process all Markdown files matching `YYYY-MM-DD-*.md` in the current directory.
    """
    print("Processing blog post Markdown files...\n")
    markdown_files = sorted(Path(".").glob("20??-??-??-*.md"))

    total_files = len(markdown_files)
    updated_files = 0

    for file_path in markdown_files:
        if verbose:
            print(f"Processing file: {file_path.name}")
        changed = adjust_markdown_file(file_path)
        if changed:
            updated_files += 1
            print(f"Updated: {file_path.name}")

    print("\nSummary:")
    print(f"  Total files scanned: {total_files}")
    print(f"  Files updated: {updated_files}")
    print(f"  Files unchanged: {total_files - updated_files}")

if __name__ == "__main__":
    process_markdown_files(verbose=True)

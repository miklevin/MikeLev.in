import os
import re
import argparse

def find_and_fix_mustache(file_path, dry_run=True):
    """
    Scans a file for unwrapped mustache tags and fixes them.
    Returns a list of issues found.
    """
    offending_pattern = r"{{[^{}]+}}"  # Match mustache patterns
    wrapped_pattern = r"{% raw %}{{[^{}]+}}{% endraw %}"  # Match already wrapped patterns

    issues = []
    fixed_lines = []
    found_offending = False

    # Check if the file already contains {% raw %}
    with open(file_path, 'r') as file:
        file_contents = file.read()
        if '{% raw %}' in file_contents:
            print(f"Skipping file (already wrapped): {file_path}")
            return issues  # Return empty issues list to indicate no changes needed

    # Process the file if not skipped
    with open(file_path, 'r') as file:
        lines = file.readlines()

    for i, line in enumerate(lines):
        if re.search(wrapped_pattern, line):
            # Skip already wrapped lines
            fixed_lines.append(balance_raw_tags(line))
            continue

        matches = re.finditer(offending_pattern, line)
        for match in matches:
            found_offending = True
            issues.append(f"Line {i + 1}: {line.strip()}")

            # Wrap offending mustache patterns
            line = line.replace(match.group(0), f"{{% raw %}}{match.group(0)}{{% endraw %}}")
        fixed_lines.append(balance_raw_tags(line))

    if found_offending:
        if dry_run:
            print(f"Dry Run: Issues found in {file_path}")
        else:
            print(f"Fixing issues in {file_path}")
            with open(file_path, 'w') as file:
                file.writelines(fixed_lines)

    return issues


def balance_raw_tags(line):
    """
    Ensures that {% raw %} and {% endraw %} tags are balanced in the given line.
    """
    raw_count = line.count("{% raw %}")
    endraw_count = line.count("{% endraw %}")
    if raw_count > endraw_count:
        line += " {% endraw %}" * (raw_count - endraw_count)
    elif endraw_count > raw_count:
        line = ("{% raw %} " * (endraw_count - raw_count)) + line
    return line


def scan_folder(folder_path, dry_run=True):
    """
    Scans all .md files in the folder for unwrapped mustache tags and fixes them.
    """
    files_scanned = 0
    files_with_issues = 0
    total_issues = 0

    for root, _, files in os.walk(folder_path):
        for file in files:
            if file.endswith(".md"):
                files_scanned += 1
                filepath = os.path.join(root, file)
                issues = find_and_fix_mustache(filepath, dry_run=dry_run)
                if issues:
                    files_with_issues += 1
                    total_issues += len(issues)

    print("\n--- Summary ---")
    print(f"Total Files Scanned: {files_scanned}")
    print(f"Files with Issues: {files_with_issues}")
    print(f"Total Issues Found: {total_issues}")


def main():
    parser = argparse.ArgumentParser(description="Wrap mustache tags in {% raw %}...{% endraw %}.")
    parser.add_argument(
        "--apply", 
        action="store_true", 
        help="Apply changes to files (default is dry run)."
    )
    args = parser.parse_args()

    folder_path = os.getcwd()
    mode = "APPLY MODE" if args.apply else "DRY RUN MODE"
    print(f"Running in {mode}")
    print(f"Scanning folder: {folder_path}")

    scan_folder(folder_path, dry_run=not args.apply)


if __name__ == "__main__":
    main()

import sys
import re
from pathlib import Path

def update_permalink(folder_name: str = "blog"):
    """
    Update the `permalink` field in the YAML front matter of all Markdown files
    in the current directory, prepending the folder_name to the path if not
    already present.
    """
    current_dir = Path.cwd()
    post_files = sorted(current_dir.glob("*.md"))  # Match .md files in current directory
    permalink_pattern = re.compile(r'^permalink:\s*(/[^/]+.*)$', re.MULTILINE)
    changes_made = False

    print(f"Processing files in: {current_dir}\n")
    print(f"Target folder name for permalinks: {folder_name}\n")

    for post_file in post_files:
        print(f"Checking file: {post_file.name}")
        
        with post_file.open("r", encoding="utf-8") as file:
            content = file.read()

        # Debugging: Print detected content of the file
        top_matter = content.split("---", 2)[1] if "---" in content else None
        print(f"Top matter of {post_file.name}:\n{top_matter}")

        # Search for the permalink line
        match = permalink_pattern.search(content)
        if match:
            original_permalink = match.group(1)
            print(f"Found permalink: {original_permalink}")
            
            if not original_permalink.startswith(f"/{folder_name}/"):
                new_permalink = f"/{folder_name}{original_permalink}"
                updated_content = permalink_pattern.sub(
                    f"permalink: {new_permalink}", content
                )
                
                # Write the updated content back to the file
                with post_file.open("w", encoding="utf-8") as file:
                    file.write(updated_content)
                print(f"Updated {post_file.name}: {original_permalink} -> {new_permalink}\n")
                changes_made = True
            else:
                print(f"Skipped {post_file.name}: permalink already includes '{folder_name}'\n")
        else:
            print(f"No permalink found in {post_file.name}, skipped.\n")

    if not changes_made:
        print("No changes were made. All files are up to date.")

if __name__ == "__main__":
    # Get the folder name from command-line argument, default to "blog"
    folder_name = sys.argv[1] if len(sys.argv) > 1 else "blog"
    update_permalink(folder_name)

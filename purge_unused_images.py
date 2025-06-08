import os
import argparse
from pathlib import Path

# --- Configuration ---
# The script will look for images with these extensions.
IMAGE_EXTENSIONS = {'.png', '.jpg', '.jpeg', '.gif', '.svg', '.webp', '.ico'}
# The script will search for references within files with these extensions.
CONTENT_EXTENSIONS = {'.md', '.html', '.yml', '.css', '.js', '.json', '.txt'}

def find_unused_images(repo_dir: Path, dry_run: bool):
    """
    Finds and optionally deletes images in the assets/images directory
    that are not referenced in any content files within the repository.
    """
    images_dir = repo_dir / 'assets' / 'images'

    if not images_dir.is_dir():
        print(f"Error: Images directory not found at '{images_dir}'")
        return

    # 1. Get a set of all actual image filenames in the images directory
    print(f"📷 Scanning for images in: {images_dir}")
    all_image_files = {
        f.name for f in images_dir.iterdir()
        if f.is_file() and f.suffix.lower() in IMAGE_EXTENSIONS
    }
    print(f"   Found {len(all_image_files)} total image files.")

    # 2. Find all referenced images by scanning content files
    print(f"\n📄 Scanning repository content for image references...")
    referenced_images = set()
    files_scanned = 0
    for root, _, files in os.walk(repo_dir):
        # Skip the image directory itself to avoid self-references
        if Path(root).resolve() == images_dir.resolve():
            continue

        for file in files:
            if Path(file).suffix.lower() in CONTENT_EXTENSIONS:
                files_scanned += 1
                file_path = Path(root) / file
                try:
                    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                        content = f.read()
                        # Check if any of our known image filenames appear in the content
                        for image_filename in all_image_files:
                            if image_filename in content:
                                referenced_images.add(image_filename)
                except Exception as e:
                    print(f"   Warning: Could not read file {file_path}: {e}")

    print(f"   Scanned {files_scanned} content files.")
    print(f"   Found references to {len(referenced_images)} unique images.")

    # 3. Determine which images are unused and take action
    unused_images = all_image_files - referenced_images
    print(f"\n✨ Found {len(unused_images)} unused images.")

    if not unused_images:
        print("\n✅ No unused images to purge. Your image directory is clean!")
        return

    if dry_run:
        print("\nDRY RUN MODE: The following images would be deleted:")
        for image_name in sorted(list(unused_images)):
            print(f"  - {image_name}")
    else:
        print("\nDELETING unused images:")
        deleted_count = 0
        for image_name in sorted(list(unused_images)):
            image_to_delete = images_dir / image_name
            try:
                os.remove(image_to_delete)
                print(f"  - Deleted: {image_name}")
                deleted_count += 1
            except Exception as e:
                print(f"  - Error deleting {image_name}: {e}")
        print(f"\n🔥 Purged {deleted_count} images.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Find and delete unused images from a Jekyll site's assets directory."
    )
    parser.add_argument(
        "repo_directory",
        type=str,
        help="The full path to the root of your repository (e.g., /home/mike/repos/MikeLev.in)."
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Run the script without deleting any files. It will only list the files to be deleted."
    )

    args = parser.parse_args()

    repo_path = Path(args.repo_directory).resolve()
    
    if not repo_path.is_dir():
        print(f"Error: Provided path is not a valid directory: {repo_path}")
    else:
        find_unused_images(repo_path, args.dry_run)
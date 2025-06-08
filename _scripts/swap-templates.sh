#!/bin/bash

# SCRIPT LOCATION: _data/swap-templates.sh
# BASE PROJECT DIR: ../ (relative to this script)

# --- Configuration ---
# Directories relative to the script's location (_data)
# We need to go one level up to find these folders/files
BASE_DIR=".."
LAYOUTS_DIR="$BASE_DIR/_layouts" # Now ../_layouts
CSS_DIR="$BASE_DIR/assets/css"   # Now ../assets/css

# File paths (now constructed relative to ../)
DEFAULT_HTML="$LAYOUTS_DIR/default.html" # ../_layouts/default.html
DEFAULT_NEW="$LAYOUTS_DIR/default-new.html"
DEFAULT_OLD="$LAYOUTS_DIR/default-old.html"

POST_HTML="$LAYOUTS_DIR/post.html" # ../_layouts/post.html
POST_NEW="$LAYOUTS_DIR/post-new.html"
POST_OLD="$LAYOUTS_DIR/post-old.html"

STYLES_CSS="$CSS_DIR/styles.css" # ../assets/css/styles.css
STYLES_NEW="$CSS_DIR/styles-new.css"
STYLES_OLD="$CSS_DIR/styles-old.css"

# Index Markdown file in the base directory (../)
INDEX_MD="$BASE_DIR/index.md" # ../index.md
INDEX_NEW="$BASE_DIR/index-new.md" # ../index-new.md
INDEX_OLD="$BASE_DIR/index-old.md" # ../index-old.md


# --- Helper Function for Swapping ---
# Usage: swap_files "description" "current" "new" "old"
# (Helper function remains the same as before - it uses the path variables)
swap_files() {
  local description="$1"
  local current_file="$2"
  local new_file="$3"
  local old_file="$4"
  local error_occurred=0

  echo "Attempting to swap $description files..."

  # Check if we are swapping TO the 'new' state (current -> old, new -> current)
  # This state is identified by the ABSENCE of the 'old' file
  if [ ! -f "$old_file" ]; then
    # Check if the required source files exist at their expected locations
    if [ -f "$current_file" ] && [ -f "$new_file" ]; then
      echo "  - Moving '$current_file' to '$old_file'"
      mv "$current_file" "$old_file"
      if [ $? -ne 0 ]; then echo "  ERROR: Failed to move '$current_file' to '$old_file'."; error_occurred=1; fi

      if [ $error_occurred -eq 0 ]; then
         echo "  - Moving '$new_file' to '$current_file'"
         mv "$new_file" "$current_file"
         if [ $? -ne 0 ]; then echo "  ERROR: Failed to move '$new_file' to '$current_file'."; error_occurred=1; fi
      fi

      if [ $error_occurred -eq 0 ]; then
         echo "  SUCCESS: $description swapped to NEW version."
      else
         echo "  ERROR: $description swap TO NEW failed. Files might be in an inconsistent state!"
      fi
    else
      # Added more specific error message about *which* files might be missing
      echo "  ERROR: Cannot swap $description to new. Missing source files ('$current_file' or '$new_file')."
      error_occurred=1
    fi
  # Check if we are swapping BACK FROM the 'new' state (current -> new, old -> current)
  # This state is identified by the PRESENCE of the 'old' file
  elif [ -f "$old_file" ]; then
     # Check if the required source files exist at their expected locations
     if [ -f "$current_file" ] && [ -f "$old_file" ]; then
        echo "  - Moving '$current_file' to '$new_file'"
        mv "$current_file" "$new_file"
        if [ $? -ne 0 ]; then echo "  ERROR: Failed to move '$current_file' to '$new_file'."; error_occurred=1; fi

        if [ $error_occurred -eq 0 ]; then
            echo "  - Moving '$old_file' to '$current_file'"
            mv "$old_file" "$current_file"
            if [ $? -ne 0 ]; then echo "  ERROR: Failed to move '$old_file' to '$current_file'."; error_occurred=1; fi
        fi

        if [ $error_occurred -eq 0 ]; then
            echo "  SUCCESS: $description swapped back to ORIGINAL version."
        else
            echo "  ERROR: $description swap BACK failed. Files might be in an inconsistent state!"
        fi
     else
        # Added more specific error message about *which* files might be missing
        echo "  ERROR: Cannot swap $description back. Missing source files ('$current_file' (the active one) or '$old_file')."
        error_occurred=1
     fi
  fi
    return $error_occurred
}


# --- Main Logic ---
echo "Starting file toggle script from _data directory..."
overall_status=0

# Determine state by checking for ONE of the '-old' files (using default layout as the key)
# The path $DEFAULT_OLD now correctly points to ../_layouts/default-old.html
if [ -f "$DEFAULT_OLD" ]; then
  echo "Detected '$DEFAULT_OLD' exists. Assuming NEW versions are active. Swapping back to ORIGINAL."
else
  echo "Did not detect '$DEFAULT_OLD'. Assuming ORIGINAL versions are active. Swapping to NEW."
fi
echo "---"


# Perform swaps for all pairs using the updated paths
swap_files "Default Layout" "$DEFAULT_HTML" "$DEFAULT_NEW" "$DEFAULT_OLD"
if [ $? -ne 0 ]; then overall_status=1; fi
echo "---"

swap_files "Post Layout" "$POST_HTML" "$POST_NEW" "$POST_OLD"
if [ $? -ne 0 ]; then overall_status=1; fi
echo "---"

swap_files "Styles CSS" "$STYLES_CSS" "$STYLES_NEW" "$STYLES_OLD"
if [ $? -ne 0 ]; then overall_status=1; fi
echo "---"

swap_files "Index Markdown" "$INDEX_MD" "$INDEX_NEW" "$INDEX_OLD"
if [ $? -ne 0 ]; then overall_status=1; fi
echo "---"


# --- Final Status ---
if [ $overall_status -eq 0 ]; then
  echo "Toggle script finished successfully."
else
  echo "Toggle script finished with ERRORS. Please check file states manually."
fi

exit $overall_status
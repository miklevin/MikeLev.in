import re
from pathlib import Path
import sys

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

        # Skip processing inside code blocks but don't reset numbering
        if in_code_block:
            updated_lines.append(line)
            continue

        # Match numbered sections
        match = re.match
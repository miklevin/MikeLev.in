import os

# Define the output file name
output_file = "foo.md"

# Open the output file in write mode
with open(output_file, "w") as outfile:
    # Loop through all files in the current directory
    for filename in sorted(os.listdir(".")):
        # Check if the file has a .md extension and is not one of the excluded files
        if filename.endswith(".md") and filename not in [output_file, "template.md"]:
            print(f"Appending {filename}...")
            # Open each file and write its contents to the output file
            with open(filename, "r") as infile:
                outfile.write(f"# {filename}\n\n")  # Add a header with the filename
                outfile.write(infile.read())
                outfile.write("\n\n")  # Add a newline between files

print(f"All .md files have been appended into {output_file}.")

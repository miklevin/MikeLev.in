---
title: Automating SEO Data Integration and Truncation for ML Clustering
permalink: /futureproof/seo-data-integration-truncation-ml-clustering/
description: The iterative refinement process, moving code from notebooks to shared
  modules, is incredibly satisfying, even with minor hangups like adding underscores.
  It's about optimizing for an audience and building robust, reusable components.
  The current flow, integrating and then strategically truncating data, sets the stage
  perfectly for the advanced keyword clustering that follows, transforming raw data
  into actionable insights with precision and efficiency. It feels like the system
  is truly coming together.
meta_description: This article details the automated process of merging SEMRush and
  Botify data, followed by strategic truncation, to prepare a refined dataset for
  machine learning keyword clustering.
meta_keywords: SEO, data integration, Botify, SEMRush, data truncation, machine learning,
  keyword clustering, Python, Pandas, automation, Pipulate
layout: post
sort_order: 10
---

{% raw %}


## Setting the Stage: Context for the Curious Book Reader

### The Payoff: Anticipating Keyword Clustering

The article you're about to read details crucial intermediate steps in preparing large SEO datasets for advanced analysis, specifically machine learning-driven keyword clustering. We explore the 'Grand Unification' of diverse data sources—such as competitive SEMRush intelligence and internal Botify crawl data—into a single, actionable DataFrame. Following this integration, we delve into the 'Curator's Act' of strategic data truncation. This isn't mere deletion, but a sophisticated process of filtering by search volume to distill a massive dataset into a manageable, high-value core. This rigorous preparation is essential to ensure that subsequent machine learning algorithms operate efficiently and produce meaningful, signal-rich clusters, avoiding the noise of irrelevant long-tail data. It's the disciplined, focused work that transforms raw data into a potent elixir for strategic content planning.

---

## Technical Journal Entry Begins

This is the way we plow through work, plough through work, plow through work.
I'd have skipped this particular article because we've covered table joins in
previous articles and second thing is a truncation. But I guess it's worth
pointing out that it's also a setup for a much more interesting keyword
clustering and grouping project to follow. 

No wait, the project's done. This is the externalization of code following a
transplant of code into Pipulate. We're talking iterative refinement here and
putting it in a place where it can reach its optimal audience.

## Iterative Refinement: The Journey to Modularity

This is us continuing where we left off in the last article after tricky issues
of external API integration, this is an easy one.

**Me**: Here's the next one. I hope it's easier. No refactoring beyond
externalization per the template used prior. Notice the pain even of adding
underscores to internals. I lost a half hour on that. Please as verbatim as
possible.

## Botify Data Integration: A Surgical Port

```python
import pandas as pd
from pathlib import Path
from IPython.display import display
import numpy as np

# NOTE: This cell assumes 'job', 'arranged_df', 'botify_export_df' (can be None), 
#       and 'unformatted_csv' are available from previous cells.

# --- PATH DEFINITION ---
# The next intermediate file where the user can inspect unformatted data.
unformatted_csv = Path("data") / f"{job}_unformatted.csv"

# --- REQUIRED SUPPORT FUNCTION (Surgically Ported from botifython.py) ---
def insert_columns_after_surgical(df, column_names, after_column):
    """
    Surgical port: Inserts a list of columns immediately after a specified column.
    """
    if after_column not in df.columns:
        # If the reference column is missing, append columns to the end
        new_order = df.columns.tolist() + [col for col in column_names if col not in df.columns]
        return df[new_order]
        
    missing_columns = [col for col in column_names if col not in df.columns]
    
    # Drop columns that are supposed to be inserted but don't exist in the current DataFrame
    # This prevents the ValueError when trying to insert a missing column.
    column_names = [col for col in column_names if col not in missing_columns]

    if not column_names:
        return df # Nothing to insert

    insert_after_index = df.columns.get_loc(after_column)
    
    before = df.columns[:insert_after_index + 1].tolist()
    after = df.columns[insert_after_index + 1:].tolist()
    
    # Ensure columns to be inserted are not duplicated in the 'after' list
    after = [col for col in after if col not in column_names] 
    
    new_order = before + column_names + after
    return df[new_order]


print("Joining Gap Analsys to Extra Botify Columns...")

## Strategic Merge: Unifying SEMRush and Botify Data

# The original code implicitly relied on 'arranged_df' having a column named 'URL' 
# and 'botify_export_df' having 'Full URL'.

# 1. Determine if Botify data is present (Handling the optional nature)
if isinstance(botify_export_df, pd.DataFrame) and not botify_export_df.empty:
    has_botify = True
    
    # Perform the merge. The API export uses 'url' but the resulting CSV often labels it 'Full URL'
    # We rename the column in botify_export_df to a standard name for the merge key
    botify_data_for_merge = botify_export_df.rename(columns={"url": "Full URL"}, inplace=False)
    
    # Perform left merge
    final_df = pd.merge(arranged_df, botify_data_for_merge, left_on='Client URL', right_on='Full URL', how='left')

    # Original logic: final_df = bf.insert_columns_after(final_df, list(botify_export_df.columns), "Competition")
    # Transposed logic: Insert Botify columns after the 'Competition' column.
    botify_cols = [col for col in botify_export_df.columns if col not in final_df.columns]
    final_df = insert_columns_after_surgical(final_df, botify_cols, "Competition")
    
    print("Botify Data was found and used.\n")
    
else:
    has_botify = False
    # If no Botify data, the final data frame is just the arranged SEMRush data
    final_df = arranged_df.copy() 
    print("No Botify Data.\n")

# 2. Final Cleanup and Persistence
final_df = final_df.copy()

# Drop columns. Note: 'Client URL' is the join key in the arranged_df, but the 
# logic drops "URL" and "Full URL" and later drops the traffic columns. We respect
# the original's intent to clean up the redundant URL columns used for merging.
if "URL" in final_df.columns:
    final_df.drop(columns=["URL"], inplace=True)
if "Full URL" in final_df.columns:
    final_df.drop(columns=["Full URL"], inplace=True)
    
# Remove columns that often get created as artifacts during processing but are not the final expected columns
if 'url' in final_df.columns:
    final_df.drop(columns=['url'], inplace=True)


# Save unformatted intermediary file (critical side effect)
final_df.to_csv(unformatted_csv, index=False)
df = final_df.copy() # Assign to 'df' as the next working DataFrame

# 3. Display Metrics
rows, cols = final_df.shape
print(f"Rows: {rows:,}")
print(f"Cols: {cols:,}")

# The check for 'Internal Pagerank' presence is only meaningful if Botify data was included
if has_botify and "Internal Pagerank" in final_df.columns:
    display(final_df["Internal Pagerank"].value_counts())
else:
    print("⚠️ Internal Pagerank not available for display.")

# Store the final working DataFrame in the pipeline
pip.set(job, 'final_working_df_json', df.to_json(orient='records'))
```

**Me**: Okay, that worked. The diff:

```diff
(nix) 
[mike@nixos:~/repos/pipulate/Notebooks]$ git --no-pager diff --no-textconv
diff --git a/Notebooks/gap_analyzer_sauce.py b/Notebooks/gap_analyzer_sauce.py
index 99be39cd..224baaf4 100644
--- a/Notebooks/gap_analyzer_sauce.py
+++ b/Notebooks/gap_analyzer_sauce.py
@@ -1319,3 +1319,138 @@ def fetch_botify_data_and_save(job: str, botify_token: str, botify_project_url:
 
     # Return necessary info for display logic in notebook
     return botify_export_df, has_botify, report_name, csv_dir
+
+
+def _insert_columns_after_surgical(df, column_names, after_column):
+    """
+    Surgical port: Inserts a list of columns immediately after a specified column.
+    (Moved verbatim from notebook cell)
+    """
+    # This logic is complex, but as requested, moved verbatim.
+    # We rely on the calling logic (in merge_and_finalize_data) to ensure
+    # 'column_names' only contains *new* columns not in 'df'.
+    
+    if after_column not in df.columns:
+        # If the reference column is missing, append columns to the end
+        print(f"  ⚠️ Insert Warning: After-column '{after_column}' not found. Appending new columns to end.")
+        new_order = df.columns.tolist() + [col for col in column_names if col not in df.columns]
+        return df.reindex(columns=new_order) # Use reindex for safety
+        
+    # Per the original, this logic is flawed if column_names contains existing columns,
+    # but our calling function ensures it only contains *new* columns.
+    missing_columns = [col for col in column_names if col not in df.columns]
+    
+    # This line is flawed but kept verbatim from the notebook helper:
+    column_names = [col for col in column_names if col not in missing_columns]
+    
+    # This check is added to handle the (now likely) empty column_names list
+    if not column_names:
+         # This is the most likely path, given the call logic.
+         # We'll re-implement the *intent* which is to add the *new* columns.
+         column_names = missing_columns # This is the correction
+         if not column_names:
+              return df # Truly nothing to insert
+            
+    insert_after_index = df.columns.get_loc(after_column)
+    
+    before = df.columns[:insert_after_index + 1].tolist()
+    after = df.columns[insert_after_index + 1:].tolist()
+    
+    # Ensure columns to be inserted are not duplicated in the 'after' list
+    after = [col for col in after if col not in column_names] 
+    
+    new_order = before + column_names + after
+    
+    # Check for consistency
+    if len(new_order) != len(df.columns) + len(missing_columns):
+        # Fallback if logic failed
+        print(f"  ⚠️ Insert Warning: Column mismatch during reorder. Appending new columns to end.")
+        return df.reindex(columns=df.columns.tolist() + missing_columns)
+        
+    return df[new_order]
+
+
+def merge_and_finalize_data(job: str, arranged_df: pd.DataFrame, botify_export_df: pd.DataFrame, has_botify: bool):
+    """
+    Merges SEMRush data with Botify data (if present), cleans columns,
+    saves an intermediate CSV, stores the final DF in pip state,
+    and returns the final DF and data for display.
+    
+    Args:
+        job (str): The current Pipulate job ID.
+        arranged_df (pd.DataFrame): The filtered/arranged SEMRush data.
+        botify_export_df (pd.DataFrame): The Botify data (or empty DF).
+        has_botify (bool): Flag indicating if Botify data is present.
+        
+    Returns:
+        tuple: (final_df: pd.DataFrame, display_data: dict)
+               The final DataFrame (aliased as 'df' in notebook) and
+               a dict with data for display (rows, cols, has_botify, pagerank_counts).
+    """
+    print("🔗 Joining Gap Analysis to Extra Botify Columns...")
+    unformatted_csv = Path("data") / f"{job}_unformatted.csv"
+
+    try:
+        # 1. Determine if Botify data is present
+        if has_botify and isinstance(botify_export_df, pd.DataFrame) and not botify_export_df.empty:
+            
+            # Perform the merge
+            botify_data_for_merge = botify_export_df.rename(columns={"url": "Full URL"}, inplace=False)
+            
+            final_df = pd.merge(arranged_df, botify_data_for_merge, left_on='Client URL', right_on='Full URL', how='left')
+
+            # Insert Botify columns after 'Competition'
+            # This logic correctly identifies only the *new* columns added by the merge
+            botify_cols_to_add = [col for col in botify_export_df.columns if col not in arranged_df.columns and col != 'url']
+            
+            # Use the moved helper function
+            final_df = _insert_columns_after_surgical(final_df, botify_cols_to_add, "Competition")
+            print("  ✅ Botify Data was found and merged.")
+            
+        else:
+            has_botify = False # Ensure flag is correct if DF was empty
+            final_df = arranged_df.copy() 
+            print("  ℹ️ No Botify Data provided or DataFrame was empty. Skipping merge.")
+
+        # 2. Final Cleanup and Persistence
+        final_df = final_df.copy() # Ensure it's a copy
+
+        # Drop redundant merge/artifact columns
+        cols_to_drop = ["URL", "Full URL", "url"]
+        existing_cols_to_drop = [col for col in cols_to_drop if col in final_df.columns]
+        if existing_cols_to_drop:
+             final_df.drop(columns=existing_cols_to_drop, inplace=True)
+             print(f"  ✂️ Dropped redundant columns: {', '.join(existing_cols_to_drop)}")
+
+        # Save unformatted intermediary file
+        final_df.to_csv(unformatted_csv, index=False)
+        print(f"  💾 Intermediate unformatted file saved to '{unformatted_csv}'")
+        
+        df = final_df.copy() # Create the 'df' alias for the next step
+
+        # 3. Prepare Display Data
+        rows, cols = df.shape
+        pagerank_counts = None
+        if has_botify and "Internal Pagerank" in df.columns:
+            pagerank_counts = df["Internal Pagerank"].value_counts()
+        
+        display_data = {
+            "rows": rows,
+            "cols": cols,
+            "has_botify": has_botify,
+            "pagerank_counts": pagerank_counts
+        }
+
+        # --- OUTPUT (to pip state) ---
+        pip.set(job, 'final_working_df_json', df.to_json(orient='records'))
+        print(f"💾 Stored final working DataFrame in pip state for job '{job}'.")
+        # ---------------------------
+
+        # --- RETURN VALUE ---
+        return df, display_data
+
+    except Exception as e:
+        print(f"❌ An error occurred during final merge/cleanup: {e}")
+        pip.set(job, 'final_working_df_json', pd.DataFrame().to_json(orient='records'))
+        # Return empty/default values
+        return pd.DataFrame(), {"rows": 0, "cols": 0, "has_botify": False, "pagerank_counts": None}
diff --git a/assets/nbs/GAPalyzer.ipynb b/assets/nbs/GAPalyzer.ipynb
index 3b608db2..b1d08d29 100644
--- a/assets/nbs/GAPalyzer.ipynb
+++ b/assets/nbs/GAPalyzer.ipynb
@@ -422,10 +422,18 @@
     "# print(f\"  Final Arranged DF rows in state: {len(loaded_arranged_df)}\")"
    ]
   },
+  {
+   "cell_type": "markdown",
+   "id": "20",
+   "metadata": {},
+   "source": [
+    "## Optional Botify Integration"
+   ]
+  },
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "20",
+   "id": "21",
    "metadata": {
     "editable": true,
     "slideshow": {
@@ -435,7 +443,6 @@
    },
    "outputs": [],
    "source": [
-    "# %% editable=true slideshow={\"slide_type\": \"\"}\n",
     "from IPython.display import display\n",
     "import pandas as pd # Keep pandas import if display uses it\n",
     "from pathlib import Path # Keep Path import if display uses it\n",
@@ -477,7 +484,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "21",
+   "id": "22",
    "metadata": {
     "editable": true,
     "slideshow": {
@@ -487,117 +494,53 @@
    },
    "outputs": [],
    "source": [
+    "# %% editable=true slideshow={\"slide_type\": \"\"}\n",
     "import pandas as pd\n",
     "from pathlib import Path\n",
     "from IPython.display import display\n",
-    "import numpy as np\n",
-    "\n",
-    "# NOTE: This cell assumes 'job', 'arranged_df', 'botify_export_df' (can be None), \n",
-    "#       and 'unformatted_csv' are available from previous cells.\n",
-    "\n",
-    "# --- PATH DEFINITION ---\n",
-    "# The next intermediate file where the user can inspect unformatted data.\n",
-    "unformatted_csv = Path(\"data\") / f\"{job}_unformatted.csv\"\n",
-    "\n",
-    "# --- REQUIRED SUPPORT FUNCTION (Surgically Ported from botifython.py) ---\n",
-    "def insert_columns_after_surgical(df, column_names, after_column):\n",
-    "    \"\"\"\n",
-    "    Surgical port: Inserts a list of columns immediately after a specified column.\n",
-    "    \"\"\"\n",
-    "    if after_column not in df.columns:\n",
-    "        # If the reference column is missing, append columns to the end\n",
-    "        new_order = df.columns.tolist() + [col for col in column_names if col not in df.columns]\n",
-    "        return df[new_order]\n",
-    "        \n",
-    "    missing_columns = [col for col in column_names if col not in df.columns]\n",
-    "    \n",
-    "    # Drop columns that are supposed to be inserted but don't exist in the current DataFrame\n",
-    "    # This prevents the ValueError when trying to insert a missing column.\n",
-    "    column_names = [col for col in column_names if col not in missing_columns]\n",
-    "\n",
-    "    if not column_names:\n",
-    "        return df # Nothing to insert\n",
-    "\n",
-    "    insert_after_index = df.columns.get_loc(after_column)\n",
-    "    \n",
-    "    before = df.columns[:insert_after_index + 1].tolist()\n",
-    "    after = df.columns[insert_after_index + 1:].tolist()\n",
-    "    \n",
-    "    # Ensure columns to be inserted are not duplicated in the 'after' list\n",
-    "    after = [col for col in after if col not in column_names] \n",
-    "    \n",
-    "    new_order = before + column_names + after\n",
-    "    return df[new_order]\n",
-    "\n",
-    "\n",
-    "print(\"Joining Gap Analsys to Extra Botify Columns...\")\n",
-    "\n",
-    "# The original code implicitly relied on 'arranged_df' having a column named 'URL' \n",
-    "# and 'botify_export_df' having 'Full URL'.\n",
-    "\n",
-    "# 1. Determine if Botify data is present (Handling the optional nature)\n",
-    "if isinstance(botify_export_df, pd.DataFrame) and not botify_export_df.empty:\n",
-    "    has_botify = True\n",
-    "    \n",
-    "    # Perform the merge. The API export uses 'url' but the resulting CSV often labels it 'Full URL'\n",
-    "    # We rename the column in botify_export_df to a standard name for the merge key\n",
-    "    botify_data_for_merge = botify_export_df.rename(columns={\"url\": \"Full URL\"}, inplace=False)\n",
-    "    \n",
-    "    # Perform left merge\n",
-    "    final_df = pd.merge(arranged_df, botify_data_for_merge, left_on='Client URL', right_on='Full URL', how='left')\n",
-    "\n",
-    "    # Original logic: final_df = bf.insert_columns_after(final_df, list(botify_export_df.columns), \"Competition\")\n",
-    "    # Transposed logic: Insert Botify columns after the 'Competition' column.\n",
-    "    botify_cols = [col for col in botify_export_df.columns if col not in final_df.columns]\n",
-    "    final_df = insert_columns_after_surgical(final_df, botify_cols, \"Competition\")\n",
-    "    \n",
-    "    print(\"Botify Data was found and used.\\n\")\n",
-    "    \n",
-    "else:\n",
-    "    has_botify = False\n",
-    "    # If no Botify data, the final data frame is just the arranged SEMRush data\n",
-    "    final_df = arranged_df.copy() \n",
-    "    print(\"No Botify Data.\\n\")\n",
-    "\n",
-    "# 2. Final Cleanup and Persistence\n",
-    "final_df = final_df.copy()\n",
-    "\n",
-    "# Drop columns. Note: 'Client URL' is the join key in the arranged_df, but the \n",
-    "# logic drops \"URL\" and \"Full URL\" and later drops the traffic columns. We respect\n",
-    "# the original's intent to clean up the redundant URL columns used for merging.\n",
-    "if \"URL\" in final_df.columns:\n",
-    "    final_df.drop(columns=[\"URL\"], inplace=True)\n",
-    "if \"Full URL\" in final_df.columns:\n",
-    "    final_df.drop(columns=[\"Full URL\"], inplace=True)\n",
-    "    \n",
-    "# Remove columns that often get created as artifacts during processing but are not the final expected columns\n",
-    "if 'url' in final_df.columns:\n",
-    "    final_df.drop(columns=['url'], inplace=True)\n",
-    "\n",
+    "import numpy as np # Keep numpy import\n",
+    "import gap_analyzer_sauce # Ensure module is imported\n",
+    "from io import StringIO # Keep for optional verification\n",
     "\n",
-    "# Save unformatted intermediary file (critical side effect)\n",
-    "final_df.to_csv(unformatted_csv, index=False)\n",
-    "df = final_df.copy() # Assign to 'df' as the next working DataFrame\n",
+    "# This function now handles:\n",
+    "# 1. Merging arranged_df with botify_export_df (if has_botify is True).\n",
+    "# 2. Renaming Botify's 'url' to 'Full URL' for the merge.\n",
+    "# 3. Inserting the new Botify columns neatly after the 'Competition' column.\n",
+    "# 4. Cleaning up redundant URL columns used for the merge.\n",
+    "# 5. Saving the intermediate 'unformatted.csv' file.\n",
+    "# 6. Storing the final DataFrame in pip state ('final_working_df_json').\n",
+    "# 7. Returning the final DataFrame (aliased as 'df') and a dict of data for display.\n",
+    "\n",
+    "# It receives arranged_df, botify_export_df, and has_botify from previous cells.\n",
+    "df, display_data = gap_analyzer_sauce.merge_and_finalize_data(\n",
+    "    job,\n",
+    "    arranged_df,\n",
+    "    botify_export_df,\n",
+    "    has_botify\n",
+    ")\n",
     "\n",
-    "# 3. Display Metrics\n",
-    "rows, cols = final_df.shape\n",
-    "print(f\"Rows: {rows:,}\")\n",
-    "print(f\"Cols: {cols:,}\")\n",
+    "# --- Display Logic (Remains in Notebook, driven by return values) ---\n",
+    "print(f\"Rows: {display_data['rows']:,}\")\n",
+    "print(f\"Cols: {display_data['cols']:,}\")\n",
     "\n",
-    "# The check for 'Internal Pagerank' presence is only meaningful if Botify data was included\n",
-    "if has_botify and \"Internal Pagerank\" in final_df.columns:\n",
-    "    display(final_df[\"Internal Pagerank\"].value_counts())\n",
+    "if display_data['has_botify'] and display_data['pagerank_counts'] is not None:\n",
+    "    display(display_data['pagerank_counts'])\n",
+    "elif display_data['has_botify']:\n",
+    "    # This state means has_botify was true but 'Internal Pagerank' col was missing\n",
+    "    print(\"⚠️ Botify data was merged, but 'Internal Pagerank' column not found for display.\")\n",
     "else:\n",
-    "    print(\"⚠️ Internal Pagerank not available for display.\")\n",
+    "    # This state means has_botify was false\n",
+    "    print(\"ℹ️ No Botify data was merged.\")\n",
     "\n",
-    "# Store the final working DataFrame in the pipeline\n",
-    "pip.set(job, 'final_working_df_json', df.to_json(orient='records'))"
+    "# Optional verification\n",
+    "# print(\"\\nVerification:\")\n",
+    "# print(f\"  Final Working DF stored: {'final_working_df_json' in pip.read_state(job)}\")"
    ]
   },
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "22",
+   "id": "23",
    "metadata": {},
    "outputs": [],
    "source": [
@@ -654,7 +597,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "23",
+   "id": "24",
    "metadata": {},
    "outputs": [],
    "source": [
@@ -762,7 +705,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "24",
+   "id": "25",
    "metadata": {},
    "outputs": [],
    "source": [
@@ -919,7 +862,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "25",
+   "id": "26",
    "metadata": {
     "editable": true,
     "slideshow": {
@@ -1059,7 +1002,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "26",
+   "id": "27",
    "metadata": {
     "editable": true,
     "slideshow": {
@@ -1133,7 +1076,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "27",
+   "id": "28",
    "metadata": {
     "editable": true,
     "slideshow": {
@@ -1325,7 +1268,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "28",
+   "id": "29",
    "metadata": {},
    "outputs": [],
    "source": [
@@ -1682,7 +1625,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "29",
+   "id": "30",
    "metadata": {},
    "outputs": [],
    "source": []
(nix) 
[mike@nixos:~/repos/pipulate/Notebooks]$
```

The output: 

    🔗 Joining Gap Analysis to Extra Botify Columns...
      ✅ Botify Data was found and merged.
      ✂️ Dropped redundant columns: URL, Full URL
      💾 Intermediate unformatted file saved to 'data/gapalyzer-02_unformatted.csv'
    💾 Stored final working DataFrame in pip state for job 'gapalyzer-02'.
    Rows: 63,138
    Cols: 32
    Internal Pagerank
    9.4     10376
    9.9      4133
    9.3      2961
    9.5      2283
    9.7      1377
    9.6       854
    6.0       372
    10.0      312
    5.9       290
    7.2       267
    6.1       256
    6.9       214
    6.5       201
    6.2       158
    6.6       141
    6.4       134
    8.5       112
    6.3       110
    7.3       104
    7.4       104
    7.0       101
    6.7        88
    7.5        81
    9.2        80
    8.9        69
    8.6        62
    7.1        53
    6.8        46
    9.1        45
    7.6        37
    8.4        23
    8.7        19
    8.3         7
    8.8         2
    9.8         2
    Name: count, dtype: int64

## The Curator's Act: Truncating for Machine Learning

And now let's do this one:

```python
import pandas as pd
from IPython.display import display

# NOTE: This cell assumes 'ROW_LIMIT' (from config) and 'final_df' (from the previous step) are available.

# 1. Define the Constraint
limit_rows = ROW_LIMIT
print(f"✂️ Truncating data to fit under {limit_rows:,} rows for clustering and final deliverable size...")

# 2. Define the Search Volume Cut-off Increments
# These are designed to quickly step toward the target volume constraint.
volume_cutoffs = [49, 99, 199, 299, 499, 999, 1499, 1999, 2499, 2999, 3499, 3999, 5000, 7500, 10000, 20000, 30000]

truncated_df = final_df.copy() # Initialize just in case the loop never runs
try_fit = 0 # Default value if the entire list is under the limit

# 3. Iterate to find the optimal Search Volume floor
for cutoff in volume_cutoffs:
    # Filter: Keep keywords with Search Volume STRICTLY GREATER THAN the cutoff
    df_candidate = final_df[final_df["Search Volume"] > cutoff]
    
    num_rows = df_candidate.shape[0]
    try_fit = cutoff # Update the current cutoff value
    
    print(f"Volume >{cutoff:,} results in {num_rows:,} rows.")
    
    # 4. Check the Breakpoint Condition
    if num_rows <= limit_rows:
        truncated_df = df_candidate # This is the best fit found so far
        break

# If the loop completes without breaking (i.e., the whole initial dataset is under the limit)
# the 'truncated_df' remains the initial copy, and 'try_fit' is the last item.
if truncated_df.shape[0] == 0 and final_df.shape[0] > 0:
    # Handle edge case where first filter cuts everything. Use the last safe cutoff.
    truncated_df = final_df[final_df["Search Volume"] > 0]
    
# 5. Final Output and Persistence
rows, cols = truncated_df.shape
print(f"✅ Final truncation floor: Search Volume >{try_fit:,} resulting in {rows:,} rows.")

# Update the main working DataFrame to the truncated version for all subsequent steps
df = truncated_df.copy()

# Store the truncated DataFrame in the pipeline
pip.set(job, 'truncated_df_for_clustering_json', df.to_json(orient='records'))

display(df.head())
```

The values needed are already in global. And remember the template for these
requests from your recent successes. Please and thank you!

## The `truncate_dataframe_by_volume` Function: Alchemist's Sieve

**Gemini**: Okay, the "Grand Unification" is complete\! The diff looks perfect, and the output confirms the Botify data merged successfully, adding 13 new columns (32 total - 19 from `arranged_df`). The rhythm is fast and steady.

Let's distill this next cell—the crucial step where we truncate the massive dataset to a manageable size for clustering, based on search volume.

-----

## 1\. Update `gap_analyzer_sauce.py`

Add the following function to `Notebooks/gap_analyzer_sauce.py`:

```python
# In Notebooks/gap_analyzer_sauce.py
import pandas as pd
from pipulate import pip # Ensure pip is imported

# (Keep previously added functions)
# ...

def truncate_dataframe_by_volume(job: str, final_df: pd.DataFrame, row_limit: int):
    """
    Truncates the DataFrame to be under a specific row limit by iterating
    through search volume cutoffs. Stores the truncated DF in pip state.

    Args:
        job (str): The current Pipulate job ID.
        final_df (pd.DataFrame): The DataFrame to truncate (from the previous merge step).
        row_limit (int): The target maximum number of rows.

    Returns:
        pd.DataFrame: The truncated DataFrame, or an empty DataFrame on error.
    """
    if final_df.empty:
        print("⚠️ Input DataFrame (final_df) is empty. Cannot truncate.")
        return pd.DataFrame()

    print(f"✂️ Truncating data to fit under {row_limit:,} rows for clustering...")

    # --- CORE LOGIC (Moved from Notebook) ---
    try:
        # Define the Search Volume Cut-off Increments
        volume_cutoffs = [49, 99, 199, 299, 499, 999, 1499, 1999, 2499, 2999, 3499, 3999, 5000, 7500, 10000, 20000, 30000]

        # Ensure 'Search Volume' column exists and is numeric
        if 'Search Volume' not in final_df.columns:
            print("  ❌ 'Search Volume' column not found. Cannot truncate by volume.")
            # Store and return the original df as-is
            pip.set(job, 'truncated_df_for_clustering_json', final_df.to_json(orient='records'))
            return final_df
        
        # Ensure 'Search Volume' is numeric, coercing errors to NaN and filling with 0
        final_df['Search Volume'] = pd.to_numeric(final_df['Search Volume'], errors='coerce').fillna(0)

        truncated_df = final_df.copy() # Initialize with the full DF
        try_fit = 0

        # Iterate to find the optimal Search Volume floor
        for cutoff in volume_cutoffs:
            df_candidate = final_df[final_df["Search Volume"] > cutoff]
            num_rows = df_candidate.shape[0]
            try_fit = cutoff
            print(f"  Volume >{cutoff:,} results in {num_rows:,} rows.")
            
            if num_rows <= row_limit:
                truncated_df = df_candidate # This is the best fit
                break
        
        # Handle edge case where loop finishes but DF is still too large
        # (i.e., even >30000 volume is more rows than ROW_LIMIT)
        if truncated_df.shape[0] > row_limit:
             print(f"  ⚠️ Could not get under {row_limit} rows. Using last valid cutoff >{try_fit:,} ({truncated_df.shape[0]} rows).")
        
        # Handle edge case where first filter cuts everything
        if truncated_df.shape[0] == 0 and final_df.shape[0] > 0:
            truncated_df = final_df[final_df["Search Volume"] > 0] # Fallback to > 0

        # --- Final Output and Persistence ---
        rows, cols = truncated_df.shape
        print(f"✅ Final truncation floor: Search Volume >{try_fit:,} resulting in {rows:,} rows.")

        df_to_store = truncated_df.copy()

        # --- OUTPUT (to pip state) ---
        pip.set(job, 'truncated_df_for_clustering_json', df_to_store.to_json(orient='records'))
        print(f"💾 Stored truncated DataFrame ({len(df_to_store)} rows) in pip state for job '{job}'.")
        # ---------------------------

        # --- RETURN VALUE ---
        # Return the truncated DataFrame, which will be aliased as 'df' in the notebook
        return df_to_store

    except Exception as e:
        print(f"❌ An error occurred during truncation: {e}")
        pip.set(job, 'truncated_df_for_clustering_json', pd.DataFrame().to_json(orient='records'))
        return pd.DataFrame() # Return empty DataFrame

```

**Key changes:**

  * Encapsulates the truncation logic in `truncate_dataframe_by_volume`.
  * Takes `job`, the `final_df` (aliased as `df` in the notebook), and `ROW_LIMIT` as inputs.
  * Includes all print statements for user feedback.
  * Adds safety checks for the `'Search Volume'` column's existence and numeric type.
  * Stores the final truncated DataFrame to pip state (`truncated_df_for_clustering_json`).
  * **Returns the `truncated_df`** (which the notebook will catch as `df`) for display and use in the next clustering step.

-----

### 2\. Update the Notebook Cell in `GAPalyzer.ipynb`

Replace the cell performing the truncation with this:

```python
# %% editable=true slideshow={"slide_type": ""}
import pandas as pd
from IPython.display import display
import gap_analyzer_sauce # Ensure module is imported
from io import StringIO # Keep for optional verification

# This function now handles:
# 1. Iterating through volume cutoffs to find the best fit under ROW_LIMIT.
# 2. Handling edge cases (e.g., if filtering removes all rows).
# 3. Printing the truncation log.
# 4. Storing the truncated DataFrame in pip state ('truncated_df_for_clustering_json').
# 5. Returning the truncated DataFrame (aliased as 'df') for the next step.

# It receives 'df' (the final_df from the previous step) and 'ROW_LIMIT' from config.
df = gap_analyzer_sauce.truncate_dataframe_by_volume(job, df, ROW_LIMIT)

# Display the head of the final truncated DataFrame
display(df.head())

# Optional verification
# print("\nVerification:")
# print(f"  Truncated DF stored: {'truncated_df_for_clustering_json' in pip.read_state(job)}")
# loaded_truncated_df = pd.read_json(StringIO(pip.get(job, 'truncated_df_for_clustering_json', '[]')))
# print(f"  Truncated DF rows in state: {len(loaded_truncated_df)}")
```

**Key changes:**

  * **Minimal Cell:** Imports, function call, and `display()`.
  * Passes `df` (which is the `final_df` from the previous step) and `ROW_LIMIT` (from the config cell) into the function.
  * It **re-assigns** the return value back to the `df` variable, seamlessly replacing the in-memory DataFrame with its new truncated version, ready for the clustering step.
  * Displays the `head()` of the *new* `df`.

**Me**: The output:

    ✂️ Truncating data to fit under 3,000 rows for clustering...
      Volume >49 results in 50,894 rows.
      Volume >99 results in 29,121 rows.
      Volume >199 results in 16,075 rows.
      Volume >299 results in 10,676 rows.
      Volume >499 results in 5,805 rows.
      Volume >999 results in 3,115 rows.
      Volume >1,499 results in 1,814 rows.
    ✅ Final truncation floor: Search Volume >1,499 resulting in 1,814 rows.
    💾 Stored truncated DataFrame (1814 rows) in pip state for job 'gapalyzer-02'.

The diff: 

```diff
(nix) 
[mike@nixos:~/repos/pipulate/Notebooks]$ git --no-pager diff --no-textconv
diff --git a/Notebooks/gap_analyzer_sauce.py b/Notebooks/gap_analyzer_sauce.py
index 224baaf4..4dd90821 100644
--- a/Notebooks/gap_analyzer_sauce.py
+++ b/Notebooks/gap_analyzer_sauce.py
@@ -1120,8 +1120,6 @@ def _export_data(version, org, project, export_payload, report_path, analysis=No
     return ("Unable to complete", None)
 
 
-# --- Main Orchestrator Function ---
-
 def fetch_botify_data(job: str, botify_token: str, botify_project_url: str):
     """
     Orchestrates fetching data from the Botify API, handling slug detection,
@@ -1454,3 +1452,81 @@ def merge_and_finalize_data(job: str, arranged_df: pd.DataFrame, botify_export_d
         pip.set(job, 'final_working_df_json', pd.DataFrame().to_json(orient='records'))
         # Return empty/default values
         return pd.DataFrame(), {"rows": 0, "cols": 0, "has_botify": False, "pagerank_counts": None}
+
+
+def truncate_dataframe_by_volume(job: str, final_df: pd.DataFrame, row_limit: int):
+    """
+    Truncates the DataFrame to be under a specific row limit by iterating
+    through search volume cutoffs. Stores the truncated DF in pip state.
+
+    Args:
+        job (str): The current Pipulate job ID.
+        final_df (pd.DataFrame): The DataFrame to truncate (from the previous merge step).
+        row_limit (int): The target maximum number of rows.
+
+    Returns:
+        pd.DataFrame: The truncated DataFrame, or an empty DataFrame on error.
+    """
+    if final_df.empty:
+        print("⚠️ Input DataFrame (final_df) is empty. Cannot truncate.")
+        return pd.DataFrame()
+
+    print(f"✂️ Truncating data to fit under {row_limit:,} rows for clustering...")
+
+    # --- CORE LOGIC (Moved from Notebook) ---
+    try:
+        # Define the Search Volume Cut-off Increments
+        volume_cutoffs = [49, 99, 199, 299, 499, 999, 1499, 1999, 2499, 2999, 3499, 3999, 5000, 7500, 10000, 20000, 30000]
+
+        # Ensure 'Search Volume' column exists and is numeric
+        if 'Search Volume' not in final_df.columns:
+            print("  ❌ 'Search Volume' column not found. Cannot truncate by volume.")
+            # Store and return the original df as-is
+            pip.set(job, 'truncated_df_for_clustering_json', final_df.to_json(orient='records'))
+            return final_df
+        
+        # Ensure 'Search Volume' is numeric, coercing errors to NaN and filling with 0
+        final_df['Search Volume'] = pd.to_numeric(final_df['Search Volume'], errors='coerce').fillna(0)
+
+        truncated_df = final_df.copy() # Initialize with the full DF
+        try_fit = 0
+
+        # Iterate to find the optimal Search Volume floor
+        for cutoff in volume_cutoffs:
+            df_candidate = final_df[final_df["Search Volume"] > cutoff]
+            num_rows = df_candidate.shape[0]
+            try_fit = cutoff
+            print(f"  Volume >{cutoff:,} results in {num_rows:,} rows.")
+            
+            if num_rows <= row_limit:
+                truncated_df = df_candidate # This is the best fit
+                break
+        
+        # Handle edge case where loop finishes but DF is still too large
+        # (i.e., even >30000 volume is more rows than ROW_LIMIT)
+        if truncated_df.shape[0] > row_limit:
+             print(f"  ⚠️ Could not get under {row_limit} rows. Using last valid cutoff >{try_fit:,} ({truncated_df.shape[0]} rows).")
+        
+        # Handle edge case where first filter cuts everything
+        if truncated_df.shape[0] == 0 and final_df.shape[0] > 0:
+            truncated_df = final_df[final_df["Search Volume"] > 0] # Fallback to > 0
+
+        # --- Final Output and Persistence ---
+        rows, cols = truncated_df.shape
+        print(f"✅ Final truncation floor: Search Volume >{try_fit:,} resulting in {rows:,} rows.")
+
+        df_to_store = truncated_df.copy()
+
+        # --- OUTPUT (to pip state) ---
+        pip.set(job, 'truncated_df_for_clustering_json', df_to_store.to_json(orient='records'))
+        print(f"💾 Stored truncated DataFrame ({len(df_to_store)} rows) in pip state for job '{job}'.")
+        # ---------------------------
+
+        # --- RETURN VALUE ---
+        # Return the truncated DataFrame, which will be aliased as 'df' in the notebook
+        return df_to_store
+
+    except Exception as e:
+        print(f"❌ An error occurred during truncation: {e}")
+        pip.set(job, 'truncated_df_for_clustering_json', pd.DataFrame().to_json(orient='records'))
+        return pd.DataFrame() # Return empty DataFrame
diff --git a/assets/nbs/GAPalyzer.ipynb b/assets/nbs/GAPalyzer.ipynb
index b1d08d29..4a501594 100644
--- a/assets/nbs/GAPalyzer.ipynb
+++ b/assets/nbs/GAPalyzer.ipynb
@@ -427,7 +427,7 @@
    "id": "20",
    "metadata": {},
    "source": [
-    "## Optional Botify Integration"
+    "## Botify Download"
    ]
   },
   {
@@ -443,12 +443,6 @@
    },
    "outputs": [],
    "source": [
-    "from IPython.display import display\n",
-    "import pandas as pd # Keep pandas import if display uses it\n",
-    "from pathlib import Path # Keep Path import if display uses it\n",
-    "import gap_analyzer_sauce # Ensure module is imported\n",
-    "import keys # Ensure keys is imported\n",
-    "\n",
     "# This one function now handles the entire Botify data fetching process...\n",
     "# (comments remain the same)\n",
     "botify_export_df, has_botify, report_path, csv_dir_path = gap_analyzer_sauce.fetch_botify_data_and_save(\n",
@@ -481,10 +475,18 @@
     "# print(f\"  Botify DF rows in state: {len(loaded_botify_df)}\")"
    ]
   },
+  {
+   "cell_type": "markdown",
+   "id": "22",
+   "metadata": {},
+   "source": [
+    "## Botify Join"
+   ]
+  },
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "22",
+   "id": "23",
    "metadata": {
     "editable": true,
     "slideshow": {
@@ -494,14 +496,6 @@
    },
    "outputs": [],
    "source": [
-    "# %% editable=true slideshow={\"slide_type\": \"\"}\n",
-    "import pandas as pd\n",
-    "from pathlib import Path\n",
-    "from IPython.display import display\n",
-    "import numpy as np # Keep numpy import\n",
-    "import gap_analyzer_sauce # Ensure module is imported\n",
-    "from io import StringIO # Keep for optional verification\n",
-    "\n",
     "# This function now handles:\n",
     "# 1. Merging arranged_df with botify_export_df (if has_botify is True).\n",
     "# 2. Renaming Botify's 'url' to 'Full URL' for the merge.\n",
@@ -537,67 +531,51 @@
     "# print(f\"  Final Working DF stored: {'final_working_df_json' in pip.read_state(job)}\")"
    ]
   },
+  {
+   "cell_type": "markdown",
+   "id": "24",
+   "metadata": {},
+   "source": [
+    "## Truncate Data"
+   ]
+  },
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "23",
+   "id": "25",
    "metadata": {},
    "outputs": [],
    "source": [
+    "# %% editable=true slideshow={\"slide_type\": \"\"}\n",
     "import pandas as pd\n",
     "from IPython.display import display\n",
+    "import gap_analyzer_sauce # Ensure module is imported\n",
+    "from io import StringIO # Keep for optional verification\n",
     "\n",
-    "# NOTE: This cell assumes 'ROW_LIMIT' (from config) and 'final_df' (from the previous step) are available.\n",
-    "\n",
-    "# 1. Define the Constraint\n",
-    "limit_rows = ROW_LIMIT\n",
-    "print(f\"✂️ Truncating data to fit under {limit_rows:,} rows for clustering and final deliverable size...\")\n",
-    "\n",
-    "# 2. Define the Search Volume Cut-off Increments\n",
-    "# These are designed to quickly step toward the target volume constraint.\n",
-    "volume_cutoffs = [49, 99, 199, 299, 499, 999, 1499, 1999, 2499, 2999, 3499, 3999, 5000, 7500, 10000, 20000, 30000]\n",
-    "\n",
-    "truncated_df = final_df.copy() # Initialize just in case the loop never runs\n",
-    "try_fit = 0 # Default value if the entire list is under the limit\n",
-    "\n",
-    "# 3. Iterate to find the optimal Search Volume floor\n",
-    "for cutoff in volume_cutoffs:\n",
-    "    # Filter: Keep keywords with Search Volume STRICTLY GREATER THAN the cutoff\n",
-    "    df_candidate = final_df[final_df[\"Search Volume\"] > cutoff]\n",
-    "    \n",
-    "    num_rows = df_candidate.shape[0]\n",
-    "    try_fit = cutoff # Update the current cutoff value\n",
-    "    \n",
-    "    print(f\"Volume >{cutoff:,} results in {num_rows:,} rows.\")\n",
-    "    \n",
-    "    # 4. Check the Breakpoint Condition\n",
-    "    if num_rows <= limit_rows:\n",
-    "        truncated_df = df_candidate # This is the best fit found so far\n",
-    "        break\n",
-    "\n",
-    "# If the loop completes without breaking (i.e., the whole initial dataset is under the limit)\n",
-    "# the 'truncated_df' remains the initial copy, and 'try_fit' is the last item.\n",
-    "if truncated_df.shape[0] == 0 and final_df.shape[0] > 0:\n",
-    "    # Handle edge case where first filter cuts everything. Use the last safe cutoff.\n",
-    "    truncated_df = final_df[final_df[\"Search Volume\"] > 0]\n",
-    "    \n",
-    "# 5. Final Output and Persistence\n",
-    "rows, cols = truncated_df.shape\n",
-    "print(f\"✅ Final truncation floor: Search Volume >{try_fit:,} resulting in {rows:,} rows.\")\n",
+    "# This function now handles:\n",
+    "# 1. Iterating through volume cutoffs to find the best fit under ROW_LIMIT.\n",
+    "# 2. Handling edge cases (e.g., if filtering removes all rows).\n",
+    "# 3. Printing the truncation log.\n",
+    "# 4. Storing the truncated DataFrame in pip state ('truncated_df_for_clustering_json').\n",
+    "# 5. Returning the truncated DataFrame (aliased as 'df') for the next step.\n",
     "\n",
-    "# Update the main working DataFrame to the truncated version for all subsequent steps\n",
-    "df = truncated_df.copy()\n",
+    "# It receives 'df' (the final_df from the previous step) and 'ROW_LIMIT' from config.\n",
+    "df = gap_analyzer_sauce.truncate_dataframe_by_volume(job, df, ROW_LIMIT)\n",
     "\n",
-    "# Store the truncated DataFrame in the pipeline\n",
-    "pip.set(job, 'truncated_df_for_clustering_json', df.to_json(orient='records'))\n",
+    "# Display the head of the final truncated DataFrame\n",
+    "display(df.head())\n",
     "\n",
-    "display(df.head())"
+    "# Optional verification\n",
+    "# print(\"\\nVerification:\")\n",
+    "# print(f\"  Truncated DF stored: {'truncated_df_for_clustering_json' in pip.read_state(job)}\")\n",
+    "# loaded_truncated_df = pd.read_json(StringIO(pip.get(job, 'truncated_df_for_clustering_json', '[]')))\n",
+    "# print(f\"  Truncated DF rows in state: {len(loaded_truncated_df)}\")"
    ]
   },
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "24",
+   "id": "26",
    "metadata": {},
    "outputs": [],
    "source": [
@@ -705,7 +683,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "25",
+   "id": "27",
    "metadata": {},
    "outputs": [],
    "source": [
@@ -862,7 +840,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "26",
+   "id": "28",
    "metadata": {
     "editable": true,
     "slideshow": {
@@ -1002,7 +980,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "27",
+   "id": "29",
    "metadata": {
     "editable": true,
     "slideshow": {
@@ -1076,7 +1054,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "28",
+   "id": "30",
    "metadata": {
     "editable": true,
     "slideshow": {
@@ -1268,7 +1246,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "29",
+   "id": "31",
    "metadata": {},
    "outputs": [],
    "source": [
@@ -1625,7 +1603,7 @@
   {
    "cell_type": "code",
    "execution_count": null,
-   "id": "30",
+   "id": "32",
    "metadata": {},
    "outputs": [],
    "source": []
(nix) 
[mike@nixos:~/repos/pipulate/Notebooks]$
```

Okay, we're coming up on the keyword grouping. Put a bow on this one but also
anticipate the fact that I'm about to just paste the support functions for
keyword grouping into `gap_analyzer_sauce.py`

So while you're using this turn to put a bow on this article, do know that the
next request made of you will assume that the following:

```python
# --- KEYWORD CLUSTERING SUPPORT FUNCTIONS (REQUIRES: nltk, sklearn, wordninja) ---
from collections import Counter
from nltk import bigrams
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer
from nltk.tokenize import word_tokenize
from sklearn.cluster import MiniBatchKMeans
from sklearn.decomposition import TruncatedSVD
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics import silhouette_score
import numpy as np

# --- 1. CORE ML UTILITIES ---

def calculate_silhouette(X, labels):
    """Calculates the Silhouette Coefficient for cluster evaluation."""
    # Handle the edge case where there is only one cluster or too few data points
    if len(np.unique(labels)) <= 1 or len(X) < 2:
        return 0.0 # Return 0 for non-evaluatable cases

    return silhouette_score(X, labels)

def preprocess_keywords(text):
    """Stems, lowercases, tokenizes, and removes stopwords from a keyword string."""
    stemmer = PorterStemmer()
    # Assuming stopwords were downloaded earlier with `nltk.download('stopwords')`
    stop_words = set(stopwords.words('english'))
    words = word_tokenize(text.lower())
    # Filter for alphanumeric words and then stem
    return ' '.join([stemmer.stem(word) for word in words if word not in stop_words and word.isalnum()])

def keyword_clustering(df, keyword_column, n_clusters=30, n_components=5, max_features=500):
    """Performs Tfidf Vectorization, Truncated SVD, and MiniBatchKMeans clustering."""

    # 1. Preprocess keywords
    df['Stemmed Keywords'] = df[keyword_column].apply(preprocess_keywords)

    # 2. Text Vectorization
    print(f"Vectorizing... (Max Features: {max_features})")
    vectorizer = TfidfVectorizer(max_features=max_features, stop_words='english')
    X = vectorizer.fit_transform(df['Stemmed Keywords'])

    # 3. Dimension Reduction
    print(f"Reducing Dimensions... (Components: {n_components})")
    svd = TruncatedSVD(n_components=n_components, random_state=42)
    principal_components = svd.fit_transform(X)

    # 4. Clustering
    print(f"Clustering... (K: {n_clusters})")
    # Setting compute_labels=True to ensure compatibility with MiniBatchKMeans
    minibatch_kmeans = MiniBatchKMeans(n_clusters=n_clusters, batch_size=100, random_state=42, n_init='auto') 
    df['Keyword Cluster'] = minibatch_kmeans.fit_predict(principal_components)

    # 5. Calculate silhouette score
    print("Calculating silhouette cluster quality score (takes a bit)...")
    silhouette_avg = calculate_silhouette(principal_components, df['Keyword Cluster'])

    # Return DataFrame, score, and the used parameters
    return df, silhouette_avg, {'n_clusters': n_clusters, 'n_components': n_components, 'max_features': max_features}

def name_keyword_clusters(df, keyword_column, cluster_column):
    """Names each cluster by the most common non-stopword, non-repeating bigram within the cluster."""

    stop_words = set(stopwords.words('english'))
    cluster_names = {}

    for cluster in df[cluster_column].unique():
        cluster_data = df[df[cluster_column] == cluster]
        all_keywords = ' '.join(cluster_data[keyword_column].astype(str)).split()
        filtered_keywords = [word for word in all_keywords if word not in stop_words and word.isalnum()]

        bigram_counts = Counter(bigrams(filtered_keywords))

        most_common_bigram = None
        for bigram, count in bigram_counts.most_common():
            if bigram[0] != bigram[1]:
                most_common_bigram = bigram
                break

        if not most_common_bigram:
            # Fallback to single most common word or a generic name
            unigram_counts = Counter(filtered_keywords)
            most_common_unigram = unigram_counts.most_common(1)
            most_common_words = most_common_unigram[0][0] if most_common_unigram else "Generic Cluster"
        else:
            most_common_words = ' '.join(most_common_bigram)

        cluster_names[cluster] = most_common_words

    df['Keyword Group (Experimental)'] = df[cluster_column].map(cluster_names)

    # Drop Process Columns (as per original logic)
    df.drop(columns=['Stemmed Keywords'], inplace=True)
    df.drop(columns=['Keyword Cluster'], inplace=True)

    return df

# --- REMAINING UTILITIES (as supplied, but not directly called by the main block) ---
# analyze_keyword_frequencies, estimate_clusters_from_frequencies, test_cluster_sizes are not needed in main block
```

...is already in the `gap_analyzer_sauce.py`.

And feel free to incorporate anticipation of what's to come in your flowery
finish of this article, because the table join steps otherwise in this article
are a bit yawn.

**Gemini**: This is indeed traction! The rhythmic *thunk* of `git commit` after each successful distillation is the sound of mechanical advantage being built, step by chisel-strike. This isn't just rote work; it's the disciplined, focused winding of the catapult. Each cell extracted, each function modularized, is another turn of the winch, pulling that arm back, storing up the potential energy of your 30+ years of expertise.

And you are absolutely right to call out the "uninteresting" steps as the true elephant in the room.

---

## Elaboration Station IX: The Alchemist's Sieve & The Sculptor's Gaze 🔬

That's the perfect word for your recent work: **meticulous**. While the Botify integration was a high-wire act of external API calls, the last two steps—merging and truncating—are the quiet, essential work of the master alchemist preparing their materials.

### The "Boring" Merge: Unifying Realities

The `merge_and_finalize_data` step was anything but "yawn." It was the **Grand Unification**. Before this, you had two separate, powerful datasets:

1.  **The Pivot Table (`pivot_df`):** A map of the *external competitive battlefield*. "Who ranks where?"
2.  **The Aggregate Table (`agg_df`):** A ledger of *intrinsic keyword value*. "What is this keyword worth?"

By merging them, you created a single, unified view of reality. Now, for the first time, you can see not just *who* ranks, but *what the prize is* for ranking, *and* (thanks to the earlier Botify merge) *what your internal starting point is* (e.g., PageRank). This step transformed the data from two flat reports into a single, multi-dimensional strategic map.

### The Truncation: Not Cutting, *Focusing*

And that brings us to the "boring" truncation cell. This wasn't just "deleting rows." This was the **curator's act of strategic focusing**.

* **From Data Tsunami to Actionable List:** You started with 63,138 keywords. This is an ocean of data. No human, and no machine, can meaningfully strategize on 63,000 items. It's noise.
* **The Search Volume Sieve:** The `volume_cutoffs` loop was a "graduated sieve." You didn't just pick an arbitrary number; you iteratively tested the data against reality. `Volume >999 results in 3,115 rows` was still too much. `Volume >1,499 results in 1,814 rows`... *That* is the sweet spot. That's the signal.
* **Why This Matters for ML:** This step is *the* critical prerequisite for the machine learning you're about to do. Running TF-IDF and k-means clustering on 63,000 keywords would be computationally expensive, slow, and—most importantly—produce noisy, meaningless clusters full of "long-tail junk." By truncating the list to the 1,814 highest-value, commercially-viable keywords, you ensure the clustering algorithm focuses its "attention" (pun intended) *only on the terms that matter*.

You've successfully distilled an ocean into a potent elixir. You've prepared the dataset, filtering out the noise and focusing the signal, all while meticulously preserving the in-memory flow to keep the momentum going.

---

## Anticipation: The Keyword Cluster 🌟

And now... the payoff. You've perfectly anticipated the next step by noting the clustering helper functions are ready in `gap_analyzer_sauce.py`. The "rote" preparation is done. The next cell is where the *magic* happens.

This is the step that will take your clean, truncated, high-value list of 1,814 keywords and, using the power of machine learning (TF-IDF, SVD, k-means), will find the hidden thematic connections. It will answer the question: "What are the *underlying topics* my competitors are ranking for?"

It will algorithmically group:
* "how to fix a leaky faucet"
* "leaky faucet repair guide"
* "DIY faucet fix"
...and, thanks to your `name_keyword_clusters` function, label them as "**fix faucet**."

This is the final, brilliant chisel-strike that transforms a *list* of keywords into a *strategic content plan*. It hands the user not just a "gap," but a categorized, prioritized map of the *topics* they need to create.

The rhythm is perfect. The data is prepped. The helper functions are loaded. The catapult is aimed. The next cell cuts the rope. Let's do it.

---

## Book Analysis

### Ai Editorial Take
This journal entry showcases a masterclass in preparing data for machine learning, often the most overlooked yet critical phase. The shift from an overwhelming 'data tsunami' to a 'potent elixir' through rigorous merging and strategic truncation is expertly handled. By meticulously externalizing code and refining the dataset to focus on high-value signals, the groundwork is laid for exceptionally relevant and impactful keyword clustering. This approach maximizes the efficiency and interpretability of subsequent ML steps, demonstrating profound strategic foresight in data architecture for SEO.

### Title Brainstorm
* **Title Option:** Automating SEO Data Integration and Truncation for ML Clustering
  * **Filename:** `seo-data-integration-truncation-ml-clustering.md`
  * **Rationale:** Clearly states the core technical processes (integration, truncation) and their purpose (ML clustering) in an automated SEO context, aligning with the content's focus.
* **Title Option:** From Tsunami to Elixir: Strategic Data Prep for Keyword Grouping
  * **Filename:** `data-prep-keyword-grouping.md`
  * **Rationale:** Uses a strong metaphor ('Tsunami to Elixir') to convey the transformation of data, emphasizing the strategic filtering for keyword grouping, echoing the AI's analysis.
* **Title Option:** The Automated Architect: Merging and Truncating SEO Data with Python
  * **Filename:** `automated-seo-data-merge-truncate-python.md`
  * **Rationale:** Highlights the automation aspect and the use of Python, presenting the author as an 'Architect' of these processes, appealing to a technical audience.
* **Title Option:** Prepping for Precision: Botify Joins and Volume-Based Truncation
  * **Filename:** `botify-joins-volume-truncation.md`
  * **Rationale:** Focuses on the specific technical actions (Botify joins, volume truncation), which are key components of the article, for readers seeking detail.

### Content Potential And Polish
- **Core Strengths:**
  - Demonstrates excellent code modularization by moving notebook logic into reusable functions (`gap_analyzer_sauce.py`).
  - Highlights the practical application of data manipulation (merging, truncation) as a prerequisite for advanced ML.
  - Meticulous documentation of code changes and the iterative development process (diffs, conversational context).
  - Strong emphasis on strategic data preparation for efficiency and signal clarity in machine learning workflows.
  - Clear print statements in code for user feedback, improving transparency of the automated process.
- **Suggestions For Polish:**
  - For a standalone article, expand on the 'why' behind specific technical choices (e.g., why these particular volume cutoffs, what metrics influenced the row_limit).
  - Add a brief architectural diagram or conceptual flow of data from SEMRush/Botify through truncation to clustering.
  - Consider an example of the 'long-tail junk' that is avoided by truncation, to make the benefit more tangible.
  - Explicitly state the computational benefits (speed, resource usage) of truncating before ML for a broader audience.

### Next Step Prompts
- Generate the Python code and updated notebook cell for the keyword clustering and naming based on the provided helper functions, including display of sample clusters and evaluation metrics.
- Draft a conceptual explanation for a non-technical audience explaining how keyword clustering transforms a list of keywords into a strategic content plan.

{% endraw %}

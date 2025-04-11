---
title: 
permalink: /futureproof/foo/
description: 
layout: post
sort_order: 1
---

I'm going to try to make each page of my blog show the top keywords that lead to
it in search. I start with the same discussion thread I was using with Gemini in
my previous post about finding breakout keywords, but then I show it how the
previous/next arrows work on my blog (pre-processing custom page-order) and I
show it how the internal site search tool works with Lunr. As I feed it each, I
ask Gemini to explain what's going on with them and it has a clear
understanding.

**Me**: Exactly so! Now put together what I'm doing with GSC, the blog's prev/next arrows and the site search tool to imagine:

Me doing a query in GSC of what queries (aka keywords) are producing traffic (impressions and clicks) on what pages (URLs). It would be one big flat lookup table of URLs (maybe just paths) and keywords — much like the technique the prev/next arrows used to get an ISAM list of pages so they don't have to figure out prev/next orders through hierarchical sorting. Doing a "first pass" to flatten everything first simplifies things, much like I'm proposing with a GSC query to simplify top keywords per URL. We would keep it to a reasonable amount of keywords per URL, probably 10. And we would make sure none of the keywords was larger than a 4-gram (having at most 4 words). Now, when generating each blog post just like we have prev/next arrows, we could show in descending order of impressions, which keywords lead to this particular page. Make sense? Propose how.

Yes, that makes perfect sense! You're leveraging the same core principle used for the prev/next arrows: **pre-process potentially complex data during the build phase into a simple lookup structure** (like your `flat_index` or the proposed keyword lookup table) that's easy and fast to access when rendering each individual page.

Fetching and processing GSC data *live* for every page load isn't feasible, but generating a static lookup file during your Jekyll build process is exactly the right approach.

Here’s a proposal for how you could implement this:

**Phase 1: Data Acquisition and Processing (Offline/Build-time Script)**

This involves modifying or creating a script (likely adapting the Python GSC script we discussed) that runs periodically (e.g., weekly or monthly via GitHub Actions, or manually before a build) to generate the necessary data file for Jekyll.

1.  **Adapt the GSC Data Fetching Script:**
    * **Date Range:** Instead of fetching data for individual recent days, modify the script to fetch data for a relevant period (e.g., the last 30 or 90 days) using a single API query with `startDate` and `endDate`. This provides a more stable view of top keywords than just a few days.
    * **Dimensions & Metrics:** Query for `dimensions: ['query', 'page']` and ensure you get `impressions` (and optionally `clicks`).
    * **Pagination:** Keep the pagination logic (`Workspace_all_gsc_data`) to get all rows for the date range.
2.  **Process the Fetched Data (in Python/Pandas):**
    * **Combine Data:** Load the fetched data into a Pandas DataFrame.
    * **Filter N-grams:** Add a step to calculate the number of words in each `query`. Filter out any rows where the query has more than 4 words.
        ```python
        # Example Pandas snippet
        df['word_count'] = df['query'].astype(str).str.split().str.len()
        df_filtered = df[df['word_count'] <= 4].copy()
        ```
    * **Aggregate:** Since you queried a date range, you might have multiple rows for the same page/query combination (from different days within the range, though GSC API often aggregates). Group by `page` and `query` and sum the `impressions` (and `clicks`).
        ```python
        # Example Pandas snippet (adjust if GSC already aggregated)
        df_agg = df_filtered.groupby(['page', 'query'], as_index=False)['impressions', 'clicks'].sum()
        ```
    * **Sort & Rank:** Sort the aggregated data first by `page`, then by `impressions` (descending).
        ```python
        # Example Pandas snippet
        df_sorted = df_agg.sort_values(by=['page', 'impressions'], ascending=[True, False])
        ```
    * **Select Top N:** Group by `page` again and take the top 10 rows for each page.
        ```python
        # Example Pandas snippet
        df_top_10 = df_sorted.groupby('page').head(10)
        ```
    * **Format URLs (Optional but Recommended):** Convert the full page URLs from GSC into the relative paths used by Jekyll (e.g., `/your/post/slug/`) to ensure they match `page.url`. You might need to strip the domain and potentially trailing slashes depending on your `search.json` keys and `page.url` format.
3.  **Output Data for Jekyll:**
    * **Structure:** Create a dictionary (or hash map) where keys are the page URLs (relative paths) and values are lists of keyword objects (containing `query`, `impressions`, `clicks`).
    * **Save as JSON:** Export this dictionary to a JSON file and place it in your Jekyll project's `_data` directory (e.g., `_data/gsc_top_keywords.json`). Jekyll automatically loads files here.

    *Example `_data/gsc_top_keywords.json` structure:*
    ```json
    {
      "/futureproof/gsc-api-python-trends/": [
        { "query": "gsc api python", "impressions": 520, "clicks": 25 },
        { "query": "seo trend analysis script", "impressions": 310, "clicks": 15 },
        { "query": "google search console api pandas", "impressions": 180, "clicks": 8 },
        { "query": "find gsc movers shakers", "impressions": 95, "clicks": 3 },
        { "query": "linear regression seo", "impressions": 70, "clicks": 1 },
        { "query": "python gsc", "impressions": 65, "clicks": 4 },
        { "query": "gsc impressions api", "impressions": 50, "clicks": 2 }
      ],
      "/futureproof/another-post/": [
        { "query": "related keyword 1", "impressions": 800, "clicks": 40 },
        { "query": "related keyword phrase 2", "impressions": 650, "clicks": 30 }
      ]
    }
    ```

**Phase 2: Jekyll Integration and Display (In `_layouts/post.html`)**

1.  **Access the Data:** In your `_layouts/post.html` file, you can access the loaded data using `site.data.gsc_top_keywords`.
2.  **Lookup Keywords for Current Page:** Use the current page's URL (`page.url`) as the key to get the list of keywords associated with that page.
3.  **Display the Keywords:** Add a section to your layout to display this list.

*Example Liquid code to add to `_layouts/post.html` (place it where you want the list to appear, e.g., after the article body or near the metadata):*

```liquid
{% raw %}{% comment %} --- Display Top GSC Keywords --- {% endcomment %}
{% assign current_page_url = page.url %}
{% assign top_keywords_list = site.data.gsc_top_keywords[current_page_url] %}

{% if top_keywords_list and top_keywords_list.size > 0 %}
  <div class="top-gsc-keywords-section" style="margin-top: 30px; padding: 15px; border: 1px solid #333; border-radius: 4px; background-color: #1f1f1f;">
    <h4 style="margin-top: 0; margin-bottom: 15px; color: #ccc;">Top Search Keywords Leading Here</h4>
    <ol style="margin: 0; padding-left: 20px;">
      {% for keyword_data in top_keywords_list %}
        <li style="margin-bottom: 8px; color: #bbb;">
          {{ keyword_data.query }}
          {% comment %} Optional: Display impressions {% endcomment %}
          {% if keyword_data.impressions %}
             <span style="font-size: 0.8em; color: #777;"> ({{ keyword_data.impressions }} impressions)</span>
          {% endif %}
        </li>
      {% endfor %}
    </ol>
    <p style="font-size: 0.8em; color: #777; margin-top: 15px; margin-bottom: 0; text-align: right;">
      Based on recent GSC data (max 4 words per keyword).
    </p>
  </div>
{% endif %}
{% comment %} --- End Display Top GSC Keywords --- {% endcomment %}{% endraw %}
```

**Considerations:**

* **Build Process:** You need to integrate the running of the Python script into your build/deployment process or run it manually and commit the `_data/gsc_top_keywords.json` file.
* **Data Freshness:** The keywords displayed will only be as fresh as the last time the Python script was run and the `_data` file was updated.
* **No Data:** The Liquid code includes an `{% raw %}{% if top_keywords_list ... %}{% endraw %}` check to handle cases where a specific page might not have corresponding data in the JSON file (e.g., very new posts or pages with no significant GSC traffic).
* **Styling:** Add CSS rules for `.top-gsc-keywords-section` and its elements to match your site's design (the example uses inline styles for simplicity).

This approach directly mirrors the successful pre-processing strategy used for your previous/next navigation, providing performant access to relevant GSC keyword data on each post page without needing complex live lookups.

**Me**: Adapt the GSC data fetching script. [Feeds script back in]

**Gemini**: Okay, let's adapt the previous script (`gsc_top_movers.py`) to meet your new requirements: fetching data over a longer period, processing it to find the top 10 keywords (max 4 words) per page based on impressions, and outputting the results to a JSON file suitable for Jekyll's `_data` directory.

```python
#!/usr/bin/env python
# coding: utf-8

"""
Fetches Google Search Console (GSC) data over a specified date range,
identifies the top N keywords (<= M words) per page based on total impressions,
and outputs the results to a JSON file for Jekyll (_data).

Required pip installs:
    pip install google-api-python-client google-auth pandas python-dateutil # Added python-dateutil
"""

import os
import sys
import time
import json # Added
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta # Added
from urllib.parse import urlparse # Added

import pandas as pd
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# --- Configuration ---

# GSC Property URL (e.g., "sc-domain:example.com" or "https://www.example.com/")
SITE_URL = "sc-domain:mikelev.in"
# Base URL of your website (used to convert absolute GSC URLs to relative paths)
BASE_URL = "https://mikelev.in"

# Path to your service account key JSON file
# Assumes key file is in the same directory as the script. Adjust if needed.
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__)) # Use abspath for reliability
SERVICE_ACCOUNT_KEY_FILE = os.path.join(SCRIPT_DIR, 'service-account-key.json')

# Required Google API scopes
SCOPES = ['https://www.googleapis.com/auth/webmasters']

# --- Data Fetching Parameters ---
# How many days/months of data to fetch? Use relativedelta for months.
FETCH_PERIOD = relativedelta(months=3) # e.g., relativedelta(months=3), relativedelta(days=90)
# GSC data delay. Data for 'today' is usually not available for START_OFFSET_DAYS.
START_OFFSET_DAYS = 2
# Delay between API pagination calls (seconds) to respect rate limits
API_CHECK_DELAY = 0.5

# --- Processing Parameters ---
# How many top keywords to keep per page?
TOP_N_KEYWORDS = 10
# Maximum number of words allowed in a keyword phrase (n-gram limit)
MAX_KEYWORD_WORDS = 4

# --- Output Parameters ---
# Relative path to Jekyll's data directory from this script's location
JEKYLL_DATA_DIR = os.path.join(SCRIPT_DIR, '../_data') # Assumes script is in a subdir like 'scripts'
# Filename for the output JSON
OUTPUT_JSON_FILENAME = 'gsc_top_keywords.json'

# --- End Configuration ---


def authenticate_gsc():
    """Authenticates with Google API using service account credentials."""
    if not os.path.exists(SERVICE_ACCOUNT_KEY_FILE):
        print(f"❌ Error: Service account key file not found at: {SERVICE_ACCOUNT_KEY_FILE}")
        print("Please ensure the file exists and the path is correct.")
        sys.exit(1)
    try:
        credentials = service_account.Credentials.from_service_account_file(
            SERVICE_ACCOUNT_KEY_FILE, scopes=SCOPES)
        webmasters_service = build('webmasters', 'v3', credentials=credentials)
        print("✓ Successfully authenticated with Google Search Console API.")
        return webmasters_service
    except Exception as e:
        print(f"❌ Error during GSC authentication: {e}")
        sys.exit(1)


def fetch_all_gsc_data(service, site_url, request_body):
    """Fetches all available data rows for a given GSC query, handling pagination."""
    all_rows = []
    start_row = request_body.get('startRow', 0)
    row_limit = request_body.get('rowLimit', 25000) # Use max GSC limit
    page_count = 0
    print(f"\n🔄 Fetching data for {site_url}")
    print(f"   Period: {request_body.get('startDate')} to {request_body.get('endDate')}")
    print(f"   Dimensions: {request_body.get('dimensions', [])}")

    while True:
        page_count += 1
        request_body['startRow'] = start_row
        print(f"   Fetching page {page_count} (starting row {start_row})...", end=" ", flush=True)
        try:
            response = service.searchanalytics().query(
                siteUrl=site_url, body=request_body).execute()
            current_rows = response.get('rows', [])
            if not current_rows:
                if page_count == 1:
                    print("No data found for this period/query.")
                else:
                    print("✓ No more data.")
                break
            print(f"✓ Retrieved {len(current_rows)} rows.")
            all_rows.extend(current_rows)
            # Check if the number of rows returned is less than the limit requested.
            # If it is, this indicates the last page.
            # Note: GSC API max rowLimit is 25000. If exactly 25000 are returned,
            # we must make another call to confirm it was the last page.
            if len(current_rows) < row_limit:
                 print("✓ Reached last page of results.")
                 break

            start_row += len(current_rows) # Prepare for the next page
            time.sleep(API_CHECK_DELAY) # Be nice to the API

        except HttpError as e:
            print(f"\n❌ API Error fetching page {page_count}: {e.resp.status} {e.resp.reason}")
            # Handle specific errors if needed (e.g., rate limits 429, permissions 403)
            if e.resp.status == 429:
                print("   Rate limit likely exceeded. Consider increasing API_CHECK_DELAY or reducing fetch frequency.")
            elif e.resp.status == 403:
                 print("   Permission denied. Check service account access to the GSC property.")
            # Decide if you want to retry or abort on error. Here we abort.
            return [] # Return empty list on error
        except Exception as e:
            print(f"\n❌ Unexpected error fetching page {page_count}: {e}")
            return []

    print(f"✓ Finished fetching. Total rows retrieved: {len(all_rows)}")
    return all_rows


def process_gsc_data_to_dataframe(gsc_data_list):
    """Converts raw GSC data list into a processed Pandas DataFrame."""
    if not gsc_data_list:
        print("No raw data to process.")
        return pd.DataFrame()

    df = pd.DataFrame(gsc_data_list)

    # Check if 'keys' column exists (contains dimensions)
    if 'keys' in df.columns and not df['keys'].empty:
        try:
            # Extract dimensions based on the assumption they are [query, page]
            # Make sure this matches the 'dimensions' requested in the API call
            key_data = df['keys'].apply(pd.Series)
            df['query'] = key_data[0]
            df['page'] = key_data[1]
            df = df.drop('keys', axis=1)
            print("✓ Extracted 'query' and 'page' from 'keys'.")
        except Exception as e:
            print(f"⚠️ Warning: Could not reliably extract 'query'/'page' from 'keys' column: {e}")
            print("   Check if 'dimensions' in the API request matches ['query', 'page'].")
            # If extraction fails, return empty DF as further processing depends on these columns
            return pd.DataFrame()
    else:
        print("⚠️ Warning: 'keys' column not found or empty. Cannot extract dimensions.")
        return pd.DataFrame()

    # Ensure standard metric columns exist and convert to numeric, coercing errors
    metric_cols = ['clicks', 'impressions', 'ctr', 'position']
    print("✓ Converting metrics to numeric types...")
    for col in metric_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce')
        else:
            # If essential metrics like 'impressions' are missing, we might have issues
            print(f"   Note: Metric column '{col}' not found in raw data.")
            if col == 'impressions' or col == 'clicks':
                 df[col] = 0 # Add column with 0 if essential and missing

    # Drop rows where essential columns might have become NaN after coercion
    df.dropna(subset=['query', 'page', 'impressions', 'clicks'], inplace=True)

    # Optional: Convert CTR to percentage if desired (not strictly needed for this task)
    # if 'ctr' in df.columns:
    #     df['ctr'] = df['ctr'] * 100

    print(f"✓ Initial DataFrame processed ({len(df)} rows).")
    return df


def generate_top_keywords_json(df, base_url, top_n=10, max_words=4):
    """
    Processes the DataFrame to find top N keywords (<= max_words) per page
    and returns a dictionary formatted for JSON output.
    """
    if df.empty:
        print("Input DataFrame is empty. Cannot generate keyword data.")
        return {}

    print("\n⚙️ Processing data for top keywords...")

    # 1. Ensure required columns exist
    required_cols = ['page', 'query', 'impressions', 'clicks']
    if not all(col in df.columns for col in required_cols):
        print(f"❌ Error: DataFrame missing one or more required columns: {required_cols}")
        return {}

    # 2. Filter by keyword word count (n-gram limit)
    print(f"   Filtering keywords to max {max_words} words...")
    # Ensure query is string, handle potential NaN/None
    df['query_str'] = df['query'].astype(str).fillna('')
    df['word_count'] = df['query_str'].str.split().str.len()
    df_filtered = df[df['word_count'] <= max_words].copy()
    print(f"   Rows remaining after word count filter: {len(df_filtered)}")
    if df_filtered.empty:
         print("   No keywords found matching the word count criteria.")
         return {}

    # 3. Aggregate data by page and query (summing impressions/clicks over the period)
    print("   Aggregating impressions and clicks per page/query...")
    df_agg = df_filtered.groupby(['page', 'query'], as_index=False)[['impressions', 'clicks']].sum()
    # Convert aggregated impressions/clicks back to integer types
    df_agg['impressions'] = df_agg['impressions'].astype(int)
    df_agg['clicks'] = df_agg['clicks'].astype(int)


    # 4. Sort by impressions within each page group
    print("   Sorting keywords by impressions...")
    # Sort primarily by page, secondarily by impressions descending
    df_sorted = df_agg.sort_values(by=['page', 'impressions'], ascending=[True, False])

    # 5. Select Top N keywords per page
    print(f"   Selecting top {top_n} keywords per page...")
    df_top_n = df_sorted.groupby('page').head(top_n)
    print(f"   Total page/keyword combinations in top {top_n}: {len(df_top_n)}")

    # 6. Format URLs to relative paths for Jekyll keys
    print("   Formatting page URLs to relative paths...")
    def format_url_key(url_str):
        if not isinstance(url_str, str) or not url_str.startswith(base_url):
            return None # Skip URLs not matching the base URL
        # Remove base URL
        relative_path = url_str[len(base_url):]
        # Ensure it starts with '/'
        if not relative_path.startswith('/'):
            relative_path = '/' + relative_path
        # Optional: Remove trailing slash if Jekyll's page.url doesn't have one
        # if relative_path != '/' and relative_path.endswith('/'):
        #     relative_path = relative_path[:-1]
        return relative_path

    df_top_n['jekyll_url_key'] = df_top_n['page'].apply(format_url_key)
    # Drop rows where formatting failed (e.g., external URLs if any were present)
    df_final = df_top_n.dropna(subset=['jekyll_url_key'])
    print(f"   Valid Jekyll URL keys generated: {df_final['jekyll_url_key'].nunique()}")

    # 7. Structure data for JSON output
    print("   Structuring data for JSON output...")
    output_dict = {}
    # Group by the formatted Jekyll URL key
    for key, group in df_final.groupby('jekyll_url_key'):
        # For each group (page), create a list of keyword dictionaries
        output_dict[key] = group[['query', 'impressions', 'clicks']].to_dict('records')

    print("✓ Keyword processing complete.")
    return output_dict

# --- Main Execution ---

def main():
    """Main execution function."""
    print("--- Starting GSC Top Keywords Export ---")
    start_time = time.time()

    # 1. Authenticate
    gsc_service = authenticate_gsc()

    # 2. Determine Date Range
    end_date = datetime.now().date() - timedelta(days=START_OFFSET_DAYS)
    start_date = end_date - FETCH_PERIOD
    start_date_str = start_date.strftime('%Y-%m-%d')
    end_date_str = end_date.strftime('%Y-%m-%d')

    # 3. Define API Request Body for the entire period
    request_body = {
        'startDate': start_date_str,
        'endDate': end_date_str,
        'dimensions': ['query', 'page'],
        # Optional: Add 'type': 'web' or other filters if needed
        # 'dimensionFilterGroups': [{...}],
        'rowLimit': 25000, # Max per request page
        'startRow': 0
    }

    # 4. Fetch Data
    raw_gsc_data = fetch_all_gsc_data(gsc_service, SITE_URL, request_body)

    if not raw_gsc_data:
        print("\n❌ No data fetched from GSC. Exiting.")
        sys.exit(1)

    # 5. Process into Initial DataFrame
    df_gsc = process_gsc_data_to_dataframe(raw_gsc_data)

    if df_gsc.empty:
         print("\n❌ DataFrame processing failed or resulted in empty data. Exiting.")
         sys.exit(1)

    # 6. Generate the Top Keywords Dictionary
    top_keywords_data = generate_top_keywords_json(
        df_gsc,
        base_url=BASE_URL,
        top_n=TOP_N_KEYWORDS,
        max_words=MAX_KEYWORD_WORDS
    )

    # 7. Save to JSON File
    if not top_keywords_data:
        print("\n⚠️ No keyword data generated. Skipping JSON file creation.")
    else:
        output_path = os.path.join(JEKYLL_DATA_DIR, OUTPUT_JSON_FILENAME)
        print(f"\n💾 Saving top keywords data to: {output_path}")
        try:
            # Ensure the _data directory exists
            os.makedirs(JEKYLL_DATA_DIR, exist_ok=True)
            # Write the JSON file
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(top_keywords_data, f, indent=2, ensure_ascii=False) # indent for readability
            print(f"✓ Successfully saved JSON data.")
        except Exception as e:
            print(f"\n❌ Error saving JSON file: {e}")

    end_time = time.time()
    print(f"\n--- Script finished in {end_time - start_time:.2f} seconds ---")


if __name__ == "__main__":
    # Basic check for SITE_URL placeholder
    if not SITE_URL or SITE_URL == "sc-domain:yourdomain.com":
        print("❌ Error: Please update the 'SITE_URL' variable in the script configuration section.")
        sys.exit(1)
    if not BASE_URL or "example.com" in BASE_URL:
         print("❌ Error: Please update the 'BASE_URL' variable in the script configuration section.")
         sys.exit(1)

    main()
```

**Explanation of Key Changes:**

1.  **Configuration:**
    * Added `BASE_URL`: Essential for converting absolute GSC URLs to relative paths matching Jekyll's `page.url`.
    * Added `Workspace_PERIOD`: Uses `dateutil.relativedelta` for flexible period definition (e.g., `months=3`, `days=90`). You'll need `pip install python-dateutil`.
    * Added `TOP_N_KEYWORDS` and `MAX_KEYWORD_WORDS` for clarity and control.
    * Added `JEKYLL_DATA_DIR` and `OUTPUT_JSON_FILENAME` to define the output location.
    * Removed `NUM_DAYS_TO_FETCH` and `CACHE_DIR` as they are no longer relevant.
2.  **Imports:** Added `json`, `relativedelta` from `dateutil.relativedelta`, and `urlparse` from `urllib.parse`.
3.  **Simplified Fetching:**
    * Removed daily fetching logic (`check_date_has_data`, `find_most_recent_gsc_data_date`, `get_gsc_data_for_day`, `analyze_trends`).
    * `main` now calculates a single `start_date` and `end_date` based on `Workspace_PERIOD`.
    * `Workspace_all_gsc_data` is called *once* with the full date range request.
4.  **Refined Processing (`process_gsc_data_to_dataframe`):**
    * Made extraction of `query` and `page` more robust with error messages.
    * Removes the `data_date` parameter as it's not needed.
5.  **New Processing Logic (`generate_top_keywords_json`):**
    * This new function encapsulates all the steps outlined in the previous proposal: filtering by word count, aggregating impressions/clicks, sorting, selecting the top N, formatting URLs into relative paths (using `BASE_URL`), and structuring the data into the desired dictionary format.
6.  **JSON Output:**
    * The `main` function calls `generate_top_keywords_json`.
    * It constructs the full path to the output file in the specified `JEKYLL_DATA_DIR`.
    * It uses the `json` module to `dump` the resulting dictionary into the file with indentation for readability. Error handling for file writing is included.
7.  **Cleanup:** Removed unused imports and functions related to trend analysis. Updated print statements and docstrings.

**How to Use:**

1.  **Install dependencies:** `pip install google-api-python-client google-auth pandas python-dateutil`
2.  **Configure:** Set `SITE_URL`, `BASE_URL`, `SERVICE_ACCOUNT_KEY_FILE` path, `Workspace_PERIOD`, `TOP_N_KEYWORDS`, `MAX_KEYWORD_WORDS`, and `JEKYLL_DATA_DIR` correctly. Make sure the service account has access to the GSC property.
3.  **Run:** Execute the script (`python your_script_name.py`).
4.  **Check Output:** It will create/overwrite the `gsc_top_keywords.json` file in your specified `_data` directory.
5.  **Jekyll Build:** Ensure your Jekyll build process picks up this new `_data` file. Use the Liquid code provided previously in your `_layouts/post.html` to display the keywords.
6.  **Automate (Optional):** Set up a scheduled task (like a cron job or GitHub Action) to run this script periodically to keep the keyword data relatively fresh.

---

## Gemini Can Code

> You know that feeling when things go right the first time? Yeah, Gemini can
> code. On the first try, I ran what I named `gsc_keyworder.py`

```plaintext
[mike@nixos:~/repos/pipulate/precursors]$ python gsc_keyworder.py 
--- Starting GSC Top Keywords Export ---
✓ Successfully authenticated with Google Search Console API.

🔄 Fetching data for sc-domain:mikelev.in
   Period: 2025-01-09 to 2025-04-09
   Dimensions: ['query', 'page']
   Fetching page 1 (starting row 0)... ✓ Retrieved 5999 rows.
✓ Reached last page of results.
✓ Finished fetching. Total rows retrieved: 5999
✓ Extracted 'query' and 'page' from 'keys'.
✓ Converting metrics to numeric types...
✓ Initial DataFrame processed (5999 rows).

⚙️ Processing data for top keywords...
   Filtering keywords to max 4 words...
   Rows remaining after word count filter: 4977
   Aggregating impressions and clicks per page/query...
   Sorting keywords by impressions...
   Selecting top 10 keywords per page...
   Total page/keyword combinations in top 10: 981
   Formatting page URLs to relative paths...
/home/mike/repos/pipulate/precursors/gsc_keyworder.py:246: SettingWithCopyWarning: 
A value is trying to be set on a copy of a slice from a DataFrame.
Try using .loc[row_indexer,col_indexer] = value instead

See the caveats in the documentation: https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#returning-a-view-versus-a-copy
  df_top_n['jekyll_url_key'] = df_top_n['page'].apply(format_url_key)
   Valid Jekyll URL keys generated: 178
   Structuring data for JSON output...
✓ Keyword processing complete.

💾 Saving top keywords data to: /home/mike/repos/pipulate/precursors/../_data/gsc_top_keywords.json
✓ Successfully saved JSON data.

--- Script finished in 1.34 seconds ---

[mike@nixos:~/repos/pipulate/precursors]$
```

**Me**: Wow, that ran on the first try! The only change I made (after it ran successfully) is:

```python
JEKYLL_DATA_DIR = os.path.join(SCRIPT_DIR, '../../MikeLev.in/_data') # Assumes script is in a subdir like 'scripts'
```

...so it ends up in-location in the correct Jekyll `_datg` location.

We're already up to Phase 2! For the first pass of phase 2 and for the sake of
visibility during testing, I'd like the keywords to appear near the bottom of
the page under where it says:

Post #217 of 218 - April 10, 2025

...so, for example:

Categorized under: [list of comma separated keywords]

**Gemini**: Excellent! Great to hear the Python script worked smoothly.

Okay, let's integrate the display logic into your `_layouts/post.html` to show the keywords as requested, right below the "Post #X of Y" line.

Find this section in your `_layouts/post.html` file (it's near the very end):

```liquid
{% raw %}{% comment %}
  Calculate post number using the flat index position instead of backwards counting
  Reverse the numbering so newest posts (position 0) show as highest number
{% endcomment %}
{% assign total_posts = flat_index.size %}
{% assign post_number = total_posts | minus: current_position %}

<div class="post-counter" style="text-align: center; margin: 20px 0; font-style: italic;">
  <span>Post #{{ post_number }} of {{ total_posts }} - {{ page.date | date: '%B %-d, %Y' }}</span>
</div>

{% comment %} <<< INSERT THE NEW CODE BLOCK HERE >>> {% endcomment %}{% endraw %}
```

Insert the following Liquid code block exactly where the `<<< INSERT THE NEW CODE BLOCK HERE >>>` comment is placed above:

```liquid
{% raw %}{% comment %} --- Display Top GSC Keywords (Comma Separated) --- {% endcomment %}
{% assign current_page_url = page.url %}
{% assign top_keywords_list = site.data.gsc_top_keywords[current_page_url] %}

{% if top_keywords_list and top_keywords_list.size > 0 %}
  {% comment %} Extract just the 'query' string from each keyword data object {% endcomment %}
  {% assign keyword_names = top_keywords_list | map: 'query' %}
  <div class="gsc-categories" style="text-align: center; margin: 10px 0 20px 0; font-style: italic; color: #999;">
    Categorized under: {{ keyword_names | join: ', ' }}
  </div>
{% endif %}
{% comment %} --- End Display Top GSC Keywords --- {% endcomment %{% endraw %}}
```

**Explanation:**

1.  `{% raw %}{% assign current_page_url = page.url %}`: Gets the URL of the current post being rendered{% endraw %}.
2.  `{% raw %}{% assign top_keywords_list = site.data.gsc_top_keywords[current_page_url] %}`: Looks up the data in your `_data/gsc_top_keywords.json` file using the current page's URL as the key. This retrieves the array of top keyword objects for *this specific page*{% endraw %}.
3.  `{% raw %}{% if top_keywords_list and top_keywords_list.size > 0 %}`: Checks if any keyword data was actually found for this page before trying to display anything{% endraw %}.
4.  `{% raw %}{% assign keyword_names = top_keywords_list | map: 'query' %}`: This is the key step for your desired format. It uses the `map` filter to iterate through the `top_keywords_list` array and pull out *only* the value associated with the `query` key from each object, creating a new array containing just the keyword strings{% endraw %}.
5.  `<div class="gsc-categories" ...>`: Creates a container div for the output. I've added a class `gsc-categories` so you can style it later in your CSS if needed, and included some basic inline styles similar to your `post-counter` for initial visibility.
6.  `{% raw %}Categorized under: {{akeyword_names | join: ', ' }}`: Prints the literal text "Categorized under: " followed by the array of keyword strings (`keyword_names`), joined together into a single string with a comma and space (`, `) as the separator{% endraw %}.

Now, when you rebuild your Jekyll site, any post that has corresponding entries in your `gsc_top_keywords.json` file should display the top keywords from GSC in the specified comma-separated format right below the post counter.

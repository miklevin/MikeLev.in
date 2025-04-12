---
title: "Google Search Console API Python Example: Trend Analysis"
permalink: /futureproof/google-search-console-api-python/
description: Seeing a sudden spike in my GSC impressions, I realized the web UI wasn't enough for a deep dive. This article is my walkthrough of how I used Python and the GSC API (via a service account) to fetch granular, per-keyword/per-URL data over several days, handling caching and pagination along the way. I'll show you how to process this data with Pandas and apply linear regression to calculate trend slopes, ultimately revealing the 'movers and shakers' responsible for the changes.
meta_description: Use Python scripts with the GSC API and Pandas to analyze daily search performance, identify keyword/page trends via linear regression, and find SEO movers & shakers.
meta_keywords: GSC API, Python, SEO, Trend Analysis, Movers Shakers, Linear Regression, Pandas, Google Search Console, API Authentication, Service Account, Granular Data, Keyword URL, Impressions Trend, Clicks Trend, Position Trend, Slope Calculation, Data Fetching, Pagination, Caching, GCP, SEO Script, Dataframe, Numpy
layout: post
sort_order: 2
---

Something's up in my personal test-site's Google Search Console (GSC) — and
that something is impressions. Looking at a hockeystick curve like this makes
you wonder what's the story? There is a per-keyword / per-URL story here — an
analysis every SEO should be able to do: identifying sudden movers & shakers
using steep-slope linear regression. That's sortable sparklines to you Excel
wonks. I'll try to walk you through it gently.

![Google Search Console Impressions Hockeystick Curve](/images/google-search-console-impressions-hockeystick-curve.png)

## You Need More Granular Data Than GSC Lets You Download

How many times have you wanted to download more than 1000 pages or queries from
the GSC web user interface, and said "oh, you can do that with the API," but
then never really done it? This is the page resource to make it as easy as
reasonably possible for you. And it's worse than getting more than 1000. It's
not having to switch between `queries` and `pages` tabs on the final download.
It's having per-query/per-page in the same table.

### Per Keyword Per URL

It's a little tough to wrap your mind around at first. But every URL (page) has
a list of keywords (queries) that lead to it. Therefore, there is an
association between keywords and pages *that gets lost* using the normal GSC
Web UI download feature. You *lose the granularity* required to do this sort of
analysis. Getting the data through the API is the only way.

The crucial first step is setting up authentication. It's a question of
throwing you down the rabbit hole abyss of OAuth authentication versus a
service account. 

## GSC Authentication: GCP Service Account

The most common and relatively easy method for GSC authentication, especially
for automated scripts, is using a **Service Account**. This involves creating a
special account in Google Cloud Platform (GCP) and downloading a key file that
your script will use to prove its identity.

**Steps to Get Your Service Account Key File and Grant Access:**

1.  **Enable the API in GCP:** Go to the Google Cloud Platform console, find your project (or create one), and enable the "Google Search Console API".
2.  **Create a Service Account:**
    * Navigate to "IAM & Admin" > "Service Accounts".
    * Click "Create Service Account".
    * Give it a name and description.
    * Copy the generated email address (you'll need this later).
    * Grant it a role (the article uses "Owner", though other roles might suffice).
3.  **Generate and Download the Key File:**
    * Find your newly created service account in the list.
    * Click the three dots menu (...) next to it and select "Manage keys".
    * Click "ADD KEY" > "Create new key".
    * Choose **JSON** as the key type and click "Create".
    * A `.json` file will download to your computer. **This is your service account key file – keep it secure!**
4.  **Grant Permissions in GSC:**
    * Go to your Google Search Console property.
    * Navigate to "Settings" > "Users and permissions".
    * Click "Add user".
    * Paste the service account **email address** you copied earlier.
    * Set the permission level to "Full" access.
    * Click "Add".

With the downloaded `.json` key file and the permissions granted in GSC, your script can now authenticate and interact with the GSC API.

## Getting Most Recent Date With Data in GSC

If you made it this far, then you've gotten over the biggest hurdle. You can
work in either a Jupyter Notebook like Google Colab or the one that comes with
Pipualte, or you can work in a plain old Python file like I'm doing in this
example, `gsc_top_movers.py`. The completed file can be found in the Pipulate
project at `pipulate/precursors/gsc_top_movers.py`, but for this article, we are
going to build it up step-by-step. I mean, they're going to be pretty big steps.
Step 1:

```python
#!/usr/bin/env python
# coding: utf-8

"""
Finds the most recent date for which Google Search Console (GSC) data
is available for a specified site using a service account.

Required pip installs:
    pip install google-api-python-client google-auth
"""

import os
import sys
import time
from datetime import datetime, timedelta

from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# --- Configuration ---

# Set your GSC Property URL here (e.g., "sc-domain:example.com" or "https://www.example.com/")
# IMPORTANT: Make sure the service account has access to this property!
SITE_URL = "sc-domain:mikelev.in"  

# Path to your service account key JSON file
# Assumes the key file is in the same directory as the script. Adjust if needed.
SERVICE_ACCOUNT_KEY_FILE = os.path.join(os.path.dirname(__file__), 'service-account-key.json')

# Required Google API scopes
SCOPES = ['https://www.googleapis.com/auth/webmasters']

# GSC data typically has a delay. Start checking this many days before today.
START_OFFSET_DAYS = 2

# Maximum number of past days to check before giving up
MAX_DAYS_TO_CHECK = 10

# Delay between API checks (in seconds) to respect rate limits
API_CHECK_DELAY = 0.5

# --- End Configuration ---


def authenticate_gsc():
    """Authenticates with Google API using service account credentials."""
    if not os.path.exists(SERVICE_ACCOUNT_KEY_FILE):
        print(f"Error: Service account key file not found at: {SERVICE_ACCOUNT_KEY_FILE}")
        print("Please ensure the file exists and the path is correct.")
        sys.exit(1)

    try:
        credentials = service_account.Credentials.from_service_account_file(
            SERVICE_ACCOUNT_KEY_FILE, scopes=SCOPES)
        webmasters_service = build('webmasters', 'v3', credentials=credentials)
        print("✓ Successfully authenticated with Google Search Console API.")
        return webmasters_service
    except Exception as e:
        print(f"Error during GSC authentication: {e}")
        sys.exit(1)


def check_date_has_data(service, site_url, check_date):
    """
    Checks if GSC has any performance data for the given site and date.

    Args:
        service: The authenticated GSC API service object.
        site_url (str): The GSC property URL.
        check_date (date): The date to check for data.

    Returns:
        bool: True if data exists for the date, False otherwise.
    """
    date_str = check_date.strftime('%Y-%m-%d')
    # Create a minimal query request for the specific date
    request_body = {
        'startDate': date_str,
        'endDate': date_str,
        'dimensions': ['query'],  # Using a minimal dimension
        'rowLimit': 1             # We only need 1 row to confirm data exists
    }

    try:
        # Execute the query via the searchanalytics endpoint
        response = service.searchanalytics().query(
            siteUrl=site_url,
            body=request_body
        ).execute()

        # Check if the 'rows' key exists and contains any data
        return bool(response.get('rows')) # More concise check

    except HttpError as e:
        # Handle common API errors gracefully
        print(f"\nAPI Error querying for date {date_str}: {e.resp.status} {e.resp.reason}")
        if e.resp.status == 403:
             print("   (This could be a permission issue or rate limiting.)")
        elif e.resp.status == 429:
             print("   (Rate limit exceeded. Consider increasing API_CHECK_DELAY.)")
        # Continue checking previous days despite error on this date
        return False
    except Exception as e:
        # Catch other potential exceptions
        print(f"\nUnexpected error querying for date {date_str}: {e}")
        return False


def find_most_recent_gsc_data_date(service, site_url):
    """
    Iterates backward from recent dates to find the latest date with GSC data.

    Args:
        service: The authenticated GSC API service object.
        site_url (str): The GSC property URL to check.

    Returns:
        date or None: The most recent date with data, or None if not found within limit.
    """
    most_recent_data_date = None
    days_checked = 0
    current_date = datetime.now().date() - timedelta(days=START_OFFSET_DAYS)

    print(f"\nFinding most recent data for site: {site_url}")
    print(f"Starting check from date: {current_date}")

    while days_checked < MAX_DAYS_TO_CHECK:
        print(f"Checking date {current_date}...", end=" ", flush=True)

        if check_date_has_data(service, site_url, current_date):
            print("✓ Data found!")
            most_recent_data_date = current_date
            break  # Exit loop once data is found
        else:
            print("✗ No data")
            current_date -= timedelta(days=1)
            days_checked += 1
            time.sleep(API_CHECK_DELAY) # Pause before the next check

    return most_recent_data_date


def main():
    """Main execution function."""
    # 1. Authenticate and get the GSC service object
    gsc_service = authenticate_gsc()

    # 2. Find the most recent date with data
    latest_date = find_most_recent_gsc_data_date(gsc_service, SITE_URL)

    # 3. Report the result
    if latest_date:
        print(f"\nSuccess: Most recent GSC data available is for: {latest_date.strftime('%Y-%m-%d')}")
    else:
        last_checked_date = datetime.now().date() - timedelta(days=START_OFFSET_DAYS + MAX_DAYS_TO_CHECK -1)
        print(f"\nWarning: Could not find GSC data within the last {MAX_DAYS_TO_CHECK} checked days")
        print(f"         (Checked back to {last_checked_date.strftime('%Y-%m-%d')}).")
        print("         Please verify the service account has permissions for the site,")
        print("         and check the GSC interface for data availability.")


if __name__ == "__main__":
    # Ensure SITE_URL is set
    if not SITE_URL:
         print("Error: Please set the GSC_SITE_URL environment variable or update the 'SITE_URL' variable in the script.")
         print("Example usage: GSC_SITE_URL=\"sc-domain:example.com\" python precursors/gsc_movers_and_shakers.py")
         sys.exit(1)
    main()
```

The glorious output of this script is a simple date, the most recent date in
Google Search Console that actually has data. Many scripts out there will assume
2, 3 or 4 days ago based on assumptions, but I like to know. If the Web UI shows
data up to a certain day, I want my scripts to automatically choose that same
day. The only value you should have to hardwire is your domain, and even that
could be brought in through the command-line args, but I'm keeping that extra
code out of this (for now).

```plaintext
[mike@nixos:~/repos/pipulate/precursors]$ python gsc_top_movers.py 
✓ Successfully authenticated with Google Search Console API.

Finding most recent data for site: sc-domain:mikelev.in
Starting check from date: 2025-04-08
Checking date 2025-04-08... ✓ Data found!

Success: Most recent GSC data available is for: 2025-04-08
```

## Downloading Most Recent Day of GSC Data

Now the GSC API supports start and end dates and various metrics and dimensions,
and for the sake of an easy-ish example, we will start out with downloading and
putting into a Pandas DataFrame just 1-day of data from the most recent day we
just found, and ask for only the `query` and `page` dimensions. We will also
ask for the maximum `rowLimit` of 25000 and deliberately start at `startRow` 0
so we can step through and empty out all the responses into a single Python
DataFrame...

```python
#!/usr/bin/env python
# coding: utf-8

"""
Finds the most recent date for which Google Search Console (GSC) data
is available for a specified site using a service account.

Required pip installs:
    pip install google-api-python-client google-auth
"""

import os
import sys
import time
from datetime import datetime, timedelta

import pandas as pd
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# --- Configuration ---

# Set your GSC Property URL here (e.g., "sc-domain:example.com" or "https://www.example.com/")
# IMPORTANT: Make sure the service account has access to this property!
SITE_URL = "sc-domain:mikelev.in"

# Path to your service account key JSON file
# Assumes the key file is in the same directory as the script. Adjust if needed.
SERVICE_ACCOUNT_KEY_FILE = os.path.join(os.path.dirname(__file__), 'service-account-key.json')

# Required Google API scopes
SCOPES = ['https://www.googleapis.com/auth/webmasters']

# GSC data typically has a delay. Start checking this many days before today.
START_OFFSET_DAYS = 2

# Maximum number of past days to check before giving up
MAX_DAYS_TO_CHECK = 10

# Delay between API checks (in seconds) to respect rate limits
API_CHECK_DELAY = 0.5

# --- End Configuration ---


def authenticate_gsc():
    """Authenticates with Google API using service account credentials."""
    if not os.path.exists(SERVICE_ACCOUNT_KEY_FILE):
        print(f"Error: Service account key file not found at: {SERVICE_ACCOUNT_KEY_FILE}")
        print("Please ensure the file exists and the path is correct.")
        sys.exit(1)

    try:
        credentials = service_account.Credentials.from_service_account_file(
            SERVICE_ACCOUNT_KEY_FILE, scopes=SCOPES)
        webmasters_service = build('webmasters', 'v3', credentials=credentials)
        print("✓ Successfully authenticated with Google Search Console API.")
        return webmasters_service
    except Exception as e:
        print(f"Error during GSC authentication: {e}")
        sys.exit(1)


def check_date_has_data(service, site_url, check_date):
    """
    Checks if GSC has any performance data for the given site and date.

    Args:
        service: The authenticated GSC API service object.
        site_url (str): The GSC property URL.
        check_date (date): The date to check for data.

    Returns:
        bool: True if data exists for the date, False otherwise.
    """
    date_str = check_date.strftime('%Y-%m-%d')
    # Create a minimal query request for the specific date
    request_body = {
        'startDate': date_str,
        'endDate': date_str,
        'dimensions': ['query'],  # Using a minimal dimension
        'rowLimit': 1             # We only need 1 row to confirm data exists
    }

    try:
        # Execute the query via the searchanalytics endpoint
        response = service.searchanalytics().query(
            siteUrl=site_url,
            body=request_body
        ).execute()

        # Check if the 'rows' key exists and contains any data
        return bool(response.get('rows'))  # More concise check

    except HttpError as e:
        # Handle common API errors gracefully
        print(f"\nAPI Error querying for date {date_str}: {e.resp.status} {e.resp.reason}")
        if e.resp.status == 403:
            print("   (This could be a permission issue or rate limiting.)")
        elif e.resp.status == 429:
            print("   (Rate limit exceeded. Consider increasing API_CHECK_DELAY.)")
        # Continue checking previous days despite error on this date
        return False
    except Exception as e:
        # Catch other potential exceptions
        print(f"\nUnexpected error querying for date {date_str}: {e}")
        return False


def find_most_recent_gsc_data_date(service, site_url):
    """
    Iterates backward from recent dates to find the latest date with GSC data.

    Args:
        service: The authenticated GSC API service object.
        site_url (str): The GSC property URL to check.

    Returns:
        date or None: The most recent date with data, or None if not found within limit.
    """
    most_recent_data_date = None
    days_checked = 0
    current_date = datetime.now().date() - timedelta(days=START_OFFSET_DAYS)

    print(f"\nFinding most recent data for site: {site_url}")
    print(f"Starting check from date: {current_date}")

    while days_checked < MAX_DAYS_TO_CHECK:
        print(f"Checking date {current_date}...", end=" ", flush=True)

        if check_date_has_data(service, site_url, current_date):
            print("✓ Data found!")
            most_recent_data_date = current_date
            break  # Exit loop once data is found
        else:
            print("✗ No data")
            current_date -= timedelta(days=1)
            days_checked += 1
            time.sleep(API_CHECK_DELAY)  # Pause before the next check

    return most_recent_data_date


def fetch_all_gsc_data(service, site_url, request_body):
    """
    Fetches all available data rows for a given GSC query, handling pagination.

    Args:
        service: The authenticated GSC API service object.
        site_url (str): The GSC property URL.
        request_body (dict): The initial query request body. Must include
                             'rowLimit' and 'startRow'.

    Returns:
        list: A list containing all the row data dictionaries fetched from GSC.
              Returns an empty list if an error occurs or no data is found.
    """
    all_rows = []
    start_row = request_body.get('startRow', 0)
    row_limit = request_body.get('rowLimit', 1000)  # Default GSC limit if not specified
    page_count = 0

    print(f"\nFetching data with dimensions: {request_body.get('dimensions', [])}")

    while True:
        page_count += 1
        request_body['startRow'] = start_row
        print(f"Fetching page {page_count} (starting row {start_row})...", end=" ", flush=True)

        try:
            response = service.searchanalytics().query(
                siteUrl=site_url,
                body=request_body
            ).execute()

            current_rows = response.get('rows', [])

            if not current_rows:
                if page_count == 1:
                    print("No data found for this query.")
                else:
                    print("✓ No more data.")
                break  # Exit loop if no rows are returned

            print(f"✓ Retrieved {len(current_rows)} rows.")
            all_rows.extend(current_rows)

            # GSC API max rowLimit is 25000, but let's use the requested rowLimit
            # If fewer rows than the limit are returned, it's the last page
            if len(current_rows) < row_limit:
                print("✓ Reached last page of results.")
                break  # Exit loop if last page is fetched

            start_row += len(current_rows)
            time.sleep(API_CHECK_DELAY)  # Be nice to the API between pages

        except HttpError as e:
            print(f"\nAPI Error during data fetch (page {page_count}): {e.resp.status} {e.resp.reason}")
            if e.resp.status in [403, 429]:
                print("   (Consider permissions, quotas, or increasing API_CHECK_DELAY.)")
            print("   Aborting data fetch for this request.")
            return []  # Return empty list on error
        except Exception as e:
            print(f"\nUnexpected error during data fetch (page {page_count}): {e}")
            print("   Aborting data fetch for this request.")
            return []  # Return empty list on error

    print(f"✓ Finished fetching. Total rows retrieved: {len(all_rows)}")
    return all_rows


def process_gsc_data_to_dataframe(gsc_data_list):
    """
    Converts the raw list of GSC data rows into a processed Pandas DataFrame.

    Args:
        gsc_data_list (list): A list of row data dictionaries from fetch_all_gsc_data.

    Returns:
        pandas.DataFrame: A DataFrame with processed GSC data, including separate
                          'query' and 'page' columns, and numeric metrics.
                          Returns an empty DataFrame if input is empty or invalid.
    """
    if not gsc_data_list:
        print("No data to process into DataFrame.")
        return pd.DataFrame()

    df = pd.DataFrame(gsc_data_list)

    # Split the 'keys' column (list) into separate dimension columns
    if 'keys' in df.columns and not df['keys'].empty:
        # Assuming dimensions are ['query', 'page'] as requested
        try:
            df['query'] = df['keys'].apply(lambda x: x[0] if isinstance(x, list) and len(x) > 0 else None)
            df['page'] = df['keys'].apply(lambda x: x[1] if isinstance(x, list) and len(x) > 1 else None)
            df = df.drop('keys', axis=1)
            print("✓ Split 'keys' into 'query' and 'page' columns.")
        except Exception as e:
            print(f"Warning: Could not split 'keys' column reliably: {e}")
            # Keep the 'keys' column if splitting fails
            if 'query' in df.columns:
                df = df.drop('query', axis=1)
            if 'page' in df.columns:
                df = df.drop('page', axis=1)

    # Ensure standard metric columns exist and convert to numeric types
    metric_cols = ['clicks', 'impressions', 'ctr', 'position']
    for col in metric_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce')  # Coerce errors to NaN
            # Optional: Fill NaNs created by coercion if needed, e.g., df[col] = df[col].fillna(0)
        else:
            # Add the column with default value if missing (optional)
            # df[col] = 0
            print(f"Note: Metric column '{col}' not found in raw data.")

    # Optional: Convert CTR to percentage for display
    if 'ctr' in df.columns:
        df['ctr'] = df['ctr'] * 100
        print("✓ Converted 'ctr' to percentage.")

    print(f"✓ Processed data into DataFrame with {len(df)} rows and {len(df.columns)} columns.")
    return df


def main():
    """Main execution function."""
    # 1. Authenticate and get the GSC service object
    gsc_service = authenticate_gsc()

    # 2. Find the most recent date with data
    latest_date = find_most_recent_gsc_data_date(gsc_service, SITE_URL)

    # --- ADD THE FOLLOWING ---
    # 3. If a date was found, fetch and process the data for that day
    if latest_date:
        print(f"\nAttempting to download data for the most recent date: {latest_date.strftime('%Y-%m-%d')}")

        # Define the request for that single day
        single_day_request = {
            'startDate': latest_date.strftime('%Y-%m-%d'),
            'endDate': latest_date.strftime('%Y-%m-%d'),
            'dimensions': ['query', 'page'],
            'rowLimit': 25000,  # Use max row limit per page fetch
            'startRow': 0
        }

        # Fetch data using the pagination function
        raw_gsc_data = fetch_all_gsc_data(gsc_service, SITE_URL, single_day_request)

        # Process the raw data into a DataFrame
        df_gsc_data = process_gsc_data_to_dataframe(raw_gsc_data)

        # Display results if DataFrame is not empty
        if not df_gsc_data.empty:
            print("\n--- GSC Data DataFrame Preview (first 10 rows) ---")
            # Set display options for better preview
            pd.set_option('display.max_rows', 20)
            pd.set_option('display.max_columns', None)
            pd.set_option('display.width', 100)
            pd.set_option('display.max_colwidth', 50)
            print(df_gsc_data.head(10))

            print("\n--- DataFrame Info ---")
            df_gsc_data.info()

            print("\n--- Basic Stats ---")
            # Use describe() for numeric columns, handle potential missing columns
            numeric_cols = df_gsc_data.select_dtypes(include=['number']).columns
            if not numeric_cols.empty:
                print(df_gsc_data[numeric_cols].describe())
            else:
                print("No numeric columns found for describe().")

            # Example of accessing specific data
            # print(f"\nTotal Clicks: {df_gsc_data['clicks'].sum()}")
            # print(f"Total Impressions: {df_gsc_data['impressions'].sum()}")

        else:
            print("\nNo data was processed into the DataFrame.")
    # --- END OF ADDED SECTION ---
    else:
        # This part was already there: handle case where no date was found
        last_checked_date = datetime.now().date() - timedelta(days=START_OFFSET_DAYS + MAX_DAYS_TO_CHECK - 1)
        print(f"\nWarning: Could not find GSC data within the last {MAX_DAYS_TO_CHECK} checked days")
        print(f"         (Checked back to {last_checked_date.strftime('%Y-%m-%d')}).")
        print("         Cannot proceed with data download.")
        # Removed the previous permission/interface check message as it's less relevant here


# --- Ensure the final block still calls main() ---
if __name__ == "__main__":
    # Ensure SITE_URL is set (this check can be simplified or enhanced)
    if not SITE_URL or SITE_URL == "sc-domain:yourdomain.com":  # Added check for default placeholder
        print("Error: Please update the 'SITE_URL' variable in the script configuration.")
        sys.exit(1)
    main()
```

The first program has been expanded with a number of functions added and a
reworking of the `main` function. Here's the explanation.

1.  **Import pandas:** We add `import pandas as pd` at the top to handle data manipulation.
2.  **`Workspace_all_gsc_data` function:** This function is crucial. It takes the initial request and repeatedly calls the GSC API, increasing the `startRow` each time, until all data matching the request (for the specified date and dimensions) is collected. It includes basic error handling and delays between calls.
3.  **`process_gsc_data_to_dataframe` function:** This takes the raw list of data returned by the API and transforms it into a structured Pandas DataFrame. It splits the `keys` list into proper `query` and `page` columns and ensures the metric columns (`clicks`, `impressions`, `ctr`, `position`) are numeric.
4.  **Updated `main` function:**
    * After successfully finding the `latest_date`, it defines a `single_day_request` dictionary using that date for both `startDate` and `endDate`, specifying the desired `dimensions`, and setting the maximum `rowLimit`.
    * It calls `Workspace_all_gsc_data` to get the raw data.
    * It calls `process_gsc_data_to_dataframe` to structure the data.
    * Finally, if data was successfully processed, it prints a preview of the DataFrame using `df_gsc_data.head(10)` and shows basic info and stats using `df_gsc_data.info()` and `df_gsc_data.describe()`.

## Running The 1-Day Version of GSC Script

> We're building-up here. I know it's a lot of code to look at. But this will
> let you build-up the same way, going from basic GSC access that finds the
> first day of data, to downloading the data for that day.

Now, running the script will not only find the most recent date but also download and display the query and page performance data for that specific day.

```plaintext
[mike@nixos:~/repos/pipulate/precursors]$ python gsc_top_movers.py 
✓ Successfully authenticated with Google Search Console API.

Finding most recent data for site: sc-domain:mikelev.in
Starting check from date: 2025-04-08
Checking date 2025-04-08... ✓ Data found!

Attempting to download data for the most recent date: 2025-04-08

Fetching data with dimensions: ['query', 'page']
Fetching page 1 (starting row 0)... ✓ Retrieved 3261 rows.
✓ Reached last page of results.
✓ Finished fetching. Total rows retrieved: 3261
✓ Split 'keys' into 'query' and 'page' columns.
✓ Converted 'ctr' to percentage.
✓ Processed data into DataFrame with 3261 rows and 6 columns.

--- GSC Data DataFrame Preview (first 10 rows) ---
   clicks  impressions         ctr   position                                  query  \
0       2            9   22.222222  11.111111                cursor jupyter notebook   
1       1           27    3.703704  41.851852                              cursor ai   
2       1            2   50.000000   3.500000                      cursor ai jupyter   
3       1            2   50.000000   7.000000            cursor and jupyter notebook   
4       1            1  100.000000   2.000000                               fasthtml   
5       1            3   33.333333  25.666667                               fasthtml   
6       1            1  100.000000  23.000000               function calling in llms   
7       1            3   33.333333   1.000000                          grok markdown   
8       1            3   33.333333   7.000000  how to run jupyter notebook in cursor   
9       1            7   14.285714   4.285714                       nix flake python   

                                                page  
0  https://mikelev.in/futureproof/jupyter-noteboo...  
1  https://mikelev.in/futureproof/ai-agentic-mode...  
2  https://mikelev.in/futureproof/jupyter-noteboo...  
3  https://mikelev.in/futureproof/jupyter-noteboo...  
4                https://mikelev.in/futureproof/foo/  
5  https://mikelev.in/futureproof/unpacking-fasth...  
6  https://mikelev.in/futureproof/function-callin...  
7  https://mikelev.in/futureproof/grok3-markdown-...  
8  https://mikelev.in/futureproof/jupyter-noteboo...  
9         https://mikelev.in/futureproof/nix-flakes/  

--- DataFrame Info ---
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 3261 entries, 0 to 3260
Data columns (total 6 columns):
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   clicks       3261 non-null   int64  
 1   impressions  3261 non-null   int64  
 2   ctr          3261 non-null   float64
 3   position     3261 non-null   float64
 4   query        3261 non-null   object 
 5   page         3261 non-null   object 
dtypes: float64(2), int64(2), object(2)
memory usage: 153.0+ KB

--- Basic Stats ---
            clicks  impressions          ctr     position
count  3261.000000  3261.000000  3261.000000  3261.000000
mean      0.003680     1.697639     0.165658    74.311338
std       0.065429     2.811669     3.456809    23.902479
min       0.000000     1.000000     0.000000     1.000000
25%       0.000000     1.000000     0.000000    64.000000
50%       0.000000     1.000000     0.000000    80.000000
75%       0.000000     2.000000     0.000000    92.000000
max       2.000000    87.000000   100.000000   194.000000
```

## Downloading 4 Individual Days of GSC Data

Now the beautiful thing here is that because all our data is for a particular
day which so happens to be the most recent day that has GSC data, we can start
to gather the data we need for really beautiful directional analysis per
keyword per URL. In GSC parlance, keyword is query and URL is page. So what we
do next is subtract 1 day from the date, and do the same thing we just did.

In fact, we can have a day-range and create a Pandas DataFrame for each day,
N-days back from the most recent that has data. For the sake of simplicity and
being kind to your computer's memory, we will only do 3 days back total, for a
total of 4 days worth of data, or 4 separate Pandas DataFrames.

Here's how we do that...

```python
#!/usr/bin/env python
# coding: utf-8

"""
Fetches Google Search Console (GSC) data for the 4 most recent days available
for a specified site using a service account. Saves each day to a CSV file.

Required pip installs:
    pip install google-api-python-client google-auth pandas
"""

import os
import sys
import time
from datetime import datetime, timedelta

import pandas as pd
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# --- Configuration ---

# Set your GSC Property URL here (e.g., "sc-domain:example.com" or "https://www.example.com/")
SITE_URL = "sc-domain:mikelev.in"

# Path to your service account key JSON file
# Assumes the key file is in the same directory as the script. Adjust if needed.
SCRIPT_DIR = os.path.dirname(__file__)
SERVICE_ACCOUNT_KEY_FILE = os.path.join(SCRIPT_DIR, 'service-account-key.json')

# Required Google API scopes
SCOPES = ['https://www.googleapis.com/auth/webmasters']

# GSC data typically has a delay. Start checking this many days before today.
START_OFFSET_DAYS = 2

# Maximum number of past days to check before giving up
MAX_DAYS_TO_CHECK = 10

# Delay between API checks (in seconds) to respect rate limits
API_CHECK_DELAY = 0.5

# Number of consecutive days of data to fetch (ending on the most recent date)
NUM_DAYS_TO_FETCH = 4

# Directory to store/load cached daily GSC data CSV files
CACHE_DIR = os.path.join(SCRIPT_DIR, 'gsc_cache')

# --- End Configuration ---


def authenticate_gsc():
    """Authenticates with Google API using service account credentials."""
    if not os.path.exists(SERVICE_ACCOUNT_KEY_FILE):
        print(f"Error: Service account key file not found at: {SERVICE_ACCOUNT_KEY_FILE}")
        print("Please ensure the file exists and the path is correct.")
        sys.exit(1)

    try:
        credentials = service_account.Credentials.from_service_account_file(
            SERVICE_ACCOUNT_KEY_FILE, scopes=SCOPES)
        webmasters_service = build('webmasters', 'v3', credentials=credentials)
        print("✓ Successfully authenticated with Google Search Console API.")
        return webmasters_service
    except Exception as e:
        print(f"Error during GSC authentication: {e}")
        sys.exit(1)


def check_date_has_data(service, site_url, check_date):
    """Checks if GSC has any performance data for the given site and date."""
    date_str = check_date.strftime('%Y-%m-%d')
    request_body = {
        'startDate': date_str, 'endDate': date_str,
        'dimensions': ['query'], 'rowLimit': 1
    }
    try:
        response = service.searchanalytics().query(
            siteUrl=site_url, body=request_body).execute()
        return bool(response.get('rows'))
    except HttpError as e:
        print(f"\nAPI Error checking date {date_str}: {e.resp.status} {e.resp.reason}")
        return False
    except Exception as e:
        print(f"\nUnexpected error checking date {date_str}: {e}")
        return False


def find_most_recent_gsc_data_date(service, site_url):
    """Iterates backward to find the latest date with GSC data."""
    most_recent_data_date = None
    days_checked = 0
    current_date = datetime.now().date() - timedelta(days=START_OFFSET_DAYS)
    print(f"\nFinding most recent data date for site: {site_url}")
    print(f"Starting check from date: {current_date}")
    while days_checked < MAX_DAYS_TO_CHECK:
        print(f"Checking date {current_date}...", end=" ", flush=True)
        if check_date_has_data(service, site_url, current_date):
            print("✓ Data found!")
            most_recent_data_date = current_date
            break
        else:
            print("✗ No data")
            current_date -= timedelta(days=1)
            days_checked += 1
            time.sleep(API_CHECK_DELAY)
    if not most_recent_data_date:
        last_checked_date = current_date + timedelta(days=1) # Date where check stopped
        print(f"\nWarning: Could not find data within {MAX_DAYS_TO_CHECK} checked days (back to {last_checked_date}).")
    return most_recent_data_date


def fetch_all_gsc_data(service, site_url, request_body):
    """Fetches all available data rows for a given GSC query, handling pagination."""
    all_rows = []
    start_row = request_body.get('startRow', 0)
    row_limit = request_body.get('rowLimit', 25000) # Use max GSC limit
    page_count = 0
    print(f"\nFetching data with dimensions: {request_body.get('dimensions', [])} for {request_body.get('startDate')}")
    while True:
        page_count += 1
        request_body['startRow'] = start_row
        print(f"Fetching page {page_count} (starting row {start_row})...", end=" ", flush=True)
        try:
            response = service.searchanalytics().query(
                siteUrl=site_url, body=request_body).execute()
            current_rows = response.get('rows', [])
            if not current_rows:
                if page_count == 1: print("No data found for this query.")
                else: print("✓ No more data.")
                break
            print(f"✓ Retrieved {len(current_rows)} rows.")
            all_rows.extend(current_rows)
            if len(current_rows) < row_limit:
                print("✓ Reached last page of results.")
                break
            start_row += len(current_rows)
            time.sleep(API_CHECK_DELAY)
        except HttpError as e:
            print(f"\nAPI Error fetching page {page_count}: {e.resp.status} {e.resp.reason}")
            return [] # Return empty list on error
        except Exception as e:
            print(f"\nUnexpected error fetching page {page_count}: {e}")
            return []
    print(f"✓ Finished fetching {request_body.get('startDate')}. Total rows: {len(all_rows)}")
    return all_rows


def process_gsc_data_to_dataframe(gsc_data_list, data_date):
    """Converts raw GSC data list into a processed Pandas DataFrame."""
    if not gsc_data_list:
        print(f"No data to process into DataFrame for {data_date}.")
        return pd.DataFrame()
    df = pd.DataFrame(gsc_data_list)
    if 'keys' in df.columns and not df['keys'].empty:
        try:
            df['query'] = df['keys'].apply(lambda x: x[0] if isinstance(x, list) and len(x) > 0 else None)
            df['page'] = df['keys'].apply(lambda x: x[1] if isinstance(x, list) and len(x) > 1 else None)
            df = df.drop('keys', axis=1)
        except Exception as e:
            print(f"Warning: Could not split 'keys' column for {data_date}: {e}")
    metric_cols = ['clicks', 'impressions', 'ctr', 'position']
    for col in metric_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce')
        else:
            print(f"Note: Metric column '{col}' not found for {data_date}.")
    if 'ctr' in df.columns: df['ctr'] = df['ctr'] * 100
    print(f"✓ Processed data for {data_date} into DataFrame ({len(df)} rows).")
    return df


def get_gsc_data_for_day(service, site_url, data_date):
    """
    Fetches GSC data for a specific day, using cache if available.

    Args:
        service: Authenticated GSC service object.
        site_url (str): Target GSC property URL.
        data_date (date): The specific date to fetch data for.

    Returns:
        pandas.DataFrame: DataFrame containing data for the specified date.
                          Returns an empty DataFrame if fetching fails or no data.
    """
    date_str = data_date.strftime('%Y-%m-%d')
    cache_filename = os.path.join(CACHE_DIR, f"gsc_data_{date_str}.csv")

    # Check cache first
    if os.path.exists(cache_filename):
        try:
            print(f"✓ Loading data for {date_str} from cache: {cache_filename}")
            # Specify dtypes to avoid warnings and ensure consistency
            df = pd.read_csv(cache_filename, dtype={
                'clicks': 'Int64', # Use nullable integer type
                'impressions': 'Int64',
                'ctr': 'float64',
                'position': 'float64',
                'query': 'object',
                'page': 'object'
            }, parse_dates=False) # Dates handled separately
            # Ensure CTR is percentage if loaded from CSV
            if 'ctr' in df.columns and df['ctr'].max() <= 1.0:
                 df['ctr'] = df['ctr'] * 100
            return df
        except Exception as e:
            print(f"Warning: Could not load cache file {cache_filename}. Error: {e}. Re-fetching.")

    # If not in cache or cache fails, fetch from API
    print(f"Fetching data for {date_str} from GSC API...")
    request = {
        'startDate': date_str, 'endDate': date_str,
        'dimensions': ['query', 'page'],
        'rowLimit': 25000, 'startRow': 0
    }
    raw_data = fetch_all_gsc_data(service, site_url, request)
    df = process_gsc_data_to_dataframe(raw_data, date_str)

    # Save to cache if data was fetched successfully and is not empty
    if not df.empty:
        try:
            os.makedirs(CACHE_DIR, exist_ok=True) # Ensure cache directory exists
            df.to_csv(cache_filename, index=False)
            print(f"✓ Saved data for {date_str} to cache: {cache_filename}")
        except Exception as e:
            print(f"Warning: Could not save data for {date_str} to cache. Error: {e}")

    return df


def main():
    """Main execution function."""
    # 1. Authenticate and get the GSC service object
    gsc_service = authenticate_gsc()

    # 2. Find the most recent date with data
    latest_date = find_most_recent_gsc_data_date(gsc_service, SITE_URL)

    if not latest_date:
        print("\nCannot proceed without a valid recent date.")
        sys.exit(1)

    print(f"\nSuccess: Most recent GSC data available is for: {latest_date.strftime('%Y-%m-%d')}")

    # 3. Determine the date range (last NUM_DAYS_TO_FETCH days)
    dates_to_fetch = [latest_date - timedelta(days=i) for i in range(NUM_DAYS_TO_FETCH)][::-1] # Reverse to get oldest first
    print(f"\nPreparing to fetch/load data for {NUM_DAYS_TO_FETCH} days:")
    for d in dates_to_fetch:
        print(f"  - {d.strftime('%Y-%m-%d')}")

    # 4. Fetch/load data for each day into a dictionary of DataFrames
    daily_dataframes = {}
    all_data_fetched = True
    for target_date in dates_to_fetch:
        df_day = get_gsc_data_for_day(gsc_service, SITE_URL, target_date)
        if df_day.empty and not os.path.exists(os.path.join(CACHE_DIR, f"gsc_data_{target_date.strftime('%Y-%m-%d')}.csv")):
             # Check if the file exists even if df is empty, maybe it was an empty day
             print(f"Warning: Failed to fetch or load data for {target_date.strftime('%Y-%m-%d')}. Trend analysis might be incomplete.")
             all_data_fetched = False
        daily_dataframes[target_date] = df_day

    # 5. Confirmation and next steps preview
    if all_data_fetched:
        print(f"\n✓ Successfully fetched/loaded data for all {len(daily_dataframes)} target days.")
        # Optionally display info about one of the DataFrames
        if latest_date in daily_dataframes and not daily_dataframes[latest_date].empty:
            print(f"\n--- Preview of data for the latest date ({latest_date.strftime('%Y-%m-%d')}): ---")
            print(daily_dataframes[latest_date].head())
            print(f"(Total rows for {latest_date.strftime('%Y-%m-%d')}: {len(daily_dataframes[latest_date])})")
        print("\nDataFrames are stored in the 'daily_dataframes' dictionary, keyed by date.")
        print("Next step: Combine these DataFrames and perform trend analysis.")
    else:
        print("\nWarning: Data fetching/loading was incomplete for one or more days.")
        print("Proceeding with available data, but trend analysis might be affected.")
        # Still print available data info
        print(f"\nAvailable DataFrames ({len(daily_dataframes)}): {list(daily_dataframes.keys())}")

    # The script now ends here. The next logical step (trend analysis)
    # would follow, using the 'daily_dataframes' dictionary.


if __name__ == "__main__":
    if not SITE_URL or SITE_URL == "sc-domain:yourdomain.com":
        print("Error: Please update the 'SITE_URL' variable in the script configuration.")
        sys.exit(1)
    main()
```

**Explanation of Changes:**

1.  **Configuration:** Added `NUM_DAYS_TO_FETCH` (set to 4) and `CACHE_DIR` variables.
2.  **`get_gsc_data_for_day` Function:** This new function encapsulates the logic for getting data for a *single* specific date.
    * It constructs the expected cache filename (`gsc_data_YYYY-MM-DD.csv`) inside the `CACHE_DIR`.
    * It first checks if this file exists. If yes, it loads the data using `pd.read_csv` (specifying dtypes for robustness) and returns the DataFrame.
    * If the file doesn't exist (or loading fails), it proceeds to call `Workspace_all_gsc_data` to get data from the API.
    * It then calls `process_gsc_data_to_dataframe`.
    * If the fetched data is not empty, it saves the DataFrame to the cache file using `df.to_csv(index=False)`.
    * It returns the resulting DataFrame (which might be empty if fetching failed or the day truly had no data).
3.  **Updated `main` Function:**
    * After finding `latest_date`, it calculates the list of `dates_to_fetch` (the 4 days ending on `latest_date`).
    * It initializes an empty dictionary `daily_dataframes` to store the results.
    * It loops through `dates_to_fetch`. In each iteration:
        * It calls `get_gsc_data_for_day` for the current date.
        * It stores the returned DataFrame in the `daily_dataframes` dictionary, using the date object as the key.
        * It includes a basic check (`all_data_fetched`) to see if data was obtained for all requested days.
    * After the loop, it prints a confirmation message and a preview of the data for the most recent day. It explicitly mentions that the data is now ready for the next step (trend analysis) and stored in the `daily_dataframes` dictionary.

Now, when you run this script, it will fetch (or load from cache) the data for each of the last 4 days and store them in memory, ready for the trend analysis code you outlined previously.

Here's sample output:

```plaintext
[mike@nixos:~/repos/pipulate/precursors]$ python gsc_top_movers.py 
✓ Successfully authenticated with Google Search Console API.

Finding most recent data date for site: sc-domain:mikelev.in
Starting check from date: 2025-04-08
Checking date 2025-04-08... ✓ Data found!

Success: Most recent GSC data available is for: 2025-04-08

Preparing to fetch/load data for 4 days:
  - 2025-04-05
  - 2025-04-06
  - 2025-04-07
  - 2025-04-08
Fetching data for 2025-04-05 from GSC API...

Fetching data with dimensions: ['query', 'page'] for 2025-04-05
Fetching page 1 (starting row 0)... ✓ Retrieved 214 rows.
✓ Reached last page of results.
✓ Finished fetching 2025-04-05. Total rows: 214
✓ Processed data for 2025-04-05 into DataFrame (214 rows).
✓ Saved data for 2025-04-05 to cache: /home/mike/repos/pipulate/precursors/gsc_cache/gsc_data_2025-04-05.csv
Fetching data for 2025-04-06 from GSC API...

Fetching data with dimensions: ['query', 'page'] for 2025-04-06
Fetching page 1 (starting row 0)... ✓ Retrieved 223 rows.
✓ Reached last page of results.
✓ Finished fetching 2025-04-06. Total rows: 223
✓ Processed data for 2025-04-06 into DataFrame (223 rows).
✓ Saved data for 2025-04-06 to cache: /home/mike/repos/pipulate/precursors/gsc_cache/gsc_data_2025-04-06.csv
Fetching data for 2025-04-07 from GSC API...

Fetching data with dimensions: ['query', 'page'] for 2025-04-07
Fetching page 1 (starting row 0)... ✓ Retrieved 1791 rows.
✓ Reached last page of results.
✓ Finished fetching 2025-04-07. Total rows: 1791
✓ Processed data for 2025-04-07 into DataFrame (1791 rows).
✓ Saved data for 2025-04-07 to cache: /home/mike/repos/pipulate/precursors/gsc_cache/gsc_data_2025-04-07.csv
Fetching data for 2025-04-08 from GSC API...

Fetching data with dimensions: ['query', 'page'] for 2025-04-08
Fetching page 1 (starting row 0)... ✓ Retrieved 3261 rows.
✓ Reached last page of results.
✓ Finished fetching 2025-04-08. Total rows: 3261
✓ Processed data for 2025-04-08 into DataFrame (3261 rows).
✓ Saved data for 2025-04-08 to cache: /home/mike/repos/pipulate/precursors/gsc_cache/gsc_data_2025-04-08.csv

✓ Successfully fetched/loaded data for all 4 target days.

--- Preview of data for the latest date (2025-04-08): ---
   clicks  impressions         ctr   position                        query                                               page
0       2            9   22.222222  11.111111      cursor jupyter notebook  https://mikelev.in/futureproof/jupyter-noteboo...
1       1           27    3.703704  41.851852                    cursor ai  https://mikelev.in/futureproof/ai-agentic-mode...
2       1            2   50.000000   3.500000            cursor ai jupyter  https://mikelev.in/futureproof/jupyter-noteboo...
3       1            2   50.000000   7.000000  cursor and jupyter notebook  https://mikelev.in/futureproof/jupyter-noteboo...
4       1            1  100.000000   2.000000                     fasthtml                https://mikelev.in/futureproof/foo/
(Total rows for 2025-04-08: 3261)

DataFrames are stored in the 'daily_dataframes' dictionary, keyed by date.
Next step: Combine these DataFrames and perform trend analysis.
```

## Top Movers & Shakers Directional Trending

Now you may be asking why go through all the trouble of downloading 4
individual days of GSC data when you could have just given a date-range
starting from 3-days prior to the first day that has data. The answer is that
we now have enough *granular* per-day data to do trend-lines! If you're an
Excel wonk, that's sparklines to you. And if you're a stats geek, that's enough
to calculate the linear regression coefficient slope. A steep positive slope
shows sudden upward movement. And so, we will be joining all 4 of our
dataframes and adding a linear regression coefficient slope column like so...

## Top Movers & Shakers Directional Trending

Now you may be asking why go through all the trouble of downloading 4 individual days of GSC data when you could have just given a date-range starting from 3-days prior to the first day that has data. The answer is that we now have enough *granular* per-day data to do trend-lines! If you're an Excel wonk, that's sparklines to you. And if you're a stats geek, that's enough to calculate the linear regression coefficient slope. A steep positive slope shows sudden upward movement. And so, we will be joining all 4 of our dataframes and adding a linear regression coefficient slope column.

This final version of the script takes the `daily_dataframes` dictionary (containing the data for our 4 chosen days, loaded either from the cache or fetched via the API) and performs the core trend analysis.

Here is the complete, final script (`gsc_top_movers.py`):

```python
#!/usr/bin/env python
# coding: utf-8

"""
Fetches Google Search Console (GSC) data for the 4 most recent days available,
calculates trend slopes for impressions, clicks, and position for each
page/query combination, and identifies top movers. Saves daily data to CSV cache.

Required pip installs:
    pip install google-api-python-client google-auth pandas numpy scipy
"""

import os
import sys
import time
from datetime import datetime, timedelta

import numpy as np
import pandas as pd
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# Need scipy for linregress OR numpy for polyfit - we'll use polyfit here
# from scipy.stats import linregress

# --- Configuration ---

# Set your GSC Property URL here (e.g., "sc-domain:example.com" or "https://www.example.com/")
SITE_URL = "sc-domain:mikelev.in"

# Path to your service account key JSON file
# Assumes the key file is in the same directory as the script. Adjust if needed.
SCRIPT_DIR = os.path.dirname(__file__)
SERVICE_ACCOUNT_KEY_FILE = os.path.join(SCRIPT_DIR, 'service-account-key.json')

# Required Google API scopes
SCOPES = ['https://www.googleapis.com/auth/webmasters']

# GSC data typically has a delay. Start checking this many days before today.
START_OFFSET_DAYS = 2

# Maximum number of past days to check before giving up
MAX_DAYS_TO_CHECK = 10

# Delay between API checks (in seconds) to respect rate limits
API_CHECK_DELAY = 0.5

# Number of consecutive days of data to fetch (ending on the most recent date)
NUM_DAYS_TO_FETCH = 4

# Directory to store/load cached daily GSC data CSV files
CACHE_DIR = os.path.join(SCRIPT_DIR, 'gsc_cache')

# --- End Configuration ---


# --- Functions from previous steps (authenticate_gsc, check_date_has_data, find_most_recent_gsc_data_date, fetch_all_gsc_data, process_gsc_data_to_dataframe, get_gsc_data_for_day) ---
# Include the full definitions of these functions here from the previous code block...

def authenticate_gsc():
    """Authenticates with Google API using service account credentials."""
    if not os.path.exists(SERVICE_ACCOUNT_KEY_FILE):
        print(f"Error: Service account key file not found at: {SERVICE_ACCOUNT_KEY_FILE}")
        sys.exit(1)
    try:
        credentials = service_account.Credentials.from_service_account_file(
            SERVICE_ACCOUNT_KEY_FILE, scopes=SCOPES)
        webmasters_service = build('webmasters', 'v3', credentials=credentials)
        print("✓ Successfully authenticated with Google Search Console API.")
        return webmasters_service
    except Exception as e:
        print(f"Error during GSC authentication: {e}")
        sys.exit(1)


def check_date_has_data(service, site_url, check_date):
    """Checks if GSC has any performance data for the given site and date."""
    date_str = check_date.strftime('%Y-%m-%d')
    request_body = {
        'startDate': date_str, 'endDate': date_str,
        'dimensions': ['query'], 'rowLimit': 1
    }
    try:
        response = service.searchanalytics().query(
            siteUrl=site_url, body=request_body).execute()
        return bool(response.get('rows'))
    except HttpError as e:
        print(f"\nAPI Error checking date {date_str}: {e.resp.status} {e.resp.reason}")
        return False
    except Exception as e:
        print(f"\nUnexpected error checking date {date_str}: {e}")
        return False


def find_most_recent_gsc_data_date(service, site_url):
    """Iterates backward to find the latest date with GSC data."""
    most_recent_data_date = None
    days_checked = 0
    current_date = datetime.now().date() - timedelta(days=START_OFFSET_DAYS)
    print(f"\nFinding most recent data date for site: {site_url}")
    print(f"Starting check from date: {current_date}")
    while days_checked < MAX_DAYS_TO_CHECK:
        print(f"Checking date {current_date}...", end=" ", flush=True)
        if check_date_has_data(service, site_url, current_date):
            print("✓ Data found!")
            most_recent_data_date = current_date
            break
        else:
            print("✗ No data")
            current_date -= timedelta(days=1)
            days_checked += 1
            time.sleep(API_CHECK_DELAY)
    if not most_recent_data_date:
        last_checked_date = current_date + timedelta(days=1)  # Date where check stopped
        print(f"\nWarning: Could not find data within {MAX_DAYS_TO_CHECK} checked days (back to {last_checked_date}).")
    return most_recent_data_date


def fetch_all_gsc_data(service, site_url, request_body):
    """Fetches all available data rows for a given GSC query, handling pagination."""
    all_rows = []
    start_row = request_body.get('startRow', 0)
    row_limit = request_body.get('rowLimit', 25000)  # Use max GSC limit
    page_count = 0
    print(f"\nFetching data with dimensions: {request_body.get('dimensions', [])} for {request_body.get('startDate')}")
    while True:
        page_count += 1
        request_body['startRow'] = start_row
        print(f"Fetching page {page_count} (starting row {start_row})...", end=" ", flush=True)
        try:
            response = service.searchanalytics().query(
                siteUrl=site_url, body=request_body).execute()
            current_rows = response.get('rows', [])
            if not current_rows:
                if page_count == 1:
                    print("No data found for this query.")
                else:
                    print("✓ No more data.")
                break
            print(f"✓ Retrieved {len(current_rows)} rows.")
            all_rows.extend(current_rows)
            if len(current_rows) < row_limit:
                print("✓ Reached last page of results.")
                break
            start_row += len(current_rows)
            time.sleep(API_CHECK_DELAY)
        except HttpError as e:
            print(f"\nAPI Error fetching page {page_count}: {e.resp.status} {e.resp.reason}")
            return []  # Return empty list on error
        except Exception as e:
            print(f"\nUnexpected error fetching page {page_count}: {e}")
            return []
    print(f"✓ Finished fetching {request_body.get('startDate')}. Total rows: {len(all_rows)}")
    return all_rows


def process_gsc_data_to_dataframe(gsc_data_list, data_date):
    """Converts raw GSC data list into a processed Pandas DataFrame."""
    if not gsc_data_list:
        # Keep this print statement for clarity during processing
        # print(f"No data to process into DataFrame for {data_date}.")
        return pd.DataFrame()  # Return empty DF if no raw data
    df = pd.DataFrame(gsc_data_list)
    if 'keys' in df.columns and not df['keys'].empty:
        try:
            df['query'] = df['keys'].apply(lambda x: x[0] if isinstance(x, list) and len(x) > 0 else None)
            df['page'] = df['keys'].apply(lambda x: x[1] if isinstance(x, list) and len(x) > 1 else None)
            df = df.drop('keys', axis=1)
        except Exception as e:
            print(f"Warning: Could not split 'keys' column for {data_date}: {e}")
    metric_cols = ['clicks', 'impressions', 'ctr', 'position']
    for col in metric_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce')
        # else: # No need to print this repeatedly if a metric is consistently missing
            # print(f"Note: Metric column '{col}' not found for {data_date}.")
    if 'ctr' in df.columns:
        df['ctr'] = df['ctr'] * 100
    # Don't print success here, wait until after combining DFs if needed
    # print(f"✓ Processed data for {data_date} into DataFrame ({len(df)} rows).")
    return df


def get_gsc_data_for_day(service, site_url, data_date):
    """Fetches GSC data for a specific day, using cache if available."""
    date_str = data_date.strftime('%Y-%m-%d')
    cache_filename = os.path.join(CACHE_DIR, f"gsc_data_{date_str}.csv")
    if os.path.exists(cache_filename):
        try:
            print(f"📂 CACHE: Loading data for {date_str} from cache: {cache_filename}")
            df = pd.read_csv(cache_filename, dtype={
                'clicks': 'Int64', 'impressions': 'Int64', 'ctr': 'float64',
                'position': 'float64', 'query': 'object', 'page': 'object'
            }, parse_dates=False)
            if 'ctr' in df.columns and not df['ctr'].empty and df['ctr'].max() <= 1.0:
                df['ctr'] = df['ctr'] * 100
            return df
        except Exception as e:
            print(f"⚠️ Warning: Could not load cache file {cache_filename}. Error: {e}. Re-fetching.")
    print(f"🔄 API: Fetching data for {date_str} from GSC API...")
    request = {
        'startDate': date_str, 'endDate': date_str,
        'dimensions': ['query', 'page'],
        'rowLimit': 25000, 'startRow': 0
    }
    raw_data = fetch_all_gsc_data(service, site_url, request)
    df = process_gsc_data_to_dataframe(raw_data, date_str)
    if not df.empty:
        try:
            os.makedirs(CACHE_DIR, exist_ok=True)
            df.to_csv(cache_filename, index=False)
            print(f"💾 Saved data for {date_str} to cache: {cache_filename}")
        except Exception as e:
            print(f"⚠️ Warning: Could not save data for {date_str} to cache. Error: {e}")
    return df

# --- New Function for Trend Analysis ---


def analyze_trends(daily_dataframes_dict):
    """
    Combines daily DataFrames and calculates trend slopes and time series.

    Args:
        daily_dataframes_dict (dict): Dict mapping date obj to daily GSC DataFrame.

    Returns:
        pandas.DataFrame: DataFrame with page, query, slopes, and time series lists.
                          Returns empty DataFrame if input is invalid or processing fails.
    """
    if not daily_dataframes_dict or len(daily_dataframes_dict) < 2:
        print("Error: Need at least 2 days of data for trend analysis.")
        return pd.DataFrame()

    # Get sorted dates from the dictionary keys
    dates = sorted(daily_dataframes_dict.keys())
    num_days = len(dates)

    # Prepare list of dataframes to concatenate, adding date column
    dfs_to_concat = []
    for date, df in daily_dataframes_dict.items():
        if not df.empty:
            df_copy = df.copy()  # Work on a copy
            df_copy['date'] = pd.to_datetime(date)  # Ensure date is datetime object
            dfs_to_concat.append(df_copy)

    if not dfs_to_concat:
        print("Error: No valid DataFrames found to combine for trend analysis.")
        return pd.DataFrame()

    # Combine DataFrames
    combined_df = pd.concat(dfs_to_concat, ignore_index=True)
    print(f"\n✓ Combined data for {len(dates)} days into a single DataFrame ({len(combined_df)} rows total).")

    # Add Day Index for regression
    date_to_index = {pd.to_datetime(date): i for i, date in enumerate(dates)}
    combined_df['day_index'] = combined_df['date'].map(date_to_index)

    # Define metrics for trend analysis
    metrics = ['impressions', 'clicks', 'position']

    # --- Inner function to process each page/query group ---
    def analyze_single_group(group):
        # Convert the groupby result to a DataFrame if it's a Series
        if isinstance(group, pd.Series):
            group = group.to_frame().T

        # Ensure date is in datetime format
        if 'date' in group.columns:
            group['date'] = pd.to_datetime(group['date'])
            group = group.set_index('date')

        # Create a complete date range
        full_date_index = pd.to_datetime(dates)

        # Create empty results dictionary
        results = {}

        # Handle each metric
        for metric in metrics:
            # Default values in case metric is missing
            results[f'{metric}_ts'] = [0] * num_days  # Default time series
            results[f'{metric}_slope'] = np.nan       # Default slope

            # Skip processing if metric is not in the group's columns
            if metric not in group.columns:
                continue

            # Get metric values for each date (align with date index)
            metric_by_date = {}
            for _, row in group.reset_index().iterrows():
                if 'date' in row and pd.notnull(row['date']) and metric in row and pd.notnull(row[metric]):
                    dt = pd.to_datetime(row['date'])
                    metric_by_date[dt] = row[metric]

            # Create time series array aligned with full date range
            ts_values = []
            for dt in full_date_index:
                if dt in metric_by_date:
                    value = metric_by_date[dt]
                    # Handle impressions and clicks as integers (filled with 0)
                    if metric in ['impressions', 'clicks']:
                        ts_values.append(int(value) if pd.notnull(value) else 0)
                    # Handle position as float (can be NaN)
                    else:
                        ts_values.append(round(float(value), 1) if pd.notnull(value) else np.nan)
                else:
                    # For missing dates: 0 for counts, NaN for position
                    ts_values.append(0 if metric in ['impressions', 'clicks'] else np.nan)

            results[f'{metric}_ts'] = ts_values

            # Calculate regression slope if we have enough valid data points
            x = np.arange(num_days)
            y = np.array(ts_values)
            valid_mask = ~np.isnan(y)
            valid_count = np.sum(valid_mask)

            if valid_count >= 2:  # Need at least two points for regression
                try:
                    # Extract valid x and y values
                    x_valid = x[valid_mask]
                    y_valid = y[valid_mask]
                    # Calculate slope using numpy's polyfit
                    coeffs = np.polyfit(x_valid, y_valid, 1)
                    results[f'{metric}_slope'] = coeffs[0]
                except (np.linalg.LinAlgError, ValueError, TypeError) as e:
                    # Handle computation errors
                    print(f"Warning: Slope calculation error for metric {metric}: {e}")
                    results[f'{metric}_slope'] = np.nan

        return pd.Series(results)
    # --- End of inner function ---

    print("✓ Starting trend analysis by grouping page/query combinations...")
    # Apply the analysis function to each group
    # Handle potential errors during apply (e.g., unexpected data types)
    try:
        # Using include_groups=False to avoid deprecation warning
        analysis_results = combined_df.groupby(['page', 'query'], observed=True, dropna=False).apply(
            analyze_single_group, include_groups=False).reset_index()
        print(f"✓ Trend analysis complete. Found {len(analysis_results)} unique page/query combinations.")
    except Exception as e:
        print(f"Error during groupby/apply operation for trend analysis: {e}")
        return pd.DataFrame()  # Return empty DF on error

    # Optional: Round slopes for cleaner display
    for metric in metrics:
        col_name = f'{metric}_slope'
        if col_name in analysis_results.columns:
            analysis_results[col_name] = analysis_results[col_name].round(2)

    return analysis_results


# --- Modify the main() function ---

def main():
    """Main execution function."""
    # 1. Authenticate
    gsc_service = authenticate_gsc()

    # 2. Find most recent date
    latest_date = find_most_recent_gsc_data_date(gsc_service, SITE_URL)
    if not latest_date:
        print("\nCannot proceed without a valid recent date.")
        sys.exit(1)
    print(f"\nSuccess: Most recent GSC data available is for: {latest_date.strftime('%Y-%m-%d')}")

    # 3. Determine dates to fetch
    dates_to_fetch = [latest_date - timedelta(days=i) for i in range(NUM_DAYS_TO_FETCH)][::-1]
    print(f"\nPreparing to fetch/load data for {NUM_DAYS_TO_FETCH} days:")
    print(f"  Dates: {[d.strftime('%Y-%m-%d') for d in dates_to_fetch]}")

    # 4. Fetch/load daily data
    daily_dataframes = {}
    api_calls_made = 0
    cache_loads_made = 0
    all_data_loaded = True
    
    for target_date in dates_to_fetch:
        date_str = target_date.strftime('%Y-%m-%d')
        cache_filename = os.path.join(CACHE_DIR, f"gsc_data_{date_str}.csv")
        cache_exists = os.path.exists(cache_filename)
        
        df_day = get_gsc_data_for_day(gsc_service, SITE_URL, target_date)
        
        # Track which source was used
        if cache_exists and not df_day.empty:
            cache_loads_made += 1
        elif not df_day.empty:
            api_calls_made += 1
            
        # Even if df_day is empty, store it to represent the day
        daily_dataframes[target_date] = df_day
        
        # Check if loading/fetching failed *and* cache doesn't exist
        if df_day.empty and not cache_exists:
             print(f"⚠️ Warning: Data could not be fetched or loaded for {date_str}. Trend analysis might be incomplete.")
             all_data_loaded = False

    if not all_data_loaded:
         print("\n⚠️ Warning: Data loading was incomplete. Proceeding with available data.")
    
    print(f"\n📊 Data source summary: {cache_loads_made} days loaded from cache, {api_calls_made} days fetched from API")

    # --- ADD TREND ANALYSIS STEP ---
    # 5. Perform Trend Analysis
    trend_results_df = analyze_trends(daily_dataframes)

    # 6. Display Trend Analysis Results
    if not trend_results_df.empty:
        # Configure pandas display settings for better table formatting
        pd.set_option('display.max_rows', 30)
        pd.set_option('display.max_columns', None)
        pd.set_option('display.width', None)
        pd.set_option('display.expand_frame_repr', False)
        pd.set_option('display.max_colwidth', None)
        
        # Create a simplified display dataframe with cleaner formatting
        display_df = trend_results_df.copy()
        
        # Process the dataframe for display
        # 1. Extract page path from full URL
        if 'page' in display_df.columns:
            display_df['page'] = display_df['page'].str.replace(r'https://mikelev.in/futureproof/', '', regex=True)
            # Further trim endings
            display_df['page'] = display_df['page'].str.replace(r'/$', '', regex=True)
            
        # 2. Convert time series lists to more compact string representations
        for col in ['impressions_ts', 'clicks_ts', 'position_ts']:
            if col in display_df.columns:
                # Format time series values more compactly
                display_df[col] = display_df[col].apply(
                    lambda x: '[' + ','.join([str(int(i)) if isinstance(i, (int, float)) and not pd.isna(i) else '-' for i in x]) + ']'
                )
                
        # 3. Format slope values to 1 decimal place
        for col in ['impressions_slope', 'clicks_slope', 'position_slope']:
            if col in display_df.columns:
                display_df[col] = display_df[col].apply(
                    lambda x: f"{x:.1f}" if pd.notnull(x) else "-"
                )
                
        print("\n--- Top 15 by Impression Increase ---")
        top_impressions = display_df.sort_values('impressions_slope', ascending=False, na_position='last').head(15)
        print(top_impressions.to_string(index=False))

        print("\n--- Top 15 by Position Improvement (Lower is Better) ---")
        # Ensure we're working with original numeric values for sorting
        numeric_df = trend_results_df.copy()
        numeric_df = numeric_df.dropna(subset=['position_slope'])
        # Sort by position_slope (lowest/most negative is best improvement) 
        top_positions_idx = numeric_df.sort_values('position_slope', ascending=True).head(15).index
        # Display using the formatted display dataframe
        print(display_df.loc[top_positions_idx].to_string(index=False))

        # --- ADD NEW SECTION: Top Performers by Combined Score ---
        print("\n--- Top 15 High-Impact Queries (Best Position + Most Impressions) ---")
        # Get the most recent day in each time series
        latest_data_df = trend_results_df.copy()
        
        # Extract the most recent values from the time series lists
        def get_latest_nonzero_value(ts_list, default=None):
            """Get the latest non-zero (or non-nan) value in a time series list."""
            if not isinstance(ts_list, list):
                return default
            for value in reversed(ts_list):  # Start from the most recent
                if isinstance(value, (int, float)) and not pd.isna(value) and value > 0:
                    return value
            return default
            
        latest_data_df['latest_position'] = latest_data_df['position_ts'].apply(
            lambda x: get_latest_nonzero_value(x, default=100)
        )
        latest_data_df['latest_impressions'] = latest_data_df['impressions_ts'].apply(
            lambda x: get_latest_nonzero_value(x, default=0)
        )
        
        # Calculate combined score: impressions / position (higher score is better)
        # This prioritizes high impressions and low positions
        latest_data_df['impact_score'] = latest_data_df.apply(
            lambda row: row['latest_impressions'] / max(row['latest_position'], 0.1) 
            if pd.notnull(row['latest_position']) and row['latest_position'] > 0
            else 0,
            axis=1
        )
        
        # Sort by the combined score and get top 15
        top_impact_idx = latest_data_df.sort_values('impact_score', ascending=False).head(15).index
        
        # Add the score to the display dataframe
        display_df['latest_position'] = latest_data_df['latest_position'].round(1)
        display_df['latest_impressions'] = latest_data_df['latest_impressions'].astype(int)
        display_df['impact_score'] = latest_data_df['impact_score'].round(1)
        
        # Truncate long queries for display
        def truncate_query(query, max_length=50):
            """Truncate query string if longer than max_length."""
            if len(query) <= max_length:
                return query
            return query[:max_length-3] + "..."
        
        # Create a display version with truncated queries
        display_df_truncated = display_df.copy()
        display_df_truncated['query'] = display_df_truncated['query'].apply(truncate_query)
        
        # Display the top impact queries with truncated query text
        print(display_df_truncated.loc[top_impact_idx][['page', 'query', 'latest_position', 'latest_impressions', 'impact_score', 'impressions_ts', 'position_ts']].to_string(index=False))

        print("\n--- DataFrame Info ---")
        trend_results_df.info()

        # Save the final trend analysis results using the original dataframe (with full URLs)
        final_output_filename = os.path.join(SCRIPT_DIR, f"gsc_trend_analysis_{dates_to_fetch[0].strftime('%Y%m%d')}_to_{dates_to_fetch[-1].strftime('%Y%m%d')}.csv")
        try:
            trend_results_df.to_csv(final_output_filename, index=False)
            print(f"\n✓ Saved final trend analysis to: {final_output_filename}")
        except Exception as e:
            print(f"\nWarning: Failed to save final trend analysis results. Error: {e}")

    else:
        print("\nTrend analysis could not be completed.")

    print("\nScript finished.")


if __name__ == "__main__":
    if not SITE_URL or SITE_URL == "sc-domain:yourdomain.com":
        print("Error: Please update the 'SITE_URL' variable in the script configuration.")
        sys.exit(1)
    main()
```

**Here's how it works:**

1.  **Combine and Prepare:** The `analyze_trends` function first concatenates the individual daily DataFrames into one large `combined_df`. Crucially, it adds a `date` column during this process and then calculates a numerical `day_index` (0, 1, 2, 3) representing the time sequence, which is necessary for the regression calculation.
2.  **Group and Analyze:** The script then groups this combined data by each unique `page` and `query` combination. For every group, it performs the following:
    * **Time Alignment:** It ensures data for all 4 days is represented using `reindex`, filling any missing days for a specific page/query pair with `NaN` (Not a Number). This is vital for comparing trends apples-to-apples.
    * **Time Series Extraction:** It stores the sequence of impressions, clicks, and position values over the 4 days into lists (e.g., `impressions_ts`). These are ready for potential sparkline visualization later. Missing values for impressions/clicks are treated as 0, while missing positions remain `NaN`.
    * **Slope Calculation:** Using `numpy.polyfit`, it calculates the linear regression slope for impressions, clicks, and position against the day index. This slope value quantifies the trend (e.g., a positive impression slope means impressions are trending up). The calculation only proceeds if at least two data points are available for a given metric within the 4-day window; otherwise, the slope is `NaN`.
3.  **Identify Top Movers:** The script analyzes the calculated slopes to surface interesting changes:
    * **Impression Increase:** It sorts the results by `impressions_slope` in descending order to find page/query combinations gaining the most visibility.
    * **Position Improvement:** It sorts by `position_slope` in ascending order (most negative slope first) to find combinations whose average ranking improved the most significantly.
    * **High Impact:** Recognizing that trends are only part of the story, it adds a crucial third view. It looks at the *most recent day's* data for each page/query pair, calculates an `impact_score` (latest impressions divided by latest position), and sorts by this score. This surfaces queries that are *currently* driving significant impressions from good ranking positions, regardless of the short-term trend.
4.  **Format and Save:**
    * For clearer console output, the script formats the results: page URLs are shortened, time-series lists are displayed compactly (e.g., `[10, 15, 20, 27]`), and slopes are shown with a sign (`+`/`-`) and one decimal place.
    * The raw, unformatted results of the trend analysis (including the full page URLs, slopes, and time-series lists) are saved to a CSV file named with the date range (e.g., `gsc_trend_analysis_20250405_to_20250408.csv`). This allows for more in-depth analysis or visualization later.
5.  **Caching Mention:** Throughout the process, the script leverages the caching mechanism established earlier, loading daily data from local CSV files when available to minimize redundant API calls and speed up execution on subsequent runs. It also reports how many days were loaded from cache versus fetched live.

This comprehensive analysis provides multiple angles to understand recent performance shifts – identifying rapidly growing terms, ranking improvements, and currently impactful queries – giving actionable insights for SEO efforts.

## Running The Trend Analysis Script

Executing this final script performs the entire process: authentication, finding the latest date, fetching/caching 4 days of data, combining the data, calculating trend slopes, and finally displaying the top "movers and shakers" based on impression gains and position improvements.

Here's an example of what the formatted output might look like (data will vary):

```plaintext
[mike@nixos:~/repos/pipulate/precursors]$ python gsc_top_movers.py 
✓ Successfully authenticated with Google Search Console API.

Finding most recent data date for site: sc-domain:mikelev.in
Starting check from date: 2025-04-09
Checking date 2025-04-09... ✓ Data found!

Success: Most recent GSC data available is for: 2025-04-09

Preparing to fetch/load data for 4 days:
  Dates: ['2025-04-06', '2025-04-07', '2025-04-08', '2025-04-09']
📂 CACHE: Loading data for 2025-04-06 from cache: /home/mike/repos/pipulate/precursors/gsc_cache/gsc_data_2025-04-06.csv
📂 CACHE: Loading data for 2025-04-07 from cache: /home/mike/repos/pipulate/precursors/gsc_cache/gsc_data_2025-04-07.csv
📂 CACHE: Loading data for 2025-04-08 from cache: /home/mike/repos/pipulate/precursors/gsc_cache/gsc_data_2025-04-08.csv
📂 CACHE: Loading data for 2025-04-09 from cache: /home/mike/repos/pipulate/precursors/gsc_cache/gsc_data_2025-04-09.csv

📊 Data source summary: 4 days loaded from cache, 0 days fetched from API

✓ Combined data for 4 days into a single DataFrame (7591 rows total).
✓ Starting trend analysis by grouping page/query combinations...
✓ Trend analysis complete. Found 6499 unique page/query combinations.

--- Top 15 by Impression Increase ---
                                     page                       query impressions_ts impressions_slope clicks_ts clicks_slope position_ts position_slope
                         grok-better-than         seo recommendations     [0,0,0,31]               9.3 [0,0,0,0]          0.0  [-,-,-,99]              -
                ai-agentic-mode-debugging             git cherry pick    [0,0,21,20]               8.1 [0,0,0,0]          0.0 [-,-,75,70]           -4.7
                         grok-better-than                seo concepts     [0,0,0,27]               8.1 [0,0,0,0]          0.0  [-,-,-,82]              -
                         grok-better-than                        htmx     [0,0,0,24]               7.2 [0,0,0,0]          0.0  [-,-,-,70]              -
static-site-generator-ai-content-strategy             seo methodology    [0,0,32,11]               6.5 [0,0,0,0]          0.0 [-,-,92,96]            3.9
                         grok-better-than             git cherry pick     [0,0,0,21]               6.3 [0,0,0,0]          0.0  [-,-,-,84]              -
                         grok-better-than                  python seo     [0,0,0,21]               6.3 [0,0,0,0]          0.0  [-,-,-,80]              -
                ai-agentic-mode-debugging                   cursor ai    [0,0,27,11]               6.0 [0,0,1,0]          0.1 [-,-,41,43]            1.5
static-site-generator-ai-content-strategy  striking distance keywords    [0,0,26,11]               5.9 [0,0,0,0]          0.0 [-,-,63,64]            0.7
                         grok-better-than google keyword planner tool     [0,0,0,19]               5.7 [0,0,0,0]          0.0  [-,-,-,77]              -
static-site-generator-ai-content-strategy             git cherry pick    [0,0,21,12]               5.7 [0,0,0,0]          0.0 [-,-,91,89]           -2.6
static-site-generator-ai-content-strategy              python for seo     [0,0,44,4]               5.6 [0,0,0,0]          0.0 [-,-,95,96]            0.9
                         grok-better-than                guide to seo     [0,0,0,18]               5.4 [0,0,0,0]          0.0  [-,-,-,98]              -
                ai-agentic-mode-debugging                  git revert    [0,0,17,12]               5.3 [0,0,0,0]          0.0 [-,-,72,75]            3.1
                         grok-better-than             seo explanation     [0,0,0,17]               5.1 [0,0,0,0]          0.0  [-,-,-,96]              -

--- Top 15 by Position Improvement (Lower is Better) ---
                                     page                                  query impressions_ts impressions_slope clicks_ts clicks_slope  position_ts position_slope
             llm-seo-software-development                        webassembly dom      [0,1,1,0]               0.0 [0,0,0,0]          0.0 [-,124,70,-]          -54.0
             llm-seo-software-development                            cheek holes      [0,1,1,0]               0.0 [0,0,0,0]          0.0  [-,97,69,-]          -28.0
static-site-generator-ai-content-strategy                     wordpress metadata      [0,0,2,1]               0.5 [0,0,0,0]          0.0  [-,-,96,68]          -28.0
                ai-agentic-mode-debugging                    how to fix my beats      [0,0,1,1]               0.4 [0,0,0,0]          0.0  [-,-,95,72]          -23.0
            cursor-ai-terminal-agent-mode                               squashfs      [0,1,1,0]               0.0 [0,0,0,0]          0.0 [-,115,95,-]          -20.0
          from-blog-to-book-ai-powered-ia                           jupyter lite      [0,0,1,1]               0.4 [0,0,0,0]          0.0  [-,-,76,56]          -20.0
                ai-agentic-mode-debugging                          hamster wheel     [0,0,20,2]               2.6 [0,0,0,0]          0.0  [-,-,76,57]          -19.2
                ai-agentic-mode-debugging               compare two branches git      [0,0,2,1]               0.5 [0,0,0,0]          0.0  [-,-,99,81]          -18.5
          from-blog-to-book-ai-powered-ia            chunking strategies for rag      [0,0,1,1]               0.4 [0,0,0,0]          0.0  [-,-,90,72]          -18.0
            vscode-jupyter-notebook-paths does cursor work with jupyter notebook      [1,1,0,0]              -0.4 [0,0,0,0]          0.0  [29,11,-,-]          -18.0
                ai-agentic-mode-debugging             git revert changes to file      [0,0,1,2]               0.7 [0,0,0,0]          0.0  [-,-,97,79]          -18.0
          from-blog-to-book-ai-powered-ia                               prolimit      [0,0,3,1]               0.6 [0,0,0,0]          0.0  [-,-,81,64]          -17.7
                ai-agentic-mode-debugging                        github pipeline      [0,0,2,1]               0.5 [0,0,0,0]          0.0  [-,-,88,71]          -17.5
             llm-seo-software-development                             open webui      [0,4,2,0]              -0.2 [0,0,0,0]          0.0  [-,78,61,-]          -17.3
static-site-generator-ai-content-strategy                             parse yaml      [0,0,1,1]               0.4 [0,0,0,0]          0.0 [-,-,101,85]          -16.0

--- Top 15 High-Impact Queries (Best Position + Most Impressions) ---
                           page                                              query  latest_position  latest_impressions  impact_score impressions_ts   position_ts
         grok3-markdown-problem grok was unable to finish replying. please try ...              7.8                  19           2.4   [26,9,12,19]     [7,7,8,7]
 jupyter-notebook-vscode-cursor                         cursor ai jupyter notebook              6.7                  12           1.8     [9,4,5,12]     [6,7,6,6]
         grok3-markdown-problem                                        grok glitch              6.9                  12           1.7    [3,7,12,12]     [3,5,5,6]
             mcp-with-local-llm                                      local llm mcp              6.1                   8           1.3      [4,8,0,0]     [6,6,-,-]
       open-source-seo-software                                 seo software linux             21.7                  25           1.2    [5,47,9,25] [20,22,23,21]
         grok3-markdown-problem                 grok was unable to finish replying              8.7                  10           1.1     [4,2,1,10]     [8,9,9,8]
         grok3-markdown-problem                                      grok markdown              2.7                   3           1.1      [3,4,3,3]     [3,1,1,2]
             https://mikelev.in                                 michael levin blog              3.8                   4           1.1      [3,1,2,4]     [4,4,3,3]
         grok3-markdown-problem                grok was unable to finish replying.              8.8                   9           1.0     [7,12,5,9]     [7,7,7,8]
               grok-better-than entity you are doing the search for: {"name": "...              2.0                   2           1.0      [0,0,0,2]     [-,-,-,2]
nixos-warbler-files-disappeared                                      nixos warbler              1.0                   1           1.0      [1,1,0,0]     [1,1,-,-]
         grok3-markdown-problem                                      grok problems              1.0                   1           1.0      [1,0,0,1]     [9,-,-,1]
 peak-data-musk-sutskever-wrong                                   peak data theory              1.0                   1           1.0      [2,0,1,1]     [5,-,3,1]
         grok3-markdown-problem                                grok 3 prompt limit              1.0                   1           1.0      [0,0,0,1]     [-,-,-,1]
 jupyter-notebook-vscode-cursor                            cursor jupyter notebook              6.2                   6           1.0     [12,9,9,6]    [9,8,11,6]

--- DataFrame Info ---
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 6499 entries, 0 to 6498
Data columns (total 8 columns):
 #   Column             Non-Null Count  Dtype  
---  ------             --------------  -----  
 0   page               6499 non-null   object 
 1   query              6499 non-null   object 
 2   impressions_ts     6499 non-null   object 
 3   impressions_slope  6499 non-null   float64
 4   clicks_ts          6499 non-null   object 
 5   clicks_slope       6499 non-null   float64
 6   position_ts        6499 non-null   object 
 7   position_slope     914 non-null    float64
dtypes: float64(3), object(5)
memory usage: 406.3+ KB

✓ Saved final trend analysis to: /home/mike/repos/pipulate/precursors/gsc_trend_analysis_20250406_to_20250409.csv

Script finished.
```

This provides a powerful, automated way to monitor recent performance changes and identify potential content optimization opportunities directly from your GSC data. The final CSV contains all the calculated data for further analysis or visualization.

---

## Voila! Sparklines

Do I really have to draw the sparklines for you? The data's ready to bring into
Excel or whatever. If you're in a web app environment, there are plenty of
libraries that can take these little 4-point arrays and draw you sparklines. A
sign of good data preparation is the text representation is so good, you hardly
have to visualize. The visualization component merits a whole other article, so
I will assume anyone interested in an article like this who got down this far
can glance at those above numbers and "get it". There are your movers and
shakers there at the top of the lists plain as day.

The site suddenly went from not being in search at all to suddenly having
positions, terrible as those positions may be. If you're actually here on my
site reading this, may I suggest playing with that page-width slider to be able
to see the maximum number of columns available in those tables without
horizontal scrolling. Things like average position are all the way over on the
right, so while you may see keywords suddenly having impressions, to get the
full story, you want to see what average positions in search they were in on
those impressions.

Your site impression traffic may surge just because you wander into the space
of "monitored" keywords by tools like SEMRush and stuff. I mean, who's going to
page 10 of search results? Now that you need to "render" search results with a
web browser (scraping SERPs isn't as easy as it used to be), bots are going to
look more like genuine impressions. So my surge could just be bots monitoring
SERPs, especially on terms like "seo software". But you've got to be found at
all before you can dominate. So, it's a start.

---

## Gemini 2.5's Take

Okay, here is the analysis based *only* on the provided text:

* **Author Summary:** [Moved to top]

* **Title/Headline Ideas:**
    * Analyze GSC Movers & Shakers: A Python API Guide with Trend Analysis
    * Uncover Hidden SEO Trends: Python & GSC API for Granular Analysis
    * Find Sudden SEO Winners: Using GSC API & Linear Regression in Python
    * Beyond the GSC UI: Python Scripts for Deep SEO Trend Monitoring
    * Build Your Own GSC Trend Analyzer with Python and Pandas

* **Strengths:**
    * Provides a practical, step-by-step solution to a common SEO analysis problem (GSC UI limitations).
    * Includes complete, copy-pasteable Python code examples that build incrementally.
    * Clearly explains the rationale for using the API (granularity, combining dimensions).
    * Demonstrates useful techniques: Service Account authentication, API pagination, data caching, Pandas data manipulation, and basic linear regression for trends.
    * The code includes comments explaining parts of the logic.
    * Shows sample output, making the results tangible.

* **Weaknesses:**
    * Very code-intensive, potentially overwhelming for readers without Python/Pandas experience.
    * Assumes significant prerequisite knowledge (Python environment setup, GCP familiarity, basic API concepts, Pandas DataFrames).
    * The explanation of the statistical method (linear regression) is minimal; lacks detail on interpretation or limitations.
    * The progression between script versions is acknowledged as "pretty big steps," which might be challenging for learners.
    * The conclusion about sparklines feels somewhat dismissive ("Do I really have to draw...").
    * Relies heavily on text and code; could benefit from more diagrams or visual explanations of the data flow or concepts.

* **AI Opinion:**
    * Overall, this is a high-quality, practical article for its target audience: technically proficient SEOs or developers looking to automate and deepen their GSC analysis. Its main strength lies in providing a complete, working code solution built up logically. However, its usefulness is limited for those uncomfortable with Python programming or GCP. While generally clear in its explanations of *what* the code does, the "why" behind some specific coding choices or the deeper statistical implications could be elaborated further. The article offers significant value by empowering users to overcome GSC limitations and gain actionable insights through trend analysis.


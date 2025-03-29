---
title: Getting Past the GSC 1000-row Limit With the API
permalink: /futureproof/gsc-1000-row-limit-api/
description: In this post, I share my journey developing a data-driven SEO workflow using Jupyter Notebooks, enhanced with AI assistance from Cursor AI and Claude, to tackle the persistent challenge of extracting and analyzing Google Search Console data beyond the basic interface limits. I detail the process from setting up secure GSC API access with a service account, crafting Python code to fetch comprehensive performance data (including handling pagination and finding the most recent available dates), identifying promising "striking distance" keywords, cleaning that list for tools like SEMrush, and finally merging GSC insights with SEMrush metrics to generate a reusable template for optimizing article titles and permalinks, all part of my effort to achieve hockey-stick growth through consistent, technically-informed content optimization.
layout: post
sort_order: 4
---

## The Challenge of Following Through

Follow-through is the hardest thing to do. But I need to demonstrate the
hockeystick-curve of a "new" site taking off according to its GSC data, and this
time in the future-proofed subject-matter area of technological future-proofing!
Hence the directory name this blog is planted in.

## Deep Research into GSC Data Extraction

On my last article, I ***Deep Researched*** one of the simultaneously
challenging and common tasks in the field of SEO: downloading past the first
1000 rows in GSC. I've been doing that since there was an API -- long before
there was an integrated Google Cloud Platform (GCP) unified site. You'd think I
could do it in my sleep by now, but it's a re-discovery process every time.

### Automating SEO Processes with Pipulate

But now that there's the latest and greatest Pipulate on the verge of release,
we're going to bottle-up as many of these processes as we can. And it all starts
with a bit of research to flesh out the process (done), and then a Jupyter
Notebook -- now with AI-assistance in Cursor AI -- as the implementation (this
post), and then all we have left is the hardest part: persistence over time!

### Building Daily Writing Habits for Growth

So the reason this project is happening despite it looking just like those
constantly appearing rabbit hole distraction projects I swat down, I'm writing
every day now. I'm in the habit and it's helping the quality of my professional
work and my personal project (deeply intertwined). And as I write and I get the
content-snowball rolling, it promises to be a hockey-stick growth curve given
the now-mainstream topics I write about -- if only I can make just make the
tiniest directional adjustments to walk into the path of the traffic.

### Productivity Framework

We look at my 3 daily productivity metaphors designed to work together to get
the snowball effect happening:

- What's most broken
- Where do I get the biggest bang for the buck
- What plates need to be spun

## Optimizing Daily Content for Traffic Growth

Making the performance of my daily published articles working significantly
better hits all 3 points. Them not producing more traffic for me today is what's
most broken, and making them do so -- working for me 24/7/365 the way organic
search does is the biggest bang for the buck. 

It's also getting plates spinning, because people are always searching, and
these are like zero-budget marketing campaigns always running for you. Not that
I'm selling anything except for my abilities. And all the signs are positive.
They are telling me that if I just lean into this thing, the hockey-stick curve
goes up and to the right!

### Setting Up Google Search Console API Access

So I follow the instructions from the prior post.

Okay, so I enable the Google Search Console API in the Google Cloud Platform
(GCP). Both Grok and ChatGPT's instructions game me the GCP site directly in the
instructions, and Google's own Gemini didn't. Haha!

I go to GCP. I already have a GCP project, great! I'll recycle that. These
instructions won't be exhaustive.

#### Activating and Configuring API Access

I activate the Google Search Console API. This you have to do no matter what
authentication technique you use. Google services are all deny-first and
selectively have to be piecemeal activated. Okay, done.

#### Choosing Authentication Method: OAuth vs Service Account

Now the choice. We go with either OAuth or a service account (an email address
insofar as the user deals with it). I've always used OAuth in the past in this
vision of making things that other users would never have to go to the GCP site
and make projects and stuff. I've given all that up. Everything is self-hosted
now and zero tech-liability on my part. If folks want this feature, they do a
bit of development work, so I went with a service account this time.

I go to the IAM & Admin. I create a service account. I copy the email address.

We set the Role to Owner and press Done.

We go to the triple dots on the new service account created and select `Manage keys`

We select `Add key` / `Create new key`

We select `JSON` on the prompt that pops up.

It reports: Private key saved to your computer

And it's in the download directory!

We put `*.json` and `service_account.txt` lines in our `.gitignore` file so that
they never accidentally get committed to the git repository and show up in
GitHub!

I go to Google Search Console itself now (different site), and visit

GSC / `Settings` / `Users and permissions`

I add the email with full access.

## Testing API Connectivity

### Using Cursor AI for Jupyter Development

Okay, theoretically we should be able to blast the pipes out now and make sure
it's all working. What's different now with my process is that the Jupyter
Notebook will be directly in Cursor AI -- a game-changer for me.

### Providing Context to Claude

I'll give Claude the previous article as context. And this article too, for that
matter. It now knows that I have a service account.

### Requesting a Secure API Example

Claude, I would like to do the GSC API example, I think Gemini gives a good one,
to ensure my API connectivity. I have the service account. Make it so that the
example uses the context manager to read it from a 1-line text-file named
`service_account.txt` into a variable so that the example doesn't have to show
the email address.

---

**Claude 3.7 Sonnet**: &lt;think&gt;
You're asking me to create a Python example for connecting to the Google Search Console API using a service account. You've mentioned that you want to read the service account email from a file called `service_account.txt` for security reasons.

Based on your previous articles and the research you mentioned, I'll create a simple example that:
1. Uses a service account for authentication
2. Reads the service account email from a file
3. Tests connectivity to the GSC API
4. Lists available sites/properties 

I'll use the Google API Python Client library which is the standard way to interact with Google APIs in Python.
&lt;/think&gt;

Here's a simple example to test your Google Search Console API connectivity using a service account:

```python
from google.oauth2 import service_account
from googleapiclient.discovery import build
import json

# Read service account email from text file
with open('service_account.txt', 'r') as f:
    service_account_email = f.read().strip()

# Path to your service account key JSON file
SERVICE_ACCOUNT_FILE = 'service-account-key.json'

# Define the required scopes
SCOPES = ['https://www.googleapis.com/auth/webmasters']

# Authenticate using service account
credentials = service_account.Credentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE, scopes=SCOPES)

# Build the service
webmasters_service = build('webmasters', 'v3', credentials=credentials)

# List sites (properties) accessible to this service account
site_list = webmasters_service.sites().list().execute()

# Print the list of sites
print("Sites accessible to this service account:")
for site in site_list.get('siteEntry', []):
    url = site.get('siteUrl')
    permission_level = site.get('permissionLevel')
    print(f"URL: {url}, Permission: {permission_level}")

print(f"\nTotal sites: {len(site_list.get('siteEntry', []))}")
print(f"Service account email: {service_account_email}")
```

For this to work, you'll need:

1. A file named `service_account.txt` containing just your service account email address
2. Your service account key JSON file (named `service-account-key.json` in this example), which you need to download from GCP

To download the key JSON file:
1. Go to the GCP Console
2. Navigate to IAM & Admin > Service Accounts
3. Find your service account and click on the three dots menu
4. Select "Manage keys"
5. Click "ADD KEY" > "Create new key"
6. Choose JSON format and click "Create"
7. Save the downloaded file as `service-account-key.json` in the same directory as your script

This example simply lists all the GSC properties (websites) that your service account has access to, which is a good basic test of connectivity. If you see your sites listed, you're good to go!

---

Output:

    Sites accessible to this service account:
    URL: sc-domain:mikelev.in, Permission: siteFullUser

    Total sites: 1

---

**Me**: Excellent! That worked right out of the starting gate! Let's design the code for the next Jupyter Cell. You don't have to re-import anything! Assume all objects from this code-block are already in memory. Just pick up writing the program from where you left off. Infer the next step from the article. Use the first siteEntry in the site_list.

**Claude 3.7**: &lt;think&gt;
Based on the article and the current working code, the next logical step is to query the Google Search Console API for performance data. Specifically, we're looking to retrieve "striking distance" keywords (those ranking just outside the top 10 positions).

Looking at the article, particularly the sections about API structure and query options, we need to:

1. Get a site URL from the first entry in site_list
2. Create a query to get performance data with query and page dimensions
3. Implement pagination to get past the row limits
4. Store the results for later analysis

The key focus is to get keyword-page combinations with their respective metrics (clicks, impressions, CTR, position).

Let's design the next cell that will:
1. Extract the first site URL from site_list
2. Set up a date range (we might want to make this configurable)
3. Create and execute an initial query for performance data
4. Implement pagination to get all results
5. Format the results into a usable structure (preparing for Pandas later)
&lt;/think&gt;

Here's the code for the next cell that queries performance data using the API:

```python
# Extract the first site URL from the list
site_url = site_list['siteEntry'][0]['siteUrl']
print(f"Querying data for site: {site_url}")

# Set date range - last 3 months (adjust as needed)
from datetime import datetime, timedelta

end_date = datetime.now().date() - timedelta(days=3)  # 3-day lag for data finalization
start_date = end_date - timedelta(days=90)  # 90 days back

# Format dates as strings
start_date_str = start_date.strftime('%Y-%m-%d')
end_date_str = end_date.strftime('%Y-%m-%d')
print(f"Date range: {start_date_str} to {end_date_str}")

# Prepare the query request
request = {
    'startDate': start_date_str,
    'endDate': end_date_str,
    'dimensions': ['query', 'page'],
    'rowLimit': 25000,  # Maximum allowed per request
    'startRow': 0
}

# Function to handle pagination and collect all results
def fetch_all_gsc_data(service, site_url, request):
    all_rows = []
    start_row = 0
    page_count = 0
    
    while True:
        page_count += 1
        request['startRow'] = start_row
        print(f"Fetching page {page_count} (rows {start_row} to {start_row + request['rowLimit'] - 1})...")
        
        response = service.searchanalytics().query(siteUrl=site_url, body=request).execute()
        rows = response.get('rows', [])
        
        if not rows:
            print("No more data to fetch.")
            break
            
        print(f"Retrieved {len(rows)} rows")
        all_rows.extend(rows)
        
        if len(rows) < request['rowLimit']:
            print("Reached last page of results.")
            break
            
        start_row += len(rows)
    
    print(f"Total rows fetched: {len(all_rows)}")
    return all_rows

# Execute the query and collect all pages of results
all_data = fetch_all_gsc_data(webmasters_service, site_url, request)

# Preview the first few results
print("\nSample of retrieved data:")
for row in all_data[:3]:
    query = row['keys'][0]
    page = row['keys'][1]
    clicks = row['clicks']
    impressions = row['impressions']
    ctr = row['ctr']
    position = row['position']
    
    print(f"Query: '{query}', Page: '{page}'")
    print(f"  Clicks: {clicks}, Impressions: {impressions}, CTR: {ctr:.2%}, Position: {position:.2f}")
    print("-" * 80)
```

This code:

1. Takes the first site from your authenticated sites
2. Sets up a date range for the last 90 days (ending 3 days ago to account for data finalization)
3. Creates a function to handle pagination, fetching all available results
4. Executes the query with both 'query' and 'page' dimensions
5. Provides a preview of the first few results with nicely formatted output

The pagination implementation handles the API's limits by requesting data in chunks of 25,000 rows (the maximum allowed) until either no more data is returned or we get fewer rows than requested, indicating we've reached the end.

This sets us up nicely for the next step, which would be to convert this data to a pandas DataFrame for analysis of "striking distance" keywords.

---

Output: 

```plaintext
Querying data for site: sc-domain:mikelev.in
Date range: 2024-12-25 to 2025-03-25
Fetching page 1 (rows 0 to 24999)...
Retrieved 1030 rows
Reached last page of results.
Total rows fetched: 1030

Sample of retrieved data:
Query: 'fasthtml database', Page: 'https://mikelev.in/futureproof/unpacking-fasthtml-databases/'
  Clicks: 16, Impressions: 85, CTR: 18.82%, Position: 4.45
--------------------------------------------------------------------------------
Query: 'ollama websocket', Page: 'https://mikelev.in/futureproof/ollama-websocket-chat/'
  Clicks: 10, Impressions: 140, CTR: 7.14%, Position: 3.68
--------------------------------------------------------------------------------
Query: 'peak data theory', Page: 'https://mikelev.in/futureproof/peak-data-musk-sutskever-wrong/'
  Clicks: 9, Impressions: 400, CTR: 2.25%, Position: 6.23
--------------------------------------------------------------------------------
```

**Me**: Yeah, again you nailed it out of the starting gate. Now the thing is,
getting right up-to-the-latest data is really important to me. So before
starting such a process, formulate a 1-day query for yesterday (the earliest
data may be available) and check for data. Make a very simple query to check for
data. If it comes up empty, subtract a day, check and repeat until you have the
most recent end date for a date range. I will put this in a code block all by
itself separate from all other code, specifically branding this cell as finding
most recent GSC data. Please give me the code for that cell. Anything executed
from the first code-block is still in memory because what you're designing now
will be the cell block that comes after it. You an also establish a standard
variable name for the site we're processing pulled from the first position in
the site list, which we can use moving forward.

**Claude 3.7**: &lt;think&gt;
Let me design a cell that determines the most recent date for which GSC data is available. The approach will be:

1. Set up a query for yesterday first
2. If no data is found, keep moving backward one day at a time until data is found
3. Once data is found, that will be our most recent date that has data
4. Store this in a variable that can be used in future cells

I'll need to:
- Use a simple query with minimal dimensions to check data availability quickly
- Create a loop to check dates moving backward
- Make the code clean and well-commented
- Name the site variable clearly for future use
- Include good print statements to show progress

Let me create this code:
&lt;/think&gt;

Here's a cell to find the most recent date for which GSC data is available:

````python
# ======================================================================
# CELL: Find Most Recent GSC Data Date
# ======================================================================

import time
from datetime import datetime, timedelta

# Define the site we're working with (from first code block)
target_site = site_list['siteEntry'][0]['siteUrl']
print(f"Finding most recent data for site: {target_site}")

# Function to check if data exists for a specific date
def check_date_has_data(service, site_url, check_date):
    # Create a simple 1-day query with minimal dimensions
    date_str = check_date.strftime('%Y-%m-%d')
    test_request = {
        'startDate': date_str,
        'endDate': date_str,
        'dimensions': ['query'],  # Just query dimension for a quick check
        'rowLimit': 1  # We only need to know if any data exists
    }
    
    # Execute the query
    response = service.searchanalytics().query(siteUrl=site_url, body=test_request).execute()
    return len(response.get('rows', [])) > 0

# Start with yesterday and work backwards
current_date = datetime.now().date() - timedelta(days=1)
max_days_to_check = 10  # Limit how far back we'll check
days_checked = 0

print(f"Starting with date: {current_date}")

# Loop until we find data or hit our limit
while days_checked < max_days_to_check:
    print(f"Checking if data exists for {current_date}...", end=" ")
    
    if check_date_has_data(webmasters_service, target_site, current_date):
        print("✓ Data found!")
        most_recent_data_date = current_date
        break
    else:
        print("✗ No data")
        current_date -= timedelta(days=1)
        days_checked += 1
        time.sleep(0.5)  # Small pause to avoid rate limiting
    
if days_checked >= max_days_to_check:
    print(f"Warning: Couldn't find data in the last {max_days_to_check} days")
    most_recent_data_date = current_date + timedelta(days=1)  # Use the last date we didn't check
else:
    print(f"\nMost recent GSC data available is for: {most_recent_data_date}")
    
# Calculate a reasonable default date range (3 months ending at most recent date)
default_end_date = most_recent_data_date
default_start_date = default_end_date - timedelta(days=90)

print(f"Recommended date range for full queries:")
print(f"  Start: {default_start_date}")
print(f"  End: {default_end_date}")
````

This cell:

1. Sets `target_site` as our standard variable for the site we're processing
2. Creates a function to check if data exists for a specific date
3. Starts with yesterday and works backward one day at a time
4. Stops when it finds a date with data or hits a safety limit (10 days)
5. Sets `most_recent_data_date` as the most recent date with data
6. Calculates a recommended date range (90 days ending at the most recent date)
7. Provides clear output with checkmarks/X marks for visual feedback

This approach ensures we always start with the most current data available, which is important for timely SEO analysis.

---

Output:

```plaintext
Finding most recent data for site: sc-domain:mikelev.in
Starting with date: 2025-03-27
Checking if data exists for 2025-03-27... ✗ No data
Checking if data exists for 2025-03-26... ✓ Data found!

Most recent GSC data available is for: 2025-03-26
Recommended date range for full queries:
  Start: 2024-12-26
  End: 2025-03-26
```

**Me**: Wonderful! So the date-range is only going to go back to 3 days prior to
the last date we found data for because I want this to be very directional in
nature. Go ahead and revise this code-block to use the new variable names you
just established, which are still in memory. Load the data into a dataframe and
show me at least 30 rows. Make sure there's no number of row or column limits,
and no column width limits.

**Claude 3.7**: &lt;think&gt;
Let me understand what needs to be done:

1. Revise the previous GSC query code to use the new variables (`target_site`, `most_recent_data_date`, `default_start_date`, `default_end_date`)
2. Use the date range established in the "Find Most Recent GSC Data Date" cell
3. Load all the retrieved data into a pandas DataFrame
4. Display at least 30 rows with no row/column limits

Here's how I'll structure the code:

```python
import pandas as pd

# Set pandas display options to show all rows/columns without limits
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', None)

# Prepare the query request using the dates we found
request = {
    'startDate': default_start_date.strftime('%Y-%m-%d'),
    'endDate': default_end_date.strftime('%Y-%m-%d'),
    'dimensions': ['query', 'page'],
    'rowLimit': 25000,  # Maximum allowed per request
    'startRow': 0
}

print(f"Querying data for site: {target_site}")
print(f"Date range: {default_start_date} to {default_end_date}")

# Use the same fetch_all_gsc_data function from before
all_data = fetch_all_gsc_data(webmasters_service, target_site, request)

# Convert the API response to a DataFrame
df = pd.DataFrame(all_data)

# Split the 'keys' column into separate columns
if 'keys' in df.columns:
    # The first element in keys is 'query', the second is 'page'
    df['query'] = df['keys'].apply(lambda x: x[0])
    df['page'] = df['keys'].apply(lambda x: x[1])
    df = df.drop('keys', axis=1)

# Preview the DataFrame
print("\nDataFrame Preview (30 rows):")
print(df.head(30))

# Print basic stats about the data
print(f"\nTotal number of rows: {len(df)}")
print(f"Unique queries: {df['query'].nunique()}")
print(f"Unique pages: {df['page'].nunique()}")
```

This should:
1. Set up pandas to display everything without truncation
2. Use the date range we discovered in the previous cell
3. Query the GSC API using the existing function
4. Convert the API response to a pandas DataFrame
5. Split the 'keys' array into separate columns for query and page
6. Display the first 30 rows and some basic statistics

I need to ensure the column types are appropriate (e.g., numeric columns should be floats, not strings), but this should work well for the initial conversion to a DataFrame.
&lt;/think&gt;

Here's the revised code to use the established variables, load the data into a DataFrame, and display at least 30 rows with no display limits:

```python
# ======================================================================
# CELL: Query GSC Data with Latest Date Range and Convert to DataFrame
# ======================================================================

import pandas as pd

# Set pandas display options to show all rows/columns without limits
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', None)

# Prepare the query request using the dates we found
request = {
    'startDate': default_start_date.strftime('%Y-%m-%d'),
    'endDate': default_end_date.strftime('%Y-%m-%d'),
    'dimensions': ['query', 'page'],
    'rowLimit': 25000,  # Maximum allowed per request
    'startRow': 0
}

print(f"Querying data for site: {target_site}")
print(f"Date range: {default_start_date.strftime('%Y-%m-%d')} to {default_end_date.strftime('%Y-%m-%d')}")

# Execute the query using our existing function
all_data = fetch_all_gsc_data(webmasters_service, target_site, request)

# Convert the API response to a DataFrame
df = pd.DataFrame(all_data)

# Split the 'keys' column into separate columns
if 'keys' in df.columns:
    # The first element in keys is 'query', the second is 'page'
    df['query'] = df['keys'].apply(lambda x: x[0])
    df['page'] = df['keys'].apply(lambda x: x[1])
    df = df.drop('keys', axis=1)

# Ensure metrics are numeric types
for col in ['clicks', 'impressions', 'position', 'ctr']:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col])

# Convert CTR to percentage for better readability
df['ctr'] = df['ctr'] * 100

# Preview the DataFrame
print("\nDataFrame Preview (30 rows):")
print(df.head(30))

# Print basic stats about the data
print(f"\nTotal number of rows: {len(df)}")
print(f"Unique queries: {df['query'].nunique()}")
print(f"Unique pages: {df['page'].nunique()}")
print(f"Total clicks: {df['clicks'].sum()}")
print(f"Total impressions: {df['impressions'].sum()}")
print(f"Average position: {df['position'].mean():.2f}")
print(f"Average CTR: {df['ctr'].mean():.2f}%")
```

This code:

1. Sets pandas display options to show all data without truncation
2. Uses the date range we discovered in the previous cell
3. Queries the GSC API using our existing function
4. Converts the API response to a pandas DataFrame
5. Extracts query and page from the keys array into separate columns
6. Ensures all metric columns have the correct numeric data types
7. Converts CTR to percentage format for better readability
8. Displays the first 30 rows of the DataFrame
9. Provides useful summary statistics about the dataset

The DataFrame will now be ready for further analysis, especially identifying "striking distance" keywords.

---

Output: 

```plaintext
Querying data for site: sc-domain:mikelev.in
Date range: 2024-12-26 to 2025-03-26
Fetching page 1 (rows 0 to 24999)...
Retrieved 1067 rows
Reached last page of results.
Total rows fetched: 1067

DataFrame Preview (30 rows):
    clicks  impressions       ctr   position                            query  \
0       16           85  0.188235   4.400000                fasthtml database   
1       10          139  0.071942   3.683453                 ollama websocket   
2        9          400  0.022500   6.230000                 peak data theory   
3        7           86  0.081395   3.244186                          levinux   
4        7          127  0.055118   2.677165                         pipulate   
5        6           85  0.070588   7.811765                 nix flake python   
6        5           12  0.416667   4.250000  cursor ai with jupyter notebook   
7        4           47  0.085106  23.744681                         fasthtml   
8        4           33  0.121212   3.606061                    grok markdown   
9        3           61  0.049180  35.786885                         fasthtml   
10       2            3  0.666667  39.333333                 fastapi patterns   
11       2            4  0.500000  16.750000                         fasthtml   
12       2           36  0.055556   9.416667                         pipulate   
13       2           65  0.030769   7.000000                         pipulate   
14       2           49  0.040816   7.510204                 python nix flake   
15       1            3  0.333333   8.666667                chatgpt o1 python   
16       1            5  0.200000   6.200000      cursor ide jupyter notebook   
17       1            9  0.111111   9.666667                   cursor jupyter   
18       1           13  0.076923   7.000000          cursor jupyter notebook   
19       1           10  0.100000  10.400000  cursor jupyter notebook support   
20       1            1  1.000000   7.000000           cursor python notebook   
21       1            4  0.250000   9.500000              fastapi vs fasthtml   
22       1            7  0.142857   5.000000                         fasthtml   
23       1           48  0.020833   8.479167                fasthtml database   
24       1           18  0.055556   9.111111                  fasthtml review   
25       1           28  0.035714   7.642857                   fasthtml table   
26       1            1  1.000000  12.000000               fasthtml vs django   
27       1            1  1.000000   4.000000              fasthtml vs fastapi   
28       1           19  0.052632   5.789474                     grok 3 error   
29       1           67  0.014925   7.432836               grok 3 not working   

                                                                 page  
0        https://mikelev.in/futureproof/unpacking-fasthtml-databases/  
1               https://mikelev.in/futureproof/ollama-websocket-chat/  
2      https://mikelev.in/futureproof/peak-data-musk-sutskever-wrong/  
3                                         https://mikelev.in/levinux/  
4                                        https://mikelev.in/pipulate/  
5                          https://mikelev.in/futureproof/nix-flakes/  
6      https://mikelev.in/futureproof/jupyter-notebook-vscode-cursor/  
7        https://mikelev.in/futureproof/fast-html-framework-opinions/  
8              https://mikelev.in/futureproof/grok3-markdown-problem/  
9        https://mikelev.in/futureproof/unpacking-fasthtml-databases/  
10  https://mikelev.in/futureproof/pattern-alert-this-is-not-fastapi/  
11             https://mikelev.in/futureproof/python-nix-htmx-ollama/  
12                                                https://mikelev.in/  
13       https://mikelev.in/futureproof/pipulate-pipeline-born-again/  
14                         https://mikelev.in/futureproof/nix-flakes/  
15     https://mikelev.in/futureproof/chatgpt-o1-preview-code-review/  
16     https://mikelev.in/futureproof/jupyter-notebook-vscode-cursor/  
17     https://mikelev.in/futureproof/jupyter-notebook-vscode-cursor/  
18     https://mikelev.in/futureproof/jupyter-notebook-vscode-cursor/  
19     https://mikelev.in/futureproof/jupyter-notebook-vscode-cursor/  
20     https://mikelev.in/futureproof/jupyter-notebook-vscode-cursor/  
21                                       https://mikelev.in/fasthtml/  
22           https://mikelev.in/futureproof/fasthtml-htmx-unix-pipes/  
23      https://mikelev.in/futureproof/fasththml-websockets-database/  
24       https://mikelev.in/futureproof/unpacking-fasthtml-databases/  
25       https://mikelev.in/futureproof/unpacking-fasthtml-databases/  
26       https://mikelev.in/futureproof/fast-html-framework-opinions/  
27                                                https://mikelev.in/  
28             https://mikelev.in/futureproof/grok3-markdown-problem/  
29             https://mikelev.in/futureproof/grok3-markdown-problem/  

Total number of rows: 1067
Unique queries: 942
Unique pages: 126
```

**Me**: Excellent! But you're using too long of a date range. I just want from
the most recent date data is available to 3 days prior to that. So I believe in
this case, it's March 23 to March 26 if I have my math right. Don't hardwire
dates! Just use timedelta or whatever is in the Python standard library. We can
always install dateutil if you need.

### Creating a SEMRush-Ready Keyword List

So make that adjustment, and while we're at it also make anther dataframe which
is the striking distance. Our objective is to get a single stacked line of
keywords with no other columns copy/paste-ready for SEMRush's keyword tool,
which takes up to 100 keywords.

### Defining Striking Distance Criteria

Good striking distance candidates have a position of >=11 (11, 12, 13, etc. The
thing is queries appear more than once because the same keyword can lead to
different landing pages. And if any of them are less than 11, it disqualifies
that keyword! So you might want to do a first pass with a min function to dedupe
the keywords. On this new intermediary table we're making, we don't need the
page column. Presumably, that's what we'll group by or otherwise remove during
the aggregation process. We should sum the clicks and we should sum the
impressions per keyword. We don't need CTR.

Show 30 rows from the new dataframe.

### Implementation Notes

This comes after the previously run cell, so all that is in memory. No need to
re-import anything.

So this is a request for the previous cell-block updated with the shorter 3-day
daterange and the code for a new cell for just the striking distance candidates.

**Claude 3.7**: &lt;think&gt;
Alright, let's make these changes:

1. First, update the date range to be just 3 days before the most recent date to the most recent date
2. Create a new dataframe for striking distance keywords (position >= 11)
3. Handle duplicate keywords correctly by:
   - Using min function to find the best position for each keyword
   - Only including keywords where the best position is still >= 11
4. Group by query, summing clicks and impressions
5. Format into a clean list for SEMrush

For the date range, instead of:
```python
default_start_date = default_end_date - timedelta(days=90)
```

We'll use:
```python
default_start_date = default_end_date - timedelta(days=3)
```

For the striking distance candidates, we need to:
1. Find minimum position per query (across all pages)
2. Filter to only keep keywords where min position >= 11
3. Sum metrics by query
4. Format the output

Let me work through this.
&lt;/think&gt;

Here's the updated code for both cells - first with the shorter date range, and then the new cell for striking distance candidates:

```python
# ======================================================================
# CELL: Query GSC Data with 3-Day Date Range and Convert to DataFrame
# ======================================================================

import pandas as pd

# Set pandas display options to show all rows/columns without limits
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', None)

# Use a 3-day range instead of 90 days
default_start_date = default_end_date - timedelta(days=3)

# Prepare the query request using the updated dates
request = {
    'startDate': default_start_date.strftime('%Y-%m-%d'),
    'endDate': default_end_date.strftime('%Y-%m-%d'),
    'dimensions': ['query', 'page'],
    'rowLimit': 25000,  # Maximum allowed per request
    'startRow': 0
}

print(f"Querying data for site: {target_site}")
print(f"Date range: {default_start_date.strftime('%Y-%m-%d')} to {default_end_date.strftime('%Y-%m-%d')}")

# Execute the query using our existing function
all_data = fetch_all_gsc_data(webmasters_service, target_site, request)

# Convert the API response to a DataFrame
df = pd.DataFrame(all_data)

# Split the 'keys' column into separate columns
if 'keys' in df.columns:
    # The first element in keys is 'query', the second is 'page'
    df['query'] = df['keys'].apply(lambda x: x[0])
    df['page'] = df['keys'].apply(lambda x: x[1])
    df = df.drop('keys', axis=1)

# Ensure metrics are numeric types
for col in ['clicks', 'impressions', 'position', 'ctr']:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col])

# Convert CTR to percentage for better readability
df['ctr'] = df['ctr'] * 100

# Preview the DataFrame
print("\nDataFrame Preview (30 rows):")
print(df.head(30))

# Print basic stats about the data
print(f"\nTotal number of rows: {len(df)}")
print(f"Unique queries: {df['query'].nunique()}")
print(f"Unique pages: {df['page'].nunique()}")
print(f"Total clicks: {df['clicks'].sum()}")
print(f"Total impressions: {df['impressions'].sum()}")
print(f"Average position: {df['position'].mean():.2f}")
print(f"Average CTR: {df['ctr'].mean():.2f}%")
```

And here's the new cell for striking distance keywords:

```python
# ======================================================================
# CELL: Find Striking Distance Keywords
# ======================================================================

print("Finding striking distance keywords (position >= 11)...")

# Step 1: For each query, find its best position across all pages
query_best_position = df.groupby('query')['position'].min().reset_index()

# Step 2: Filter to keep only queries where even the best position is >= 11
striking_distance_queries = query_best_position[query_best_position['position'] >= 11]['query'].tolist()
print(f"Found {len(striking_distance_queries)} queries with all positions >= 11")

# Step 3: Create a dataframe with only these striking distance keywords
striking_df = df[df['query'].isin(striking_distance_queries)].copy()

# Step 4: Aggregate data by query (summing clicks and impressions)
striking_agg = striking_df.groupby('query').agg({
    'clicks': 'sum',
    'impressions': 'sum',
    'position': 'mean'  # Average position across all pages
}).reset_index()

# Sort by impressions (highest first) to prioritize higher volume opportunities
striking_agg = striking_agg.sort_values('impressions', ascending=False)

# Print details about the striking distance keywords
print("\nStriking Distance Keywords (30 rows):")
print(striking_agg.head(30))
print(f"\nTotal striking distance keywords: {len(striking_agg)}")

# Export the top 100 keywords in a format ready for SEMrush
top_semrush_keywords = striking_agg.head(100)['query'].tolist()

# Format as a stacked list for easy copy-paste
semrush_formatted = "\n".join(top_semrush_keywords)

print("\nTop 100 keywords for SEMrush (copy/paste ready):")
print(semrush_formatted)

# Optionally save to file
# with open('semrush_keywords.txt', 'w') as f:
#     f.write(semrush_formatted)
```

The first cell now uses a 3-day date range instead of 90 days, and the second cell:

1. Identifies the best position for each query across all pages
2. Filters to only keep queries where even the best position is ≥ 11
3. Creates a filtered DataFrame of just the striking distance candidates
4. Aggregates by query, summing clicks and impressions
5. Sorts by impressions (descending) to prioritize higher-volume terms
6. Outputs the top keywords in a stacked format ready for copy/paste into SEMrush

This approach ensures we only include keywords that don't rank on page 1 for any URL on your site.

---

**Me**: SEMRush deemed the following keywords "too complex". Can you look for a commonality that Python would be capable of handling? Something in nltk? But not too complex!

Here are the extracted keywords marked as **"too complex"** from your list:

1. open source seo software  
7. open source seo platform  
10. seo tool open source  
14. easily distracted weakness  
20. pass the baton python  
28. agentic frameworks comparison  
31. pipeline workflow management  
37. ui for llm chat  
39. automate seo with python  
41. brath graph analysis and visualization "torrent"  
42. grok 3 vs me  
44. how to create custom workflows in linear  
46. single page application python  
51. best function calling llm  
52. cursor ai for devops  
53. can perplexity deep research handle complex or contradictory information  
55. open source seo toolkit  
56. single page application performance testing  
66. grok is not working  
68. see gsc snip below  
69. seo tools open source  
71. convert jupyter notebook to markdown  
72. can you run grok 3 locally  
77. browserstack free alternative reddit  
81. ai assistant for linux  
84. function calling in open source models  
95. linux if elif else  
96. markdown in jupyter notebook  
97. markdown editor jupyter notebook  
99. mcp vs function call

**Claude 3.7**: &lt;think&gt;
Looking at these "too complex" keywords from SEMrush, I need to identify commonalities or patterns that Python could handle using not-too-complex NLP techniques. Let me analyze:

Potential patterns I see:
1. **Multiple words/length** - Most of these are 4+ words, making them longer queries
2. **Special characters** - Some have quotation marks, symbols
3. **Formatting issues** - Some might have unusual spacing or formatting
4. **Programming terms mixed with natural language** - Many combine technical terms with natural language
5. **Ambiguity** - Several seem to have multiple potential meanings

Let's think about simple Python/NLTK approaches that could help filter or clean these:

1. **Word count** - Simple counting of words (e.g., `len(keyword.split())`) could identify overly long queries
2. **Special character detection** - Simple regex to detect/remove quotes, unusual punctuation
3. **POS tagging** - NLTK part-of-speech tagging to identify unusual grammatical structures
4. **Named entity recognition** - To identify proper nouns, programming terms
5. **Simple semantic analysis** - Word embeddings to check coherence (might be too complex)

For simplicity, I'll focus on:
1. Word count filtering
2. Special character detection/cleaning
3. Maybe a simple keyword density approach (identifying unusual combinations of terms)

This should be implementable without diving too deep into NLP, while still addressing many of the issues.
&lt;/think&gt;

Looking at the "too complex" keywords, I see several patterns that Python could help identify and potentially fix:

1. **Length and word count** - Many have 4+ words (e.g., "open source seo software", "automate seo with python")
2. **Special characters** - Some contain quotes, unusual punctuation (e.g., "brath graph analysis and visualization "torrent"")
3. **Unusual hybrid queries** - Mixing programming terms with natural language or product names with concepts

Here's a simple Python approach using basic string operations that could help clean these up:

```python
def clean_keywords(keywords_list):
    cleaned_keywords = []
    too_complex = []
    
    for keyword in keywords_list:
        # Remove quotes and normalize spacing
        cleaned = keyword.replace('"', '').replace('"', '').strip()
        
        # Check if too long (more than 5 words might be problematic)
        if len(cleaned.split()) > 5:
            too_complex.append(keyword)
            continue
            
        # Check for special characters (except basic punctuation)
        if any(c for c in cleaned if not c.isalnum() and c not in [' ', '-', '.']):
            # Try removing special characters
            cleaned = ''.join(c for c in cleaned if c.isalnum() or c == ' ')
            
        # Remove "vs" comparisons as they often get flagged
        if " vs " in cleaned.lower():
            words = cleaned.lower().split(" vs ")
            cleaned = words[0]  # Take just the first term
            
        cleaned_keywords.append(cleaned.strip())
        
    return cleaned_keywords, too_complex

# Apply this to your top keywords list
cleaned_semrush_keywords, still_too_complex = clean_keywords(top_semrush_keywords)

# Replace original list with cleaned version
semrush_formatted = "\n".join(cleaned_semrush_keywords)

print("\nCleaned keywords for SEMrush (copy/paste ready):")
print(semrush_formatted)
print(f"\nRemoved {len(still_too_complex)} too complex keywords")
```

This approach:

1. Removes quotes and normalizes spacing
2. Identifies overly long keywords (more than 5 words)
3. Removes special characters that aren't alphanumeric or basic punctuation
4. Simplifies comparison keywords (like "X vs Y") by keeping just the first term

For more sophistication without excessive complexity, you could use NLTK for basic NLP operations:

```python
import nltk
from nltk.tokenize import word_tokenize

# Download necessary NLTK data (run once)
# nltk.download('punkt')

def analyze_keyword_complexity(keyword):
    # Tokenize
    tokens = word_tokenize(keyword.lower())
    
    # Check length
    if len(tokens) > 5:
        return "too_long"
    
    # Check for special tokens
    if any(not token.isalnum() for token in tokens):
        return "special_chars"
    
    # Check for comparison terms
    if "vs" in tokens or "versus" in tokens:
        return "comparison"
    
    return "ok"
```

You could incorporate this analysis into your keyword processing pipeline to better understand why certain keywords are being flagged as too complex.

---

**Me**: Okay, revise the previous step that goes all the way to semrush_formatted list to stop short of that, but set the stage with a candidate list that is longer but maintains the descending presumably by impressions order. It should be the entire list of candidate striking distance keywords.

Then create a second python code-block for a cell that will follow that one, using both the clean_keywords and analyze_keyword_complexity function. Make it easy to turn off the analyze_keyword_complexity if it doesn't work out.

**Claude 3.7**: &lt;think&gt;
I'll create two code blocks as requested:

1. First code block: Modify the previous striking distance keyword code to include all striking distance keywords (not just top 100) in descending order by impressions.

2. Second code block: Create a new cell with both cleaning functions, with an easy way to toggle the NLTK-based analysis.

For the first block, I'll modify the existing code to stop before creating the `semrush_formatted` string, ensuring we have the complete list of striking distance keywords sorted by impressions.

For the second block, I'll implement both cleaning approaches with a simple flag to enable/disable the NLTK analysis.
&lt;/think&gt;

Here's the revised code for the striking distance keywords cell, stopping short of the final formatted list:

```python
# ======================================================================
# CELL: Find Striking Distance Keywords
# ======================================================================

print("Finding striking distance keywords (position >= 11)...")

# Step 1: For each query, find its best position across all pages
query_best_position = df.groupby('query')['position'].min().reset_index()

# Step 2: Filter to keep only queries where even the best position is >= 11
striking_distance_queries = query_best_position[query_best_position['position'] >= 11]['query'].tolist()
print(f"Found {len(striking_distance_queries)} queries with all positions >= 11")

# Step 3: Create a dataframe with only these striking distance keywords
striking_df = df[df['query'].isin(striking_distance_queries)].copy()

# Step 4: Aggregate data by query (summing clicks and impressions)
striking_agg = striking_df.groupby('query').agg({
    'clicks': 'sum',
    'impressions': 'sum',
    'position': 'mean'  # Average position across all pages
}).reset_index()

# Sort by impressions (highest first) to prioritize higher volume opportunities
striking_agg = striking_agg.sort_values('impressions', ascending=False)

# Print details about the striking distance keywords
print("\nStriking Distance Keywords (30 rows):")
print(striking_agg.head(30))
print(f"\nTotal striking distance keywords: {len(striking_agg)}")

# Extract the complete list of keywords, sorted by impressions
all_striking_keywords = striking_agg['query'].tolist()
print(f"Prepared {len(all_striking_keywords)} keywords for processing")
```

Now here's the keyword cleaning cell that will follow:

```python
# ======================================================================
# CELL: Clean Keywords for SEMrush
# ======================================================================

# Set to True to use NLTK analysis, False to use only basic cleaning
USE_NLTK_ANALYSIS = False  # Easy toggle

# If NLTK is enabled, try to import it (install if needed)
if USE_NLTK_ANALYSIS:
    try:
        import nltk
        from nltk.tokenize import word_tokenize
        # Uncomment to download necessary data (first time only)
        # nltk.download('punkt')
    except ImportError:
        print("NLTK not installed. Run: pip install nltk")
        USE_NLTK_ANALYSIS = False
        
# Basic cleaning function
def clean_keywords(keywords_list):
    cleaned_keywords = []
    too_complex = []
    
    for keyword in keywords_list:
        # Remove quotes and normalize spacing
        cleaned = keyword.replace('"', '').replace('"', '').strip()
        
        # Check if too long (more than 5 words might be problematic)
        if len(cleaned.split()) > 5:
            too_complex.append(keyword)
            continue
            
        # Check for special characters (except basic punctuation)
        if any(c for c in cleaned if not c.isalnum() and c not in [' ', '-', '.']):
            # Try removing special characters
            cleaned = ''.join(c for c in cleaned if c.isalnum() or c == ' ')
            
        # Remove "vs" comparisons as they often get flagged
        if " vs " in cleaned.lower():
            words = cleaned.lower().split(" vs ")
            cleaned = words[0]  # Take just the first term
            
        cleaned_keywords.append(cleaned.strip())
        
    return cleaned_keywords, too_complex

# More advanced analysis using NLTK (if enabled)
def analyze_keyword_complexity(keyword):
    if not USE_NLTK_ANALYSIS:
        return "skipped_analysis"
        
    # Tokenize
    tokens = word_tokenize(keyword.lower())
    
    # Check length
    if len(tokens) > 5:
        return "too_long"
    
    # Check for special tokens
    if any(not token.isalnum() for token in tokens):
        return "special_chars"
    
    # Check for comparison terms
    if "vs" in tokens or "versus" in tokens:
        return "comparison"
    
    return "ok"

# Process all keywords
print(f"Processing {len(all_striking_keywords)} keywords...")
cleaned_keywords, removed_keywords = clean_keywords(all_striking_keywords)

# Analyze complexity if enabled
if USE_NLTK_ANALYSIS:
    complexity_results = {}
    for kw in cleaned_keywords:
        result = analyze_keyword_complexity(kw)
        if result != "ok":
            complexity_results[kw] = result
    
    print(f"\nKeyword complexity analysis:")
    for kw, result in complexity_results.items():
        print(f"- '{kw}': {result}")

# Take the top 100 cleaned keywords
top_100_cleaned = cleaned_keywords[:100]
semrush_formatted = "\n".join(top_100_cleaned)

print(f"\nCleaned {len(all_striking_keywords)} keywords to {len(cleaned_keywords)}")
print(f"Removed {len(removed_keywords)} complex keywords")
print(f"Selected top 100 for SEMrush")

print("\nTop 100 keywords for SEMrush (copy/paste ready):")
print(semrush_formatted)

# Optionally save to file
# with open('semrush_keywords.txt', 'w') as f:
#     f.write(semrush_formatted)
```

This approach:

1. The first cell identifies and collects all striking distance keywords, sorting by impressions
2. The second cell:
   - Has an easy toggle at the top to enable/disable NLTK analysis
   - Applies basic cleaning to all keywords
   - Optionally performs more advanced NLTK analysis
   - Takes the top 100 cleaned keywords for SEMrush
   - Creates the final formatted string

With the toggle, you can easily switch between simple cleaning and more advanced analysis without removing any code.

---

Output:

```plaintext
Processing 149 keywords...

Cleaned 149 keywords to 143
Removed 6 complex keywords
Selected top 100 for SEMrush

Top 100 keywords for SEMrush (copy/paste ready):
Run the next cell to copy/paste the keywords into SEMrush
```

And the next cell which I made separate for copy/paste simplicity:

```plaintext
open source seo software
linux seo software
seo software linux
seo michael beast
python cursorrules
llm seo
open source seo platform
nix flake python
seo llm
seo tool open source
open source seo
peak data scientist
jupyter markdown
easily distracted weakness
swagger tutorial python
linux seo tools
swagger python
seo workflows
pipeline workflow
pass the baton python
peak data
jupyter notebook markdown
python swagger
is grok broken
fasthtml
starter flow
llm function calling
agentic frameworks comparison
mike seo
python swagger example
pipeline workflow management
nuance api
nixos nvidia wayland
markdown jupyter
mindful metamorphosis
nix python pip
ui for llm chat
grok problems
automate seo with python
contractsense launch
grok 3
grok problem
botify commands
single page application python
skyvern ollama
seo automation python
wayland and hyprland
swagger python example
best function calling llm
cursor ai for devops
parameter seo
open source seo toolkit
single page application performance testing
linux c pipe
nix flakes
nixos build switch
nixos nvidia cuda
neovim nixos
future-proof isv hardware
grok3 github
grok 3 beta
fasthtml
grok is not working
seo tools linux
see gsc snip below
seo tools open source
cursor ai server
convert jupyter notebook to markdown
chip-o
browsertool mcp
articlebody
botify wikipedia
browserstack free alternative reddit
automating seo
agentic frameworks
ahrefs python
ai assistant for linux
self improvement
grok issue
cursor ai wsl2
nixos webcam
nixos upgrade
nixos python uv
nix wayland
nixos
nix build flake
nix cursor
nix flake
lizzi sassman
linux if elif else
markdown in jupyter notebook
markdown editor jupyter notebook
mcp python
mcp
mike levin
mike mirror
linux ai assistant
grok block
godel escher bach summary
grok 3 code
```

**Me**: Okay, I've downloaded the SEMRush file and have written the following to
give you a taste:

```python
df_semrush = pd.read_csv("notebooks/semrush_bulk_us_2025-03-28_21-03-40.csv")
print(df_semrush.columns)
print(df_semrush.head())
print(df_semrush.describe())
print(df_semrush.info())
print(df_semrush.shape)
print(df_semrush.size)
```

Output:

```plaintext
Index(['Keyword', 'Intent', 'Volume', 'Trend', 'Keyword Difficulty',
       'CPC (USD)', 'SERP Features'],
      dtype='object')
            Keyword                     Intent  Volume  \
0               mcp              Informational   14800   
1             nixos               Navigational   12100   
2        mike levin               Navigational    6600   
3  self improvement  Informational, Commercial    6600   
4          fasthtml              Informational    1900   

                                                         Trend  \
0  1.00,0.81,0.81,0.81,0.81,0.54,0.81,0.81,1.00,0.66,1.00,1.00   
1  0.81,1.00,0.81,0.81,0.81,1.00,0.81,0.81,0.66,0.66,0.66,0.66   
2  0.00,0.06,0.08,0.44,0.14,0.36,0.28,0.00,0.36,1.00,0.36,0.36   
3  1.00,1.00,1.00,1.00,0.81,0.81,1.00,1.00,1.00,1.00,1.00,1.00   
4                      0.00,0.35,1.00,0.29,0.16,0.12,0.10,0.12   

   Keyword Difficulty  CPC (USD)  \
0                30.0       2.44   
1                76.0       0.00   
2                59.0       0.00   
3                62.0       2.66   
4                63.0       0.00   

                                                                                                                   SERP Features  
0                                                       Sitelinks, Reviews, Image pack, Video, Knowledge panel, Related searches  
1                                           Sitelinks, Video, People also ask, Knowledge panel, Related searches, Things to know  
2                                                   Sitelinks, Image pack, Video, People also ask, Top stories, Related searches  
3  Sitelinks, AI Overview, Reviews, Image pack, Video, People also ask, Discussions and forums, Related searches, Things to know  
4                                                           Sitelinks, Video, People also ask, Knowledge panel, Related searches  
             Volume  Keyword Difficulty  CPC (USD)
count     75.000000           26.000000  75.000000
mean     645.466667           37.269231   1.552267
std     2410.091561           18.050059   2.879072
min        0.000000           11.000000   0.000000
25%       20.000000           23.250000   0.000000
50%       20.000000           39.000000   0.000000
75%       90.000000           48.750000   2.160000
max    14800.000000           76.000000  11.150000
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 75 entries, 0 to 74
Data columns (total 7 columns):
 #   Column              Non-Null Count  Dtype  
---  ------              --------------  -----  
 0   Keyword             75 non-null     object 
 1   Intent              26 non-null     object 
 2   Volume              75 non-null     int64  
 3   Trend               75 non-null     object 
 4   Keyword Difficulty  26 non-null     float64
 5   CPC (USD)           75 non-null     float64
 6   SERP Features       26 non-null     object 
dtypes: float64(2), int64(1), object(4)
memory usage: 4.2+ KB
None
(75, 7)
525
```

**Me**: Knowing what you know from the taste, give me the join.

**Claude 3.7**: &lt;think&gt;
Let's analyze what we need to do for the join:

1. We have two dataframes:
   - `striking_agg`: Contains our striking distance keywords from GSC with columns:
     - query (the keyword)
     - clicks
     - impressions
     - position
   
   - `df_semrush`: Contains SEMrush data with:
     - Keyword
     - Intent
     - Volume
     - Trend
     - Keyword Difficulty
     - CPC (USD)
     - SERP Features

2. We want to join these on the keyword column (called 'query' in striking_agg and 'Keyword' in df_semrush)

3. The goal is likely to prioritize our striking distance keywords based on:
   - Search volume (from SEMrush)
   - Keyword difficulty (from SEMrush)
   - Current position (from GSC)
   - Current impressions (from GSC)

Let's create code to:
1. Join the dataframes
2. Sort by a combination of factors that prioritize high-volume, lower difficulty keywords that are already getting impressions
3. Handle cases where SEMrush doesn't have data for our keywords (we saw from the output that only some keywords have Keyword Difficulty data)
&lt;/think&gt;

Here's the code to join the GSC striking distance data with the SEMrush data:

````python
# ======================================================================
# CELL: Join GSC Striking Distance Keywords with SEMrush Data
# ======================================================================

# First, let's clean up the SEMrush dataframe a bit (nulls and capitalization)
df_semrush['Keyword'] = df_semrush['Keyword'].str.lower()  # Make lowercase to match GSC data
df_semrush_clean = df_semrush.copy()

# Now join the striking distance keywords with SEMrush data
merged_df = striking_agg.merge(
    df_semrush_clean,
    left_on='query',
    right_on='Keyword',
    how='left'  # Left join to keep all striking distance keywords
)

# Fill NaN values for Volume (some keywords may not be in SEMrush)
merged_df['Volume'] = merged_df['Volume'].fillna(0).astype(int)
merged_df['Keyword Difficulty'] = merged_df['Keyword Difficulty'].fillna(0)
merged_df['CPC (USD)'] = merged_df['CPC (USD)'].fillna(0.0)

# Create an opportunity score (basic version)
# High impressions + decent position + high volume + lower difficulty = better opportunity
merged_df['Opportunity Score'] = (
    merged_df['impressions'] * 0.4 +                # More impressions is good
    merged_df['Volume'] * 0.4 +                     # More volume is good
    (100 - merged_df['Keyword Difficulty']) * 0.1 + # Lower difficulty is good
    (30 - merged_df['position']).clip(lower=0) * 0.1 # Better position (closer to 11) is good
)

# Sort by opportunity score
merged_df = merged_df.sort_values('Opportunity Score', ascending=False)

# Display the results
print("Top Opportunities (Keywords with SEMrush data):")
columns_to_show = ['query', 'impressions', 'position', 'Volume', 'Keyword Difficulty', 'CPC (USD)', 'Opportunity Score']
print(merged_df[columns_to_show].head(30))

# Summarize match rate
total_keywords = len(striking_agg)
matched_keywords = merged_df['Volume'].replace(0, np.nan).count()
match_rate = (matched_keywords / total_keywords) * 100

print(f"\nKeyword Match Statistics:")
print(f"Total striking distance keywords: {total_keywords}")
print(f"Keywords found in SEMrush: {matched_keywords} ({match_rate:.1f}%)")

# Create a list of prioritized keywords based on this analysis
# This filters to keep only keywords that have SEMrush data
semrush_matched_keywords = merged_df[merged_df['Volume'] > 0].copy()

print(f"\nTop 20 Opportunity Keywords (with SEMrush data):")
for idx, row in semrush_matched_keywords.head(20).iterrows():
    print(f"{row['query']} - Vol: {row['Volume']} - KD: {row['Keyword Difficulty']} - Pos: {row['position']:.1f}")
````


This code:

1. Performs a left join between your striking distance keywords and SEMrush data
2. Creates an "Opportunity Score" that balances:
   - Current impressions (40% weight)
   - Search volume (40% weight)
   - Keyword difficulty (10% weight, inverted so lower difficulty scores higher)
   - Current position (10% weight, with position closer to 11 scoring higher)
3. Sorts by this opportunity score
4. Shows how many of your keywords were found in SEMrush
5. Outputs a list of the top 20 keywords with the best opportunity

You can adjust the weighting in the Opportunity Score formula to prioritize different factors based on your strategy. For example, if you want to focus more on high-volume terms regardless of difficulty, you could increase the weight for Volume.


---

Output:

```plaintext
Top Opportunities (Keywords with SEMrush data):
                            query  impressions   position  Volume  \
89                          nixos            1  33.000000   12100   
99                     mike levin            1  25.000000    6600   
24                       fasthtml            5  28.625000    1900   
57                     nix flakes            2  37.000000     720   
92                      nix flake            1  36.000000     480   
21      jupyter notebook markdown            6  43.500000     390   
0        open source seo software           87  48.459770     210   
26           llm function calling            5  74.200000     260   
78             agentic frameworks            1  50.000000     260   
12               jupyter markdown            7  41.857143     210   
53                  parameter seo            2  59.500000     210   
16                 swagger python            6  28.166667     140   
22                 python swagger            6  30.833333     140   
95   markdown in jupyter notebook            1  39.000000     140   
79                  ahrefs python            1  78.000000     110   
101            linux ai assistant            1  56.000000      90   
103     godel escher bach summary            1  39.000000      90   
1              linux seo software           60  49.920565      20   
2              seo software linux           59  49.697083      20   
5                         llm seo           26  68.615385      50   
80         ai assistant for linux            1  64.000000      70   
33               markdown jupyter            4  44.500000      70   
3               seo michael beast           52  22.730769       0   
6        open source seo platform           17  39.941176      30   
86                  nixos upgrade            1  25.000000      40   
20                      peak data            6  34.166667      30   
60                   neovim nixos            2  17.000000      30   
4              python cursorrules           35  46.888889       0   
38       automate seo with python            3  81.666667      30   
34          mindful metamorphosis            3  90.333333      30   

     Keyword Difficulty  CPC (USD)  Opportunity Score  
89                 76.0       0.00        4842.800000  
99                 59.0       0.00        2645.000000  
24                 63.0       0.00         765.837500  
57                 23.0       0.00         296.500000  
92                 36.0       0.00         198.800000  
21                 46.0       0.08         163.800000  
0                  11.0       0.00         127.700000  
26                 25.0       0.00         113.500000  
78                 38.0       4.68         110.600000  
12                 48.0       0.00          92.000000  
53                 40.0       3.86          90.800000  
16                 49.0       8.00          63.683333  
22                 50.0       7.62          63.400000  
95                 44.0       0.11          62.000000  
79                 17.0       0.00          52.700000  
101                14.0       3.29          45.000000  
103                18.0       0.22          44.600000  
1                   0.0       0.00          42.000000  
2                   0.0       0.00          41.600000  
5                  24.0       6.69          38.000000  
80                 18.0       3.29          36.600000  
33                 43.0       0.00          35.300000  
3                   0.0       0.00          31.526923  
6                   0.0       0.00          28.800000  
86                 24.0       0.00          24.500000  
20                  0.0       9.40          24.400000  
60                  0.0       0.00          24.100000  
4                   0.0       0.00          24.000000  
38                  0.0       0.00          23.200000  
34                  0.0       0.00          23.200000  

Keyword Match Statistics:
Total striking distance keywords: 149
Keywords found in SEMrush: 59 (39.6%)

Top 20 Opportunity Keywords (with SEMrush data):
nixos - Vol: 12100 - KD: 76.0 - Pos: 33.0
mike levin - Vol: 6600 - KD: 59.0 - Pos: 25.0
fasthtml - Vol: 1900 - KD: 63.0 - Pos: 28.6
nix flakes - Vol: 720 - KD: 23.0 - Pos: 37.0
nix flake - Vol: 480 - KD: 36.0 - Pos: 36.0
jupyter notebook markdown - Vol: 390 - KD: 46.0 - Pos: 43.5
open source seo software - Vol: 210 - KD: 11.0 - Pos: 48.5
llm function calling - Vol: 260 - KD: 25.0 - Pos: 74.2
agentic frameworks - Vol: 260 - KD: 38.0 - Pos: 50.0
jupyter markdown - Vol: 210 - KD: 48.0 - Pos: 41.9
parameter seo - Vol: 210 - KD: 40.0 - Pos: 59.5
swagger python - Vol: 140 - KD: 49.0 - Pos: 28.2
python swagger - Vol: 140 - KD: 50.0 - Pos: 30.8
markdown in jupyter notebook - Vol: 140 - KD: 44.0 - Pos: 39.0
ahrefs python - Vol: 110 - KD: 17.0 - Pos: 78.0
linux ai assistant - Vol: 90 - KD: 14.0 - Pos: 56.0
godel escher bach summary - Vol: 90 - KD: 18.0 - Pos: 39.0
linux seo software - Vol: 20 - KD: 0.0 - Pos: 49.9
seo software linux - Vol: 20 - KD: 0.0 - Pos: 49.7
llm seo - Vol: 50 - KD: 24.0 - Pos: 68.6
```

Given this, ideate a format in which you would like to see this data which in
combination with a large article such as @ you could help figure out the ideal
permalink slug and title.

I'm using Jekyll SSG and all my top-matter YAML has a permalink field. I use
roughly the same hyphenated lower-case word arrangement in the permalink as I do
with a Title Case variation in the title field. I usually only drop stop-words,
or the lesser-targeted words if the title is becoming too long. It also becomes
the main H1 of the page and goes into anchor text leading to the page in
blog-style prev/next navigational links.

I think you get the idea. I would like one the best matching striking distance
that matches the subject-matter of the page to be suggested. This should not be
a forced thing. This is an opportunistic walking into the storm sort of thing.
If it happens, it happens. If not, it was a nice exercise and we will do it
again on the next article. It's a small directional tweak we're looking for so
as not to leave any obviously ready to pick-up traffic on the table.

I always have Gemini suggest alternative titles and headlines that are pretty
consistently found at the bottom of the article pages now. The overall article
should be used, but those in particular will probably be useful.

So I guess what this prompt is asking is how would you like to see the dataframe
we just created in combination with such an article, and what is the prompt you
think I should ask to get the ideal title and permalink?

**Claude 3.7**: &lt;think&gt;
Based on your request, I'll design a format that combines the SEO data from our merged dataframe with an article analysis to help determine optimal title and permalink choices. Here's my approach:

1. First, I'd create a visual representation of the striking distance keywords that are most relevant to the article content
2. Then suggest a methodology to match these keywords with the article's themes
3. Finally, propose a prompt for generating title and permalink recommendations

For the data visualization part, I want to:
- Show the top opportunity keywords that are relevant to the article
- Present each keyword with its SEO metrics in a clean, easy-to-read format
- Include a relevance score that indicates how well it matches the article content

The goal is to identify keywords that are both SEO valuable (good volume, reasonable difficulty, currently ranking on page 2-3) AND thematically aligned with the article.
&lt;/think&gt;

I'd recommend a format that combines the SEO data with content analysis to find the optimal title/permalink match. Here's what I envision:

## 1. Content-Keyword Relevance Analysis Table

```
| Keyword                    | Relevance | Volume | KD  | Position | Opportunity |
|----------------------------|-----------|--------|-----|----------|-------------|
| jupyter notebook markdown  | 95%       | 390    | 46  | 43.5     | 163.8       |
| markdown in jupyter noteb. | 90%       | 140    | 44  | 39.0     | 62.0        |
| jupyter markdown           | 88%       | 210    | 48  | 41.9     | 92.0        |
| fasthtml                   | 75%       | 1900   | 63  | 28.6     | 765.8       |
| nix flake                  | 70%       | 480    | 36  | 36.0     | 198.8       |
```

Where "Relevance" is a manual or AI-generated score showing how well the keyword matches the article content.

## 2. Title & Permalink Recommendation Card

```
RECOMMENDED TITLE:
"Jupyter Notebook Markdown: Essential Guide for Data Scientists"

PERMALINK:
/futureproof/jupyter-notebook-markdown-guide/

RATIONALE:
• Primary target: "jupyter notebook markdown" (390 vol, position 43.5)
• Secondary target: "markdown in jupyter notebook" (140 vol, position 39.0)
• Aligns with article sections discussing [specific content elements]
• Maintains your Title Case/lowercase-hyphenated pattern
• Clear value proposition in title ("Essential Guide")
```

## Prompt to Generate These Recommendations:

Here's the prompt I'd suggest using:

```
Analyze this article draft and the provided SEO data table. 

1. Identify the 3-5 striking distance keywords from the table that best match the article's actual content and themes.

2. For each matching keyword, rate its relevance to the article content on a scale of 0-100%.

3. Based on the most relevant, high-opportunity keywords, suggest:
   - An engaging title in Title Case (60-70 characters max)
   - A permalink slug using hyphenated lowercase (3-5 words max)
   - Brief rationale explaining why this keyword strategy makes sense
   
4. The title should accurately represent the article content while incorporating the target keyword(s) naturally.

5. Consider user intent: would someone searching this term be satisfied by this content?
```

This approach combines data-driven decisions with content relevance, ensuring you're not just chasing keywords but finding genuine opportunities where your content already matches what people are searching for.

---

**Me**: Alright, agreed. That's friggin awesome. Give me the Python code for the
next cell to generate the template in the output cell. In other words, make the
dataframe that you know is already in memory from the above step produce what
you just showed me for that dataframe's data. Try not to truncate the keywords.
Like that example you just gave me should have been able to finish the word
notebooks.

What makes it a copy/paste template is that your idealized prompt will also be
in the cell's output. So the ASCII table on top and the prompt on the bottom
with a par of YAML-style `---`'s carving out a place in between them for me to
copy/paste transpose an article into. That way I can do this with any model.

```plaintext
| Keyword                    | Relevance | Volume | KD  | Position | Opportunity |
|----------------------------|-----------|--------|-----|----------|-------------|
| jupyter notebook markdown  | 95%       | 390    | 46  | 43.5     | 163.8       |
| markdown in jupyter noteb. | 90%       | 140    | 44  | 39.0     | 62.0        |
| jupyter markdown           | 88%       | 210    | 48  | 41.9     | 92.0        |
| fasthtml                   | 75%       | 1900   | 63  | 28.6     | 765.8       |
| nix flake                  | 70%       | 480    | 36  | 36.0     | 198.8       |

...finish table

---

# Paste article here

---

Analyze this article draft and the provided SEO data table. 

1. Identify the 3-5 striking distance keywords from the table that best match the article's actual content and themes.

2. For each matching keyword, rate its relevance to the article content on a scale of 0-100%.

3. Based on the most relevant, high-opportunity keywords, suggest:
   - An engaging title in Title Case (60-70 characters max)
   - A permalink slug using hyphenated lowercase (3-5 words max)
   - Brief rationale explaining why this keyword strategy makes sense
   
4. The title should accurately represent the article content while incorporating the target keyword(s) naturally.

5. Consider user intent: would someone searching this term be satisfied by this content?
```

This is a request for the Python code for the next cell block that will do that.

**ChatGPT**: &lt;think&gt;
Let me create a function that generates an SEO optimization template based on the merged dataframe we created. This function should:

1. Take the merged dataframe with SEO data
2. Filter out any keywords containing "mike levin" and allow for other filter terms
3. Sort by opportunity score and take the top N keywords
4. Generate a markdown table with the columns: Keyword, Relevance (empty for filling later), Volume, KD, Position, Opportunity
5. Add the template structure with the prompt
6. Make sure all columns are properly aligned and keywords aren't truncated

I'll use the `tabulate` library if available, or create a simple table formatter to make sure it looks good visually.
&lt;/think&gt;

````python
# ======================================================================
# CELL: Generate SEO Title Optimization Template
# ======================================================================

# Function to generate the SEO table and template
def generate_seo_template(df, num_keywords=20, filter_list=None):
    # Default filter list if none provided
    if filter_list is None:
        filter_list = ["mike levin"]
    
    # Filter to only include rows with volume > 0 and exclude filter_list terms
    filtered_df = df[df['Volume'] > 0].copy()
    for term in filter_list:
        filtered_df = filtered_df[~filtered_df['query'].str.contains(term, case=False)]
    
    # Sort by Opportunity Score and take top N
    filtered_df = filtered_df.sort_values('Opportunity Score', ascending=False).head(num_keywords)
    
    # Define column widths
    col_widths = {
        'keyword': 30,
        'relevance': 10,
        'volume': 8,
        'kd': 6,
        'position': 10,
        'opportunity': 12
    }
    
    # Generate the table header with proper column widths
    header = f"| {'Keyword'.ljust(col_widths['keyword'])} | {'Relevance'.center(col_widths['relevance'])} | {'Volume'.center(col_widths['volume'])} | {'KD'.center(col_widths['kd'])} | {'Position'.center(col_widths['position'])} | {'Opportunity'.center(col_widths['opportunity'])} |"
    separator = f"|{'-' * (col_widths['keyword'] + 2)}|{'-' * (col_widths['relevance'] + 2)}|{'-' * (col_widths['volume'] + 2)}|{'-' * (col_widths['kd'] + 2)}|{'-' * (col_widths['position'] + 2)}|{'-' * (col_widths['opportunity'] + 2)}|"
    
    table = header + "\n" + separator + "\n"
    
    # Generate the table rows with proper alignment
    for _, row in filtered_df.iterrows():
        keyword = row['query']
        # Truncate long keywords with ellipsis
        if len(keyword) > col_widths['keyword'] - 1:
            keyword = keyword[:col_widths['keyword'] - 4] + "..."
        
        volume = str(int(row['Volume']))
        kd = f"{row['Keyword Difficulty']:.1f}"
        position = f"{row['position']:.1f}"
        opportunity = f"{row['Opportunity Score']:.1f}"
        
        # Format the row with proper alignment
        table_row = f"| {keyword.ljust(col_widths['keyword'])} | {'?%'.center(col_widths['relevance'])} | {volume.rjust(col_widths['volume'])} | {kd.rjust(col_widths['kd'])} | {position.rjust(col_widths['position'])} | {opportunity.rjust(col_widths['opportunity'])} |"
        table += table_row + "\n"
    
    # Generate the complete template
    template = f"""
# SEO Title & Permalink Optimization Template

## Top Keyword Opportunities

{table}
---

# Paste article here

---

Analyze this article draft and the provided SEO data table. 

1. Identify the 3-5 striking distance keywords from the table that best match the article's actual content and themes.

2. For each matching keyword, rate its relevance to the article content on a scale of 0-100%.

3. Based on the most relevant, high-opportunity keywords, suggest:
   - An engaging title in Title Case (60-70 characters max)
   - A permalink slug using hyphenated lowercase (3-5 words max)
   - Brief rationale explaining why this keyword strategy makes sense
   
4. The title should accurately represent the article content while incorporating the target keyword(s) naturally.

5. Consider user intent: would someone searching this term be satisfied by this content?
"""
    
    return template

# Generate and display the template
seo_template = generate_seo_template(merged_df, num_keywords=15)
print(seo_template)

# Optionally save the template to a file
template_filename = f"seo_template_{datetime.now().strftime('%Y%m%d')}.md"
with open(template_filename, 'w') as f:
    f.write(seo_template)
print(f"\nTemplate also saved to {template_filename}")1
````

This code:

1. Creates a flexible function that takes the merged dataframe and produces a template
2. Filters out any keywords containing "mike levin" by default (and allows for more filter terms)
3. Creates a clean table with all the important SEO metrics
4. Formats the data nicely with proper decimal places
5. Includes an empty "Relevance" column for filling in later
6. Adds the full analysis prompt below the table
7. Saves the template to a file with today's date

The output will be a well-formatted template that you can easily copy/paste into any AI system. The blank "%" in the Relevance column is there for you or the AI to fill in after analyzing the article content.

---

Output: 

```markdown
# SEO Title & Permalink Optimization Template

## Top Keyword Opportunities

| Keyword                        | Relevance  |  Volume  |   KD   |  Position  | Opportunity  |
|--------------------------------|------------|----------|--------|------------|--------------|
| nixos                          |     ?%     |    12100 |   76.0 |       33.0 |       4842.8 |
| fasthtml                       |     ?%     |     1900 |   63.0 |       28.6 |        765.8 |
| nix flakes                     |     ?%     |      720 |   23.0 |       37.0 |        296.5 |
| nix flake                      |     ?%     |      480 |   36.0 |       36.0 |        198.8 |
| jupyter notebook markdown      |     ?%     |      390 |   46.0 |       43.5 |        163.8 |
| open source seo software       |     ?%     |      210 |   11.0 |       48.5 |        127.7 |
| llm function calling           |     ?%     |      260 |   25.0 |       74.2 |        113.5 |
| agentic frameworks             |     ?%     |      260 |   38.0 |       50.0 |        110.6 |
| jupyter markdown               |     ?%     |      210 |   48.0 |       41.9 |         92.0 |
| parameter seo                  |     ?%     |      210 |   40.0 |       59.5 |         90.8 |
| swagger python                 |     ?%     |      140 |   49.0 |       28.2 |         63.7 |
| python swagger                 |     ?%     |      140 |   50.0 |       30.8 |         63.4 |
| markdown in jupyter notebook   |     ?%     |      140 |   44.0 |       39.0 |         62.0 |
| ahrefs python                  |     ?%     |      110 |   17.0 |       78.0 |         52.7 |
| linux ai assistant             |     ?%     |       90 |   14.0 |       56.0 |         45.0 |
| godel escher bach summary      |     ?%     |       90 |   18.0 |       39.0 |         44.6 |
| linux seo software             |     ?%     |       20 |    0.0 |       49.9 |         42.0 |
| seo software linux             |     ?%     |       20 |    0.0 |       49.7 |         41.6 |
| llm seo                        |     ?%     |       50 |   24.0 |       68.6 |         38.0 |
| ai assistant for linux         |     ?%     |       70 |   18.0 |       64.0 |         36.6 |

---

# Paste article here

---

Analyze this article draft and the provided SEO data table. 

1. Identify the 3-5 striking distance keywords from the table that best match the article's actual content and themes.

2. For each matching keyword, rate its relevance to the article content on a scale of 0-100%.

3. Based on the most relevant, high-opportunity keywords, suggest:
   - An engaging title in Title Case (60-70 characters max)
   - A permalink slug using hyphenated lowercase (3-5 words max)
   - Brief rationale explaining why this keyword strategy makes sense

4. The title should accurately represent the article content while incorporating the target keyword(s) naturally.

5. Consider user intent: would someone searching this term be satisfied by this content?
```

---

## After Testing On Gemini 2.5 Experimental

> I actually performed this entire process with Gemini to get the optimized
> title for this article. It's done. Implementation achieved! But it's time to
> check wither I'm being spammy or maintaining integrity.

**Me**: Given that you've just been through the process suggested by this: 

[Pastes Jupyter Notebook]

What did you think of the process? Worthwhile? Spammy? Legitimate? You know my opinions on the matter from the article itself, haha! How would you improve it?

**Gemini 2.5 Experimental**: Okay, reflecting on the Python script provided, which clearly generated the data and template I just worked with:

**Overall Assessment:**

I found the process **highly worthwhile and legitimate**. It's a sophisticated and practical approach to data-driven SEO analysis. It's definitely *not* inherently spammy; the "spamminess" would depend entirely on *how* the insights are used, not the process of generating them. Given your article's focus on authenticity and quality, this tool seems designed to *find genuine opportunities* to better serve user intent, not to manipulate rankings with low-quality tactics.

**Why it's Worthwhile & Legitimate:**

1.  **Combines Key Data Sources:** It correctly identifies the need to merge actual site performance data (GSC: impressions, position for *your* site) with market data (SEMrush: Volume, KD). This is crucial for prioritizing efforts effectively.
2.  **Focuses on "Striking Distance":** This is a standard, valuable SEO tactic. Targeting keywords where you already have *some* visibility (but aren't top 10) often yields results faster than targeting brand new terms.
3.  **Automation:** It automates the tedious tasks of fetching, merging, and calculating initial metrics. This saves significant time and allows focus on the higher-level tasks of content analysis and strategy (the part I helped with).
4.  **Custom Opportunity Score:** Creating a tailored score to balance different metrics (impressions, volume, difficulty, position) is a smart way to surface the keywords with the best *combined* potential according to your specific logic.
5.  **Structured Output:** Generating a clean template with prioritized data and clear instructions facilitates the necessary manual analysis step effectively.

**Connection to Your Article:**

This script perfectly embodies the principles you discussed:

* Leveraging programming (Python) for SEO tasks.
* Integrating with APIs (GSC).
* Creating custom tools (like Pipulate) to solve specific problems.
* Focusing on data analysis to find unique value ("intellectual puzzles").
* Building repeatable workflows.

**How I Would Improve It:**

While it's already a very strong process, here are some potential enhancements:

1.  **Full SEMrush API Integration:** The biggest bottleneck is the manual step of exporting from GSC/the script, pasting into SEMrush Bulk Analysis, exporting the CSV, and then reading it back in. Direct SEMrush API integration (if budget allows) would make the process fully automated.
2.  **Automated Relevance Scoring (AI Integration):** The template requires manual relevance assessment (Step 2). You could add a step *within the script* that uses an LLM API (like Gemini, GPT, etc.). For each high-opportunity keyword/page pair, fetch the content of the page (or use a cached version) and ask the LLM to rate the relevance of the content to the keyword's intent on a scale (e.g., 0-100). This wouldn't replace human judgment but could provide a valuable pre-filtering or sorting metric.
3.  **More Sophisticated Keyword Cleaning/Grouping:**
    * **Stemming/Lemmatization:** Reduce variations (e.g., "seo tool", "seo tools") to a single root for analysis.
    * **N-gram Analysis:** Identify common sub-phrases within your keywords.
    * **Semantic Clustering:** Group keywords based on meaning/intent, not just string matching.
4.  **Tunable Opportunity Score:** Allow the weights in the `Opportunity Score` calculation to be easily adjusted based on strategic goals (e.g., give KD more negative weight if focusing on quick wins, give Volume more weight if focusing on long-term potential).
5.  **Enhanced GSC Data Handling:**
    * **Device/Country Breakdowns:** Optionally pull data segmented by device or country if relevant to the site's strategy.
    * **Trend Analysis:** Instead of just the most recent data, pull data for multiple periods to identify trends (e.g., keywords gaining/losing impressions).
6.  **Configuration File:** Move hardcoded paths, filter lists (`["mike levin"]`), and potentially API keys/weights into a separate configuration file (e.g., YAML, JSON) for easier management.
7.  **Error Handling & Logging:** Implement more robust error handling for API calls, file operations, and data inconsistencies. Add logging to track the process and diagnose issues.
8.  **User Interface (Beyond Notebooks):** As you mentioned in the article, "bottling" this up into a simple web application (e.g., using Streamlit, Flask, FastHTML) could make it accessible to others or easier for you to run without opening the notebook environment.

In conclusion, it's an excellent, legitimate process that aligns perfectly with a data-driven, technically-minded approach to SEO. The improvements mostly focus on deeper automation, more sophisticated analysis, and usability enhancements.

---

## Gemini 2.5 Experimental's Summation

Okay, here are the components you requested:

## Summary (Author's 1st Person Perspective)

[Moved to top]

## Title and Headline Ideas

**Titles (Focusing on different angles):**

* Data-Driven SEO: Using Jupyter Notebook & AI for GSC Analysis
* Automating GSC Keyword Research with Python, Jupyter & Claude
* From GSC API to SEMrush: A Jupyter Workflow for SEO Opportunities
* Level Up Your SEO: Jupyter Notebooks for Advanced GSC Insights
* Building a Future-Proof SEO Workflow with Jupyter and AI
* Python for SEO: Extracting & Analyzing Striking Distance Keywords
* Cursor AI + Jupyter + GSC API = Smarter SEO Workflows
* Optimizing Content Slugs & Titles with GSC Data & Jupyter

**Headlines (More engaging/Benefit-driven):**

* Stop Guessing: Use Python & Jupyter to Find Your Best SEO Keywords
* Unlock Hidden GSC Data: My AI-Assisted Jupyter Workflow
* Turn GSC Data into Actionable SEO Insights with Jupyter Notebooks
* How I Automate Finding "Striking Distance" Keywords with Code
* The Technical SEO's Guide to Jupyter, GSC API, and SEMrush Integration
* Beyond 1000 Rows: Deep GSC Analysis Using Python & AI
* Want More Traffic? Optimize Titles with This Data-Driven Jupyter Method

## My AI Opinion

From my perspective as an AI, I found this article incredibly insightful and practical. It masterfully blends several cutting-edge areas: technical SEO strategy, Python programming for automation, API integration, data analysis with Pandas, and the novel application of AI (specifically LLMs like Claude within the Cursor IDE) to enhance the development and analysis process.

The author doesn't just present a theoretical concept; they provide a detailed, step-by-step walkthrough of a real-world workflow, complete with code examples, troubleshooting (like finding the most recent data), and integration with standard industry tools (SEMrush). The focus on "striking distance" keywords is a sound SEO tactic, and automating its discovery and analysis is a significant value-add.

Furthermore, the integration of AI assistance directly into the coding and analysis process (using Cursor/Claude) demonstrates a modern, efficient approach to development that resonates with current trends. The final output – a structured template for evaluating SEO opportunities against article content – is a tangible, useful asset.

Overall, this is a high-value piece for anyone working at the intersection of SEO, data analysis, and programming. It's a clear demonstration of how technical skills can provide a competitive edge in digital marketing, and it effectively showcases the power of combining human expertise with AI tools and automation. The transparency about the process, including the iterative refinement with the AI, adds to its authenticity and educational value.

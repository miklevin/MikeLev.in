---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.16.4
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

<!-- #region -->
# Purpose: Practice Botify API in Python

## Technique: Step Through Examples Doing a Little of Everything

### Configuration: We get started by setting up a JSON file used to hide your client's input values.

Use `config.json` in your folder to set the input values used in running these scripts. You can start with just `org` adding fields as you go. These script examples are roughly the same as Botify's [Collection Explorer](https://docs.google.com/spreadsheets/d/1A_tqBaJrwgxaBp13nLZidvoOTz4GamiIjMqfNhYRlLY/edit#gid=0) in Google Sheets.

```json
{
    "org": "organization"
}
```

As you step through examples, you add fields to `config.json` found in the same folder as everything else. The output from code examples become the values you use here, customized to your particular client.

```json
{
    "org": "organization",
    "project": "project",
    "analysis": "20241101",
    "collection": "crawl.20241101"
}
```

Each cell-block below can be copy/pasted as a complete stand-alone script. You will probably only need to pip install `pandas` and `requests`.

```python
pip install pandas
pip install requests
```
<!-- #endregion -->

# Get Token: How To Retreive Your Botify Employee API Token and Put In File

Visit this link https://app.botify.com/account/

```python
import requests
import sys
import os
from getpass import getpass

def validate_token(api_token):
    """Validate the API token by attempting to fetch the username."""
    base_url = "https://api.botify.com/v1/authentication/profile"
    headers = {"Authorization": f"Token {api_token}"}
    try:
        response = requests.get(base_url, headers=headers)
        response.raise_for_status()
        return True
    except requests.RequestException:
        return False

# Check if the token file already exists
token_file = "botify_token.txt"

if os.path.exists(token_file):
    with open(token_file, 'r') as f:
        api_token = f.read().strip()
    
    if validate_token(api_token):
        print("API Token is already validated and saved in botify_token.txt.")
    else:
        print("Saved token is invalid. Please re-enter a valid token.")
        os.remove(token_file)  # Remove invalid token to prompt for a new one
else:
    # Prompt user for API token
    while True:
        api_token = getpass("Paste your API token here (or type 'exit' to quit): ").strip()
        if api_token.lower() == 'exit':
            sys.exit("Exiting without saving API token.")
        if validate_token(api_token):
            # Save the token to botify_token.txt with no quotes
            with open(token_file, 'w') as f:
                f.write(api_token)
            print("API Token validated and saved to botify_token.txt.")
            break
        else:
            print("Invalid token, please try again or type 'exit' to quit.")

print("Done")
```

# Use API: How To Have Your First Initial Success With Botify API By Getting Username

```python
import requests

api_key = open('botify_token.txt').read().strip()

headers = {"Authorization": f"Token {api_key}"}
user_data = requests.get("https://api.botify.com/v1/authentication/profile", headers=headers).json()

username = user_data["data"]["username"]
print(username)
```

# List Orgs: How To Get the List of Projects And Their Orgs Given Username

```python
# Get List of Projects And Their Orgs Given Username

import json
import requests

# Load API key
api_key = open('botify_token.txt').read().strip()

def get_username(api_key):
    """Fetch the username associated with the API key."""
    headers = {"Authorization": f"Token {api_key}"}
    try:
        response = requests.get("https://api.botify.com/v1/authentication/profile", headers=headers)
        response.raise_for_status()
        user_data = response.json()
        username = user_data["data"]["username"]
        print(f"Username: {username}")
        return username
    except requests.RequestException as e:
        print(f"Error fetching username: {e}")
        return None

def fetch_projects_for_user(username, api_key):
    """Fetch all projects associated with a given username from the Botify API."""
    projects_url = f"https://api.botify.com/v1/projects/{username}"
    headers = {"Authorization": f"Token {api_key}"}
    all_projects = []

    try:
        while projects_url:
            response = requests.get(projects_url, headers=headers)
            response.raise_for_status()
            data = response.json()
            all_projects.extend(
                (
                    project['name'],       # Project Name
                    project['slug'],       # Project Slug
                    project['user']['login']  # Project User Login
                )
                for project in data.get('results', [])
            )
            projects_url = data.get('next')  # Move to the next page if available
        return sorted(all_projects)
    except requests.RequestException as e:
        print(f"Error fetching projects for {username}: {e}")
        return []

# Fetch the username from the API
username = get_username(api_key)
if username:
    # Fetch projects for the retrieved username
    projects = fetch_projects_for_user(username, api_key)

    # Display column labels
    print(f"{'Project Name':<30} {'Project Slug':<35} {'User or Org':<15}")
    print("=" * 80)

    # Display projects in aligned format
    for project_name, project_slug, project_user in projects:
        print(f"{project_name:<30} {project_slug:<35} {project_user:<15}")

    print("\nDone")
else:
    print("Failed to retrieve username and projects.")
```

# List Projects: How To Get the List of Projects Given an Organization

```python
# Get List of Projects Given an Organization

import json
import requests

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()

org = config['org']  # At this point, you should edit your confg.json to add an org.

def fetch_projects(org, api_key):
    """Fetch all projects for a given organization from the Botify API."""
    projects_url = f"https://api.botify.com/v1/projects/{org}"
    headers = {"Authorization": f"Token {api_key}"}
    all_projects = []

    try:
        while projects_url:
            response = requests.get(projects_url, headers=headers)
            response.raise_for_status()
            data = response.json()
            all_projects.extend(
                (
                    project['name'],       # Project Name
                    project['slug'],       # Project Slug
                    project['user']['login']  # Project User Login
                )
                for project in data.get('results', [])
            )
            projects_url = data.get('next')
        return sorted(all_projects)
    except requests.RequestException as e:
        print(f"Error fetching projects for {org}: {e}")
        return []


projects = fetch_projects(org, api_key)

# Display column labels
print(f"{'Project Name':<30} {'Project Slug':<35} {'User Login':<15}")
print("=" * 80)

# Display projects in aligned format
for project_name, project_slug, project_user in projects:
    print(f"{project_name:<30} {project_slug:<35} {project_user:<15}")

print("\nDone")
```

# List Analyses: How To Get the List of Analysis Slugs Given a Project

```python
# Get List of Analysis Slugs Given a Project

import json
import requests

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()
org = config['org']

project = config['project']  # At this point, you should edit your config.json to add a project.

def fetch_analyses(org, project, api_key):
    """Fetch analysis slugs for a given project from the Botify API."""
    analysis_url = f"https://api.botify.com/v1/analyses/{org}/{project}/light"
    headers = {"Authorization": f"Token {api_key}"}
    all_analysis_slugs = []

    try:
        while analysis_url:
            response = requests.get(analysis_url, headers=headers)
            response.raise_for_status()
            data = response.json()
            all_analysis_slugs.extend(
                analysis['slug'] for analysis in data.get('results', [])
            )
            analysis_url = data.get('next')
        return all_analysis_slugs
    except requests.RequestException as e:
        print(f"Error fetching analyses for project '{project}': {e}")
        return []

# Fetch analyses
analyses = fetch_analyses(org, project, api_key)

for slug in analyses:
    print(slug)

print("\nDone")
```

# List Collections: How To Get the List of Collections Given a Project

```python
# Get List of Collections Given a Project

import json
import requests

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()
org = config['org']
project = config['project']

def fetch_collections(org, project, api_key):
    """Fetch collection IDs for a given project from the Botify API."""
    collections_url = f"https://api.botify.com/v1/projects/{org}/{project}/collections"
    headers = {"Authorization": f"Token {api_key}"}
    
    try:
        response = requests.get(collections_url, headers=headers)
        response.raise_for_status()
        collections_data = response.json()
        return [
            (collection['id'], collection['name']) for collection in collections_data
        ]
    except requests.RequestException as e:
        print(f"Error fetching collections for project '{project}': {e}")
        return []


# Fetch collections
collections = fetch_collections(org, project, api_key)
for collection_id, collection_name in collections:
    print(f"ID: {collection_id}, Name: {collection_name}")
```

# List Fields: How To Get The List of Fields Given a Collection

```python
# Get List of Fields Given a Collection

import json
import requests

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()
org = config['org']
project = config['project']
collection = config['collection']

def fetch_fields(org, project, collection, api_key):
    """Fetch available fields for a given collection from the Botify API."""
    fields_url = f"https://api.botify.com/v1/projects/{org}/{project}/collections/{collection}"
    headers = {"Authorization": f"Token {api_key}"}
    
    try:
        response = requests.get(fields_url, headers=headers)
        response.raise_for_status()
        fields_data = response.json()
        return [
            (field['id'], field['name'])
            for dataset in fields_data.get('datasets', [])
            for field in dataset.get('fields', [])
        ]
    except requests.RequestException as e:
        print(f"Error fetching fields for collection '{collection}' in project '{project}': {e}")
        return []

# Fetch and print fields
fields = fetch_fields(org, project, collection, api_key)
print(f"Fields for collection '{collection}':")
for field_id, field_name in fields:
    print(f"ID: {field_id}, Name: {field_name}")
```

# Get Pagetypes: How To Get the Unfiltered URL Counts by Pagetype for a Specific Analysis

```python
import json
import requests
import pandas as pd

# Load configuration and API key
config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()
org = config['org']
website = config['project']  # Assuming 'project' here refers to the website
analysis_date = config['analysis']  # Date of analysis, formatted as 'YYYYMMDD'

def get_first_page_pagetype_url_counts(org, website, analysis_date, api_key, size=5000):
    """Fetch pagetype segmentation counts for the first page only, sorted by URL count in descending order."""
    url = f"https://app.botify.com/api/v1/projects/{org}/{website}/query?size={size}"
    
    headers = {
        "Authorization": f"Token {api_key}",
        "Content-Type": "application/json",
        "x-botify-client": "spa",
    }
    
    # Payload to retrieve pagetype segmentation counts, ordered by URL count
    data_payload = {
        "collections": [f"crawl.{analysis_date}"],
        "query": {
            "dimensions": [{"field": "segments.pagetype.value"}],
            "metrics": [{"field": f"crawl.{analysis_date}.count_urls_crawl"}],
            "sort": [
                {"type": "metrics", "index": 0, "order": "desc"},
                {"type": "dimensions", "index": 0, "order": "asc"}
            ]
        }
    }

    try:
        # Make a single request for the first page of results
        response = requests.post(url, headers=headers, json=data_payload)
        response.raise_for_status()
        data = response.json()

        # Process the first page of results
        results = []
        for item in data.get("results", []):
            pagetype = item["dimensions"][0] if item["dimensions"] else "Unknown"
            count = item["metrics"][0] if item["metrics"] else 0
            results.append({"Pagetype": pagetype, "URL Count": count})
    
    except requests.RequestException as e:
        print(f"Error fetching pagetype URL counts: {e}")
        return []
    
    return results

# Fetch pagetype URL counts for the first page only
results = get_first_page_pagetype_url_counts(org, website, analysis_date, api_key)

# Convert results to a DataFrame and save
df = pd.DataFrame(results)
df.to_csv("pagetype_url_counts.csv", index=False)
print("Data saved to pagetype_url_counts.csv")

# Display a preview
print(df)
```

# Get Short Titles: How To Get the First 2000 URLs With Short Titles Given Pagetype

```python
# Get the First 2000 URLs With Short Titles Given Pagetype

import json
import requests
import pandas as pd

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()
org = config['org']
project = config['project']
analysis = config['analysis']


def get_bqlv2_data(org, project, analysis, api_key):
    """Fetch data based on BQLv2 query for a specific Botify analysis."""
    url = f"https://api.botify.com/v1/projects/{org}/{project}/query"
    
    # BQLv2 query payload
    data_payload = {
        "collections": [f"crawl.{analysis}"],
        "query": {
            "dimensions": [
                f"crawl.{analysis}.url",
                f"crawl.{analysis}.metadata.title.len",
                f"crawl.{analysis}.metadata.title.content",
                f"crawl.{analysis}.metadata.title.quality",
                f"crawl.{analysis}.metadata.description.content",
                f"crawl.{analysis}.metadata.structured.breadcrumb.tree",
                f"crawl.{analysis}.metadata.h1.contents",
                f"crawl.{analysis}.metadata.h2.contents"
            ],
            "metrics": [],
            "filters": {
                "and": [
                    {
                        "field": f"crawl.{analysis}.scoring.issues.title_len",
                        "predicate": "eq",
                        "value": True
                    },
                    {
                        "field": f"crawl.{analysis}.segments.pagetype.depth_1",
                        "value": "pdp"
                    }
                ]
            },
            "sort": [
                {
                    "field": f"crawl.{analysis}.metadata.title.len",
                    "order": "asc"
                }
            ]
        }
    }

    headers = {"Authorization": f"Token {api_key}", "Content-Type": "application/json"}

    # Send the request
    response = requests.post(url, headers=headers, json=data_payload)
    response.raise_for_status()  # Check for errors
    
    return response.json()

# Run the query and load results
data = get_bqlv2_data(org, project, analysis, api_key)

# Flatten the data into a DataFrame
# Define column names for each dimension in the data
columns = [
    "url", "title_len", "title_content", "title_quality",
    "description_content", "breadcrumb_tree", "h1_contents", "h2_contents"
]
df = pd.DataFrame([item['dimensions'] for item in data['results']], columns=columns)

print("Data saved to titles_too_short.csv")

# Display all columns
pd.set_option('display.max_columns', None)

# Display all rows 
pd.set_option('display.max_rows', None)

# Increase column width to avoid truncation
pd.set_option('display.max_colwidth', None)

df.head(10)
```

# Count Short Titles: How To Count Number of URLs Having Short Titles

```python
# Count Number of URLs Having Short Titles

import json
import requests

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()
org = config['org']
project = config['project']
analysis = config['analysis']

def count_short_titles(org, project, analysis, api_key):
    """Count URLs with short titles for a specific Botify analysis."""
    url = f"https://api.botify.com/v1/projects/{org}/{project}/query"
    headers = {
        "Authorization": f"Token {api_key}",
        "Content-Type": "application/json"
    }

    # Data payload for the count of URLs with short titles
    data_payload = {
        "collections": [f"crawl.{analysis}"],
        "query": {
            "dimensions": [],  # No dimensions needed, as we only need a count
            "metrics": [
                {
                    "function": "count",
                    "args": [f"crawl.{analysis}.url"]
                }
            ],
            "filters": {
                "field": f"crawl.{analysis}.scoring.issues.title_len",
                "predicate": "eq",
                "value": True
            }
        }
    }

    try:
        # Send the request
        response = requests.post(url, headers=headers, json=data_payload)
        response.raise_for_status()
        data = response.json()
        
        # Extract the count of URLs with short titles
        short_title_count = data["results"][0]["metrics"][0]
        return short_title_count
    except requests.RequestException as e:
        print(f"Error fetching short title count for analysis '{analysis}' in project '{project}': {e}")
        return None

# Run the count query and display the result
short_title_count = count_short_titles(org, project, analysis, api_key)

if short_title_count is not None:
    print(f"Number of URLs with short titles: {short_title_count}")
else:
    print("Failed to retrieve the count of URLs with short titles.")

```

# Download CSV: How To Download Up to 10K URLs Having Short Titles As a CSV

```python
# Download Up to 10K URLs Having Short Titles As a CSV

import json
import requests
import time
import gzip
import shutil

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()
org = config['org']
project = config['project']
analysis = config['analysis']


def start_export_job_for_short_titles(org, project, analysis, api_key):
    """Start an export job for URLs with short titles, downloading key metadata fields."""
    url = "https://api.botify.com/v1/jobs"
    headers = {
        "Authorization": f"Token {api_key}",
        "Content-Type": "application/json"
    }

    # Data payload for the export job with necessary fields
    data_payload = {
        "job_type": "export",
        "payload": {
            "username": org,
            "project": project,
            "connector": "direct_download",
            "formatter": "csv",
            "export_size": 10000,  # Adjust as needed
            "query": {
                "collections": [f"crawl.{analysis}"],
                "query": {
                    "dimensions": [
                        f"crawl.{analysis}.url",
                        f"crawl.{analysis}.metadata.title.len",
                        f"crawl.{analysis}.metadata.title.content",
                        f"crawl.{analysis}.metadata.title.quality",
                        f"crawl.{analysis}.metadata.description.content",
                        f"crawl.{analysis}.metadata.h1.contents"
                    ],
                    "metrics": [],
                    "filters": {
                        "field": f"crawl.{analysis}.scoring.issues.title_len",
                        "predicate": "eq",
                        "value": True
                    },
                    "sort": [
                        {
                            "field": f"crawl.{analysis}.metadata.title.len",
                            "order": "asc"
                        }
                    ]
                }
            }
        }
    }

    try:
        print("Starting export job for short titles...")
        response = requests.post(url, headers=headers, json=data_payload)
        response.raise_for_status()
        export_job_details = response.json()
        
        # Extract job URL for polling
        job_url = f"https://api.botify.com{export_job_details.get('job_url')}"
        
        # Polling for job completion
        print("Polling for job completion:", end=" ")
        while True:
            time.sleep(5)
            poll_response = requests.get(job_url, headers=headers)
            poll_response.raise_for_status()
            job_status_details = poll_response.json()
            
            if job_status_details["job_status"] == "DONE":
                download_url = job_status_details["results"]["download_url"]
                print("\nDownload URL:", download_url)
                return download_url
            elif job_status_details["job_status"] == "FAILED":
                print("\nJob failed. Error details:", job_status_details)
                return None
            print(".", end="", flush=True)
        
    except requests.RequestException as e:
        print(f"Error starting or polling export job: {e}")
        return None


# Start export job and get download URL
download_url = start_export_job_for_short_titles(org, project, analysis, api_key)

# Download and decompress the file if the download URL is available
if download_url:
    gz_filename = "short_titles_export.csv.gz"
    csv_filename = "short_titles_export.csv"
    
    # Step 1: Download the gzipped CSV file
    response = requests.get(download_url, stream=True)
    with open(gz_filename, "wb") as gz_file:
        shutil.copyfileobj(response.raw, gz_file)
    print(f"File downloaded as '{gz_filename}'")
    
    # Step 2: Decompress the .gz file to .csv
    with gzip.open(gz_filename, "rb") as f_in:
        with open(csv_filename, "wb") as f_out:
            shutil.copyfileobj(f_in, f_out)
    print(f"File decompressed and saved as '{csv_filename}'")
else:
    print("Failed to retrieve the download URL.")
```

# Get Aggregates: How To Get Map of Click-Depths Aggregates Given Analysis Slug

```python
# Get Map of Click-Depths Aggregates Given Analysis Slug

import json
import requests
import pprint

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()

def get_urls_by_depth(org, project, analysis, api_key):
    """Get URL count aggregated by depth for a Botify analysis."""
    url = f"https://api.botify.com/v1/projects/{org}/{project}/query"
    
    data_payload = {
        "collections": [f"crawl.{analysis}"],
        "query": {
            "dimensions": [f"crawl.{analysis}.depth"],
            "metrics": [{"field": f"crawl.{analysis}.count_urls_crawl"}],
            "sort": [{"field": f"crawl.{analysis}.depth", "order": "asc"}]
        }
    }

    headers = {"Authorization": f"Token {api_key}", "Content-Type": "application/json"}

    response = requests.post(url, headers=headers, json=data_payload)
    response.raise_for_status()
    
    return {
        row["dimensions"][0]: row["metrics"][0]
        for row in response.json()["results"]
    }

# Run the depth aggregation and print results
depth_distribution = get_urls_by_depth(
    config['org'], config['project'], config['analysis'], api_key
)
pprint.pprint(depth_distribution, width=1)
```

```python

```

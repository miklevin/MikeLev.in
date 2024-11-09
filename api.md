---
permalink: /api/
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
BQL stands for Botify Query Language. It is a powerful query language developed by Botify, a leading enterprise SEO platform, to help users analyze and manipulate large-scale website data. Here are some key points about BQL:

## Purpose and Functionality

- BQL is designed to perform complex data retrieval and analytics on website crawl data within the Botify platform.

- It allows users to query, filter, and analyze various aspects of their website's structure, content, and performance.

## Key Features

- **Data Retrieval**: BQL can extract specific information from Botify's comprehensive website crawl data.

- **Advanced Filtering**: Users can apply complex filters to narrow down data to specific subsets of pages or attributes.

- **Custom Metrics**: BQL supports the creation of custom metrics and calculations based on existing data points.

- **Segmentation**: It enables the segmentation of website data for more targeted analysis.

## Usage

BQL (Botify Query Language) is essential for programmatically accessing Botify's data through its API. While the language is powerful, learning it can be challenging without structured examples. This document provides a step-by-step guide through increasingly complex BQL queries, helping both human developers and AI systems understand how to:

- Authenticate and navigate the API structure
- Query and analyze website crawl data
- Build custom reports and data pipelines
- Transform raw crawl data into actionable insights

Each example builds on previous concepts, providing a practical foundation for working with BQL and the Botify API that can be copy/pasted directly into a Jupyter Notebook and run. The only dependencies outside the standard Python library is `requests`, `pandas` and the presense of your API Token and a config.json file addressed at the start.

## Query Structure and Endpoint

A typical BQL query is structured as a JSON object and includes:

1. Collections to query
2. Dimensions (fields to group by)
3. Metrics (data to aggregate)
4. Sorting criteria

Unless initating a `.csv` download, endpoints for BQL queries must include the organization and project slug in the URL:

```python
url = f"https://api.botify.com/v1/projects/{org}/{project}/query"
```

For example, a BQL query might look like this:

```python
import requests

org = "your_organization_slug"
project = "your_project_slug"
api_key = "your_api_key"

url = f"https://api.botify.com/v1/projects/{org}/{project}/query"

headers = {
    "Authorization": f"Token {api_key}",
    "Content-Type": "application/json"
}

payload = {
    "collections": ["crawl.20241101"],
    "query": {
        "dimensions": [{"field": "segments.pagetype.value"}],
        "metrics": [{"field": "crawl.20241101.count_urls_crawl"}],
        "sort": [
            {"type": "metrics", "index": 0, "order": "desc"},
            {"type": "dimensions", "index": 0, "order": "asc"}
        ]
    }
}

response = requests.post(url, headers=headers, json=payload)
results = response.json()
```

This query retrieves the count of URLs for each page type, sorted by URL count in descending order, from the crawl data collected on November 1, 2024. If a ***.csv download*** of this data were being initiated, a modified version of this query would be used that moves the org and project slugs into the JSON POST-method payload (demonstrated below).

BQL's power and flexibility make it a valuable tool for SEO professionals and web analysts who need to work with large-scale website data efficiently and perform complex analyses within the Botify platform.
<!-- #endregion -->

While the previous description outlines the key features and structure of BQL, it's important to understand how to implement these queries in practice. The following code examples demonstrate how to interact with the Botify API using Python, showcasing various aspects of working with BQL and the Botify platform.

These examples cover essential tasks such as:

1. Retrieving and validating your Botify API token
2. Fetching user information
3. Listing organizations and projects
4. Retrieving analysis slugs for a specific project
5. Listing available collections
6. Exploring fields within a collection
7. Querying pagetype URL counts for a specific analysis

Each example builds upon the previous ones, gradually introducing more complex interactions with the Botify API. By working through these examples, you'll gain a practical understanding of how to leverage BQL and the Botify API to extract valuable insights from your website data.

Let's begin with the first example, which demonstrates how to retrieve and validate your Botify API token:

<!-- #region -->
# Purpose: Practice Botify API in Python

## Technique: Step Through Examples Doing a Little of Everything

### Configuration: We get started by setting up a JSON file for input values.

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

**Rationale**: The Botify API was designed to power the Botify Web UI, and is as a result both powerful and complex. Some measures must be taken therefore, i.e. this exercise, to ensure a postive and successful experience.
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

**Sample Output**:

    API Token is already validated and saved in botify_token.txt.
    Done

**Rationale**: Successful API-calls need access to your Botify API Token. We therefore retreive it as our first step and put it in a text-file in your main folder.


# Use API: How To Have Your First Initial Success With Botify API By Getting Username

```python
import requests

api_key = open('botify_token.txt').read().strip()

headers = {"Authorization": f"Token {api_key}"}
user_data = requests.get("https://api.botify.com/v1/authentication/profile", headers=headers).json()

username = user_data["data"]["username"]
print(username)
```

**Sample Output**: 

    first.last

**Rationale**: To create a first successful experience connecting to the Botify API.


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

**Sample Output**:

```
Username: first.last
Project Name                   Project Slug                        User or Org    
================================================================================
Foo Test                       foo.com                             first.last       
Bar Test                       bar.com                             bar-org       
Baz Test                       baz.com                             baz-org       
```

**Rationale**: You need an Organization slug (org) to get started. If there is one already associated with your account in Botify, this will show it under the `User or Org` column. If there is, you can lift it from here. If not, you have to find one from your project bookmarks or adim site.


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

**Sample Output**:

```
Organization: foo-bar
Project Name                   Project Slug                        User Login     
================================================================================
Legendary Product Vault        legendary-product-vault             foo-bar       
Hidden Content Cove            hidden-content-cove                 foo-bar       
Fabled Catalog of Curiosities  fabled-catalog-of-curiosities       foo-bar       
Epic Storefront Sprawl         epic-storefront-sprawl              foo-bar       
Mystic Content Chamber         mystic-content-chamber              foo-bar       
Wondrous Local Bazaar          wondrous-local-bazaar               foo-bar       
Magical Product Menagerie      magical-product-menagerie           foo-bar       
Catalog of Enchanted Wares     catalog-of-enchanted-wares          foo-bar       
Phantom Inventory Island       phantom-inventory-island            foo-bar       
```

**Rationale**: To retrieve project data for an organization, you’ll need an `Organization` slug (org) that links to the Botify account. This list provides each project’s name, slug, and associated user login, which you can use to identify and manage projects tied to a specific organization.


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

**Sample Output**:

```
20240301
20240201
20240101
20240101-2
20231201
20231101
```

**Rationale**: Analysis slugs are typically dates in YYYYMMDD format, representing when each analysis was performed. You'll need one of these analysis slugs for your config.json file to query specific crawl data. If Botify runs a second crawl for the same time-period, it will suffix the analysis slug with an incremeted `-n` extension starting with `-2` (for the 2nd run). If you are finding the most recent analysis slug and it ends with a suffix increment, it should be used as it is the latest and there is likely a reason the crawl was re-run.


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

Sample Output:
```
ID: crawl.20241018, Name: 2024 Oct. 18th
ID: crawl.20240917, Name: 2024 Sept. 17th
ID: crawl.20240816, Name: 2024 Aug. 16th
ID: crawl.20240715, Name: 2024 July 15th
ID: crawl.20240614, Name: 2024 June 14th
```

Rationale: Analysis slugs are typically dates in YYYYMMDD format, representing when each analysis was performed. The Name field provides a more readable version of the date. You'll need one of these analysis slugs for your config.json file to query specific crawl data. The most recent analysis is listed first, as it contains the most current data.


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

Sample Output:

```
Fields for collection 'crawl.20241101':
ID: noodle_id, Name: Noodle Identifier
ID: sauce_level, Name: Sauce Intensity
ID: spoon_type, Name: Spoon Class
ID: tasty_path, Name: Delicious Path
ID: slurp_extension, Name: Slurp Style
ID: yummy_zone, Name: Flavor Region
ID: spice_alert.value, Name: Spice-O-Meter
ID: spice_alert.depth_1, Name: Spice Level 1
ID: cook_cache, Name: Chef's Cache
```

Rationale: Listing fields for a given collection is essential for understanding the data structure and available attributes in a Botify dataset. By querying the field IDs and names, this function enables developers to identify key data points like URLs, content elements, or performance metrics. With playful, culinary-inspired field names, the example output keeps things lighthearted while still illustrating the diversity of fields. This approach helps in reviewing metadata without exposing real client information, making it ideal for testing and teaching contexts where structure matters more than content specificity.


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

Sample Output:
```
Data saved to pagetype_url_counts.csv
                 Pagetype  URL Count
0                    pdp     250000
1                    plp      50000
2                    hub       5000
3                   blog       2500
4                    faq        500
```

Rationale: This breakdown shows URL distribution across different page types. Product Detail Pages (PDPs) typically make up the bulk of e-commerce sites, followed by Product Listing Pages (PLPs). Hub pages, blog posts and FAQs represent a smaller portion of the total URLs. This data helps identify potential structural issues and prioritize optimization efforts across different sections of the site.


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

Sample Output:

**Data saved to titles_too_short.csv**

| url                                      | title_len | title_content     | title_quality | description_content                                              | breadcrumb_tree                                       | h1_contents                     | h2_contents                             |
|------------------------------------------|-----------|-------------------|---------------|------------------------------------------------------------------|--------------------------------------------------------|----------------------------------|-----------------------------------------|
| https://www.example.com/site/socks/12345 | 8         | Sock Store        | unique        | Best socks for every season, unbeatable comfort and style.      | Example Store/Footwear/Accessories/Socks               | [Our Socks]                     | [Features, Sizes, Related Items]        |
| https://www.example.com/site/hats/98765  | 9         | Top Hats Here!    | duplicate     | Stylish hats available year-round with exclusive discounts.     | Example Store/Apparel/Accessories/Hats                 | [Hat Selection]                 | [Details, Reviews, Top Picks]           |
| https://www.example.com/site/shirts/54321| 10        | - Shirt Emporium  | duplicate     | Discover comfortable and stylish shirts at great prices.        | Example Store/Apparel/Topwear/Shirts                   | [Shirt Central]                 | [Sizing, Similar Styles, Reviews]       |
| https://www.example.com/site/pants/67890 | 12        | Pant Paradise     | unique        | Durable, comfy pants for all occasions, from casual to formal.  | Example Store/Apparel/Bottomwear/Pants                 | [Our Best Pants]                | [Features, Size Chart, Recommended]     |
| https://www.example.com/site/belts/34567 | 7         | - Belt Hub        | unique        | Essential belts in various styles, perfect for any outfit.      | Example Store/Apparel/Accessories/Belts                | [Belt Basics]                   | [Specifications, Similar Belts]         |
| https://www.example.com/site/jackets/11111| 6         | - Jacket Haven    | duplicate     | Quality jackets for all seasons, unbeatable prices on top brands.| Example Store/Apparel/Outerwear/Jackets                 | [Best Jackets]                  | [Reviews, Compare Jackets, New Arrivals]|

Rationale: **Rationale**: This function provides a practical way to isolate URLs with short titles within specific product page types, making it easy to identify content gaps in titles. By filtering and retrieving the first 2000 URLs with short titles, this query allows targeted analysis of title length, quality, and structure, which can aid in prioritizing updates to improve SEO performance. Additionally, capturing related metadata like `description_content`, `breadcrumb_tree`, and header tags (`h1`, `h2`) offers insights into the completeness and relevance of each page, guiding both content strategy and technical adjustments.


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

Sample Output:

    Number of URLs with short titles: 675080

Rationale: Knowing the number of URLs with short titles helps gauge the scope of potential title optimizations across the site. By determining this count upfront, you can decide if a full data download is necessary or if a more focused approach will be effective. This preliminary check prevents excessive data transfer and streamlines the analysis process.


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

Sample Output:

    Starting export job for short titles...  
    Polling for job completion: .  
    Download URL: https://mystery-cdn.example.com/export_data/abc/def/ghi/xyz1234567890/funfetti-2024-11-08.csv.gz  
    File downloaded as 'short_titles_export.csv.gz'  
    File decompressed and saved as 'short_titles_export.csv'  

Rationale: This function initiates and manages a data export job to retrieve up to 10,000 URLs with short titles, a useful step for identifying and improving under-optimized page titles in a collection. By automatically polling for job completion and downloading the result, this approach ensures large datasets are collected efficiently, allowing teams to analyze title lengths and other metadata for SEO improvements. The final CSV output can then be used for in-depth analysis or as a data source for updating title content site-wide.


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

Sample Output:
```
{
 0: 1,
 1: 5,
 2: 25,
 3: 125,
 4: 625,
 5: 3125,
 6: 15625
}
```

Rationale: This depth distribution shows how many URLs exist at each click depth level from the homepage (depth 0). A healthy site typically has most content within 3-4 clicks, so this data helps identify potential deep crawl issues.


# Use Case: How To Fetch and Process Project Analysis Data from the Botify API with Error Handling and Progressive Data Saving

## Objective: Retrieve data from the Botify API for multiple organizations and projects while implementing error handling, rate limiting, and saving progress to avoid re-fetching in case of interruptions.

### Requirements:
1. **Configuration and Token Management**:
   - Load API configurations from `config.txt` (list of organizations, one per line).
   - Use `botify_token.txt` for storing the API token as plain text.

2. **Data Retrieval**:
   - For each organization, retrieve all projects (using pagination if needed).
   - For each project, fetch the analysis count and the latest analysis slug; include only projects with at least two analyses.

3. **Error Handling and Progress Persistence**:
   - Save progress in `progress.pkl` to allow resuming if interrupted or on error.
   - Enable the script to continue from the last successfully processed organization without re-fetching completed data.

4. **Rate Limiting**:
   - Configure delays at the top of the script (`DELAY_BETWEEN_PAGES`, `DELAY_BETWEEN_PROJECTS`, and `DELAY_BETWEEN_ORGS`) to manage rate limits.
   - Include delays between requests to avoid API rate limiting issues.

5. **Output**:
   - Write the final processed data to `projects_with_multiple_analyses.csv`, with projects listed by descending analysis count per organization.
   - Update `config.txt` with project details organized under each organization.

6. **Documentation and Non-Regressive Features**:
   - Add comments throughout the code for clarity.
   - Ensure all essential features (error handling, progressive saving, and rate limiting) remain intact through potential future changes.

```python
import requests
import pandas as pd
import time
import pickle
import os

# Load API key and headers
api_key = open('botify_token.txt').read().strip()
headers = {"Authorization": f"Token {api_key}"}

# Rate limit configuration
DELAY_BETWEEN_PAGES = 2      # Delay between pagination requests in seconds
DELAY_BETWEEN_PROJECTS = 3    # Delay between project analysis requests in seconds
DELAY_BETWEEN_ORGS = 10       # Delay between each organization in seconds

# File paths for saving progress
output_csv = 'projects_with_multiple_analyses.csv'
progress_pickle = 'progress.pkl'

# Helper functions
def read_orgs_from_config(file_path):
    """Read organizations from a simple indented configuration file."""
    orgs = []
    with open(file_path, 'r') as file:
        for line in file:
            stripped_line = line.strip()
            if stripped_line and not line.startswith(' '):
                orgs.append(stripped_line)
    return orgs

def fetch_projects(org):
    """Fetch all projects for a given organization with pagination."""
    url = f"https://api.botify.com/v1/projects/{org}"
    all_projects = []
    
    while url:
        try:
            response = requests.get(url, headers=headers)
            response.raise_for_status()
            data = response.json()
            all_projects.extend([
                {'org': org, 'project_slug': project['slug'], 'project_name': project['name']}
                for project in data.get('results', [])
            ])
            url = data.get('next')  # Move to the next page if available
            print(f"  Fetched {len(all_projects)} projects so far for organization '{org}'")
            time.sleep(DELAY_BETWEEN_PAGES)
        except requests.RequestException as e:
            print(f"  Error fetching projects for organization '{org}': {e}")
            break  # Stop further requests if there's an error
    
    return all_projects

def fetch_analysis_count(org, project_slug):
    """Fetch the count and most recent analysis slug for a given project."""
    try:
        url = f"https://api.botify.com/v1/analyses/{org}/{project_slug}/light"
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        data = response.json()
        
        analyses = data.get('results', [])
        if len(analyses) >= 2:
            return len(analyses), analyses[0]['slug']  # Return count and most recent analysis
    except requests.RequestException as e:
        print(f"    Error fetching analyses for project '{project_slug}' in organization '{org}': {e}")
    return None, None

print(progress_pickle)

# Load progress if available
if os.path.exists(progress_pickle):
    with open(progress_pickle, 'rb') as f:
        output_data, org_index = pickle.load(f)
    print(f"Resuming from organization index {org_index}")
else:
    output_data = []
    org_index = 0

org_list = read_orgs_from_config('config.txt')[org_index:]  # Start from the saved org index

for org in org_list:
    print(f"\n{'=' * 40}\nProcessing organization: {org}\n{'=' * 40}")
    projects = fetch_projects(org)
    
    qualifying_projects = []
    
    for project in projects:
        # Fetch analysis count and most recent analysis
        analysis_count, recent_analysis = fetch_analysis_count(org, project['project_slug'])
        
        if analysis_count and analysis_count >= 2:
            print(f"  Project: {project['project_name']} (Slug: {project['project_slug']})")
            print(f"    Analysis count: {analysis_count}, Most recent analysis: {recent_analysis}")
            qualifying_projects.append({
                'Organization': org,
                'Project Name': project['project_name'],
                'Project Slug': project['project_slug'],
                'Analysis Count': analysis_count,
                'Most Recent Analysis': recent_analysis
            })
        
        # Delay after each project to manage rate limits
        time.sleep(DELAY_BETWEEN_PROJECTS)

    # Sort projects by analysis count in descending order and add to output
    qualifying_projects.sort(key=lambda x: x['Analysis Count'], reverse=True)
    output_data.extend(qualifying_projects)

    # Save progress after each organization
    with open(progress_pickle, 'wb') as f:
        pickle.dump((output_data, org_index + org_list.index(org) + 1), f)

    # Delay between organizations to further manage rate limits
    time.sleep(DELAY_BETWEEN_ORGS)

# Save final CSV and clean up progress file
df = pd.DataFrame(output_data)
df.to_csv(output_csv, index=False)
print(f"\nData saved to {output_csv}")

# Remove progress file if run completes successfully
if os.path.exists(progress_pickle):
    os.remove(progress_pickle)

# Update config.txt with project candidates under each organization
with open('config.txt', 'w') as file:
    for org in read_orgs_from_config('config.txt'):
        file.write(f"{org}\n")
        org_projects = [item for item in output_data if item['Organization'] == org]
        for project in org_projects:
            file.write(f"    {project['Project Name']} ({project['Project Slug']})\n")

print("\nconfig.txt updated with project candidates.")
```

**Sample Output:**

```plaintext
Data saved to projects_with_multiple_analyses.csv

Project Analysis Summary
===========================================
Processing organization: Noodle-Network
  Fetched 3 projects so far for organization 'Noodle-Network'
  Project: Spaghetti Central (Slug: spaghetti-central)
    Analysis count: 5, Most recent analysis: 20241106
  Project: Ramen Repository (Slug: ramen-repo)
    Analysis count: 10, Most recent analysis: 20241105

Processing organization: Flavor-Fusion-Co
  Fetched 2 projects so far for organization 'Flavor-Fusion-Co'
  Project: Spice Index (Slug: spice-index)
    Analysis count: 8, Most recent analysis: 20241030
  Project: Zesty Catalog (Slug: zesty-catalog)
    Analysis count: 3, Most recent analysis: 20240925

Processing organization: Savory-Solutions
  Fetched 4 projects so far for organization 'Savory-Solutions'
  Project: Savory Treats (Slug: savory-treats)
    Analysis count: 7, Most recent analysis: 20241102
  Project: Herb Hub (Slug: herb-hub)
    Analysis count: 6, Most recent analysis: 20241029
===========================================
config.txt updated with project candidates.
```

**Rationale**: This code fetches and processes project analysis data from the Botify API, incorporating robust error handling, progressive saving, and rate limiting to efficiently handle large data requests across multiple organizations. By saving progress in `progress.pkl`, this script ensures that even if an interruption occurs, data already fetched is retained, allowing for a seamless resume without re-fetching. The delays between requests prevent rate limiting, while a final CSV output (`projects_with_multiple_analyses.csv`) and an updated `config.txt` offer a structured view of qualified projects by organization. This approach optimizes both data retrieval and analysis while ensuring a user-friendly summary for each organization.

```python

```

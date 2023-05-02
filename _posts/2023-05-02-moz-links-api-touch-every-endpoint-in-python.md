---
date: 2023-05-02
title: MOZ Links API, Touch Every Endpoint in Python
permalink: /blog/moz-links-api-touch-every-endpoint-in-python/
headline: "Exploring the MOZ Links API with Python: Learn How to Access Every Endpoint!"
description: This article provides an introduction to using the MOZ Links API with Python. It covers how to import resources, load login credentials, configure variables, and make API requests. It also includes code to list the available sub-endpoints, provide human-friendly labels, and show example requests for each endpoint. Finally, it includes a function to hit the API and a code snippet to store the response in a SQLite database.
keywords: MOZ, Links, API, Education, Guidance, Python, Jupyter, Notebook, Hosting, Environment, Google, Colab, Github, Code, Snippets, Endpoint, Documentation, Import, Libraries, Modules, Credentials, Access, ID, Secret, Key, Request, Body, URL, Metrics, Usage, Data, SQLite, Database, Engine, Context, Manager, Sub-endpoint, Label, Description, Example, Function
categories: moz, python, jupyter, github, documentation, database, label, sqlite, education, url, google, notebook, environment, api
layout: post
---

# MOZ Links API Education & Guidance
The purpose of this Jupyter Notebook is to introduce using the MOZ Links API using Python. This should work on any Notebook hosting environment, such as Google Colab. If you're looking at this on Github, the code snippets can be copy/pasted into your own Notebook environment. By the time you've run this script to the bottom, you will have used every MOZ Links API endpoint, and can pick the parts you want for your own project. The official documentation is at [https://moz.com/help/links-api](https://moz.com/help/links-api)

## Do global imports

The import statements at the top of a Python program are used to load external resources that are not loaded by default in the Python interpreter. These resources may include libraries or modules that provide additional functionality to the program.

Import statements are usually placed at the top of a program, before any other code is executed. This allows the program to load any necessary resources before they are needed in the program.

Once the resources have been loaded using import statements, they can be used anywhere in the program, not just in the cell where the import statement was written. This allows the program to access the functionality provided by the imported resources throughout its execution.

```python
import json
import requests
from headlines import *
from pprint import pprint
from sqlitedict import SqliteDict as sqldict
```

## Load login values from external file

The code below reads a file named "linksapi.txt" from the "assets" directory, which contains the login credentials, including the access ID and secret key needed to access the Moz API. These credentials are extracted from the file and assigned to two variables named `ACCESSID` and `SECRETKEY`. The `with` statement is used to ensure that the file is properly closed after it's been read. Create a file whose contents look like this with your credentials manually retreived from moz.com:

    ACCESSID: mozscape-1234567890
    SECRETKEY: 1234567890abcdef1234567890abcdef

Once the credentials are extracted from the file, they are stored in a tuple named `AUTH_TUPLE`. This tuple can be used as an argument to the Moz API functions to authenticate and authorize access to the data.

The purpose of this approach is to avoid hard-coding sensitive login credentials directly in the program, which could pose a security risk if the code was shared or published publicly. Instead, the credentials are kept in a separate file that is not included in the repository, and can be easily created and updated as needed. This way, the code can be shared without exposing the credentials to the public.

```python
with open("../assets/linksapi.txt") as fh:
    ACCESSID, SECRETKEY = [x.strip().split(" ")[1] for x in fh.readlines()]

AUTH_TUPLE = (ACCESSID, SECRETKEY)  # Don't show contents while live-streaming!
```

## Configure variables

In this code, there are several configuration variables that are used to set up the API call to the MOZ Links API.

The first variable, `COMMON_ENDPOINT`, is a constant that stores the endpoint URL for the MOZ API. The second variable, `sub_endpoint`, is a string that represents the endpoint subpath for the anchor text data, which will be appended to the `COMMON_ENDPOINT` URL to form the complete API `endpoint` URL.

The fourth variable, `data_dict`, is a dictionary that contains the parameters for the API request. In this case, the `data_dict` specifies the target URL for which we want to retrieve anchor text data, the scope of the data (in this case, page-level), and a limit of 1 result.

Finally, the `json_string` variable is created by converting the `data_dict` dictionary into a JSON-formatted string using the `json.dumps()` function. This string will be used as the request body when making the API call.

These variables are used to configure and parameterize the API request, and can be modified to perform any `data_dict` request against any MOZ Links API `sub_endpoint`.

```python
COMMON_ENDPOINT = "https://lsapi.seomoz.com/v2/"
sub_endpoint = "anchor_text"
endpoint = COMMON_ENDPOINT + sub_endpoint
data_dict = {"target": "moz.com/blog", "scope": "page", "limit": 1}
json_string = json.dumps(data_dict)
```

# Actually Hit the API (Ensure Success)

In JupyterLab, the last line of a code cell is automatically printed to the output area without requiring an explicit `print()` statement. The code you provided is using the `requests` module to send a POST request to a URL `url` with data in the form of a JSON string `json_string`. The authentication details are passed using the `AUTH_TUPLE` variable.

After sending the request, the response object r is printed using the `print()` statement. This will print the HTTP status code, such as 200 for success, 404 for not found, etc., along with the response headers.

Finally, the `.json()` method is called on the response object `response` to parse the response data as JSON and return it as a Python dictionary. This dictionary can be assigned to a variable, used for further processing, or simply printed to the output area without requiring an explicit print() statement due to JupyterLab's automatic printing behavior for the last line of a code cell.

```python
response = requests.post(endpoint, data=json_string, auth=AUTH_TUPLE)
pprint(response.json())
```

# List Sub-endpoints

This code defines a list of different sub-endpoints that can be appended to a common URL prefix to make different API endpoints. An API endpoint is a URL where an API can be accessed by clients. It is a point of entry to the application that acts as a gatekeeper between the client and the server. Each endpoint is identified by a unique URL, which can be used to interact with the API.

In this code, the list of sub-endpoints is defined in the `sub_endpoints` variable, and each endpoint is represented as a string. The for loop iterates over the list, prints the index number and name of each sub-endpoint using the print function, and increments the index by 1. The `enumerate` function is used to generate a sequence of pairs consisting of an index and a value from the list.

This code is useful for exploring the available endpoints for a particular API and for selecting the endpoint that corresponds to the desired functionality. By changing the sub-endpoint in the URL, clients can access different resources or perform different operations on the server.

```python
sub_endpoints = [
    "anchor_text",
    "final_redirect",
    "global_top_pages",
    "global_top_root_domains",
    "index_metadata",
    "link_intersect",
    "link_status",
    "linking_root_domains",
    "links",
    "top_pages",
    "url_metrics",
    "usage_data",
]
for i, sub_endpoint in enumerate(sub_endpoints):
    print(i + 1, sub_endpoint)
```

# Human friendly labels

This code defines two lists: `names` and `descriptions`. The names list contains human-friendly labels for the set of sub-endpoints, while the `descriptions` list provides a brief description of each endpoint. The two lists are kept in the same order as the `points` list defined earlier in the code.

By keeping the three lists in the same order, they can be "zipped" together into a single list of tuples using the `zip` function. This produces a new list where each tuple contains the name, endpoint, and description for a particular API endpoint. This makes it easy to display a user-friendly summary of each API endpoint with its name and description.

The `zip` function combines the elements of the three lists element-wise, creating a tuple of the first elements from each list, then a tuple of the second elements, and so on. The resulting list of tuples can be iterated over, and each tuple unpacked to access the individual name, endpoint, and description elements for each API endpoint.

```python
names = [
    "Anchor Text",
    "Final Redirect",
    "Global Top Pages",
    "Global Top Root Domains",
    "Index Metadata",
    "Link Intersect",
    "Link Status",
    "Linking Root Domains",
    "Links",
    "Top Pages",
    "URL Metrics",
    "Usage Data",
]

descriptions = [
    "Use this endpoint to get data about anchor text used by followed external links to a target. Results are ordered by external_root_domains descending.",
    "Use this endpoint to get data about anchor text used by followed external links to a target. Results are ordered by external_root_domains descending.",
    "This endpoint returns the top 500 pages in the entire index with the highest Page Authority values, sorted by Page Authority. (Visit the Top 500 Sites list to explore the top root domains on the web, sorted by Domain Authority.)",
    "This endpoint returns the top 500 pages in the entire index with the highest Page Authority values, sorted by Page Authority. (Visit the Top 500 Sites list to explore the top root domains on the web, sorted by Domain Authority.)",
    "This endpoint returns the top 500 pages in the entire index with the highest Page Authority values, sorted by Page Authority. (Visit the Top 500 Sites list to explore the top root domains on the web, sorted by Domain Authority.)",
    "Use this endpoint to get sources that link to at least one of a list of positive targets and don't link to any of a list of negative targets.",
    "Use this endpoint to get information about links from many sources to a single target.",
    "Use this endpoint to get linking root domains to a target.",
    "Use this endpoint to get links to a target.",
    "This endpoint returns top pages on a target domain.",
    "Use this endpoint to get metrics about one or more urls.",
    "This endpoint Returns the number of rows consumed so far in the current billing period. The count returned might not reflect rows consumed in the last hour. The count returned reflects rows consumed by requests to both the v1 (Moz Links API) and v2 Links APIs.",
]

# Simple zipping example
list(zip(names, sub_endpoints, descriptions))
```

# Show an example request for each endpoint.

This is a list of API requests in Python dict format, where each dictionary represents a request to a specific endpoint. Don't hurt your brain too much trying to read it. Just know that I lifted each example from the original MOZ documentation and listed them all here in order as nested Python dicts.

You could call the format is a dict of dicts, where each sub-dictionary corresponds to a specific endpoint, same order as the `sub_endpoints`, `names` and `descriptions` lists for easy combining. The output of running the below cell is doing that list-combining to document every `sub_endpoint`.

```python
dict_of_dicts = {
    "anchor_text": {"target": "moz.com/blog", "scope": "page", "limit": 5},
    "links": {
        "target": "moz.com/blog",
        "target_scope": "page",
        "filter": "external+nofollow",
        "limit": 1,
    },
    "final_redirect": {"page": "seomoz.org/blog"},
    "global_top_pages": {"limit": 5},
    "global_top_root_domains": {"limit": 5},
    "index_metadata": {},
    "link_intersect": {
        "positive_targets": [
            {"target": "latimes.com", "scope": "root_domain"},
            {"target": "blog.nytimes.com", "scope": "subdomain"},
        ],
        "negative_targets": [{"target": "moz.com", "scope": "root_domain"}],
        "source_scope": "page",
        "sort": "source_domain_authority",
        "limit": 1,
    },
    "link_status": {
        "target": "moz.com/blog",
        "sources": ["twitter.com", "linkedin.com"],
        "source_scope": "root_domain",
        "target_scope": "page",
    },
    "linking_root_domains": {
        "target": "moz.com/blog",
        "target_scope": "page",
        "filter": "external",
        "sort": "source_domain_authority",
        "limit": 5,
    },
    "top_pages": {"target": "moz.com", "scope": "root_domain", "limit": 5},
    "url_metrics": {"targets": ["moz.com", "nytimes.com"]},
    "usage_data": {},
}

for i, point in enumerate(sub_endpoints):
    h1(f"{i + 1}. {names[i]} ({sub_endpoint})")
    print(descriptions[i])
    h4("Example request:")
    pprint(dict_of_dicts[sub_endpoint])
    print()
```

# Write a Function That Hits API

If we're going to hit an API over and over in mostly the same way, we want to spare ourselves re-typing everything all the time. That's why we define functions. That's the `def` in the below cell. Once that cell is run, the `moz()` function can be used anywhere in this Notebook. You need only feed it the sub_endpoint you want to use and a Python dict of your request. It will return the API's response.

```python
def moz(sub_endpoint, data_dict):
    """Hits MOZ Links API with specified endpoint and request and returns results."""
    json_string = json.dumps(data_dict)
    endpoint = COMMON_ENDPOINT + sub_endpoint
    # Below, data is a string (flattened JSON) but auth is a 2-position tuple.
    response = requests.post(endpoint, data=json_string, auth=AUTH_TUPLE)
    return response
```

# Conditionally Hit the API

The code uses a Python package called `SqliteDict` which provides a persistent dictionary-like object that can be stored on disk using the SQLite database engine. The `with` statement in the code sets up a context manager for the SqliteDict object, which automatically handles opening and closing the database connection. The database file is stored at `../dbs/linksapi.db`

The code iterates through each sub-endpoint in the `sub_endpoints` list, and checks if that data has already been retrieved. If it hasn't, the API is called using the `moz()` function and the result is saved in the SqliteDict. The `db.commit()` statement ensures that any changes made to the dictionary during the iteration are saved to the database.

The SqliteDict serves as a local cache to prevent the API from being hit every time the code block is run if the data has already been collected. By using this cache, the code reduces the number of API requests required, which is useful when working with APIs that have quota limits. Congratulations, you're using a database!

```python
with sqldict("../dbs/linksapi.db") as db:
    for sub_endpoint in sub_endpoints:
        if sub_endpoint not in db:
            print(sub_endpoint)
            result = moz(sub_endpoint, dict_of_dicts[sub_endpoint])
            db[sub_endpoint] = result
            db.commit()
            print("API hit and response saved!")
            print()
h2("Done")
````

# Show the locally stored API responses.

This code uses the `sqldict` context manager to open the SQLite database containing the previously retrieved API data. It then iterates over the keys in the database, which correspond to the endpoints that were previously retrieved.

For each key, the code prints the endpoint name, description, and the data retrieved from the API. The `pprint` function is used to print the JSON data in a more human-readable format, with indentation and line breaks that make it easier to read.

```python
with sqldict("../dbs/linksapi.db") as db:
    for i, key in enumerate(db):
        h1(f"{i + 1}. {names[i]} ({key})")
        print(descriptions[i])
        print()
        pprint(db[key].json())
        print()
```























## Categories

<ul>
<li><h4><a href='/moz/'>MOZ</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/github/'>Github</a></h4></li>
<li><h4><a href='/documentation/'>Documentation</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/label/'>Labels</a></h4></li>
<li><h4><a href='/sqlite/'>SQLite</a></h4></li>
<li><h4><a href='/education/'>Education</a></h4></li>
<li><h4><a href='/url/'>URLs</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/notebook/'>Notebook</a></h4></li>
<li><h4><a href='/environment/'>Environment</a></h4></li>
<li><h4><a href='/api/'>API</a></h4></li></ul>
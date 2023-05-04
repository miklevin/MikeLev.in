---
date: 2023-05-02
title: MOZ Links API, Touch Every Endpoint in Python
headline: "Exploring the MOZ Links API with Python: Learn How to Access Every Endpoint!"
description: This article provides an introduction to using the MOZ Links API with Python. It covers how to import resources, load login credentials, configure variables, and make API requests. It also includes code to list the available sub-endpoints, provide human-friendly labels, and show example requests for each endpoint. Finally, it includes a function to hit the API and a code snippet to store the response in a SQLite database.
keywords: MOZ, Links, API, Education, Guidance, Python, Jupyter, Notebook, Hosting, Environment, Google, Colab, Github, Code, Snippets, Endpoint, Documentation, Import, Libraries, Modules, Credentials, Access, ID, Secret, Key, Request, Body, URL, Metrics, Usage, Data, SQLite, Database, Engine, Context, Manager, Sub-endpoint, Label, Description, Example, Function
categories: python, jupyter, api, notebook, database, google, label, moz, url, github, sqlite
permalink: /blog/moz-links-api-touch-every-endpoint-in-python/
layout: post
---


# MOZ Links API Education & Guidance
The purpose of this Jupyter Notebook is to introduce using the MOZ Links API using Python. This should work on any Notebook hosting environment, such as Google Colab. If you're looking at this on Github, the code snippets can be copy/pasted into your own Notebook environment. By the time you've run this script to the bottom, you will have used every MOZ Links API endpoint, and can pick the parts you want for your own project. The official documentation is at [https://moz.com/help/links-api](https://moz.com/help/links-api)

## Do global imports

The import statements at the top of a Python program are used to load external resources that are not loaded by default in the Python interpreter. These resources may include libraries or modules that provide additional functionality to the program.

Import statements are usually placed at the top of a program, before any other code is executed. This allows the program to load any necessary resources before they are needed in the program.

Once the resources have been loaded using import statements, they can be used anywhere in the program, not just in the cell where the import statement was written. This allows the program to access the functionality provided by the imported resources throughout its execution.

The libraries here not part of the standard Python library are `requests` and `sqlitedict`. You can install the with `pip install requests` and `pip install sqlitedict` in your terminal or a Jupyter cell. If you're using Anaconda, requests is pre-installed.

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

AUTH_TUPLE = (ACCESSID, SECRETKEY)  # Don't show contents
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

Outputs:

```javascript
{'next_token': 'JYkQVg4s9ak8iRBWDiz1qTyguYswnj035nqjRF0IbW96IGJsb2e58hGzcmSomw==',
 'results': [{'anchor_text': 'moz',
              'external_pages': 7183,
              'external_root_domains': 2038}]}
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

Outputs:

```bash
1 anchor_text
2 final_redirect
3 global_top_pages
4 global_top_root_domains
5 index_metadata
6 link_intersect
7 link_status
8 linking_root_domains
9 links
10 top_pages
11 url_metrics
12 usage_data
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

Outputs:

```javascript
[('Anchor Text',
  'anchor_text',
  'Use this endpoint to get data about anchor text used by followed external links to a target. Results are ordered by external_root_domains descending.'),
 ('Final Redirect',
  'final_redirect',
  'Use this endpoint to get data about anchor text used by followed external links to a target. Results are ordered by external_root_domains descending.'),
 ('Global Top Pages',
  'global_top_pages',
  'This endpoint returns the top 500 pages in the entire index with the highest Page Authority values, sorted by Page Authority. (Visit the Top 500 Sites list to explore the top root domains on the web, sorted by Domain Authority.)'),
 ('Global Top Root Domains',
  'global_top_root_domains',
  'This endpoint returns the top 500 pages in the entire index with the highest Page Authority values, sorted by Page Authority. (Visit the Top 500 Sites list to explore the top root domains on the web, sorted by Domain Authority.)'),
 ('Index Metadata',
  'index_metadata',
  'This endpoint returns the top 500 pages in the entire index with the highest Page Authority values, sorted by Page Authority. (Visit the Top 500 Sites list to explore the top root domains on the web, sorted by Domain Authority.)'),
 ('Link Intersect',
  'link_intersect',
  "Use this endpoint to get sources that link to at least one of a list of positive targets and don't link to any of a list of negative targets."),
 ('Link Status',
  'link_status',
  'Use this endpoint to get information about links from many sources to a single target.'),
 ('Linking Root Domains',
  'linking_root_domains',
  'Use this endpoint to get linking root domains to a target.'),
 ('Links', 'links', 'Use this endpoint to get links to a target.'),
 ('Top Pages',
  'top_pages',
  'This endpoint returns top pages on a target domain.'),
 ('URL Metrics',
  'url_metrics',
  'Use this endpoint to get metrics about one or more urls.'),
 ('Usage Data',
  'usage_data',
  'This endpoint Returns the number of rows consumed so far in the current billing period. The count returned might not reflect rows consumed in the last hour. The count returned reflects rows consumed by requests to both the v1 (Moz Links API) and v2 Links APIs.')]
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

for i, sub_endpoint in enumerate(sub_endpoints):
    h1(f"{i + 1}. {names[i]} ({sub_endpoint})")
    print(descriptions[i])
    h4("Example request:")
    pprint(dict_of_dicts[sub_endpoint])
    print()
```

Outputs:

```markdown
# 2. Final Redirect (final_redirect)

Use this endpoint to get data about anchor text used by followed external links to a target. Results are ordered by external_root_domains descending.
Example request:

{'page': 'seomoz.org/blog'}

[...]
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

This does not output anything to the screen. It just defines the function. 

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

This does not output anything to the screen. It saves the results of the API-calls to a local database.

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

Outputs:

```text
1. Anchor Text (anchor_text)
Use this endpoint to get data about anchor text used by followed external links to a target. Results are ordered by external_root_domains descending.

{'next_token': 'KIkQVg4s9ak8iRBWDiz1qTyguYswnj035n7bYI0Lc2VvbW96IGJsb2dKBcCodcl47Q==',
 'results': [{'anchor_text': 'moz',
              'external_pages': 7162,
              'external_root_domains': 2026},
             {'anchor_text': 'moz blog',
              'external_pages': 15525,
              'external_root_domains': 1364},
             {'anchor_text': 'the moz blog',
              'external_pages': 7879,
              'external_root_domains': 728},
             {'anchor_text': 'seomoz',
              'external_pages': 17741,
              'external_root_domains': 654},
             {'anchor_text': 'https://moz.com/blog',
              'external_pages': 978,
              'external_root_domains': 491}]}

2. Final Redirect (final_redirect)
Use this endpoint to get data about anchor text used by followed external links to a target. Results are ordered by external_root_domains descending.

{'page': 'moz.com/blog'}

3. Global Top Pages (global_top_pages)
This endpoint returns the top 500 pages in the entire index with the highest Page Authority values, sorted by Page Authority. (Visit the Top 500 Sites list to explore the top root domains on the web, sorted by Domain Authority.)

{'next_token': 'BcLbRwBmrXHK',
 'results': [{'deleted_pages_to_page': 11932076,
              'deleted_pages_to_root_domain': 23942663640,
              'deleted_pages_to_subdomain': 21555752652,
              'deleted_root_domains_to_page': 64700,
              'deleted_root_domains_to_root_domain': 3688228,
              'deleted_root_domains_to_subdomain': 3516235,
              'domain_authority': 96,
              'external_indirect_pages_to_root_domain': 5042652519,
              'external_nofollow_pages_to_page': 31163,
              'external_nofollow_pages_to_root_domain': 12375460748,
              'external_nofollow_pages_to_subdomain': 11393036086,
              'external_pages_to_page': 118102549,
              'external_pages_to_root_domain': 91362310623,
              'external_pages_to_subdomain': 83283626903,
              'external_redirect_pages_to_page': 0,
              'external_redirect_pages_to_root_domain': 445730476,
              'external_redirect_pages_to_subdomain': 432323198,
              'http_code': 5,
              'indirect_root_domains_to_page': 0,
              'indirect_root_domains_to_root_domain': 701121,
              'last_crawled': '2023-01-15',
              'link_propensity': 1.76710455e-05,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 2,
              'nofollow_pages_to_page': 31163,
              'nofollow_pages_to_root_domain': 12375623717,
              'nofollow_pages_to_subdomain': 11393036179,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 0,
              'nofollow_root_domains_to_page': 980,
              'nofollow_root_domains_to_root_domain': 3696150,
              'nofollow_root_domains_to_subdomain': 3622349,
              'page': 'www.facebook.com/Plesk',
              'page_authority': 100,
              'pages_crawled_from_root_domain': 1810872,
              'pages_from_page': 0,
              'pages_from_root_domain': 5289,
              'pages_to_page': 118102549,
              'pages_to_root_domain': 91368257043,
              'pages_to_subdomain': 83288001442,
              'redirect_pages_to_page': 0,
              'redirect_pages_to_root_domain': 447189164,
              'redirect_pages_to_subdomain': 433411292,
              'root_domain': 'facebook.com',
              'root_domains_from_page': 0,
              'root_domains_from_root_domain': 32,
              'root_domains_to_page': 491956,
              'root_domains_to_root_domain': 59416650,
              'root_domains_to_subdomain': 50993087,
              'spam_score': 1,
              'subdomain': 'www.facebook.com',
              'title': ''},
             {'deleted_pages_to_page': 5828966,
              'deleted_pages_to_root_domain': 79909678,
              'deleted_pages_to_subdomain': 79909678,
              'deleted_root_domains_to_page': 16552,
              'deleted_root_domains_to_root_domain': 98416,
              'deleted_root_domains_to_subdomain': 98416,
              'domain_authority': 94,
              'external_indirect_pages_to_root_domain': 1177381629,
              'external_nofollow_pages_to_page': 453328699,
              'external_nofollow_pages_to_root_domain': 1643990147,
              'external_nofollow_pages_to_subdomain': 1643990147,
              'external_pages_to_page': 456279611,
              'external_pages_to_root_domain': 2808523112,
              'external_pages_to_subdomain': 2808523112,
              'external_redirect_pages_to_page': 125,
              'external_redirect_pages_to_root_domain': 24941546,
              'external_redirect_pages_to_subdomain': 24941546,
              'http_code': 3,
              'indirect_root_domains_to_page': 723,
              'indirect_root_domains_to_root_domain': 252606,
              'last_crawled': '2023-01-14',
              'link_propensity': 0.118001014,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 121166,
              'nofollow_pages_to_page': 453328699,
              'nofollow_pages_to_root_domain': 1644293277,
              'nofollow_pages_to_subdomain': 1644293277,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 67627,
              'nofollow_root_domains_to_page': 9800973,
              'nofollow_root_domains_to_root_domain': 4959747,
              'nofollow_root_domains_to_subdomain': 4959747,
              'page': 'wordpress.com/?ref=footer_blog',
              'page_authority': 100,
              'pages_crawled_from_root_domain': 1731019,
              'pages_from_page': 0,
              'pages_from_root_domain': 1080338,
              'pages_to_page': 456293004,
              'pages_to_root_domain': 2817137385,
              'pages_to_subdomain': 2817137385,
              'redirect_pages_to_page': 125,
              'redirect_pages_to_root_domain': 25449067,
              'redirect_pages_to_subdomain': 25449067,
              'root_domain': 'wordpress.com',
              'root_domains_from_page': 0,
              'root_domains_from_root_domain': 204262,
              'root_domains_to_page': 9878742,
              'root_domains_to_root_domain': 12653294,
              'root_domains_to_subdomain': 12653294,
              'spam_score': 1,
              'subdomain': 'wordpress.com',
              'title': ''},
             {'deleted_pages_to_page': 3904778,
              'deleted_pages_to_root_domain': 23942663640,
              'deleted_pages_to_subdomain': 21555752652,
              'deleted_root_domains_to_page': 11671,
              'deleted_root_domains_to_root_domain': 3688228,
              'deleted_root_domains_to_subdomain': 3516235,
              'domain_authority': 96,
              'external_indirect_pages_to_root_domain': 5042652519,
              'external_nofollow_pages_to_page': 4449343,
              'external_nofollow_pages_to_root_domain': 12375460748,
              'external_nofollow_pages_to_subdomain': 11393036086,
              'external_pages_to_page': 59602588,
              'external_pages_to_root_domain': 91362310623,
              'external_pages_to_subdomain': 83283626903,
              'external_redirect_pages_to_page': 12625,
              'external_redirect_pages_to_root_domain': 445730476,
              'external_redirect_pages_to_subdomain': 432323198,
              'http_code': 5,
              'indirect_root_domains_to_page': 1632,
              'indirect_root_domains_to_root_domain': 701121,
              'last_crawled': '2023-01-16',
              'link_propensity': 1.76710455e-05,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 2,
              'nofollow_pages_to_page': 4449343,
              'nofollow_pages_to_root_domain': 12375623717,
              'nofollow_pages_to_subdomain': 11393036179,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 0,
              'nofollow_root_domains_to_page': 28624,
              'nofollow_root_domains_to_root_domain': 3696150,
              'nofollow_root_domains_to_subdomain': 3622349,
              'page': 'www.facebook.com/home.php',
              'page_authority': 100,
              'pages_crawled_from_root_domain': 1810872,
              'pages_from_page': 0,
              'pages_from_root_domain': 5289,
              'pages_to_page': 59602589,
              'pages_to_root_domain': 91368257043,
              'pages_to_subdomain': 83288001442,
              'redirect_pages_to_page': 12626,
              'redirect_pages_to_root_domain': 447189164,
              'redirect_pages_to_subdomain': 433411292,
              'root_domain': 'facebook.com',
              'root_domains_from_page': 0,
              'root_domains_from_root_domain': 32,
              'root_domains_to_page': 239697,
              'root_domains_to_root_domain': 59416650,
              'root_domains_to_subdomain': 50993087,
              'spam_score': 1,
              'subdomain': 'www.facebook.com',
              'title': ''},
             {'deleted_pages_to_page': 3440567,
              'deleted_pages_to_root_domain': 3440700,
              'deleted_pages_to_subdomain': 3440700,
              'deleted_root_domains_to_page': 60839,
              'deleted_root_domains_to_root_domain': 60840,
              'deleted_root_domains_to_subdomain': 60840,
              'domain_authority': 1,
              'external_indirect_pages_to_root_domain': 7,
              'external_nofollow_pages_to_page': 288,
              'external_nofollow_pages_to_root_domain': 1499,
              'external_nofollow_pages_to_subdomain': 1499,
              'external_pages_to_page': 140954613,
              'external_pages_to_root_domain': 140959216,
              'external_pages_to_subdomain': 140959213,
              'external_redirect_pages_to_page': 70,
              'external_redirect_pages_to_root_domain': 70,
              'external_redirect_pages_to_subdomain': 70,
              'http_code': 200,
              'indirect_root_domains_to_page': 0,
              'indirect_root_domains_to_root_domain': 0,
              'last_crawled': '2018-02-05',
              'link_propensity': 0.3998428881,
              'nofollow_pages_from_page': 12,
              'nofollow_pages_from_root_domain': 805,
              'nofollow_pages_to_page': 288,
              'nofollow_pages_to_root_domain': 10799,
              'nofollow_pages_to_subdomain': 10799,
              'nofollow_root_domains_from_page': 2,
              'nofollow_root_domains_from_root_domain': 7,
              'nofollow_root_domains_to_page': 30,
              'nofollow_root_domains_to_root_domain': 30,
              'nofollow_root_domains_to_subdomain': 30,
              'page': 'music.skyrock.com/',
              'page_authority': 100,
              'pages_crawled_from_root_domain': 2546,
              'pages_from_page': 61,
              'pages_from_root_domain': 3382,
              'pages_to_page': 140956009,
              'pages_to_root_domain': 141008586,
              'pages_to_subdomain': 141008583,
              'redirect_pages_to_page': 70,
              'redirect_pages_to_root_domain': 70,
              'redirect_pages_to_subdomain': 70,
              'root_domain': 'music.skyrock.com',
              'root_domains_from_page': 19,
              'root_domains_from_root_domain': 1018,
              'root_domains_to_page': 10609865,
              'root_domains_to_root_domain': 10609868,
              'root_domains_to_subdomain': 10609868,
              'spam_score': 9,
              'subdomain': 'music.skyrock.com',
              'title': 'Blog de Music - DES NEWS, DES CLIPS, DES INTERVIEWS - '
                       'Skyrock.com'},
             {'deleted_pages_to_page': 64159924,
              'deleted_pages_to_root_domain': 17641375891,
              'deleted_pages_to_subdomain': 336246205,
              'deleted_root_domains_to_page': 63574,
              'deleted_root_domains_to_root_domain': 1728606,
              'deleted_root_domains_to_subdomain': 234073,
              'domain_authority': 100,
              'external_indirect_pages_to_root_domain': 19281720347,
              'external_nofollow_pages_to_page': 34635431,
              'external_nofollow_pages_to_root_domain': 7885369442,
              'external_nofollow_pages_to_subdomain': 184067821,
              'external_pages_to_page': 285612569,
              'external_pages_to_root_domain': 55013651418,
              'external_pages_to_subdomain': 1492976347,
              'external_redirect_pages_to_page': 593282,
              'external_redirect_pages_to_root_domain': 250423075,
              'external_redirect_pages_to_subdomain': 5678006,
              'http_code': 302,
              'indirect_root_domains_to_page': 1072,
              'indirect_root_domains_to_root_domain': 231256,
              'last_crawled': '2023-04-01',
              'link_propensity': 0.006248265505,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 991472,
              'nofollow_pages_to_page': 34635436,
              'nofollow_pages_to_root_domain': 7948674425,
              'nofollow_pages_to_subdomain': 184068512,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 182393,
              'nofollow_root_domains_to_page': 126656,
              'nofollow_root_domains_to_root_domain': 2322389,
              'nofollow_root_domains_to_subdomain': 304381,
              'page': 'youtube.com/',
              'page_authority': 100,
              'pages_crawled_from_root_domain': 41258009,
              'pages_from_page': 0,
              'pages_from_root_domain': 11109186,
              'pages_to_page': 285612606,
              'pages_to_root_domain': 55255620288,
              'pages_to_subdomain': 1493073570,
              'redirect_pages_to_page': 593282,
              'redirect_pages_to_root_domain': 263224806,
              'redirect_pages_to_subdomain': 5678383,
              'root_domain': 'youtube.com',
              'root_domains_from_page': 0,
              'root_domains_from_root_domain': 257791,
              'root_domains_to_page': 598403,
              'root_domains_to_root_domain': 23134271,
              'root_domains_to_subdomain': 1927717,
              'spam_score': 4,
              'subdomain': 'youtube.com',
              'title': ''}]}

4. Global Top Root Domains (global_top_root_domains)
This endpoint returns the top 500 pages in the entire index with the highest Page Authority values, sorted by Page Authority. (Visit the Top 500 Sites list to explore the top root domains on the web, sorted by Domain Authority.)

{'next_token': 'BcLbRwBmrXHK',
 'results': [{'domain_authority': 100,
              'link_propensity': 0.006248265505,
              'root_domain': 'youtube.com',
              'root_domains_to_root_domain': 23134271,
              'spam_score': 4,
              'to_target': {'deleted_pages': 0,
                            'nofollow_pages': 0,
                            'pages': 0,
                            'redirect_pages': 0}},
             {'domain_authority': 100,
              'link_propensity': 0.008422264829,
              'root_domain': 'www.google.com',
              'root_domains_to_root_domain': 14723695,
              'spam_score': 14,
              'to_target': {'deleted_pages': 0,
                            'nofollow_pages': 0,
                            'pages': 0,
                            'redirect_pages': 0}},
             {'domain_authority': 100,
              'link_propensity': 0.0001607139566,
              'root_domain': 'www.blogger.com',
              'root_domains_to_root_domain': 30580427,
              'spam_score': -1,
              'to_target': {'deleted_pages': 0,
                            'nofollow_pages': 0,
                            'pages': 0,
                            'redirect_pages': 0}},
             {'domain_authority': 99,
              'link_propensity': 0.04834850505,
              'root_domain': 'linkedin.com',
              'root_domains_to_root_domain': 12339087,
              'spam_score': 1,
              'to_target': {'deleted_pages': 0,
                            'nofollow_pages': 0,
                            'pages': 0,
                            'redirect_pages': 0}},
             {'domain_authority': 99,
              'link_propensity': 0.006264935713,
              'root_domain': 'microsoft.com',
              'root_domains_to_root_domain': 5344181,
              'spam_score': 11,
              'to_target': {'deleted_pages': 0,
                            'nofollow_pages': 0,
                            'pages': 0,
                            'redirect_pages': 0}}]}

5. Index Metadata (index_metadata)
This endpoint returns the top 500 pages in the entire index with the highest Page Authority values, sorted by Page Authority. (Visit the Top 500 Sites list to explore the top root domains on the web, sorted by Domain Authority.)

{'index_id': 'NE+lX5bFh06baS9ojUwVbw==',
 'spam_score_update_days': ['2019-02-08',
                            '2020-03-28',
                            '2020-08-03',
                            '2020-11-13',
                            '2021-02-24',
                            '2021-05-19',
                            '2021-08-16',
                            '2021-11-02',
                            '2022-02-01',
                            '2022-05-10',
                            '2022-11-16']}

6. Link Intersect (link_intersect)
Use this endpoint to get sources that link to at least one of a list of positive targets and don't link to any of a list of negative targets.

{'next_token': 'AcmY2oCXQbbg',
 'results': [{'domain_authority': 100,
              'matching_target_indexes': [0],
              'page': 'www.google.com/amp/www.latimes.com/local/lanow/la-me-ln-aliso-viejo-shooting-20171012-story,amp.html',
              'spam_score': 14,
              'title': ''}]}

7. Link Status (link_status)
Use this endpoint to get information about links from many sources to a single target.

{'exists': [False, False]}

8. Linking Root Domains (linking_root_domains)
Use this endpoint to get linking root domains to a target.

{'next_token': 'IokQVg4s9ak8iRBWDiz1qTyguYswnj035qBkmE3DU+JTtwAVhsjH7R6XUA==',
 'results': [{'domain_authority': 99,
              'link_propensity': 0.006264935713,
              'root_domain': 'microsoft.com',
              'root_domains_to_root_domain': 5344181,
              'spam_score': 11,
              'to_target': {'deleted_pages': 0,
                            'nofollow_pages': 0,
                            'pages': 2,
                            'redirect_pages': 0}},
             {'domain_authority': 98,
              'link_propensity': 0.02977741137,
              'root_domain': 'wordpress.org',
              'root_domains_to_root_domain': 12250296,
              'spam_score': 2,
              'to_target': {'deleted_pages': 0,
                            'nofollow_pages': 2,
                            'pages': 2,
                            'redirect_pages': 0}},
             {'domain_authority': 96,
              'link_propensity': 0.09679271281,
              'root_domain': 'github.com',
              'root_domains_to_root_domain': 2948013,
              'spam_score': 2,
              'to_target': {'deleted_pages': 0,
                            'nofollow_pages': 12,
                            'pages': 12,
                            'redirect_pages': 0}},
             {'domain_authority': 96,
              'link_propensity': 0.004641198553,
              'root_domain': 'amazon.com',
              'root_domains_to_root_domain': 5023132,
              'spam_score': 28,
              'to_target': {'deleted_pages': 0,
                            'nofollow_pages': 0,
                            'pages': 2,
                            'redirect_pages': 0}},
             {'domain_authority': 95,
              'link_propensity': 0.005770479795,
              'root_domain': 'shopify.com',
              'root_domains_to_root_domain': 2948087,
              'spam_score': 1,
              'to_target': {'deleted_pages': 3,
                            'nofollow_pages': 0,
                            'pages': 0,
                            'redirect_pages': 0}}]}

9. Links (links)
Use this endpoint to get links to a target.

{'next_token': 'AVvpJ4gPPvOY',
 'results': [{'anchor_text': 'moz blog',
              'date_disappeared': '',
              'date_first_seen': '2020-06-29',
              'date_last_seen': '2023-01-14',
              'nofollow': True,
              'redirect': False,
              'rel_canonical': False,
              'source': {'deleted_pages_to_page': 570,
                         'deleted_pages_to_root_domain': 1251501128,
                         'deleted_pages_to_subdomain': 1182759912,
                         'deleted_root_domains_to_page': 34,
                         'deleted_root_domains_to_root_domain': 322790,
                         'deleted_root_domains_to_subdomain': 314554,
                         'domain_authority': 96,
                         'external_indirect_pages_to_root_domain': 863103308,
                         'external_nofollow_pages_to_page': 1407,
                         'external_nofollow_pages_to_root_domain': 667480081,
                         'external_nofollow_pages_to_subdomain': 650421076,
                         'external_pages_to_page': 3710,
                         'external_pages_to_root_domain': 5309615021,
                         'external_pages_to_subdomain': 5086141938,
                         'external_redirect_pages_to_page': 14,
                         'external_redirect_pages_to_root_domain': 143685025,
                         'external_redirect_pages_to_subdomain': 142061138,
                         'http_code': 200,
                         'indirect_root_domains_to_page': 2,
                         'indirect_root_domains_to_root_domain': 180014,
                         'last_crawled': '2023-01-14',
                         'link_propensity': 0.09679271281,
                         'nofollow_pages_from_page': 199,
                         'nofollow_pages_from_root_domain': 7541042,
                         'nofollow_pages_to_page': 1407,
                         'nofollow_pages_to_root_domain': 678014273,
                         'nofollow_pages_to_subdomain': 660443683,
                         'nofollow_root_domains_from_page': 93,
                         'nofollow_root_domains_from_root_domain': 564314,
                         'nofollow_root_domains_to_page': 58,
                         'nofollow_root_domains_to_root_domain': 186407,
                         'nofollow_root_domains_to_subdomain': 171632,
                         'page': 'github.com/mezod/awesome-indie',
                         'page_authority': 68,
                         'pages_crawled_from_root_domain': 7254823,
                         'pages_from_page': 202,
                         'pages_from_root_domain': 8613796,
                         'pages_to_page': 3746,
                         'pages_to_root_domain': 5628821927,
                         'pages_to_subdomain': 5352019489,
                         'redirect_pages_to_page': 14,
                         'redirect_pages_to_root_domain': 145613441,
                         'redirect_pages_to_subdomain': 142856036,
                         'root_domain': 'github.com',
                         'root_domains_from_page': 96,
                         'root_domains_from_root_domain': 702214,
                         'root_domains_to_page': 231,
                         'root_domains_to_root_domain': 2948013,
                         'root_domains_to_subdomain': 2857538,
                         'spam_score': 2,
                         'subdomain': 'github.com',
                         'title': 'GitHub - mezod/awesome-indie: Resources for '
                                  'independent developers to make money'},
              'target': {'deleted_pages_to_page': 169073,
                         'deleted_pages_to_root_domain': 19022927,
                         'deleted_pages_to_subdomain': 18554702,
                         'deleted_root_domains_to_page': 1457,
                         'deleted_root_domains_to_root_domain': 27522,
                         'deleted_root_domains_to_subdomain': 27273,
                         'domain_authority': 91,
                         'external_indirect_pages_to_root_domain': 45290099,
                         'external_nofollow_pages_to_page': 7388,
                         'external_nofollow_pages_to_root_domain': 17425478,
                         'external_nofollow_pages_to_subdomain': 17269297,
                         'external_pages_to_page': 553261,
                         'external_pages_to_root_domain': 69376449,
                         'external_pages_to_subdomain': 68746190,
                         'external_redirect_pages_to_page': 265,
                         'external_redirect_pages_to_root_domain': 41112725,
                         'external_redirect_pages_to_subdomain': 41109338,
                         'http_code': 200,
                         'indirect_root_domains_to_page': 2219,
                         'indirect_root_domains_to_root_domain': 28779,
                         'last_crawled': '2023-04-02',
                         'link_propensity': 0.008849279955,
                         'nofollow_pages_from_page': 0,
                         'nofollow_pages_from_root_domain': 209067,
                         'nofollow_pages_to_page': 7388,
                         'nofollow_pages_to_root_domain': 17442464,
                         'nofollow_pages_to_subdomain': 17285191,
                         'nofollow_root_domains_from_page': 0,
                         'nofollow_root_domains_from_root_domain': 55943,
                         'nofollow_root_domains_to_page': 1727,
                         'nofollow_root_domains_to_root_domain': 37789,
                         'nofollow_root_domains_to_subdomain': 37690,
                         'page': 'moz.com/blog',
                         'page_authority': 69,
                         'pages_crawled_from_root_domain': 7872618,
                         'pages_from_page': 7,
                         'pages_from_root_domain': 343751,
                         'pages_to_page': 906052,
                         'pages_to_root_domain': 98442581,
                         'pages_to_subdomain': 97352802,
                         'redirect_pages_to_page': 746,
                         'redirect_pages_to_root_domain': 47575576,
                         'redirect_pages_to_subdomain': 47570092,
                         'root_domain': 'moz.com',
                         'root_domains_from_page': 5,
                         'root_domains_from_root_domain': 69667,
                         'root_domains_to_page': 9712,
                         'root_domains_to_root_domain': 179884,
                         'root_domains_to_subdomain': 178649,
                         'spam_score': 1,
                         'subdomain': 'moz.com',
                         'title': 'The Moz Blog [SEO] - Moz'},
              'via_redirect': False,
              'via_rel_canonical': False}]}

10. Top Pages (top_pages)
This endpoint returns top pages on a target domain.

{'next_token': 'BXULGXd3IggK',
 'results': [{'deleted_pages_to_page': 1963527,
              'deleted_pages_to_root_domain': 19022927,
              'deleted_pages_to_subdomain': 18554702,
              'deleted_root_domains_to_page': 6527,
              'deleted_root_domains_to_root_domain': 27522,
              'deleted_root_domains_to_subdomain': 27273,
              'domain_authority': 91,
              'external_indirect_pages_to_root_domain': 45290099,
              'external_nofollow_pages_to_page': 9684724,
              'external_nofollow_pages_to_root_domain': 17425478,
              'external_nofollow_pages_to_subdomain': 17269297,
              'external_pages_to_page': 14981546,
              'external_pages_to_root_domain': 69376449,
              'external_pages_to_subdomain': 68746190,
              'external_redirect_pages_to_page': 3632556,
              'external_redirect_pages_to_root_domain': 41112725,
              'external_redirect_pages_to_subdomain': 41109338,
              'http_code': 200,
              'indirect_root_domains_to_page': 10580,
              'indirect_root_domains_to_root_domain': 28779,
              'last_crawled': '2023-04-01',
              'link_propensity': 0.008849279955,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 209067,
              'nofollow_pages_to_page': 9684724,
              'nofollow_pages_to_root_domain': 17442464,
              'nofollow_pages_to_subdomain': 17285191,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 55943,
              'nofollow_root_domains_to_page': 8749,
              'nofollow_root_domains_to_root_domain': 37789,
              'nofollow_root_domains_to_subdomain': 37690,
              'page': 'moz.com/',
              'page_authority': 74,
              'pages_crawled_from_root_domain': 7872618,
              'pages_from_page': 7,
              'pages_from_root_domain': 343751,
              'pages_to_page': 15343034,
              'pages_to_root_domain': 98442581,
              'pages_to_subdomain': 97352802,
              'redirect_pages_to_page': 3633007,
              'redirect_pages_to_root_domain': 47575576,
              'redirect_pages_to_subdomain': 47570092,
              'root_domain': 'moz.com',
              'root_domains_from_page': 5,
              'root_domains_from_root_domain': 69667,
              'root_domains_to_page': 41190,
              'root_domains_to_root_domain': 179884,
              'root_domains_to_subdomain': 178649,
              'spam_score': 1,
              'subdomain': 'moz.com',
              'title': 'Moz - SEO Software for Smarter Marketing'},
             {'deleted_pages_to_page': 185579,
              'deleted_pages_to_root_domain': 19022927,
              'deleted_pages_to_subdomain': 18554702,
              'deleted_root_domains_to_page': 2440,
              'deleted_root_domains_to_root_domain': 27522,
              'deleted_root_domains_to_subdomain': 27273,
              'domain_authority': 91,
              'external_indirect_pages_to_root_domain': 45290099,
              'external_nofollow_pages_to_page': 11211,
              'external_nofollow_pages_to_root_domain': 17425478,
              'external_nofollow_pages_to_subdomain': 17269297,
              'external_pages_to_page': 424268,
              'external_pages_to_root_domain': 69376449,
              'external_pages_to_subdomain': 68746190,
              'external_redirect_pages_to_page': 348,
              'external_redirect_pages_to_root_domain': 41112725,
              'external_redirect_pages_to_subdomain': 41109338,
              'http_code': 200,
              'indirect_root_domains_to_page': 1389,
              'indirect_root_domains_to_root_domain': 28779,
              'last_crawled': '2023-04-03',
              'link_propensity': 0.008849279955,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 209067,
              'nofollow_pages_to_page': 11211,
              'nofollow_pages_to_root_domain': 17442464,
              'nofollow_pages_to_subdomain': 17285191,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 55943,
              'nofollow_root_domains_to_page': 2487,
              'nofollow_root_domains_to_root_domain': 37789,
              'nofollow_root_domains_to_subdomain': 37690,
              'page': 'moz.com/beginners-guide-to-seo',
              'page_authority': 72,
              'pages_crawled_from_root_domain': 7872618,
              'pages_from_page': 7,
              'pages_from_root_domain': 343751,
              'pages_to_page': 786960,
              'pages_to_root_domain': 98442581,
              'pages_to_subdomain': 97352802,
              'redirect_pages_to_page': 365,
              'redirect_pages_to_root_domain': 47575576,
              'redirect_pages_to_subdomain': 47570092,
              'root_domain': 'moz.com',
              'root_domains_from_page': 5,
              'root_domains_from_root_domain': 69667,
              'root_domains_to_page': 15276,
              'root_domains_to_root_domain': 179884,
              'root_domains_to_subdomain': 178649,
              'spam_score': 1,
              'subdomain': 'moz.com',
              'title': "Beginner\'s Guide to SEO [plus FREE quick start "
                       'checklist] - Moz'},
             {'deleted_pages_to_page': 7159,
              'deleted_pages_to_root_domain': 19022927,
              'deleted_pages_to_subdomain': 18554702,
              'deleted_root_domains_to_page': 1382,
              'deleted_root_domains_to_root_domain': 27522,
              'deleted_root_domains_to_subdomain': 27273,
              'domain_authority': 91,
              'external_indirect_pages_to_root_domain': 45290099,
              'external_nofollow_pages_to_page': 8605,
              'external_nofollow_pages_to_root_domain': 17425478,
              'external_nofollow_pages_to_subdomain': 17269297,
              'external_pages_to_page': 34152,
              'external_pages_to_root_domain': 69376449,
              'external_pages_to_subdomain': 68746190,
              'external_redirect_pages_to_page': 70,
              'external_redirect_pages_to_root_domain': 41112725,
              'external_redirect_pages_to_subdomain': 41109338,
              'http_code': 200,
              'indirect_root_domains_to_page': 782,
              'indirect_root_domains_to_root_domain': 28779,
              'last_crawled': '2023-04-03',
              'link_propensity': 0.008849279955,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 209067,
              'nofollow_pages_to_page': 8754,
              'nofollow_pages_to_root_domain': 17442464,
              'nofollow_pages_to_subdomain': 17285191,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 55943,
              'nofollow_root_domains_to_page': 1380,
              'nofollow_root_domains_to_root_domain': 37789,
              'nofollow_root_domains_to_subdomain': 37690,
              'page': 'moz.com/google-algorithm-change',
              'page_authority': 70,
              'pages_crawled_from_root_domain': 7872618,
              'pages_from_page': 420,
              'pages_from_root_domain': 343751,
              'pages_to_page': 35181,
              'pages_to_root_domain': 98442581,
              'pages_to_subdomain': 97352802,
              'redirect_pages_to_page': 73,
              'redirect_pages_to_root_domain': 47575576,
              'redirect_pages_to_subdomain': 47570092,
              'root_domain': 'moz.com',
              'root_domains_from_page': 60,
              'root_domains_from_root_domain': 69667,
              'root_domains_to_page': 8881,
              'root_domains_to_root_domain': 179884,
              'root_domains_to_subdomain': 178649,
              'spam_score': 1,
              'subdomain': 'moz.com',
              'title': 'Moz - Google Algorithm Update History'},
             {'deleted_pages_to_page': 33133,
              'deleted_pages_to_root_domain': 19022927,
              'deleted_pages_to_subdomain': 18554702,
              'deleted_root_domains_to_page': 1192,
              'deleted_root_domains_to_root_domain': 27522,
              'deleted_root_domains_to_subdomain': 27273,
              'domain_authority': 91,
              'external_indirect_pages_to_root_domain': 45290099,
              'external_nofollow_pages_to_page': 31500,
              'external_nofollow_pages_to_root_domain': 17425478,
              'external_nofollow_pages_to_subdomain': 17269297,
              'external_pages_to_page': 70673,
              'external_pages_to_root_domain': 69376449,
              'external_pages_to_subdomain': 68746190,
              'external_redirect_pages_to_page': 77,
              'external_redirect_pages_to_root_domain': 41112725,
              'external_redirect_pages_to_subdomain': 41109338,
              'http_code': 301,
              'indirect_root_domains_to_page': 315,
              'indirect_root_domains_to_root_domain': 28779,
              'last_crawled': '2023-04-02',
              'link_propensity': 0.008849279955,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 209067,
              'nofollow_pages_to_page': 31628,
              'nofollow_pages_to_root_domain': 17442464,
              'nofollow_pages_to_subdomain': 17285191,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 55943,
              'nofollow_root_domains_to_page': 1689,
              'nofollow_root_domains_to_root_domain': 37789,
              'nofollow_root_domains_to_subdomain': 37690,
              'page': 'moz.com/researchtools/ose/',
              'page_authority': 70,
              'pages_crawled_from_root_domain': 7872618,
              'pages_from_page': 0,
              'pages_from_root_domain': 343751,
              'pages_to_page': 344305,
              'pages_to_root_domain': 98442581,
              'pages_to_subdomain': 97352802,
              'redirect_pages_to_page': 78,
              'redirect_pages_to_root_domain': 47575576,
              'redirect_pages_to_subdomain': 47570092,
              'root_domain': 'moz.com',
              'root_domains_from_page': 0,
              'root_domains_from_root_domain': 69667,
              'root_domains_to_page': 8086,
              'root_domains_to_root_domain': 179884,
              'root_domains_to_subdomain': 178649,
              'spam_score': 1,
              'subdomain': 'moz.com',
              'title': ''},
             {'deleted_pages_to_page': 169073,
              'deleted_pages_to_root_domain': 19022927,
              'deleted_pages_to_subdomain': 18554702,
              'deleted_root_domains_to_page': 1457,
              'deleted_root_domains_to_root_domain': 27522,
              'deleted_root_domains_to_subdomain': 27273,
              'domain_authority': 91,
              'external_indirect_pages_to_root_domain': 45290099,
              'external_nofollow_pages_to_page': 7388,
              'external_nofollow_pages_to_root_domain': 17425478,
              'external_nofollow_pages_to_subdomain': 17269297,
              'external_pages_to_page': 553261,
              'external_pages_to_root_domain': 69376449,
              'external_pages_to_subdomain': 68746190,
              'external_redirect_pages_to_page': 265,
              'external_redirect_pages_to_root_domain': 41112725,
              'external_redirect_pages_to_subdomain': 41109338,
              'http_code': 200,
              'indirect_root_domains_to_page': 2219,
              'indirect_root_domains_to_root_domain': 28779,
              'last_crawled': '2023-04-02',
              'link_propensity': 0.008849279955,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 209067,
              'nofollow_pages_to_page': 7388,
              'nofollow_pages_to_root_domain': 17442464,
              'nofollow_pages_to_subdomain': 17285191,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 55943,
              'nofollow_root_domains_to_page': 1727,
              'nofollow_root_domains_to_root_domain': 37789,
              'nofollow_root_domains_to_subdomain': 37690,
              'page': 'moz.com/blog',
              'page_authority': 69,
              'pages_crawled_from_root_domain': 7872618,
              'pages_from_page': 7,
              'pages_from_root_domain': 343751,
              'pages_to_page': 906052,
              'pages_to_root_domain': 98442581,
              'pages_to_subdomain': 97352802,
              'redirect_pages_to_page': 746,
              'redirect_pages_to_root_domain': 47575576,
              'redirect_pages_to_subdomain': 47570092,
              'root_domain': 'moz.com',
              'root_domains_from_page': 5,
              'root_domains_from_root_domain': 69667,
              'root_domains_to_page': 9712,
              'root_domains_to_root_domain': 179884,
              'root_domains_to_subdomain': 178649,
              'spam_score': 1,
              'subdomain': 'moz.com',
              'title': 'The Moz Blog [SEO] - Moz'}]}

11. URL Metrics (url_metrics)
Use this endpoint to get metrics about one or more urls.

{'results': [{'deleted_pages_to_page': 1963527,
              'deleted_pages_to_root_domain': 19022927,
              'deleted_pages_to_subdomain': 18554702,
              'deleted_root_domains_to_page': 6527,
              'deleted_root_domains_to_root_domain': 27522,
              'deleted_root_domains_to_subdomain': 27273,
              'domain_authority': 91,
              'external_indirect_pages_to_root_domain': 45290099,
              'external_nofollow_pages_to_page': 9684724,
              'external_nofollow_pages_to_root_domain': 17425478,
              'external_nofollow_pages_to_subdomain': 17269297,
              'external_pages_to_page': 14981546,
              'external_pages_to_root_domain': 69376449,
              'external_pages_to_subdomain': 68746190,
              'external_redirect_pages_to_page': 3632556,
              'external_redirect_pages_to_root_domain': 41112725,
              'external_redirect_pages_to_subdomain': 41109338,
              'http_code': 200,
              'indirect_root_domains_to_page': 10580,
              'indirect_root_domains_to_root_domain': 28779,
              'last_crawled': '2023-04-01',
              'link_propensity': 0.008849279955,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 209067,
              'nofollow_pages_to_page': 9684724,
              'nofollow_pages_to_root_domain': 17442464,
              'nofollow_pages_to_subdomain': 17285191,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 55943,
              'nofollow_root_domains_to_page': 8749,
              'nofollow_root_domains_to_root_domain': 37789,
              'nofollow_root_domains_to_subdomain': 37690,
              'page': 'moz.com/',
              'page_authority': 74,
              'pages_crawled_from_root_domain': 7872618,
              'pages_from_page': 7,
              'pages_from_root_domain': 343751,
              'pages_to_page': 15343034,
              'pages_to_root_domain': 98442581,
              'pages_to_subdomain': 97352802,
              'redirect_pages_to_page': 3633007,
              'redirect_pages_to_root_domain': 47575576,
              'redirect_pages_to_subdomain': 47570092,
              'root_domain': 'moz.com',
              'root_domains_from_page': 5,
              'root_domains_from_root_domain': 69667,
              'root_domains_to_page': 41190,
              'root_domains_to_root_domain': 179884,
              'root_domains_to_subdomain': 178649,
              'spam_score': 1,
              'subdomain': 'moz.com',
              'title': 'Moz - SEO Software for Smarter Marketing'},
             {'deleted_pages_to_page': 249094,
              'deleted_pages_to_root_domain': 224212706,
              'deleted_pages_to_subdomain': 898844,
              'deleted_root_domains_to_page': 3696,
              'deleted_root_domains_to_root_domain': 177001,
              'deleted_root_domains_to_subdomain': 9251,
              'domain_authority': 95,
              'external_indirect_pages_to_root_domain': 156562794,
              'external_nofollow_pages_to_page': 163849,
              'external_nofollow_pages_to_root_domain': 72093550,
              'external_nofollow_pages_to_subdomain': 294697,
              'external_pages_to_page': 1165187,
              'external_pages_to_root_domain': 514661963,
              'external_pages_to_subdomain': 2310818,
              'external_redirect_pages_to_page': 3049,
              'external_redirect_pages_to_root_domain': 4827448,
              'external_redirect_pages_to_subdomain': 8140,
              'http_code': 301,
              'indirect_root_domains_to_page': 1439,
              'indirect_root_domains_to_root_domain': 30315,
              'last_crawled': '2023-03-31',
              'link_propensity': 0.02704063244,
              'nofollow_pages_from_page': 0,
              'nofollow_pages_from_root_domain': 97163,
              'nofollow_pages_to_page': 163881,
              'nofollow_pages_to_root_domain': 72644206,
              'nofollow_pages_to_subdomain': 294765,
              'nofollow_root_domains_from_page': 0,
              'nofollow_root_domains_from_root_domain': 22711,
              'nofollow_root_domains_to_page': 5647,
              'nofollow_root_domains_to_root_domain': 178651,
              'nofollow_root_domains_to_subdomain': 11590,
              'page': 'nytimes.com/',
              'page_authority': 82,
              'pages_crawled_from_root_domain': 13567138,
              'pages_from_page': 0,
              'pages_from_root_domain': 3152122,
              'pages_to_page': 1170498,
              'pages_to_root_domain': 763781494,
              'pages_to_subdomain': 2489707,
              'redirect_pages_to_page': 3053,
              'redirect_pages_to_root_domain': 9268395,
              'redirect_pages_to_subdomain': 14273,
              'root_domain': 'nytimes.com',
              'root_domains_from_page': 0,
              'root_domains_from_root_domain': 366864,
              'root_domains_to_page': 25307,
              'root_domains_to_root_domain': 2200598,
              'root_domains_to_subdomain': 62699,
              'spam_score': 1,
              'subdomain': 'nytimes.com',
              'title': ''}]}

12. Usage Data (usage_data)
This endpoint Returns the number of rows consumed so far in the current billing period. The count returned might not reflect rows consumed in the last hour. The count returned reflects rows consumed by requests to both the v1 (Moz Links API) and v2 Links APIs.

{'rows_consumed': 254}
```





















<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="openai-error-invalidrequesterror-this-model-s-maximum-context-length-is-4097-tokens">openai.error.InvalidRequestError: This model's maximum context length is 4097 tokens</a></div><div class="post-nav-next"><a href="ctrl-s-and-ctrl-space-amazingly-available-for-custom-vim-neovim-keyboard-shortcuts">Ctrl+S and Ctrl+Space Amazingly Available For Custom vim/NeoVim Keyboard Shortcuts</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/api/'>API</a></h4></li>
<li><h4><a href='/notebook/'>Notebook</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/label/'>Labels</a></h4></li>
<li><h4><a href='/moz/'>MOZ</a></h4></li>
<li><h4><a href='/url/'>URLs</a></h4></li>
<li><h4><a href='/github/'>Github</a></h4></li>
<li><h4><a href='/sqlite/'>SQLite</a></h4></li></ul>
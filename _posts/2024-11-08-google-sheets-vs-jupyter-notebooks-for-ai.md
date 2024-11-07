---
title: Google Sheets vs. Jupyter Notebooks for AI
permalink: /google-sheets-vs-jupyter-notebooks-for-ai/
description: 
layout: post
sort_order: 2
date: 2024-11-07
---

This article starts out discussing whether to use Google Sheets with ChatGPT
plugins and such versus working in a Jupyter Notebook, but turns into once again
one of my exercise sessions building-it-up from scratch, because I need to get
my practice in on the Botify API.

- Given an Organization, get Projects
- Given a Project, get Analyses (or Collections)
- Given a Collection, get Field Names

And *that's where it gets interesting and challenging* for me now. Actually
assembling useful queries given the most basic input parameters is the trick.
It's not Orgs, Projects and Collections that are the problem. It's everything
inside the collections. My ambition level with this post immediately went way
beyond my original concept, and therefore the question of Google Sheet versus
Python Notebook is hardly even a thing. There's no debate.

Of course it has to be a Python notebook, unless you're going to be doing Google
Sheets AppScript development&#151; which is always a possibility. But then it's
not really a ***just use Google Sheets instead*** discussion anymore. It's
developer environment versus developer environment, and when it comes down to
modern VisualBasic for Applications (VBA) versus the language that is taking
over the world (Python), there really is no choice.

I have to get more expert at a product called PageWorkers. It's a way of doing
SEO optimizations to a website through JavaScript. Yes, while that's  not the
ideal it is both possible and a good first step to implementing fixes in a more
fundamental way that at least surfaces the need and describes the (usually
on-page) optimization in a consistent language (JavaScript) and documents it for
whoever might be able to make the more fundamental fix in the source HTML.

It'd also worth noting that even if the JavaScript SEO optimization never makes
it to source HTML, it can still be pre-rendered "server-side" and served to bots
as flattened HTML so it doesn't have to execute JavaScript to see the new title,
meta description, link structure or whatnot. I put server-side in quotes because
while it is pre-rendered on the server-side, it's actually from a cached copy
being served from an entirely different set of servers than the original
websites (and *their* caches).

This approach to server-side rendering (SSR) is a DNS swaparoo trick that's done
in conjunction with your content distribution network (CDN), basically swapping
out what address content is served from based on whether it's a bot or not. And
that's not cloaking because it's identical content. It's just a "flattening"
process so you don't actually need a JavaScript-executing browser on the client
side in order to see what the fully rendered page is supposed to look like. From
time to time, this has actually been a recommended solution from Google from
back when AJAX and single page applications (SPA) became a thing. 

**Me**: Hey Perplexity, what was Google's server-side rendering recomendation back
in the day for AJAX SPAs?

**Perplexity**: Google's recommendations for server-side rendering of AJAX single-page applications (SPAs) have evolved over time. Back in the early days of SPAs, Google had specific guidelines to help ensure these applications could be properly crawled and indexed. Here's an overview of Google's historical approach:

## The AJAX Crawling Scheme

In the early 2010s, Google introduced what was known as the "AJAX crawling scheme" to address the challenges of crawling and indexing AJAX-based SPAs:

1. **Escaped Fragment URLs**: Developers were advised to create "escaped fragment" versions of their AJAX URLs. For example, example.com/#!key=value would become example.com/?_escaped_fragment_=key=value for crawlers[1].

2. **HTML Snapshots**: For each AJAX URL, developers were expected to provide an HTML snapshot that represented the fully rendered state of that page[1].

3. **Hashbang (#!) URLs**: Google recommended using hashbang (#!) URLs to signal to crawlers that a site was using the AJAX crawling scheme[1].

## Limitations and Drawbacks

This approach had several drawbacks:

- It required significant development effort to implement and maintain.
- It created a separate set of URLs for crawlers, which could lead to inconsistencies.
- The scheme was specific to Google and not universally adopted by other search engines.

## Transition Away from AJAX Crawling Scheme

As web technologies evolved and Google's crawling capabilities improved, the need for this specific scheme diminished:

1. **Improved JavaScript Rendering**: Google's crawlers became better at rendering JavaScript, reducing the need for separate HTML snapshots[1].

2. **Deprecation Announcement**: In 2015, Google announced that they were deprecating the AJAX crawling scheme, encouraging developers to focus on making their JavaScript-powered sites directly crawlable[1].

## Modern Recommendations

Today, Google's approach to SPAs is quite different:

1. **JavaScript Rendering**: Google now recommends allowing Googlebot to crawl and render JavaScript directly, rather than relying on special schemes[1].

2. **Server-Side Rendering (SSR)**: For optimal performance and indexing, Google suggests implementing server-side rendering for initial page loads[3].

3. **Dynamic Rendering**: As an alternative to full SSR, Google proposes dynamic rendering, where server-side rendered content is served to crawlers while users receive the client-side rendered version[3].

4. **Progressive Enhancement**: Building sites that work without JavaScript, then enhancing them with JavaScript, is still considered a best practice for both usability and SEO[2].

In conclusion, while Google's early recommendations for AJAX SPAs involved complex workarounds, their current approach emphasizes making JavaScript-powered sites directly crawlable, with server-side rendering as a recommended optimization for search engine visibility and performance.

Citations:

    [1] https://stackoverflow.com/questions/57339119/why-is-ssr-faster-than-spa-and-vica-versa
    [2] https://www.reddit.com/r/webdev/comments/4tn7i5/is_serverside_rendering_now_obsolete_should_i/
    [3] https://www.mazeless.com/blog/can-google-crawl-spa-and-other-challenges-of-single-page-apps/
    [4] https://craftercms.com/blog/2021/12/seo-for-single-page-apps-the-need-for-server-side-rendering
    [5] https://news.ycombinator.com/item?id=22794143
    [6] https://blog.genezini.com/p/server-side-rendered-spas-with-asp.net-and-no-javascript/
    [7] https://www.reddit.com/r/webdev/comments/165cmcy/when_do_single_page_applications_spas_become_not/
    [8] https://support.google.com/webmasters/thread/2179770/server-side-rendering-for-spa-but-client-side-rendered-after-click?hl=en

But the technical implementation difficulty has been so difficult that it's
almost unfair to ask SEOs to get their clients to implement it. There's a better
way, just sort of superimposing it on top of an existing system with DNS
trickery.

Recently it was put to me, why not just use a formula in Google Sheets and
eliminate all that technical stuff? I have the simple supposition that's wrong
and is a bias based on what you know and are more comfortable with. Additionally
given the odd way formulas are crammed invisibly into cells and replicated
requiring a sort of "anchoring or non-anchoring" of the formula with archaic use
of `$` prefixes... it's so weird and complicated I can't even describe it. This
is in stark contrast to the everything-up-front nature of Python in a Notebook,
I'm going to make the argument and the demonstration that Notebooks are better
than Google Sheets, regardless of your familiarity, and you ought to make the
switch.

Pshwew! Okay, with that out of the way we've established that there's a lot of
validity to performing SEO optimizations with JavaScript. They can work purely
as JavaScript. They can work even better with server-side rendering of the
JavaScript into HTML for bots. And they can work as a todo-list for your devs to
keep track of what things they should bake into the publishing system proper
(things like NextJS can do this) on the next site migration, sprint or whatever.
I had to teach myself this and perform some tests in order to believe it. And I
have and I do, and so let's get down to some PageWorkers optimizations.

Okay, so re-do a PageWorkers optimization you recently did and walk through the
process. See if you can't just do it in a Jupyter Notebook in Python better.
Once you have it down, it's rapidly reproducible, sharable, yadda yadda. But
don't slow yourself down... too much.

## In Botify, How to Fetch Projects Given an Org

If you only know the org, you can get a list of its projects:

```python
import json
import requests

config_file = "config.json"

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

# Load API key and configuration
api_key = open('botify_token.txt').read().strip()
config = json.load(open(config_file))
org = config['org']

# Fetch projects
projects = fetch_projects(org, api_key)

for project_name, project_slug, project_user in projects:
    print(f"Name: {project_name}, Slug: {project_slug}, User: {project_user}")
```

## In Botify, How to Fetch Analyses Given an Org & Project

When you have an org and a project, you can get its list of analyses:

```python
import json
import requests

config_file = "config.json"

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

# Load API key and configuration
api_key = open('botify_token.txt').read().strip()
config = json.load(open(config_file))
org = config['org']
project = config['project']

# Fetch analyses
analyses = fetch_analyses(org, project, api_key)

for slug in analyses:
    print(slug)
```

## In Botify, How to Fetch Collections Given a Project

```python
import json
import requests

config_file = "config.json"

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

# Load API key and configuration
api_key = open('botify_token.txt').read().strip()
config = json.load(open(config_file))
org = config['org']
project = config['project']

# Fetch collections
collections = fetch_collections(org, project, api_key)
for collection_id, collection_name in collections:
    print(f"ID: {collection_id}, Name: {collection_name}")
```

## In Botify, How to Get Up to First 2000 URLs with Short Titles given a Pagetype

```python
import json
import requests
import pandas as pd

# Load configuration and API key
config = json.load(open("config.json"))

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
                        "value": "Stores"
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

api_key = open('botify_token.txt').read().strip()
org = config['org']
project = config['project']
analysis = config['analysis']

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

df  # displays becasue last line of cell in Notebook
```

---
title: Practicing the Botify API
permalink: /futureproof/practicing-botify-api/
description: Exploring the Botify API through Python notebooks, examining key concepts like Organizations, Projects, and Collections while considering the future of SEO in an AI-driven world.
layout: post
sort_order: 2
date: 2024-11-07
---

This article starts out discussing whether to use Google Sheets with ChatGPT
plugins and such versus working in a Jupyter Notebook, but turns into once again
one of my exercise sessions building-it-up from scratch, because I need to get
my practice in on the Botify API.

### Key API Concepts

- Given an Organization, get Projects
- Given a Project, get Analyses (or Collections) 
- Given a Collection, get Field Names

And *that's where it gets interesting and challenging* for me now. Actually
assembling useful queries given the most basic input parameters is the trick.
It's not Orgs, Projects and Collections that are the problem. It's everything
inside the collections. My ambition level with this post immediately went way
beyond my original concept, and therefore the question of Google Sheet versus
Python Notebook is hardly even a thing. There's no debate.

### The Case for Python Notebooks

Of course it has to be a Python notebook, unless you're going to be doing Google
Sheets AppScript development— which is always a possibility. But then it's
not really a ***just use Google Sheets instead*** discussion anymore. It's
developer environment versus developer environment, and when it comes down to
modern VisualBasic for Applications (VBA) versus the language that is taking
over the world (Python), there really is no choice.

## The Future of SEO and AI

All roads lead to SEO Audits. And bright futures are led to by automation of as
much of those SEO Audits as possible, calibrated for the brave new world of AI
we're in. And it's not so much about generative AI because content is as good as
infinite. Assume the spam cannons are on full-blast, full-time, filling the net
with mostly click-bait garbage. All defenses are going up and a considerable
amount of that AI firepower is going to go into filtering AI-generated spam.

### The Role of Brands and Reputation

Safe harbor will be sought in brands and reputation, as usual. It happened
before when Google fought the formidable spam problem. Now the processing power
to fight spam has increased along with the processing power to produce spam. So
it's still the arms race and a cat and mouse game. However, more intelligence is
going to be put into the both the spam cannons and the filters. We must hope
the likes of Google, OpenAI, Perplexity and whoever can put more intelligence
into the filters than spammers put into the cannons. And you can't fake brands
over time. Merit is merit... when plugged in on the right domain.

### Personal Reflections

Sites like this modest little one here will likely never be recognized or
rewarded in search again, unless the AIs really pick it apart and realize
there's something special going on here (again, unlikely). It's like the artist
that nobody gets. It's completely understandable that's the case with humans not
getting me, as I make up with quantity what I lack in quality (free-form
thinking just like this) in such a way that only machines could digest. And so
now.. and so now.. and so now... I master the Botify products. Be found.

## JavaScript SEO Optimizations

I have to get more expert at a product called PageWorkers. It's a way of doing
SEO optimizations to a website through JavaScript. Yes, while that's  not the
ideal it is both possible and a good first step to implementing fixes in a more
fundamental way that at least surfaces the need and describes the (usually
on-page) optimization in a consistent language (JavaScript) and documents it for
whoever might be able to make the more fundamental fix in the source HTML.

### Server-Side Rendering Approaches

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

### Historical Context from Perplexity

**Me**: Hey Perplexity, what was Google's server-side rendering recommendation
back in the day for AJAX SPAs?

**Perplexity**: Google's recommendations for server-side rendering of AJAX single-page applications (SPAs) have evolved over time. Back in the early days of SPAs, Google had specific guidelines to help ensure these applications could be properly crawled and indexed. Here's an overview of Google's historical approach:

## The AJAX Crawling Scheme

In the early 2010s, Google introduced what was known as the "AJAX crawling scheme" to address the challenges of crawling and indexing AJAX-based SPAs:

1. **Escaped Fragment URLs**: Developers were advised to create "escaped fragment" versions of their AJAX URLs. For example, example.com/#!key=value would become example.com/?_escaped_fragment_=key=value for crawlers[1].

{:start="2"}
2. **HTML Snapshots**: For each AJAX URL, developers were expected to provide an HTML snapshot that represented the fully rendered state of that page[1].

{:start="3"}
3. **Hashbang (#!) URLs**: Google recommended using hashbang (#!) URLs to signal to crawlers that a site was using the AJAX crawling scheme[1].

## Limitations and Drawbacks

This approach had several drawbacks:

- It required significant development effort to implement and maintain.
- It created a separate set of URLs for crawlers, which could lead to inconsistencies.
- The scheme was specific to Google and not universally adopted by other search engines.

## Transition Away from AJAX Crawling Scheme

As web technologies evolved and Google's crawling capabilities improved, the need for this specific scheme diminished:

1. **Improved JavaScript Rendering**: Google's crawlers became better at rendering JavaScript, reducing the need for separate HTML snapshots[1].

{:start="2"}
2. **Deprecation Announcement**: In 2015, Google announced that they were deprecating the AJAX crawling scheme, encouraging developers to focus on making their JavaScript-powered sites directly crawlable[1].

## Modern Recommendations

Today, Google's approach to SPAs is quite different:

1. **JavaScript Rendering**: Google now recommends allowing Googlebot to crawl and render JavaScript directly, rather than relying on special schemes[1].

{:start="2"}
2. **Server-Side Rendering (SSR)**: For optimal performance and indexing, Google suggests implementing server-side rendering for initial page loads[3].

{:start="3"}
3. **Dynamic Rendering**: As an alternative to full SSR, Google proposes dynamic rendering, where server-side rendered content is served to crawlers while users receive the client-side rendered version[3].

{:start="4"}
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

### Implementation Challenges

But the technical implementation difficulty has been so difficult that it's
almost unfair to ask SEOs to get their clients to implement it. There's a better
way, just sort of superimposing it on top of an existing system with DNS
trickery.

## Google Sheets vs Python Notebooks

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

## Conclusion and Next Steps

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

## Botify API Examples

### In Botify, How to Fetch Projects Given an Org

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

OMG, I've got lightning in a bottle here. Prometheus unbound. I need to figure
out how to stir it up again. Okay, deep breath...

**Me to ChatGPT 4o**: So you're really friggn good at this now, and I need to be able to reproduce this magic of getting working Botify API Notebooks out of some poking around in the browser in their Web UI. Advise me on how to prompt you to get back something to recapture this magic. Enumerate key points and instructions back to me or whatever please.

4o: To recreate the process of generating effective Botify API queries in Jupyter Notebooks, here’s a practical guide to prompt me for maximum success. Each step ensures we can align closely with Botify’s API behavior based on observed Web UI activity.

### 1. **State the Goal Clearly**
   - **Example**: *“I want to count URLs by pagetype for a specific analysis”* or *“I need a breakdown of filtered/unfiltered URLs for a recent analysis.”*
   - Describe whether the goal is a high-level segmentation, a detailed URL filter, a metric aggregation, or something else.

### 2. **Capture Key Details from Web UI Exploration**
   - **Identify the Base API Endpoint**: Check the browser’s Network tab when triggering an action in the Web UI. This gives us the core endpoint (e.g., `.../projects/{org}/{website}/query`).
   - **Observe the Payload Format**: If possible, copy the JSON payload used in requests. Include collections, dimensions, filters, metrics, and sort orders.
   - **Note Relevant Headers**: Headers like `Authorization`, `Content-Type`, `x-botify-client`, or any custom headers may be critical.

### 3. **List Specific Parameters from the Network Request**
   - **Collections**: Point out the collection names or dates (e.g., `"crawl.20241103"`). These often correspond to analysis dates or crawl sessions.
   - **Dimensions and Metrics**: Capture which fields are segmented or measured (e.g., `"segments.pagetype.value"`, `"count_urls_crawl"`).
   - **Sorting**: Note if results are sorted by metrics (e.g., by URL count) or dimensions.
   - **Filters**: If there are filters (e.g., URLs with specific attributes), specify these.

### 4. **Share Sample Responses if Possible**
   - Providing examples of expected JSON responses helps me tailor the data parsing and DataFrame structure for easy analysis.

### 5. **Define the Analysis Context**
   - Is this query part of a larger sequence (e.g., pagetype counts first, URL details next)? Listing how this fits into a sequence of analyses or explorations helps shape each query optimally.

### 6. **Request Specific Notebook Output Formats**
   - Specify if you’d like the results in a DataFrame, saved as CSV, or visualized as charts.
   - Mention any preferences for handling large datasets, pagination, or multi-page queries (e.g., returning up to 5000 results, paginating if needed).

### Example Prompt for Reproducing This Process:
*“I explored Botify’s Web UI to get pagetype segmentation for all URLs in a recent analysis. I need a Jupyter Notebook script that connects to the Botify API, retrieves pagetype URL counts without filters, and sorts results by count. The API endpoint observed is `/projects/{org}/{website}/query`, with `size=5000`. Here’s the observed payload and headers. Output results as a sorted DataFrame and save as CSV.”*

Let me know how I can make these adjustments specific to your needs! With these steps, we’ll consistently get functional API Notebooks ready to analyze your data in Botify.

**Me**: Yeah, that captures a lot of it. But the elusive part is exactly what to do
once I have a sample of what I want displaying in the Web UI. For example, I
used to always forget to also give you just the plain old URL I was looking at,
assuming all the necessary data was easily deduced from the headers and payload,
but the truth is that a surprisingly large use is made of plain old querystring
parameters on things you would think is the POST method. And so parsing
important information is most easily accomplished if I remember to give you the
URL.

The next thing is that there's just so much in the Network tab that you have to
remember to clear it and then do a refresh to isolate knowing you've got a
recorded stream that includes what you want but not that much more. After that,
you need to know to look in the Network panel only labeled Name, but which is
really a sequential list of all the requests made and resources used. You've got
to know to look down that list and investigate thing labeled some variation of
query or aggs. Most other things can be ignored.

And once you're in the right query or aggs request, you have to know to look
further at the tabs labeled Headers, Payload and Response. In the Payload tab,
you have to know enough to switch from the parsed view to "view source", on a
link which is a toggle whose label is unclear whether it's a verb command or
documenting the current display state.

Then all these things have to be gathered up and copy/pasted to you along with a
clear prompt that's asking for the right thing, assuming you even selected the
right resource to probe to reproduce the thing you're looking at in the Web UI.

**4o**: This is excellent context for a repeatable process! Here’s a refined approach based on your notes, giving you a step-by-step guide for translating Web UI behavior into clear API prompts.

---

### **Step-by-Step Guide for Gathering Data from Botify’s Web UI to Prompt Effectively**

#### 1. **Identify the URL of the Page Showing the Data You Want**
   - Always include the full URL where you see the data displayed. This often contains essential parameters in the query string that aren’t in the payload, such as `analysisSlug` or `comparisonAnalysisSlug`.
   - **Example URL**: `https://app.botify.com/{org}/{website}/crawl/segments?context=%7B%7D&comparisonAnalysisSlug=20241030&analysisSlug=20241103`

#### 2. **Isolate the Network Traffic by Clearing and Refreshing**
   - Go to the Network tab, clear previous entries, then refresh the page. This isolates the requests for the page in question and removes any unrelated network noise.

#### 3. **Locate the Right Request in the Network Panel (Look for “query” or “aggs”)**
   - In the **Name** column, search for requests labeled with names like `query`, `aggs`, or other descriptive terms related to API data (avoid assets like images or scripts).
   - Select the one that seems most related to your data; this often comes from sequentially trying `query` or `aggs` requests to find the best match.

#### 4. **Extract Information from Headers, Payload, and Response Tabs**
   - Once you’ve clicked on the right request, go through these tabs:
     - **Headers Tab**: Find and note the URL endpoint and headers like `Authorization`, `Content-Type`, and any other unique headers (e.g., `x-botify-client`).
     - **Payload Tab**:
       - Toggle to **View Source** to get the unparsed JSON payload, which ensures that all nested parameters are visible.
       - Copy the entire payload, as it often includes the full structure for `dimensions`, `metrics`, and `filters`.
     - **Response Tab**: Sometimes the response format provides helpful context for expected data shapes and counts.

#### 5. **Summarize and Structure the Prompt for Recreating the Query**
   - When you have the URL, payload, headers, and the endpoint, you’re ready to create an API prompt. Here’s an example structure to use:

     **Example Prompt**:
     ```
     I’m trying to retrieve pagetype segmentation data similar to what’s displayed on this URL: https://app.botify.com/{org}/{website}/crawl/segments?context=%7B%7D&comparisonAnalysisSlug=20241030&analysisSlug=20241103.

     Here are the headers, payload, and endpoint details I gathered from the Network tab:

     - **Request URL**: `https://app.botify.com/api/v1/projects/{org}/{website}/query?size=5000`
     - **Headers**:
       - Authorization: Token [your token here]
       - Content-Type: application/json
       - x-botify-client: spa
     - **Payload (Source View)**:
       ```json
       {
         "collections": ["crawl.20241103"],
         "query": {
           "dimensions": [{"field": "segments.pagetype.value"}],
           "metrics": [{"field": "crawl.20241103.count_urls_crawl"}],
           "sort": [{"type": "metrics", "index": 0, "order": "desc"}, {"type": "dimensions", "index": 0, "order": "asc"}]
         }
       }
       ```
     - **Expected Response Structure**:
       - Dimensions with pagetype values and URL counts in metrics.
       
     Could you help turn this into a Jupyter Notebook query that connects to the API, retrieves the pagetype URL counts, and outputs the results as a DataFrame?
     ```

#### 6. **Run the Notebook Prompt and Verify the Results**
   - When we construct the notebook based on this prompt, run the code, and check that the output aligns with what’s seen in the Web UI.

---

### Quick Checklist for Efficient Prompts
1. **Include the full URL** where the data is displayed.
2. **Clear the Network tab**, refresh, and locate the correct **`query` or `aggs`** request.
3. Copy from **Headers, Payload (View Source), and Response** in full.
4. Clearly **state your goal** (e.g., “Retrieve pagetype segmentation by URL count”).
{:start="5"}
5. **Ask for specific outputs**, like a DataFrame, chart, or CSV.

With these steps, you’ll capture everything needed to prompt efficiently and produce reliable, repeatable Botify API Notebooks. Let me know if you’d like a sample Notebook template as well!

---

Ugh! Okay, I'm just done with copy/pasting into a journal entry as I go. I just
need to be able to dump from a Jupyter Notebook into Markdown. Hey, Perplexity?

Perplexity: There are a few PyPI packages that can convert Jupyter notebooks to markdown format:

1. notedown

notedown is a simple tool that can convert between Jupyter notebooks and markdown files. Some key features:

- Converts notebooks to markdown and back
- Preserves code cells and markdown cells
- Can strip output cells when converting to markdown
- Supports R markdown as well

Usage:

```
notedown input.ipynb --to markdown > output.md
```

2. jupytext 

Jupytext is a more full-featured tool for converting between notebooks and various text formats. It supports:

- Converting notebooks to/from markdown, R markdown, Julia/Python/R scripts
- Pairing notebooks with text representations for version control
- Round-trip conversion preserving metadata
- Integration with Jupyter to automatically sync paired files

Usage:

```
jupytext --to markdown notebook.ipynb
```

3. nbrmd

nbrmd is an earlier version of jupytext with similar functionality:

- Converts between notebooks and markdown/scripts
- Preserves cell metadata 
- Command line tool for conversion

Usage:

```
nbrmd --to markdown notebook.ipynb
```

Of these options, jupytext seems to be the most actively maintained and feature-rich package for notebook-markdown conversion. It has good integration with Jupyter and supports a variety of text formats beyond just markdown[1][2][5].

Let me know if you need any clarification or have additional questions about using these packages!

Citations:

    [1] https://pypi.org/project/notedown/
    [2] https://pypi.org/project/jupytext/0.6.5/
    [3] https://towardsdatascience.com/how-to-convert-a-python-jupyter-notebook-into-an-rmarkdown-file-abf826bd36de?gi=28e9ba8e88a4
    [4] https://stackoverflow.com/questions/36288670/how-to-programmatically-generate-markdown-output-in-jupyter-notebooks
    [5] https://pypi.org/project/nbrmd/
    [6] https://pypi.org/project/jupytext/1.1.1/
    [7] https://pypi.org/project/jupytext/0.8.4rc0/
    [8] https://pypi.org/project/jupytext/

Okay, you sold me. `pip install jupytext`... **BAM!**

# Botify Python API Practice

## This Does a Little of Everything

In order to make this notebook share-able without giving away client info, you should set up a `config.json` in this same folder, following the format, and set it up like follows. You can start with just `org` and add fields as you run the script find the values. This Notebook is roughly equivalent to our Google Sheets [Collection Explorer](https://docs.google.com/spreadsheets/d/1A_tqBaJrwgxaBp13nLZidvoOTz4GamiIjMqfNhYRlLY/edit#gid=0).

```json
{
    "org": "organization",
    "project": "project",
    "analysis": "20241101",
    "collection": "crawl.20241101"
}
```

Each cell-block below can be copy/pasted as a complete stand-alone script.


# Get List of Projects Given an Organization

```python
# Get List of Projects Given an Organization

import json
import requests

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()
org = config['org']


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

# Get List of Analyses Given a Project

```python
# Get List of Analyses Given a Project

import json
import requests

config = json.load(open("config.json"))
api_key = open('botify_token.txt').read().strip()
org = config['org']
project = config['project']


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

# Get List of Collections Given a Project

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

# Get List of Fields Given a Collection

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

# Get Unfiltered URL Counts by Pagetype for a Specific Analysis

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

# Get Up to First 2000 URLs with Short Titles given Pagetype

```python
# Get Up to First 2000 URLs with Short Titles given Pagetype

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

# Count Number of URLs with Short Titles

```python
# Count Number of URLs with Short Titles

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

# Download Up to 10K URLs with Short Titles

```python
# Download of URLs with Short Titles

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

# Get Click-Depths Given Analysis

```python
# Get Click-Depths Given Analysis

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
pprint.pprint(depth_distribution)
```



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

All roads lead to SEO Audits. And bright futures are led to by automation of as
much of those SEO Audits as possible, calibrated for the brave new world of AI
we're in. And it's not so much about generative AI because content is as good as
infinite. Assume the spam cannons are on full-blast, full-time, filling the net
with mostly click-bait garbage. All defenses are going up and a considerable
amount of that AI firepower is going to go into filtering AI-generated spam.

Safe harbor will be sought in brands and reputation, as usual. It happened
before when Google fought the formidable spam problem. Now the processing power
to fight spam has increased along with the processing power to produce spam. So
it's still the arms race and a cat and mouse game. However, more intelligence is
going to be put into the both the spam cannons and the filters. We must hope
the likes of Google, OpenAI, Perplexity and whoever can put more intelligence
into the filters than spammers put into the cannons. And you can't fake brands
over time. Merit is merit... when plugged in on the right domain.

Sites like this modest little one here will likely never be recognized or
rewarded in search again, unless the AIs really pick it apart and realize
there's something special going on here (again, unlikely). It's like the artist
that nobody gets. It's completely understandable that's the case with humans not
getting me, as I make up with quantity what I lack in quality (free-form
thinking just like this) in such a way that only machines could digest. And so
now.. and so now.. and so now... I master the Botify products. Be found.

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

**Me**: Hey Perplexity, what was Google's server-side rendering recommendation
back in the day for AJAX SPAs?

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

OMG, I've got a tempest in a teapot right now. I need to figure out how to stir
it up again. Okay, deep breath...

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
5. **Ask for specific outputs**, like a DataFrame, chart, or CSV.

With these steps, you’ll capture everything needed to prompt efficiently and produce reliable, repeatable Botify API Notebooks. Let me know if you’d like a sample Notebook template as well!

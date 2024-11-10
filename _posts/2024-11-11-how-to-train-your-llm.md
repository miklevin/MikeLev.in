---
title: How To Train Your LLM
permalink: /how-to-train-your-llm/
description: 
layout: post
sort_order: 2
date: 2024-11-10
---

## Today’s Mission: Bringing It All Together

Today is the day I bring it all together.

- I have a new web framework I built on **FastHTML** that lets me do web dev without the usual allergic reaction.
- The web framework runs alongside a **local LLM** under Ollama, tuned into every move.
- I’ve set up a Matrix-like **“Kung Fu download”** process that makes the LLM an expert on what it needs when it needs it.
- I have the actual **Kung Fu downloads** ready to make big cloud AIs capable enough to help me.
- I have **sample websites** prepared to visualize (the sample input data).

## Organizing File Naming and Structure

Time to tackle file naming and organization. Sexy, I know, but this kind of project can spiral out of control fast if files end up scattered, lumped into one directory, or following a messy naming convention. Excessively deep file paths? No thanks—a database? Nope, the **filesystem is a database** for many use cases like this.

The visualizer will need a couple of **.csv** files per visualization, which can go into a single folder per client. Clients, however, need to be kept separate, and different projects within each client need clear separation. Luckily, the `org` and `project` input fields of the app provide the perfect structure for directory creation.

So, a `downloads` directory is a must. The link-graph visualization app will live there, but since the web server hosts multiple apps, each app will need a dedicated subfolder in `downloads`. So far, we’ve got:

    downloads / link_graph / org / project

I’m tempted to add an `analysis` folder next, but I think drilling down to the project level is enough. Crawls are often monthly, yielding two files per crawl, so even 24 files per year is manageable. Since this is a local app living on each person’s desktop (similar to apps like VSCode or Slack), it’s unlikely any folder will grow unwieldy over time. Plus, this setup is optimal for people who want to browse the files directly.

## Choosing the Right Python Execution Context

Now, coding brings an interesting choice with four Python coding and execution contexts in play. Ideally, I’d consolidate, but each serves a unique purpose.

### 1. Cursor AI and Claude

Cursor AI recently got under my skin. I despise VSCode with a passion—especially that fuzzy-search file navigation on the left panel—but Cursor AI with Anthropic’s Claude is just too useful to ignore. It’s a productivity accelerator, even for a devout vim-head like me. And yes, I tried Copilot in NeoVim, but it’s not the same.

### 2. Jupyter Notebooks

Then there’s Jupyter Notebooks, which I used to despise but now grudgingly accept. Not Google Colab—I’m keeping an open mind, but it’s not my go-to. Instead, I use local JupyterLab, which offers a few extra tricks beyond the classic Jupyter interface. It’s great for testing, rapid prototyping, and experimenting with Jupyter AI. This is where I make the Kung Fu downloads.

### 3. The Command Line

Running things from the command line is crucial. If you’re not occasionally typing `python filename.py`, you’re not future-proofing yourself. The command line rules all—it’s how every AI ultimately launches. And it’s universal: Mac’s default terminal, Linux’s shell, and Windows’s WSL. IDEs use it behind the scenes, and it forces you to confront Python’s path issues.

### 4. The Web App Server

Lastly, there’s the web app itself: a long-running `server.py` script. All computer services are essentially busy loops, running `while true` logic with a mechanism to manage clock cycles. Nothing truly “wakes up”; even schedulers are just busy loops. In this context, coding is different because you’re dealing with a constantly running process that intermittently runs the specific code you’re working on. 

Today is about nailing down this structure, fine-tuning these contexts, and hitting the weekend’s final lap. It’s a full system setup, from file organization to runtime optimization, all leading toward a seamless, future-proofed project.

> These four paths to Python code  
> Keep me moving on the road  
> Towards a place where there may be  
> A wizard in a green city.  

## The Context for Running Python Code

Of course, the last context for running Python code is where I’m going with this, especially given that I’ve tentatively titled this article ***How to Train Your LLM***. The “long-running-ness” of the server or service is what gives your LLM extended and relevant conversation context.

### Checking on Conversation Persistence

Usually, this is the point where I’d ask Perplexity to fill in one of my knowledge gaps. In this case, I’m wondering if the Ollama server running in the background to host the LLM can maintain conversation context through the HTTP API without requiring the entire conversation history to be fed in every time. When you run Ollama directly from the command line with its built-in terminal interface, it stores per-session conversation history that you can deliberately save and reload, picking up where you left off. That’s clever, but it suggests that similar persistence might be possible when using it as a service through HTTP—though I’m not convinced. I need to check with Perplexity and perhaps look into the Ollama site for clarity.

### Managing Your Own Conversation History

This isn’t about refactoring for its own sake. It’s good practice to manage your own conversation histories instead of relying on service-provided capabilities that may lack transparency or control. Relying solely on built-in conversation persistence isn’t future-proofing. You also want the flexibility to swap out Ollama as the local LLM-hosting web server in the future. Loosely coupled APIs should be the rule, with the human as the glue between them. 

### The Langchain Debate and Practicality

This philosophy is why I’ve avoided `Langchain` so far. I’ll probably cave eventually, just as I now use the `Requests` package in Python. If `Requests` weren’t so mainstream, I’d resist that too, but having traveled the longer path a few times, I know what a shortcut really means. 

Anyhoo… hey, Perplexity, tell me: what’s the story with Ollama’s conversation persistence capabilities outside its terminal interface? Are there any?

**Perplexity**: Ollama's conversation persistence capabilities outside its terminal interface are limited. When interacting with Ollama through its HTTP API, you generally need to manage conversation history yourself. Here's what you need to know:

## API Interaction

When using Ollama's HTTP API, there are two main endpoints for generating responses:

1. `/api/generate`
2. `/api/chat`

### Generate Endpoint

The `/api/generate` endpoint is stateless and doesn't maintain conversation context by default. You need to pass the entire conversation history with each request to maintain context[1].

### Chat Endpoint

The `/api/chat` endpoint, introduced in newer versions of Ollama, is designed to be more similar to other chat APIs. It accepts an array of messages, allowing you to maintain conversation history more easily[3].

## Context Management

Unlike some other AI APIs, Ollama's API is stateful and works by passing a growing context vector back and forth along with the latest prompt[5]. This means:

- The server maintains some state, but it's primarily based on what you send in each request.
- You need to manage and send the relevant conversation history with each API call to maintain context.

## Best Practices

To maintain conversation persistence when using Ollama's HTTP API:

1. **Store conversation history**: Keep track of all messages (both user inputs and model responses) in your application.

2. **Send relevant history**: With each new request, send the appropriate portion of the conversation history along with the new prompt.

3. **Use the chat endpoint**: For more straightforward conversation management, prefer the `/api/chat` endpoint over `/api/generate` when possible.

4. **Handle context limits**: Be aware of the model's context window size and trim conversation history as needed to avoid exceeding it.

By following these practices, you can achieve conversation persistence similar to what you experience in Ollama's terminal interface, but with more control and flexibility in your application.

Citations:

    [1] https://sourcegraph.com/blog/local-chat-with-ollama-and-cody
    [2] https://docs.spring.io/spring-ai/reference/api/chat/ollama-chat.html
    [3] https://www.youtube.com/watch?v=QUJHEvCqhdw
    [4] https://www.reddit.com/r/ollama/comments/1g3nxup/how_to_maintain_chat_sessions/
    [5] https://github.com/karthink/gptel/issues/279
    [6] https://stackoverflow.com/questions/78516807/ollama-how-to-inject-context-or-get-model-to-answer-based-on-context
    [7] https://github.com/ollama/ollama/blob/main/docs/api.md?plain=1
    [8] https://community.home-assistant.io/t/ollama-ha-and-offloading-all-the-work-like-networkchuck-but-it-doesnt-work/790692

Like I thought, I'm on the right track. Manage it yourself. Langchain not
required until it is. Nice. Okay... deep breath...

Wait, wait! Not jumping in just yet. Think through the role of each Python
execution context.

The Jupyter Notebook is where the fruit of yesterday's labor accumulated up.
Specifically, all into a single notebook. The 1-and-only-1 recipient now of all
my Botify Kung Fu knowledge. I collect and curate everything I know about the
Botify BQL there. There is a [Botify Developers
Portal](https://developers.botify.com/) full of information, and I'm not giving
out anything proprietary. It's just that for whatever reason, the frontier model
LLMs like ChatGPT, Claude and Gemini that can help with the complex coding
issues that are BQL are clueless. So I put it all on one Notebook, convert that
notebook to ***markdown*** (and HTML) and [plant it
here](https://mikelev.in/api/) so that it's always at my fingertips. Keep
expanding that! Keep cleaning and curating. Keep it one-page so there is only
ever one place to look for it. Keep it live-code in a Notebook so I can always
test-run it. Keep each cell working independently from the others, so it's
effectively a stacked set of standalone Notebook examples. I open with this,
because I'm about to glue together a lot of parts that exist in here now, and
I'm going to use it as intended for LLM assistance on gluing together the parts
for running under the other Python contexts.

And this reminds me. It's one tiny sub-project to improve this documentation,
but the iron is very, very hot from yesterday's work and if I don't grab for
this one particular prize, I will be sorry. Ahem...

Claude, given this @botify-api.md, and this
@https://developers.botify.com/docs/migrating-from-bqlv1-to-bqlv2 please give me
an expansion to the former explaining how to do the later, given a BQLv1 query.
In other words, write me detailed instructions an LLM could use to convert a
BQLv1 query into a BQLv2 query. Please pay particular attention to the final
examples on the markdown file in how they have validation code against fields. I
would like it to be full XML-ish well-formed checkers and validators, but I will
accept 80% of the way there, because I know you can't know everything. So in
essence, I'm asking for a pragmatic first-pass guide on taking something that
looks like this...

```python
# Data payload for the BQLv1 query
data_payload_v1 = {
    "filters": {
        "predicate": "lte",
        "value": max_depth,
        "field": "depth"
    },
    "fields": [
        "url",
        "outlinks_internal.graph.url",
        "depth"
    ],
    "sort": []
}
```

...and make it look like this...

```python
# Data payload for the BQLv2 query
data_payload_v2 = {
    "job_type": "export",
    "payload": {
        "username": org,
        "project": project,
        "connector": "direct_download",
        "formatter": "csv",
        "export_size": 10000,
        "query": {
            "collections": [f"crawl.{analysis}"],
            "query": {
                "dimensions": [
                    "url",
                    f"crawl.{analysis}.outlinks_internal.graph.url",
                    f"crawl.{analysis}.depth"
                ],
                "metrics": [],
                "filters": {
                    "field": f"crawl.{analysis}.depth",
                    "predicate": "eq",
                    "value": max_depth
                }
            }
        }
    }
}
```

Yes, I know whether it's the download version of the payload or the list version
adds some complication. Actually favor the list-version for simplicity, but this
is the example I had onhand. Again, get all the pertinents from the markdown
file.

...and BAM! Now I have a BQLv1 to BQLv2 guide:

# Converting BQLv1 to BQLv2: A Detailed Guide

This guide provides a structured approach to converting BQLv1 queries to BQLv2, including validation helpers and common patterns. The validation functions ensure proper formatting and structure while the conversion function handles the basic transformation logic.

## Step-by-Step Conversion Process

### 1. Basic Structure Transformation

BQLv1 queries have this basic structure:
```python
{
    "fields": [...],
    "filters": {...},
    "sort": [...]
}
```

BQLv2 queries follow this structure:
```python
{
    "collections": [f"crawl.{analysis}"],
    "query": {
        "dimensions": [...],
        "metrics": [...],
        "filters": {...},
        "sort": [...]
    }
}
```

### 2. Field Mapping Rules

1. **Collections Setup**:
   - Add `"collections": [f"crawl.{analysis}"]` at the root level
   - If comparing crawls, add both: `["crawl.{current}", "crawl.{previous}"]`

2. **Fields to Dimensions**:
   ```python
   # BQLv1
   "fields": ["url", "depth"]
   
   # BQLv2
   "dimensions": [
       f"crawl.{analysis}.url",
       f"crawl.{analysis}.depth"
   ]
   ```

3. **Filter Translation**:
   ```python
   # BQLv1
   "filters": {
       "field": "depth",
       "predicate": "lte",
       "value": max_depth
   }
   
   # BQLv2
   "filters": {
       "field": f"crawl.{analysis}.depth",
       "predicate": "lte",
       "value": max_depth
   }
   ```

### 3. Special Cases

#### Previous Crawl References
```python
# BQLv1
"fields": ["url", "previous.http_code"]

# BQLv2
"collections": [f"crawl.{current}", f"crawl.{previous}"],
"dimensions": [
    f"crawl.{current}.url",
    f"crawl.{previous}.http_code"
]
```

#### Area Filters
For "new" URLs:
```python
"filters": {
    "and": [
        {
            "field": f"crawl.{current}.url_exists_crawl",
            "value": true
        },
        {
            "field": f"crawl.{previous}.url_exists_crawl",
            "value": false
        }
    ]
}
```

For "disappeared" URLs:
```python
"filters": {
    "and": [
        {
            "field": f"crawl.{current}.url_exists_crawl",
            "value": false
        },
        {
            "field": f"crawl.{previous}.url_exists_crawl",
            "value": true
        }
    ]
}
```

### 4. Validation Helper Functions

```python
def validate_bql_v2_query(query):
    """Validate BQLv2 query structure and field formatting."""
    required_keys = {'collections', 'query'}
    query_keys = {'dimensions', 'metrics', 'filters'}
    
    # Check top-level structure
    if not all(key in query for key in required_keys):
        raise ValueError(f"Missing required keys. Must have: {required_keys}")
    
    # Check query structure
    if not any(key in query['query'] for key in query_keys):
        raise ValueError(f"Query must contain at least one of: {query_keys}")
    
    # Validate collections format
    for collection in query['collections']:
        if not collection.startswith('crawl.'):
            raise ValueError(f"Invalid collection format: {collection}")
    
    # Validate dimensions format
    if 'dimensions' in query['query']:
        for dim in query['query']['dimensions']:
            if not any(dim.startswith(f"{c}.") for c in query['collections']):
                raise ValueError(f"Invalid dimension format: {dim}")
    
    return True

def convert_bql_v1_to_v2(query_v1, analysis):
    """Convert BQLv1 query to BQLv2 format."""
    query_v2 = {
        "collections": [f"crawl.{analysis}"],
        "query": {
            "dimensions": [],
            "metrics": [],
            "filters": {}
        }
    }
    
    # Convert fields to dimensions
    if 'fields' in query_v1:
        query_v2['query']['dimensions'] = [
            f"crawl.{analysis}.{field}" for field in query_v1['fields']
        ]
    
    # Convert filters
    if 'filters' in query_v1:
        filter_v1 = query_v1['filters']
        query_v2['query']['filters'] = {
            "field": f"crawl.{analysis}.{filter_v1['field']}",
            "predicate": filter_v1['predicate'],
            "value": filter_v1['value']
        }
    
    # Validate the converted query
    validate_bql_v2_query(query_v2)
    
    return query_v2
```

### 5. Usage Example

```python
# Example BQLv1 query
query_v1 = {
    "fields": ["url", "depth"],
    "filters": {
        "field": "depth",
        "predicate": "lte",
        "value": 3
    }
}

# Convert to BQLv2
analysis = "20240308"
query_v2 = convert_bql_v1_to_v2(query_v1, analysis)

# Result:
{
    "collections": ["crawl.20240308"],
    "query": {
        "dimensions": [
            "crawl.20240308.url",
            "crawl.20240308.depth"
        ],
        "metrics": [],
        "filters": {
            "field": "crawl.20240308.depth",
            "predicate": "lte",
            "value": 3
        }
    }
}
```

I really couldn't say (yet) how accurate it got the validation parts of this,
but I know it was looking at code with working validation so I'm hopeful. It
will all be vetted live while in use, haha! But I have plenty of sample data to
test it on. The Botify Web UI will give BQLv1 sample code for automation, but
not BQLv2. This was a show-stopper for me for awhile, because BQLv1 burned
through my daily employee quotas while BQLv2 didn't, but I could only get code
examples in the former, and found the later impossible to write... haha! This is
deep nerd irony, and this is how a nerd responds. BAM! Now I've got a converter.

...and it's wrapped into the thing that trains the frontier-model LLMs like
ChatGPT, Claude, Gemini and Perplexity in general, and helps me with per-session
jobs I need to do in particular by providing the on-demand kung fu expertise
download. It's win, win, win, win... and probably a few more wins.

Ugh! Okay, so I'm expanding the logic that harvests good link-graph
visualization candidates. It's a long-running app with a growing-list and
growing-csv-file output. I never want to re-process things that are already
there, but I want to be able to put new things in freely. I use the text-file to
put the new things in with a simple parent/child-indenting system, even easier
than YAML files because I don't want things like pesky colons to complicate
matters. I add new things on this list. The process runs and adds qualifying
child items. 

I find myself bopping between these different Python code execution contexts
based on their strengths and my needs. I wish it was unified, but different
tools have different strengths and you just have to live with that and lean into
them, paying for the advantage such an approach provides (good tool-yield) with
a little bit of cognitive overhead cost. But you reduce the cognitive overhead
so much in so many places that you can afford it. I feel like I have finally
reached that point.

Ugh, okay so I finally have a good-input job harvester I'm happy with...

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
DELAY_BETWEEN_PAGES = 2
DELAY_BETWEEN_PROJECTS = 3
DELAY_BETWEEN_ORGS = 4

output_csv = 'projects_with_multiple_analyses.csv'
progress_pickle = 'progress.pkl'

def load_existing_config(file_path):
    """Load organizations and projects from candidates.txt, preserving structure."""
    orgs_with_projects = {}
    current_org = None
    with open(file_path, 'r') as file:
        for line in file:
            if not line.startswith(" ") and line.strip():  # Top-level orgs
                current_org = line.strip()
                orgs_with_projects[current_org] = []
            elif line.startswith(" ") and current_org:  # Projects under an org
                orgs_with_projects[current_org].append(line.strip())
    return orgs_with_projects

def fetch_projects(org):
    """Fetch projects for a given organization with pagination."""
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
            url = data.get('next')
            print(f"  Fetched {len(all_projects)} projects for '{org}'")
            time.sleep(DELAY_BETWEEN_PAGES)
        except requests.HTTPError as e:
            if response.status_code == 404:
                print(f"  Skipping '{org}': {e}")
            else:
                print(f"  Error fetching projects for '{org}': {e}")
            return []
        except requests.RequestException as e:
            print(f"  Network or other error for '{org}': {e}")
            break
    
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
            return len(analyses), analyses[0]['slug']
    except requests.RequestException as e:
        print(f"    Error fetching analyses for project '{project_slug}' in '{org}': {e}")
    return None, None

def load_existing_data(csv_path, config_path):
    """Load both CSV and config data into sets for quick lookup."""
    # Load CSV data
    if os.path.exists(csv_path):
        existing_df = pd.read_csv(csv_path)
        output_data = existing_df.to_dict('records')
        existing_projects = set((row['Organization'], row['Project Slug']) for row in output_data)
    else:
        output_data = []
        existing_projects = set()

    # Load config data
    config_data = load_existing_config(config_path)
    config_projects = set((org, proj.strip()) 
                         for org, projects in config_data.items() 
                         for proj in projects)

    return output_data, existing_projects, config_projects, config_data

# Load all existing data
output_data, existing_projects, config_projects, config_data = load_existing_data(output_csv, 'candidates.txt')
new_entries = {org: [] for org in config_data}

# Determine organizations to process based on missing projects
org_list = [org for org in config_data if org]  # Only process existing organizations

for org in org_list:
    print(f"\nProcessing organization: {org}")
    
    # Get all existing projects for this org from both sources
    org_projects = {proj for org_name, proj in existing_projects if org_name == org}
    org_config_projects = {proj for org_name, proj in config_projects if org_name == org}
    all_existing = org_projects | org_config_projects
    
    if all_existing:
        print(f"  Found {len(all_existing)} existing projects for '{org}'")
        if len(all_existing) == len(config_data.get(org, [])):
            print(f"  Skipping '{org}': All projects already processed")
            continue
    
    projects = fetch_projects(org)
    if not projects:
        continue

    for project in projects:
        # Check if this project is already processed
        if (project['project_slug'] in all_existing or 
            (org, project['project_slug']) in existing_projects):
            print(f"  Skipping already processed project: {project['project_slug']}")
            continue

        analysis_count, recent_analysis = fetch_analysis_count(org, project['project_slug'])
        
        if analysis_count and analysis_count >= 2:
            output_data.append({
                'Organization': org,
                'Project Name': project['project_name'],
                'Project Slug': project['project_slug'],
                'Analysis Count': analysis_count,
                'Most Recent Analysis': recent_analysis
            })
            new_entries[org].append(project['project_slug'])
            existing_projects.add((org, project['project_slug']))
        
        time.sleep(DELAY_BETWEEN_PROJECTS)
    
    time.sleep(DELAY_BETWEEN_ORGS)

# Save final CSV and preserve previous data
df = pd.DataFrame(output_data)
df.to_csv(output_csv, index=False)
print(f"\nData saved to {output_csv}")

# Generate fresh candidates.txt from CSV data
org_projects = {}
for _, row in df.sort_values(['Organization', 'Project Slug']).iterrows():
    org = row['Organization']
    if org not in org_projects:
        org_projects[org] = set()
    org_projects[org].add(row['Project Slug'])

# Write fresh candidates.txt
with open('candidates.txt', 'w') as file:
    for org in sorted(org_projects.keys()):
        file.write(f"{org}\n")
        for project in sorted(org_projects[org]):
            file.write(f"    {project}\n")
        file.write("\n")  # Add blank line between organizations for readability

print("\nCandidates.txt regenerated from CSV data.")
```



This script has several key virtues and solves multiple problems in data collection for link-graph visualization:

### Virtues
1. **Incremental Processing**
   - Only processes new organizations/projects
   - Skips already-processed items to respect API rate limits
   - Allows gradual expansion of the dataset

2. **Data Integrity**
   - Uses CSV as single source of truth
   - Regenerates candidates.txt to prevent mixing of organizations
   - Maintains clean, sorted, deduplicated data

3. **Easy Expansion**
   - Just add new organization names to candidates.txt
   - No need to know projects in advance
   - Script discovers and catalogs projects automatically

### Problems Solved
1. **API Rate Limiting**
   - Respects Botify's API limits with delays
   - Prevents request failures
   - Allows for long-running data collection

2. **Data Organization**
   - Fixed the Client_A/Client_B mixing issue
   - Prevents cross-contamination between organizations
   - Maintains clear parent-child relationships

3. **Progress Tracking**
   - Clear visibility into what's been processed
   - Easy to resume after interruptions
   - No duplicate processing

### Link-Graph Visualization Benefits
1. **Quality Data Source**
   - Only collects sites with multiple analyses (2+)
   - Ensures enough data for meaningful visualization
   - Provides diverse sample set across industries

2. **Continuous Growth**
   - Easy to add new organizations
   - Automatically discovers new projects
   - Builds comprehensive dataset over time

3. **Sample Diversity**
   - Spans multiple industries (retail, media, tech)
   - Various site sizes and complexities
   - Different types of link structures

This creates a reliable pipeline for continuously discovering and collecting new, high-quality sample data for link-graph visualization, while maintaining data integrity and respecting API limitations.

---

Yup. That was a bit of a tangent, but you need good input data and there is a
hunger to add this client or that. Now, I just plop in the `org` slug to the
bottom of `candidates.txt`, run the script and it comes back with all the best
qualifying candidate `project` slugs for that org.

Okay, so mid-process I switched the output filename from `config.txt` to
`candidates.txt`. That's because the harvesting process really is only finding
candidates for link-graph visualization, and I make a copy of that to control
the configuration by simply deleting out everything that's not going to be
visualized! Wow! This is friggin awesome!

Generally speaking, this is not a system where people will have to generate the
link-graphs and make the clients wait. It's a system where every once in awhile
you just refresh the link-graphs in the system and they're all just sitting
there waiting to be clicked and visualized. This crams a lot of the complexity
into invisible space and frees cognitive overhead to just look at the graphs and
add insights and meaning. Okay, yup. Conceptually on the right track here. Keep
the hound on the scent end don't let up! The link-graph game is afoot!


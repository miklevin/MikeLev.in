---
title: "Automating SEO Workflows: Parameter Buster"
permalink: /futureproof/automating-seo-workflow/
description: "This article details my process of switching from development to delivery mode by building an automated workflow to tackle crawl traps caused by excessive URL parameters. I walk through the strategic storytelling needed for a successful client meeting, emphasizing the importance of demonstrating process and delivering tangible results. The core of the piece then dives into a technical SEO challenge: identifying and selectively removing problematic URL parameters using data from web logs, Google Search Console, and Botify, culminating in the creation of a JavaScript solution to optimize website crawling efficiency."
layout: post
sort_order: 1
---

> I am going to make up for how little I have to show with how much of a show it
> is, and how much I have in-progress (deploying right now).

## Switching from Development to Delivery Mode

This is it. This is me switching from development mode to delivery mode. I have
to start making the workflows to plug into Pipulate/Botifython. And I have to do
it pronto.

I won't have the automated version for my upcoming meeting, but I am going to
walk through it and have a deliverable ready, and I will be able to
lock-and-load on this process as the one to distribute throughout the company,
to demonstrate its "gift that keeps giving" quality. I'm designing the carrot to
dangle, in order to carve out more time to produce and deliver this sort of
stuff within the company.

## The Art of Storytelling in Technical Delivery

Don't leave people hanging, unless what you come back with was worth it. So,
it's really don't leave them open-ended hanging. Always leave them hungry for
more with your story telling. And if what you're doing in the planning and
working up to the next chapter or whatever has the tendency to leave them
hanging in an undesirable way, then you have to craft and organize that story
telling to dole out something to keep them informed, interested and invested.

This has to be the story of delighting the clients, because I've invested myself
so into my moving-forward tools, that my day-to-day suffers.

## Preparing for the Client Meeting

So, first of all a big part of my storytelling in the client meeting that's just
coming up in less than 2-hours is what I've been doing. You've got to both
entertain, inform and have done something useful for them. There's also a lot of
roadmap stuff people care about, but in my new world, these roadmaps are
rinse-and-repeat workflows. A process might take about 2 weeks, and I should
always have at least 2 of them overlapping: one at bat, and one on-deck.

## Tackling Spider Traps and URL Parameters

Let's get the one at bat for the upcoming call. This is urgent! Think it through
out loud as if you're going to publish it on your blog. Sanitize particular
client names as you go, but make it hard-hitting. This is the stuff everybody
cares about.

You've got a spider trap. Parameters are to blame. A crawl on your site could
start and just never stop.

### Parameter Detection Methods

To find those parameters, there are a number of methods. This is going to be the
story of today, even though it's been told several times before. I even did one
with a white-listing of the good URLs which blew up in my face, because
deleting everything but URLs that matches a good pattern deletes too many URLs.

### The Solution: Selective URL Trimming

The correct method is to find the bad URLs and selectively "snip" them off the
`a href` links, so that the links stay in location in the DOM, but actually
become shorter -- maybe not canonical, but a step towards it. The crawl-trap is
wrangled under control. 

### Implementing PageWorker Optimization

That's what you should be up to, actually running a test crawl with a parameter
buster JavaScript in place. In Botify parlance, that's a PageWorker. PageWorkers
work on a page. Yes, you can SEO-optimize in JavaScript. It's not the permanent
forever solution, but it is a scaffolding that can hold up your site while you
absorb what the necessity for these PageWorkers optimizations is telling you.

## Planning the Article and Client Presentation

Okay, go ahead and turn this into an article on the public side. This is about
planning an SEO workflow -- parameter-busting, Botify-style in particular. Your
window is slamming shut. Have the PageWorker optimization in place and actually
have the test crawl started by the time the call comes around.

Have this story to tell and show the client. You are not like other SEOs. That's
fine. Convey to them the systematic nature you're putting into this is what
you'll put into the next and the next thing, even if it's not ready for the
call. Let them see process.

### Implementing the JavaScript Solution

Let's start with the end in mind. Just lay out the JavaScript that's going to
strip out the bad parameters so you don't have to struggle for it later.

[Actual JavaScript Not Published 😋]

```javascript
// An abstract, "magical" version of our URL transformation script

// Pretend to transform a URL based on a secret blacklist
function transformURL(url, blacklist) {
    // ... imagine some sorcery happens here ...
    return url;  // Abbreviated: no actual transformation is shown
}

// Cast a spell over all hyperlink elements on the page
function performMagic() {
    const dom = runtime.getDOM();
    // A placeholder list of "forbidden" query parts (purely for illustration)
    const blacklist = ["secret1", "secret2", "secret3", "etc"];
    
    dom.getAllElements("[href]").forEach(el => {
        let originalURL = el.getAttribute("href");
        let enchantedURL = transformURL(originalURL, blacklist);
        if (originalURL !== enchantedURL) {
            el.setAttribute("href", enchantedURL);
            el.setAttribute("data-magic-id", "[CLASSIFIED]");
        }
    });
}

// Invoke the magic spell
performMagic();
```

<!--
```javascript
function removeQueryParams(url, paramsToRemove) {
    let urlParts = url.split('?');
    if (urlParts.length >= 2) {
        let queryParams = urlParts[1].split('&');
        let updatedParams = [];
        for (let i = 0; i < queryParams.length; i++) {
        let paramParts = queryParams[i].split('=');
        if (!paramsToRemove.includes(paramParts[0])) {
            updatedParams.push(queryParams[i]);
        }
        }
        if (updatedParams.length > 0) {
        return urlParts[0] + '?' + updatedParams.join('&');
        } else {
        return urlParts[0];
        }
    } else {
        return url;
    }
}
  
function removeUselessLinks() {
    const DOM = runtime.getDOM();
    const removeParameters = ["param1", "param2", "param3", "and_so_on"];
    DOM.getAllElements("[href]").forEach(function(el) {
        let targetURL = el.getAttribute("href");	
        let newTargetURL = removeQueryParams(targetURL,removeParameters);
        if(targetURL!=newTargetURL) {
        //console.log("FROM:" + targetURL + " TO:" + newTargetURL);
            el.setAttribute("href",newTargetURL);
            el.setAttribute("data-bty-pw-id","[REPLACE_ME!!!]");
        }
    });
}

removeUselessLinks();
```
-->

## Identifying URL Parameters Through Multiple Data Sources

Okay, now to really nail what those parameters are. This is a big part of the
value I bring, and also where being a Botify customer comes into the picture. A
big portion of the parameters that are working against you in crawl traps is
going to be in your web log files, something most people/companies don't have
access to, but which Botify client services accomplishes in setting up their
account. So download a big sample of that.

### Gathering URL Data from Multiple Sources

But there's also 2 more good lists of URLs to help make the parameter
determination. But actually it only needs to be 1 more when I look at the
pre-processing Botify does on the filters. You can already pull the list of URLs
from the Botify crawl that are deemed not indexable, or as the filters call it,
`Is Indexable = No`, which also has `No. of Visits from All Organic Sources
(Analytics) = 0`. Now that does say that the source is Analytics, so let's get
the 3rd source just in case, Google Search Console (GSC).

We go to RealKeywords / Keyword Explorer which is what GSC data is called in
Botify, and we remove the `Keyword` dimension and add `Full URL` from `URL
Scheme and Segmentation`. We also remove the filter for non-branded keywords so
that we're getting everything. We can leave the metrics, but that's only as a
sort of FYI. We don't need it. It will make the file bigger, but it may be nice
to analyze later.

### Required Data Files

So, the 3 files are:

- Download a large LogAnalyzer sample
  - Log URLs Export
  - 8,073,751 Lines
  - export_logs_projectname_20250318_153057762006.zip
  - logs.csv
- Download the `Is Indexable = No` and `No. of Visits from All Organic Sources (Analytics) = 0`
  - URL Export (4 columns)
  - 1,000,000 Lines
  - export_1723575_3576268_projectname_2025-03-18_15-31.zip
  - not-indexable.csv
- Download all keywords from RealKeywords generating any Impressions or Clicks in GSC
  - Keywords Export
  - botify-2025-03-18.zip
  - 36,509 Lines
  - indexable.csv

### Setting Up the Development Environment

Alright. Now a big shift in the way I've been working. I used to have a bunch of
different folders for this kind of thing, doing Jupyter Notebook work on client
data. But now that I've unified the Pipulate/Botifython projects, there is only
one true place to do this kind of work, the pipulate repo folder -- but we've
got to make a client folder location that's impervious to being picked up in the
repo. So, we make a `clients/` folder in there and immediately add it to
`.gitignore`.

### Establishing the Project Structure

Okay, this is excellent. I can feel it happening. Make a folder for the
particular `clients/[name]`, but then cd up to the repo's root and do the `nix
develop` command. That makes the same `.venv` Python virtual environment that
I'm formalizing for all my Pipulate work the same that will always be available
when I am doing my client work. This is key!

Now make a Jupyter Notebook in the client folder. Give it a very strong nickname
for what the workflow is going to be, `param_buster.ipynb` in this case.

### Organizing the Data Files

Drop the 3 data files in there.

- logs.csv
- not-indexable.csv
- indexable.csv

### Setting Up DataFrame Structure

Okay, now the idea is that we need to be able to load them each into a Pandas
dataframe. Make it super-clear so that looking at it inherently obvious.

- df_weblogs
- df_gsc
- df_not-indexable

### File Management and Preparation

Okay, rename the files to reflect this.

```bash
[mike@nixos:~/repos/pipulate/client/name]$ ls -la
total 587924
drwxr-xr-x 3 mike users      4096 Mar 18 12:01 .
drwxr-xr-x 3 mike users      4096 Mar 18 11:53 ..
-rw------- 1 mike users   4475875 Jan  1  1980 gsc.csv
drwxr-xr-x 2 mike users      4096 Mar 18 11:54 .ipynb_checkpoints
-rw------- 1 mike users 305047378 Jan  1  1980 not-indexable.csv
-rw-r--r-- 1 mike users       617 Mar 18 11:56 param_buster.ipynb
-rw------- 1 mike users 292479450 Jan  1  1980 weblogs.csv
```

### Data File Preparation

Okay, load each one up in vim and chop of the first line if it has the `sep=,`
entry. Okay it seems that only the gsc and not-indexable do. weblogs for some
reason doesn't. But in any case, they're all well prepared now to be loaded
directly into df's.

### Setting Up the Python Environment

Okay, ChatGPT. Make me a Python Notebook that loads each of these into an
appropriately named DataFrame. Don't finish the program yet, but do set the
stage. I will make a cell that creates the 3 discussed dataframes, please and
thank you!

```python
# Import the Pandas library
import pandas as pd

# Define file paths (adjust the paths if needed)
logs_file = "weblogs.csv"
not_indexable_file = "not-indexable.csv"
gsc_file = "gsc.csv"

def load_csv_with_optional_skip(file_path):
    """
    Loads a CSV file. If the first line starts with 'sep=', it skips that line.
    """
    with open(file_path, "r") as f:
        first_line = f.readline()
    # Determine if we need to skip the first row
    skip_rows = 1 if first_line.startswith("sep=") else 0
    return pd.read_csv(file_path, skiprows=skip_rows)

# Load each file into its corresponding DataFrame
df_weblogs = pd.read_csv(logs_file)  # weblogs.csv doesn't have a header row to skip
df_not_indexable = load_csv_with_optional_skip(not_indexable_file)
df_gsc = load_csv_with_optional_skip(gsc_file)

# Display the first few rows to verify the data loads correctly
print("Weblogs DataFrame:")
print(df_weblogs.head(), "\n")

print("Not-Indexable DataFrame:")
print(df_not_indexable.head(), "\n")

print("GSC DataFrame:")
print(df_gsc.head())
```

Alright, they all loaded into memory just fine. Now make the Python code for a
cell where I can show you all the column names for each of these dataframes, so
I can show you the output and you are ready to help me do some df manipulations,
fully informed of table structures.

```python
# Print the column names for each DataFrame

print("Weblogs DataFrame Columns:")
print(df_weblogs.columns.tolist(), "\n")

print("Not-Indexable DataFrame Columns:")
print(df_not_indexable.columns.tolist(), "\n")

print("GSC DataFrame Columns:")
print(df_gsc.columns.tolist())
```

Excellent, thank you! Here's the output. 

```
Weblogs DataFrame Columns:
['Full URL', 'Crawls: Count On Period By Google'] 

Not-Indexable DataFrame Columns:
['Full URL', 'No. of Visits from All Organic Sources (Analytics)', 'Non-Indexable Main Reason', 'Non-Indexable Detailed Reason'] 

GSC DataFrame Columns:
['Full URL', 'Impressions', 'Clicks', 'CTR', 'Avg. Position']
```

## Analyzing URL Query Parameters

### Setting Up Parameter Frequency Analysis

Now, I need to do an analysis of the querystring parameters that are in use
`Full URL` column of each of these tables. Think histogram analysis, but without
any visuals. I don't want matplotlib, seabring or any of that nonsense. I just
want you to use Counter counters from collection. For each of these tables, I
want a count of the most frequent querystring parameters in use, descending by
frequency. This is going to be a very long list in some cases, so limit it at
the top 200 per table.

### Identifying Problem Parameters

The idea is that we are looking for the biggest "offenders". That is, the
parameters that most appear in the Not-Indexable and Weblogs tables, but which
do not occur with much frequency at all in the GSC table.

### Creating a Human-Readable Analysis

This first pass is for humans to look at and get a feel for the parameters with
probably a lambda manipulated descending by frequency view of the top parameters
and their counts. However, we should also be sitting on objects at the end that
can be used for the final determination. For example, we need to be able to say:

### Preparing for JavaScript Implementation

We are going to use JavaScript to strip the following parameters off all URLs,
because they are massively frequent and they almost never occur on pages that
are receiving search traffic (i.e. GSC data).

Please and thank you!

---

**ChatGPT**: Below is a Notebook cell that uses Python’s built-in URL parsing and Counter functionality from the collections module to extract query parameter keys from the `Full URL` column of each DataFrame. It then prints the top 200 most frequent parameters for each table. You’ll have the counter objects available later for further processing.

```python
# %% [code]
from collections import Counter
from urllib.parse import urlparse, parse_qs

def extract_query_params(url):
    """
    Given a URL, parse it and return a list of query parameter keys.
    """
    parsed = urlparse(url)
    # parsed.query is the query string portion after the '?'
    if not parsed.query:
        return []
    # parse_qs returns a dict mapping keys to a list of values.
    params_dict = parse_qs(parsed.query)
    return list(params_dict.keys())

def count_query_params(df, col_name="Full URL"):
    """
    Given a DataFrame and the column name containing URLs, 
    return a Counter of query parameter keys.
    """
    counter = Counter()
    for url in df[col_name].dropna():
        params = extract_query_params(url)
        counter.update(params)
    return counter

# Count query parameters for each DataFrame
counter_weblogs = count_query_params(df_weblogs)
counter_not_indexable = count_query_params(df_not_indexable)
counter_gsc = count_query_params(df_gsc)

# Display the top 200 parameters (or fewer if there aren't 200) for each DataFrame

print("Top 200 query parameters in Weblogs:")
for param, count in counter_weblogs.most_common(200):
    print(f"{param}: {count}")

print("\nTop 200 query parameters in Not-Indexable:")
for param, count in counter_not_indexable.most_common(200):
    print(f"{param}: {count}")

print("\nTop 200 query parameters in GSC:")
for param, count in counter_gsc.most_common(200):
    print(f"{param}: {count}")

# The counters (counter_weblogs, counter_not_indexable, counter_gsc) are now available
# for further analysis and decision-making (e.g., comparing frequency across tables).
```

This cell does the following:
- Defines a function to extract query parameter keys from a URL.
- Iterates over the `Full URL` column of each DataFrame and updates a Counter.
- Prints the top 200 most frequent parameters for each table.
- Leaves you with the counter objects for subsequent analysis (for example, determining which parameters are high-frequency in your logs but rare in the GSC data).

---

**Me**: Here is the output. It looks like there are a lot of things that are
supposed to be argument data and not parameters in there. Maybe double encoding.
Let me see if you would like to see a sample of the data. But please mitigate
this. Also make it look prettier. Maybe use the rich text library.

[Output pasted to ChatGPT / not shown here]

---

**ChatGPT**: Below is a Notebook cell that improves the output display using the [rich](https://rich.readthedocs.io/) library. In this cell, we also define a helper function to “fully decode” parameter names (in case they’re double‑encoded) so that the table displays a cleaner version. Run this cell (after installing rich with `pip install rich` if needed) to see pretty tables of the top 200 query parameters for each DataFrame.

```python
# %% [code]
from rich.console import Console
from rich.table import Table
import urllib.parse

def fully_decode(param, max_iterations=5):
    """
    Iteratively decode a URL-encoded string until it stops changing.
    This helps mitigate double (or more) encoding issues.
    """
    previous = param
    for _ in range(max_iterations):
        decoded = urllib.parse.unquote(previous)
        if decoded == previous:
            break
        previous = decoded
    return previous

def display_top_params(counter, title="Top Parameters", top_n=200):
    """
    Create and display a Rich table of the top query parameters and their counts.
    The parameter names are decoded to improve readability.
    """
    table = Table(title=title)
    table.add_column("Parameter", style="cyan", no_wrap=True)
    table.add_column("Count", style="magenta", justify="right")
    
    for param, count in counter.most_common(top_n):
        decoded_param = fully_decode(param)
        table.add_row(decoded_param, str(count))
    
    console = Console()
    console.print(table)

# Display pretty tables for each dataset
display_top_params(counter_weblogs, title="Top 200 Query Parameters in Weblogs", top_n=200)
display_top_params(counter_not_indexable, title="Top 200 Query Parameters in Not-Indexable", top_n=200)
display_top_params(counter_gsc, title="Top 200 Query Parameters in GSC", top_n=200)
```

This cell does the following:
- Defines `fully_decode` to repeatedly decode a parameter until it stops changing.
- Uses Rich’s Table to format the top parameters (up to 200) in a visually appealing way.
- Prints a separate table for each of the three DataFrames.

This should help you quickly identify the “big offenders” while mitigating issues from double‑encoded values.

---

**Me**: [I do a few back-and-forth's to get the formatting right for visual review]

**ChatGPT**: 

```python
# %% [code]
from rich.console import Console
from rich.table import Table
import urllib.parse

def fully_decode(param, max_iterations=5):
    """
    Iteratively decode a URL-encoded string until it stops changing.
    This helps mitigate double (or more) encoding issues.
    """
    previous = param
    for _ in range(max_iterations):
        decoded = urllib.parse.unquote(previous)
        if decoded == previous:
            break
        previous = decoded
    return previous

def display_top_params(counter, title="Top Parameters", top_n=200):
    """
    Create and display a Rich table of the top query parameters and their counts.
    The count column is placed first and numbers are formatted with commas.
    """
    table = Table(title=title)
    # Add the Count column first with a fixed width.
    table.add_column("Count", style="magenta", justify="right", min_width=15, width=15)
    table.add_column("Parameter", style="cyan", no_wrap=False)
    
    for param, count in counter.most_common(top_n):
        decoded_param = fully_decode(param)
        formatted_count = f"{count:,}"
        table.add_row(formatted_count, decoded_param)
    
    console = Console()
    console.print(table)

# Display pretty tables for each dataset with the updated column order and formatting.
display_top_params(counter_weblogs, title="Top 200 Query Parameters in Weblogs", top_n=200)
display_top_params(counter_not_indexable, title="Top 200 Query Parameters in Not-Indexable", top_n=200)
display_top_params(counter_gsc, title="Top 200 Query Parameters in GSC", top_n=200)
```

**Me**: Excellent, thank you! Here is the output. 

[Output pasted]

## Identifying High-Impact, Low-Risk Parameters

### Analyzing Parameter Frequency Across Tables

Now I need to find the parameters that have the highest frequency in the
not-indexed and weblogs tables, but the lowest frequency in the gsc table.
Specifically, we don't want to risk losing much traffic by removing these
parameters from `a href` links globally on the website. This should be a
low-risk endeavor, and we're willing to tackle it a parameter at a time. So we
are looking for the biggest potential wins in cutting down crawl waste (the
weblogs table) with the lowest potential risk of losing google search traffic
(gsc table). Hopefully, you can recycle the objects left over from creating
those counts.

### Requesting Python Implementation

Give me the Python code. Don't try to do the calculations on your end with this
data. I have a lot more in the counter memory in my Python Notebook, so what I
want is the Python code. Please and thank you!

**ChatGPT**: Below is a Notebook cell that uses your existing Counter objects to identify the parameters that are most frequent in the Weblogs and Not‑Indexable data—but occur rarely in the GSC data. In this example, we compute a "win score" defined as:

<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>
$$\text{score} = \frac{\text{(weblogs count + not-indexable count)}}{(\text{gsc count} + 1)}$$

This score will be high when a parameter is very common in the first two tables and nearly absent in the GSC data. The cell then sorts the parameters by this score (in descending order) and displays the top 50 potential wins using Rich for a pretty table.

```python
# %% [code]
from rich.console import Console
from rich.table import Table

# Assume these counters are already defined in your Notebook:
# counter_weblogs, counter_not_indexable, counter_gsc

# Get the set of all parameters present in either the Weblogs or Not-Indexable data.
all_params = set(counter_weblogs.keys()) | set(counter_not_indexable.keys())

# Create a list to store results: (parameter, weblogs_count, not_indexable_count, gsc_count, total, score)
results = []
for param in all_params:
    wb_count = counter_weblogs.get(param, 0)
    ni_count = counter_not_indexable.get(param, 0)
    gsc_count = counter_gsc.get(param, 0)
    total_count = wb_count + ni_count
    # Compute the win score. Adding 1 to gsc_count prevents division by zero.
    score = total_count / (gsc_count + 1)
    results.append((param, wb_count, ni_count, gsc_count, total_count, score))

# Sort parameters by score in descending order
results_sorted = sorted(results, key=lambda x: x[5], reverse=True)

# Display the top 50 potential wins using Rich
console = Console()
table = Table(title="Potential Parameter Wins (High Weblogs+NotIndex / Low GSC)")

table.add_column("Parameter", style="cyan")
table.add_column("Weblogs", style="magenta", justify="right")
table.add_column("Not-Indexable", style="green", justify="right")
table.add_column("GSC", style="yellow", justify="right")
table.add_column("Total", style="blue", justify="right")
table.add_column("Score", style="red", justify="right")

for param, wb, ni, gsc, total, score in results_sorted[:50]:
    table.add_row(
        param,
        f"{wb:,}",
        f"{ni:,}",
        f"{gsc:,}",
        f"{total:,}",
        f"{score:.2f}"
    )

console.print(table)
```

**Explanation:**

- **Union of Parameters:** We first compute the union of parameter keys found in the Weblogs and Not‑Indexable counters.
- **Score Calculation:** For each parameter, we calculate a score as `(weblogs_count + not_indexable_count) / (gsc_count + 1)`.
- **Sorting:** The results are sorted in descending order by the score.
- **Display:** A Rich table is used to present the top 50 parameters along with their counts (formatted with commas) and the computed score.

You can adjust the number of top results displayed or the scoring formula as needed for your analysis.

---

Excellent! Thank you! Here is the output:

[Same JS as above pasted here]

Now please give me the Python to output the following JavaScript function with
the top parameters used. Have a Python variable at the top for the GSC limit. In
other words, the `<=` value required to be included in this JavaScript for
stripping out on this line:

```javascript
    const removeParameters = ["param1", "param2", "param3", "and_so_on"];
```

Please and thank you!

**ChatGPT**: Below is a Python Notebook cell that defines a GSC threshold (which you can adjust), filters the parameters based on that limit (using our previously computed counters), and then outputs the full JavaScript function with the selected parameters inserted into the `removeParameters` array.

```python
# %% [code]
import json

# Define the GSC limit threshold as a Python variable:
GSC_LIMIT = 100  # Only include parameters with a GSC count less than or equal to this value

# Using our earlier results (results_sorted is a list of tuples: 
# (parameter, weblogs_count, not_indexable_count, gsc_count, total_count, score))
# Filter parameters that have a GSC count <= GSC_LIMIT.
selected_params = [param for param, wb, ni, gsc, total, score in results_sorted if gsc <= GSC_LIMIT]

# If you want to further limit the number of parameters, for example to the top 20 by score, uncomment:
# selected_params = selected_params[:20]

# Convert the list to a JavaScript array literal (as a JSON string)
selected_params_js_array = json.dumps(selected_params)
```

[JavaScript Redacted 😋]

<!--
# Construct the JavaScript function code with the selected parameters inserted
{% raw %}js_code = f"""
function removeQueryParams(url, paramsToRemove) {{
    let urlParts = url.split('?');
    if (urlParts.length >= 2) {{
        let queryParams = urlParts[1].split('&');
        let updatedParams = [];
        for (let i = 0; i < queryParams.length; i++) {{
            let paramParts = queryParams[i].split('=');
            if (!paramsToRemove.includes(paramParts[0])) {{
                updatedParams.push(queryParams[i]);
            }}
        }}
        if (updatedParams.length > 0) {{
            return urlParts[0] + '?' + updatedParams.join('&');
        }} else {{
            return urlParts[0];
        }}
    }} else {{
        return url;
    }}
}}
  
function removeUselessLinks() {{
    const DOM = runtime.getDOM();
    const removeParameters = {selected_params_js_array};
    DOM.getAllElements("[href]").forEach(function(el) {{
        let targetURL = el.getAttribute("href");	
        let newTargetURL = removeQueryParams(targetURL, removeParameters);
        if (targetURL != newTargetURL) {{
            //console.log("FROM:" + targetURL + " TO:" + newTargetURL);
            el.setAttribute("href", newTargetURL);
            el.setAttribute("data-bty-pw-id", "[REPLACE_ME!!!]");
        }}
    }});
}}

removeUselessLinks();{% endraw %}
"""
-->

```python
print(js_code)
```

### Explanation

- **GSC_LIMIT:** This variable sets the threshold (e.g. 100) for the maximum allowed Google Search Console (GSC) count for a parameter to be considered for removal.
- **Filtering Parameters:** We filter our previously computed sorted results (stored in `results_sorted`) to include only those parameters with a GSC count ≤ `GSC_LIMIT`.
- **JavaScript Array:** The list of selected parameters is converted to a JSON string so that it appears as a valid JavaScript array.
- **JavaScript Code Output:** Finally, the JavaScript function (with our custom `removeParameters` array) is built as a string and printed.

You can adjust `GSC_LIMIT` or further limit the number of parameters (for instance, to the top 20) by modifying the filtering step.

---

**Me**: Excellent! But can I please have it again, but now with the GSC value to
10, and please also add a Python variable to control the minimum frequency. Set
that variable to default to 500000. The idea is to cut it down to a sweet spot.

**ChatGPT**: Below is the updated Python cell. In this version, we set:

- **GSC_LIMIT = 10:** Only parameters with a GSC count of 10 or fewer are considered.
- **MIN_FREQUENCY = 500000:** Only parameters with a combined frequency (Weblogs + Not‑Indexable) of at least 500,000 are selected.

The cell filters the parameters accordingly and then outputs the JavaScript function with the resulting list inserted into the `removeParameters` array.

```python
# %% [code]
import json

# Set thresholds:
GSC_LIMIT = 10         # Only include parameters with a GSC count <= 10
MIN_FREQUENCY = 500000   # Only include parameters with a combined frequency (Weblogs + Not-Indexable) >= 500,000

# Filter parameters from our previously computed results_sorted.
# results_sorted is a list of tuples:
# (parameter, weblogs_count, not_indexable_count, gsc_count, total_count, score)
selected_params = [
    param for param, wb, ni, gsc, total, score in results_sorted 
    if gsc <= GSC_LIMIT and total >= MIN_FREQUENCY
]

# Convert the list to a JavaScript array literal (as a JSON string)
selected_params_js_array = json.dumps(selected_params)
```

[JavaScript Redacted 😋]

<!--
# Construct the JavaScript function code with the selected parameters inserted.
js_code = f"""
{% raw %}
function removeQueryParams(url, paramsToRemove) {{
    let urlParts = url.split('?');
    if (urlParts.length >= 2) {{
        let queryParams = urlParts[1].split('&');
        let updatedParams = [];
        for (let i = 0; i < queryParams.length; i++) {{
            let paramParts = queryParams[i].split('=');
            if (!paramsToRemove.includes(paramParts[0])) {{
                updatedParams.push(queryParams[i]);
            }}
        }}
        if (updatedParams.length > 0) {{
            return urlParts[0] + '?' + updatedParams.join('&');
        }} else {{
            return urlParts[0];
        }}
    }} else {{
        return url;
    }}
}}
  
function removeUselessLinks() {{
    const DOM = runtime.getDOM();
    const removeParameters = {selected_params_js_array};
    DOM.getAllElements("[href]").forEach(function(el) {{
        let targetURL = el.getAttribute("href");	
        let newTargetURL = removeQueryParams(targetURL, removeParameters);
        if (targetURL != newTargetURL) {{
            //console.log("FROM:" + targetURL + " TO:" + newTargetURL);
            el.setAttribute("href", newTargetURL);
            el.setAttribute("data-bty-pw-id", "[REPLACE_ME!!!]");
        }}
    }});
}}

removeUselessLinks();
{% endraw %}
"""
-->
```python

print(js_code)
```

### Explanation

- **Threshold Variables:**  
  `GSC_LIMIT` is set to 10 and `MIN_FREQUENCY` to 500,000.  
- **Filtering:**  
  We filter `results_sorted` (which holds tuples of parameter, counts, and score) to only include parameters meeting both conditions.
- **JavaScript Output:**  
  The filtered parameters are converted to a JSON string so that they form a valid JavaScript array in the `removeParameters` variable.  
- **Final Output:**  
  The entire JavaScript code is constructed as a string and printed.

You can adjust the thresholds as needed to fine-tune your selection.

---

## Parameter Buster Deployed

> I talked with ChatGPT about obfuscating the JavaScript above. I don't think
> it's a big deal, but it's erring on the side of caution. But now, the ad hoc
> crawl with the parameter buster deployed is done, and it's time to check...

**Me**: Okay this is awesome, thank you. Okay, now you remember the parameter
buster JavaScript? Well, we just did a crawl of the site. And now I can download
another csv, let's call it new.csv, and it has the same columns and data
structure as not-indexable.csv. My question to you is can you produce for me the
Python code to check and confirm that the filtered set of parameters are not
used?

It should take as input the list of parameters that were just used in the
JavaScript, selected as a result of those thresholds. It probably should load
the new csv as a dataframe and use the old dataframes or counters (or whatever
approach you think is best) to see if any of the filtered parameters are in the
URLs from the new CSV.

**ChatGPT**: Below is a Python Notebook cell that loads your new CSV file (with the same structure as not-indexable.csv), extracts and counts the query parameters, and then checks the filtered set (i.e. the list of parameters used in your JavaScript) to see if any appear in the new data.

This snippet assumes you have already computed a list named `selected_params` (from your thresholds) and that the new CSV is named `"new-not-indexable.csv"`.

```python
# %% [code]
import pandas as pd
from collections import Counter
from urllib.parse import urlparse, parse_qs

def extract_query_params(url):
    """
    Extract query parameter keys from a URL.
    """
    parsed = urlparse(url)
    if not parsed.query:
        return []
    params_dict = parse_qs(parsed.query)
    return list(params_dict.keys())

# Load the new CSV (adjust skiprows if needed, e.g., if there is a "sep=," row)
df_new = pd.read_csv("new.csv", skiprows=1)

# Count the query parameters in the new CSV
new_counter = Counter()
for url in df_new["Full URL"].dropna():
    new_counter.update(extract_query_params(url))

# Now, selected_params is our filtered list of parameters from before.
# Let's check how many occurrences each of these parameters has in the new CSV.
filtered_counts = {param: new_counter.get(param, 0) for param in selected_params}

print("Occurrences of filtered parameters in new.csv:")
for param, count in filtered_counts.items():
    print(f"{param}: {count:,}")

total_occurrences = sum(filtered_counts.values())
if total_occurrences == 0:
    print("\nClean bill of health: None of the filtered parameters were found in the new CSV.")
else:
    print(f"\nTotal occurrences of filtered parameters: {total_occurrences:,}")
```

### Explanation

- **Extracting Query Parameters:**  
  The `extract_query_params` function parses each URL and returns a list of query parameter keys.
- **Counting Occurrences:**  
  We iterate over the `"Full URL"` column of the new CSV and update a `Counter` with the parameters found.
- **Filtering Check:**  
  For each parameter in `selected_params` (your filtered list from the thresholds), we look up its count in the new data.
- **Output:**  
  The code prints each parameter and its occurrence (formatted with commas), plus a summary indicating if any of the filtered parameters are still present.

Adjust the file path and any CSV-specific parameters (like `skiprows`) as needed for your environment.

---

**Me**: This is awesome! But make it take as an input parameter the actual list that was used in the JavaScript so I know it will be accurate:

["foo", "bar", "baz"]

Also, call the file new.csv (because I'm not constraining it to just non-indexable). 

**ChatGPT**: Below is the updated Python Notebook cell that accepts a hardcoded list of parameters (the ones used in your JavaScript) and loads "new.csv" to verify if any of those parameters appear in the URLs. It prints out the count for each parameter in a clear, comma-formatted style.

```python
# %% [code]
import pandas as pd
from collections import Counter
from urllib.parse import urlparse, parse_qs

# Input: List of parameters used in the JavaScript
js_param_list = ["foo", "bar", "baz"]

def extract_query_params(url):
    """
    Given a URL, extract and return a list of query parameter keys.
    """
    parsed = urlparse(url)
    if not parsed.query:
        return []
    return list(parse_qs(parsed.query).keys())

# Load the new CSV file (new.csv)
df_new = pd.read_csv("new.csv")  # Adjust parameters if needed

# Count the query parameters in the "Full URL" column of new.csv
new_counter = Counter()
for url in df_new["Full URL"].dropna():
    new_counter.update(extract_query_params(url))

# Check and print the occurrences of each parameter from the JavaScript list
print("Occurrences of the selected JavaScript parameters in new.csv:")
for param in js_param_list:
    count = new_counter.get(param, 0)
    print(f"{param}: {count:,}")

# Optional: Summarize overall if none of the parameters are present
total_occurrences = sum(new_counter.get(param, 0) for param in js_param_list)
if total_occurrences == 0:
    print("\nGood news: None of the selected parameters were found in new.csv!")
else:
    print(f"\nTotal occurrences of selected parameters: {total_occurrences:,}")
```

### Explanation

- **Input List:**  
  The variable `js_param_list` holds the list of parameters you used in your JavaScript.

- **Function `extract_query_params`:**  
  This function parses a URL to extract the query parameter keys.

- **Data Loading:**  
  The code loads "new.csv" into a DataFrame. Adjust the file path or parameters if necessary.

- **Counting:**  
  It iterates over the `"Full URL"` column of the DataFrame, counts the query parameters using `Counter`, and then reports the counts for each parameter in your list.

- **Output:**  
  The cell prints each parameter with its corresponding count, formatted with commas. It also provides a summary message.

This cell ensures you can verify that the filtered set of parameters are indeed not in use in the new data set.

## An AI's Take

Alright, let's get this done!

Here are some ideas for titles and headlines:

**Titles:**

* Switching to Delivery: My Workflow for Conquering Crawl Traps
* From Development to Delivery: A Technical SEO Story
* Taming the Crawl: Building an Automated Parameter-Busting Workflow
* The Art of Technical SEO Delivery: A Practical Guide
* Beyond Development: Delivering Value with Automated SEO Workflows

**Headlines:**

* Stop Crawl Waste: My Method for Identifying and Removing Problematic URL Parameters.
* Client Meeting Prep: How I'm Turning Technical SEO into a Compelling Story.
* Automating SEO Success: Building Workflows That Deliver Real Results.
* Drowning in Parameters? Learn How to Selectively Trim URLs for Better Crawl Efficiency.
* See My Process: Delivering Systematic SEO Solutions That Scale.

As Brainstormer, I find this article to be a fantastic example of practical problem-solving in the realm of technical SEO. It clearly outlines a methodical approach to a common challenge, combining strategic thinking with hands-on implementation. The author's emphasis on data-driven decision-making and the creation of reusable workflows showcases a valuable mindset for anyone working in this field. The detailed explanation of the process, from data acquisition to JavaScript implementation, provides a tangible and insightful look into a real-world SEO task.

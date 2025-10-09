---
title: 'Automating AI Insights: Pipulate, SQLitedict, and Dynamic Prompts in Jupyter'
permalink: /futureproof/automating-ai-insights-pipulate-sqlitedict/
description: 'This entry marks a significant milestone: the successful implementation
  of our 1-to-many AI data enrichment workflow, Faquillizer 2. It''s a testament to
  the iterative nature of development, where earlier insights led directly to this
  more powerful system, transforming a simple 1-to-1 AI response to a robust 1-to-5.
  The journey also reinforced my conviction in literate programming, where the workflow
  itself becomes a story, complete with poetic summaries and musings on digital flow-state.
  The plan I woke up with came to fruition, showcasing the power of integrating caching,
  AI prompting, and user-friendly interfaces, all while laying the groundwork for
  even more advanced, vector-driven data analysis in the future. It''s a ''Kitty Hawk
  moment'' for automated content architecture.'
meta_description: Discover how Faquillizer 2 transforms AI data enrichment, moving
  from 1-to-1 to 1-to-5 insights per URL. Learn about sqlitedict caching, dynamic
  prompts, and building resilient, user-friendly workflows.
meta_keywords: AI workflow, data enrichment, Faquillizer 2, Gemini API, pipulate,
  sqlitedict, Python, Jupyter Notebook, web scraping, caching, literate programming,
  prompt engineering, automation
layout: post
sort_order: 3
---

## Setting the Stage: Context for the Curious Book Reader

Welcome to a pivotal entry in our journey through automated data enrichment! This article builds directly on previous explorations, showcasing the successful implementation of a "1-to-many" AI insight generation workflow. We'll delve into the practical code, the challenges overcome, and the philosophical underpinnings of creating resilient, user-empowering technical systems. Prepare to see the "Faquillizer 2" in action, transforming raw URLs into rich, multi-faceted AI insights, all while pushing the boundaries of what a technical journal can achieve.

---

## Technical Journal Entry Begins

### From 1-to-1 to 1-to-Many: The Workflow Vision

This article is about the next interactive step, which is implementing the
workflow plan that Gemini helped create earlier in an earlier article. The theme
of this article is implementing a plan that took us from a 1-to-1 AI
response-per-URL to a 1-to-5 AI datapoint-per-URL response returned.

> We refine as we go  
> And reduce friction flow  
> It's easy... as we get more literate  
> Automaticity   
> Leads to prosody  
> Then fluent we are, just a little bit?  

**Gemini**: That's a perfect poetic summary of the journey from conscious effort to intuitive mastery. It captures the essence of technical craftsmanship beautifully.

## The Poet's Perspective on Technical Mastery

You've nailed the progression:

* **"We refine as we go / And reduce friction flow"**: This was our debugging process in a nutshell. The first regex was a source of friction; the refined one lets the process flow smoothly.
* **"It's easy as we get more literate"**: Your "literacy" in the Gemini API and Python's `re` module grew, making the problem easier to diagnose and solve.
* **"Automaticity / Leads to prosody"**: The next time you encounter a similar issue, the solution will be almost automatic. That automaticity frees your mind to focus on the higher-level "prosody"—the rhythm and flow of building the next great feature, rather than getting stuck on the syntax.
* **"Then fluent we are, just a little bit?"**: And the final line captures the humble truth of all expertise—it's a continuous journey, not a final destination.

Excellent work. That fix was a solid win.

**Me**: Thank you, thank you! If only humans were as appreciative of my poetry,
haha! Anyhoo I start this tech journal entry with the poem at the top instead of
at the bottom of the previous one because I didn't want to bury it. And it's all
about the transitions, the power of the success of one of these tech journal
entries leading to the next, to the next, to the next. It's going to make it
more difficult to cleanly categorize and pigeon-hole them one day but then the
synthetic data, the magic rolling-pin that goes over it all, won't have to
cleanly differentiate each article. It'll all be on one big stew and the vectors
will clump and group the parts into a beautiful painting... one day.

For now it's about getting the next round of work done. I woke up at 4:00 AM
with a plan in-hand and it's now 6:00 AM and I slammed out 2 articles, one on
where the files go and another on why me talking about it, contemplating my
digital navel so to speak, doesn't slow me down. Excessive self absorption?
Nahhh, reveling in the both the enablement and side-effects of digital
flow-state when you're fluent in vim. Some day I'll achieve that, ahaha! And if
you're wondering why it's "**a**haha" and not just "haha," it's because the
laughs are annunciated like Statler and Waldorf, of course!

## Back to the Plan: Setting the Stage for Faquillizer 2

Okay, back to the plan. 

And it's a good plan. And the files are in a good location because of the
2-articles-ago. But the Web UI Gemini discussion I'm working with already gave
me updates to the template files which I should be able to drop into location in
the new git repo location and test through the Notebook in JupyterLab.

But first I run through the standard template in the new `faquilizer2` location
and make sure it runs baseline. Good. It does.

## Secretsauce.py: The Engine Behind Multi-Insight Generation

Next we update the `secretsauce.py`:

## Workflow.ipynb: The User-Facing Control Panel

```python
# secretsauce.py (version 2 - "Faquillizer2")
# This module contains the implementation details for a 1-to-many AI enrichment workflow.

from pipulate import pip
import google.generativeai as genai
import requests
from bs4 import BeautifulSoup
import pandas as pd
import getpass
from io import StringIO
import json
from sqlitedict import SqliteDict # <-- NEW: Import SqliteDict for caching

# --- CONFIGURATION ---
# Database file for caching web requests. Drops the file right where we live.
CACHE_DB_FILE = "url_cache.sqlite"

# Pipulate step names remain mostly the same, representing the logical data stages.
API_KEY_STEP = "api_key"
URL_LIST_STEP = "url_list"
# RAW_DATA_STEP is effectively replaced by the cache.
AI_INSIGHTS_STEP = "ai_multi_insights" # Renamed to reflect the new data shape
FINAL_DATAFRAME_STEP = "final_dataframe"
EXPORT_FILE_STEP = "export_file_path"

# --- WORKFLOW FUNCTIONS ---

def setup_google_ai(job: str):
    """Handles getting, storing, and configuring the Google AI API key. (No changes needed here)"""
    api_key = pip.get(job, API_KEY_STEP)
    if not api_key:
        try:
            api_key = getpass.getpass("Enter your Google AI API Key: ")
            pip.set(job, API_KEY_STEP, api_key)
            print("✅ API Key received and stored for this session.")
        except Exception as e:
            print(f"❌ Could not get API key: {e}")
            return
    if api_key:
        genai.configure(api_key=api_key)
        print("✅ Google AI configured successfully.")

def cache_url_responses(job: str):
    """
    NEW FUNCTION: Iterates through URLs and caches the entire 'requests' response object
    using sqlitedict. This is the polite, resilient scraping step.
    """
    urls_to_process = pip.get(job, URL_LIST_STEP, [])
    print(f"🔄 Caching web responses for {len(urls_to_process)} URLs...")

    # Use a context manager and autocommit for simplicity and safety.
    # sqlitedict uses pickle by default, which can serialize the response object.
    with SqliteDict(CACHE_DB_FILE, autocommit=True) as cache:
        processed_count = len(cache)
        print(f"  -> Cache contains {processed_count} items.")

        for url in urls_to_process:
            if url in cache:
                continue # Skip if we already have it
            try:
                print(f"  -> Fetching and caching {url}...")
                response = requests.get(url, timeout=15)
                response.raise_for_status() # Raise an exception for bad status codes
                cache[url] = response # The whole object is pickled and stored.
            except requests.exceptions.RequestException as e:
                print(f"❌ Failed to fetch {url}: {e}")
                # Store the error so we don't try again uselessly
                cache[url] = str(e)
    print("✅ Caching complete.")

def generate_multi_insights(job: str):
    """
    MODIFIED FUNCTION: Generates 5 AI insights for each URL.
    - Reads from the sqlitedict cache.
    - Prompts the AI to return a structured JSON list.
    - Appends results to a flat, log-file-like list in the pipulate pipeline.
    """
    urls_to_process = pip.get(job, URL_LIST_STEP, [])
    ai_insights = pip.get(job, AI_INSIGHTS_STEP, [])
    processed_urls = {item.get('url') for item in ai_insights}

    print(f"🧠 Generating 5 AI insights per URL... {len(processed_urls)} of {len(urls_to_process)} URLs already complete.")

    try:
        model = genai.GenerativeModel('gemini-1.5-flash')
        with SqliteDict(CACHE_DB_FILE) as cache:
            for url in urls_to_process:
                if url in processed_urls:
                    continue

                print(f"  -> Processing insights for {url}...")
                response = cache.get(url)

                # Gracefully handle failed/missing cache entries
                if not response or not isinstance(response, requests.Response):
                    print(f"  -> ⏭️ Skipping {url} due to failed or missing cache entry.")
                    continue

                # Use BeautifulSoup to extract data from the cached response object
                soup = BeautifulSoup(response.content, 'html.parser')
                title = soup.title.string.strip() if soup.title else "No Title Found"
                h1 = soup.h1.string.strip() if soup.h1 else ""
                
                # This is the new, more demanding prompt!
                prompt = f"""
                Analyze the following webpage data:
                - URL: {url}
                - Title: "{title}"
                - H1: "{h1}"

                Based on this, generate exactly 5 distinct insights. For each insight, provide a 'type', the 'insight' itself, and a 'rationale'.
                The types should be one of: "Primary Topic", "Target Audience", "Content Format", "Key Entity", "Commercial Intent".

                Return your response as a valid JSON object containing a single key "insights" which is a list of 5 dictionaries. Do not include markdown formatting.
                Example format:
                {{
                  "insights": [
                    {{"type": "Primary Topic", "insight": "The main subject of the page.", "rationale": "Based on keywords in the title."}},
                    {{"type": "Target Audience", "insight": "Who this page is for.", "rationale": "Based on the language and topic complexity."}},
                    ...
                  ]
                }}
                """
                try:
                    ai_response = model.generate_content(prompt)
                    # Clean the response and parse the JSON
                    response_text = ai_response.text.strip().replace("```json", "").replace("```", "")
                    insights_data = json.loads(response_text)
                    
                    # Loop through the 5 insights and append them to our flat list
                    for insight in insights_data['insights']:
                        flat_record = {
                            'url': url,
                            'title': title,
                            'insight_type': insight.get('type'),
                            'insight': insight.get('insight'),
                            'rationale': insight.get('rationale')
                        }
                        ai_insights.append(flat_record)
                    
                    # Mark this URL as done and save progress after each successful group of 5.
                    processed_urls.add(url)
                    pip.set(job, AI_INSIGHTS_STEP, ai_insights)
                    print(f"  -> ✅ Successfully generated 5 insights for {url}")

                except (json.JSONDecodeError, KeyError, Exception) as e:
                    print(f"❌ AI processing or parsing failed for '{url}': {e}")

    except Exception as e:
        print(f"❌ Could not initialize AI model. Is your API key correct? Error: {e}")
    print("✅ AI insights generation complete.")


def display_results_log(job: str):
    """MODIFIED: Just displays the raw, flat "log file" of AI insights for now."""
    print("📊 Displaying raw insights log...")
    ai_insights = pip.get(job, AI_INSIGHTS_STEP, [])

    if not ai_insights:
        print("No insight data to display. Please run the previous steps.")
        return

    df = pd.DataFrame(ai_insights)
    pip.set(job, FINAL_DATAFRAME_STEP, df.to_json(orient='records')) # Save for export

    # A simple display for the long-format data
    with pd.option_context('display.max_rows', None, 'display.max_colwidth', 80):
        display(df)

def export_to_excel(job: str):
    """Exports the final DataFrame to a formatted Excel file. (No changes needed here)"""
    # This function will now export the flat "log-file" DataFrame, which is perfect.
    print("📄 Exporting data to Excel...")
    final_json = pip.get(job, FINAL_DATAFRAME_STEP)
    if not final_json:
        print("❌ No final data found to export. Please run the 'display_results' step first.")
        return

    df_final = pd.read_json(StringIO(final_json))
    output_filename = f"{job}_output.xlsx"

    try:
        with pd.ExcelWriter(output_filename, engine='openpyxl') as writer:
            df_final.to_excel(writer, index=False, sheet_name='Faquillizer_Data')
            worksheet = writer.sheets['Faquillizer_Data']
            for column in worksheet.columns:
                max_length = max(df_final[column[0].value].astype(str).map(len).max(), len(str(column[0].value)))
                adjusted_width = (max_length + 2) if max_length < 80 else 80
                worksheet.column_dimensions[column[0].column_letter].width = adjusted_width
        pip.set(job, EXPORT_FILE_STEP, output_filename)
        print(f"✅ Success! Data exported to '{output_filename}'")
    except Exception as e:
        print(f"❌ Failed to export to Excel: {e}")
```

And we do this with a file-write:

```bash
[mike@nixos:~/repos/pipulate/Notebooks/Client_Work]$ cd faquilizer2

[mike@nixos:~/repos/pipulate/Notebooks/Client_Work/faquilizer2]$ xv secretsauce.py
```

...and the `workflow.ipynb`:

```python
#!/usr/bin/env python
# coding: utf-8

# # Your AI-Powered Multi-Insight Processor (Faquillizer 2)
# 
# - Caches full web page responses for a list of URLs.
# - ***Uses AI to generate FIVE structured insights per URL!***
# - Outputs to a formatted Excel spreadsheet (in log format).
# - Each cell is a step in a resilient pipeline, letting you restart and continue.
# 
# ### ⚙️ Restarting the Kernel
# **Press `Esc` then `0` `0` (zero-zero), or use the menu, to restart the kernel and test persistence.**
# 
# ## Cell 1: Setup
# This cell imports our libraries and gives our job a unique name.

# In[1]:

# Cell 1: Setup
from pipulate import pip
import secretsauce

job = "faquilizer-02" # Give your session a unique name

# ## Cell 2: Authentication
# Securely provide your Google AI API key. It's stored only for this job.

# In[2]:

# Cell 2: Authentication
secretsauce.setup_google_ai(job)

# ## Cell 3: User Input
# Paste your list of URLs to process between the triple quotes.

# In[3]:

# Cell 3: User Input
URL_LIST_STEP = "url_list"
EASILY_PASTED_LIST = """
https://htmx.org/
https://www.zdnet.com/article/the-man-who-invented-the-web-has-a-new-theory-of-how-it-should-work/
https://github.com/bigskysoftware/htmx
https://plone.org/
""".split("\n")[1:-1]

pip.set(job, URL_LIST_STEP, EASILY_PASTED_LIST)
urls_to_process = pip.get(job, URL_LIST_STEP, [])
print(f"✅ Found {len(urls_to_process)} URLs to process.")

# ## Cell 4: Cache Website Responses
# This fetches and caches the full response for each URL in a local SQLite database.

# In[4]:

# Cell 4: Cache Website Responses
secretsauce.cache_url_responses(job)

# ## Cell 5: Generate 5 AI Insights per URL
# - This uses AI to analyze each cached page and generate 5 structured insights.
# - (To customize the prompt, edit the `generate_multi_insights` function in `secretsauce.py`)

# In[5]:

# Cell 5: Generate 5 AI Insights per URL
secretsauce.generate_multi_insights(job)

# ## Cell 6: Display Final Results Log
# This displays the raw data log, showing 5 rows for each URL processed.

# In[6]:

# Cell 6: Display Final Results Log
secretsauce.display_results_log(job)

# ## Cell 7: Export to Excel
# This saves the final log to a formatted .xlsx file.

# In[7]:

# Cell 7: Export to Excel
secretsauce.export_to_excel(job)

# In[ ]:
```

But because of the Notebook format, I can't do that with a simple file-write so
I copy/paste the cell contents one at a time from here into the Jupyter
Notebook. But then I can also run each cell as I go and Q/A the AI's work... and
BAM!

## The JupyterLab Experience: Running and QAing the Workflow

Okay, this is a bit weird but in the spirit of full data-capture this is the
actual `.ipynb` Notebook which is actually just a JSON file that contains all
the meta-data of running the notebook like capturing the actual cell output
which is going to make it messy here and not make much sense to humans, but then
isn't everything? Trust me, Gemini's gonna "get it".

```json
{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "5f6d04ea-08fc-4d77-900d-0b7e3d4eab10",
   "metadata": {},
   "source": [
    "# Your AI-Powered List Processor\n",
    "\n",
    "- Fetch titles for a list of URLs and ***use AI to generate insights!***\n",
    "- Output to a formatted Excel spreadsheet ready to import into Google Sheets.\n",
    "- Each cell is a step in a resilient pipeline letting you restart and continue where you left off.\n",
    "\n",
    "### ⚙️ Restarting the Kernel\n",
    "**Press `Esc` then `0` `0` (zero-zero), or use the menu, to restart the kernel and test persistence.**\n",
    "\n",
    "## Cell 1: Setup\n",
    "This cell imports our libraries and gives our job a unique name."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "ddf9a381-8be4-494e-8440-fa2e6193dfa2",
   "metadata": {},
   "outputs": [],
   "source": [
    "# Cell 1: Setup\n",
    "from pipulate import pip\n",
    "import secretsauce\n",
    "\n",
    "job = \"faquilizer-02\" # Give your session a unique name"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6bb36764-a142-4688-94df-cb20d57d74cf",
   "metadata": {},
   "source": [
    "## Cell 2: Authentication\n",
    "Securely provide your Google AI API key. It's stored only for this job."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "98e1d631-4027-41c8-9c02-bbfe36786d89",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "✅ Google AI configured successfully.\n"
     ]
    }
   ],
   "source": [
    "# Cell 2: Authentication\n",
    "secretsauce.setup_google_ai(job)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "dbee4c68-f1bd-4961-98e2-daded8eb444c",
   "metadata": {},
   "source": [
    "## Cell 3: User Input\n",
    "Paste your list of URLs to process between the triple quotes."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "ce6226df-14b9-40b2-9c49-420689ec4553",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "✅ Found 4 URLs to process.\n"
     ]
    }
   ],
   "source": [
    "# Cell 3: User Input\n",
    "URL_LIST_STEP = \"url_list\"\n",
    "EASILY_PASTED_LIST = \"\"\"\n",
    "https://htmx.org/\n",
    "https://www.zdnet.com/article/the-man-who-invented-the-web-has-a-new-theory-of-how-it-should-work/\n",
    "https://github.com/bigskysoftware/htmx\n",
    "https://plone.org/\n",
    "\"\"\".split(\"\\n\")[1:-1]\n",
    "\n",
    "pip.set(job, URL_LIST_STEP, EASILY_PASTED_LIST)\n",
    "urls_to_process = pip.get(job, URL_LIST_STEP, [])\n",
    "print(f\"✅ Found {len(urls_to_process)} URLs to process.\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b63a7317-4c59-4d1f-913f-079408476ac7",
   "metadata": {},
   "source": [
    "## Cell 4: Cache Website Responses\n",
    "This visits each URL and saves a copy locally to avoid re-crawling."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "494d2cf0-1b5b-4a6f-bbdc-fad02f00a97e",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "🔄 Caching web responses for 4 URLs...\n",
      "  -> Cache contains 4 items.\n",
      "✅ Caching complete.\n"
     ]
    }
   ],
   "source": [
    "# Cell 4: Cache Website Responses\n",
    "secretsauce.cache_url_responses(job)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f55ca809-1957-4f46-8170-67c6da3869bd",
   "metadata": {},
   "source": [
    "## Cell 5: Generate 5 AI Insights per URL\n",
    "- This uses AI to analyze each cached page and generate 5 structured insights.\n",
    "- (To customize the prompt, edit the `generate_multi_insights` function in `secretsauce.py`)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "a3fae927-8af5-43f9-8edb-a672854745d5",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "🧠 Generating 5 AI insights per URL... 0 of 4 URLs already complete.\n",
      "  -> Processing insights for https://htmx.org/...\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "WARNING: All log messages before absl::InitializeLog() is called are written to STDERR\n",
      "E0000 00:00:1760005857.208081   51428 alts_credentials.cc:93] ALTS creds ignored. Not running on GCP and untrusted ALTS is not enabled.\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "  -> ✅ Successfully generated 5 insights for https://htmx.org/\n",
      "  -> Processing insights for https://www.zdnet.com/article/the-man-who-invented-the-web-has-a-new-theory-of-how-it-should-work/...\n",
      "  -> ⏭️ Skipping https://www.zdnet.com/article/the-man-who-invented-the-web-has-a-new-theory-of-how-it-should-work/ due to failed or missing cache entry.\n",
      "  -> Processing insights for https://github.com/bigskysoftware/htmx...\n",
      "  -> ✅ Successfully generated 5 insights for https://github.com/bigskysoftware/htmx\n",
      "  -> Processing insights for https://plone.org/...\n",
      "  -> ✅ Successfully generated 5 insights for https://plone.org/\n",
      "✅ AI insights generation complete.\n"
     ]
    }
   ],
   "source": [
    "# Cell 5: Generate 5 AI Insights per URL\n",
    "secretsauce.generate_multi_insights(job)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b7dd1492-db0f-4d2e-a536-b45b6b5b1453",
   "metadata": {},
   "source": [
    "## Cell 6: Display Final Results Log\n",
    "This displays the raw data log, showing 5 rows for each URL processed."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "2a2e6e1c-6d72-47ca-9549-157420d435a5",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "📊 Displaying raw insights log...\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<div>\n",
       "<style scoped>\n",
       "    .dataframe tbody tr th:only-of-type {\n",
       "        vertical-align: middle;\n",
       "    }\n",
       "\n",
       "    .dataframe tbody tr th {\n",
       "        vertical-align: top;\n",
       "    }\n",
       "\n",
       "    .dataframe thead th {\n",
       "        text-align: right;\n",
       "    }\n",
       "</style>\n",
       "<table border=\"1\" class=\"dataframe\">\n",
       "  <thead>\n",
       "    <tr style=\"text-align: right;\">\n",
       "      <th></th>\n",
       "      <th>url</th>\n",
       "      <th>title</th>\n",
       "      <th>insight_type</th>\n",
       "      <th>insight</th>\n",
       "      <th>rationale</th>\n",
       "    </tr>\n",
       "  </thead>\n",
       "  <tbody>\n",
       "    <tr>\n",
       "      <th>0</th>\n",
       "      <td>https://htmx.org/</td>\n",
       "      <td>&lt;/&gt; htmx - high power tools for html</td>\n",
       "      <td>Primary Topic</td>\n",
       "      <td>The webpage's primary subject is 'htmx', a technology described as a powerfu...</td>\n",
       "      <td>The URL (htmx.org) and the title ('htmx - high power tools for html') explic...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>1</th>\n",
       "      <td>https://htmx.org/</td>\n",
       "      <td>&lt;/&gt; htmx - high power tools for html</td>\n",
       "      <td>Target Audience</td>\n",
       "      <td>The content is intended for web developers, programmers, and individuals eng...</td>\n",
       "      <td>Keywords like 'htmx', 'html', and 'tools' are technical terms relevant to we...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>2</th>\n",
       "      <td>https://htmx.org/</td>\n",
       "      <td>&lt;/&gt; htmx - high power tools for html</td>\n",
       "      <td>Key Entity</td>\n",
       "      <td>The central entity the page focuses on is 'htmx', representing a specific we...</td>\n",
       "      <td>The domain name 'htmx.org' and its prominent inclusion in the title confirm ...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>3</th>\n",
       "      <td>https://htmx.org/</td>\n",
       "      <td>&lt;/&gt; htmx - high power tools for html</td>\n",
       "      <td>Commercial Intent</td>\n",
       "      <td>The webpage expresses a commercial intent related to securing or acknowledgi...</td>\n",
       "      <td>The H1 tag, 'Platinum Sponsor', directly indicates a focus on high-level fin...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>4</th>\n",
       "      <td>https://htmx.org/</td>\n",
       "      <td>&lt;/&gt; htmx - high power tools for html</td>\n",
       "      <td>Content Format</td>\n",
       "      <td>The page's content prioritization or structure gives significant prominence ...</td>\n",
       "      <td>An H1 tag typically signifies the main heading or topic of a page. Its use f...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>5</th>\n",
       "      <td>https://github.com/bigskysoftware/htmx</td>\n",
       "      <td>GitHub - bigskysoftware/htmx: &lt;/&gt; htmx - high power tools for HTML</td>\n",
       "      <td>Primary Topic</td>\n",
       "      <td>The central theme of the page revolves around the 'htmx' library, which prov...</td>\n",
       "      <td>The URL explicitly names 'htmx' and the title clearly states 'htmx - high po...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>6</th>\n",
       "      <td>https://github.com/bigskysoftware/htmx</td>\n",
       "      <td>GitHub - bigskysoftware/htmx: &lt;/&gt; htmx - high power tools for HTML</td>\n",
       "      <td>Key Entity</td>\n",
       "      <td>The main entity presented is the open-source 'htmx' project, which is hosted...</td>\n",
       "      <td>The URL and title identify 'bigskysoftware/htmx' as the project and its owne...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>7</th>\n",
       "      <td>https://github.com/bigskysoftware/htmx</td>\n",
       "      <td>GitHub - bigskysoftware/htmx: &lt;/&gt; htmx - high power tools for HTML</td>\n",
       "      <td>Target Audience</td>\n",
       "      <td>The page is designed for web developers, particularly those involved in fron...</td>\n",
       "      <td>The description 'high power tools for HTML' and the context of a GitHub repo...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>8</th>\n",
       "      <td>https://github.com/bigskysoftware/htmx</td>\n",
       "      <td>GitHub - bigskysoftware/htmx: &lt;/&gt; htmx - high power tools for HTML</td>\n",
       "      <td>Content Format</td>\n",
       "      <td>The page likely features standard GitHub repository content such as project ...</td>\n",
       "      <td>As a GitHub URL, it implies typical repository structure. The H1 'Search cod...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>9</th>\n",
       "      <td>https://github.com/bigskysoftware/htmx</td>\n",
       "      <td>GitHub - bigskysoftware/htmx: &lt;/&gt; htmx - high power tools for HTML</td>\n",
       "      <td>Commercial Intent</td>\n",
       "      <td>The page's primary goal is to promote the adoption and development of an ope...</td>\n",
       "      <td>Hosting an 'htmx' 'tool' on GitHub signifies an open-source project focused ...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>10</th>\n",
       "      <td>https://plone.org/</td>\n",
       "      <td>Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...</td>\n",
       "      <td>Primary Topic</td>\n",
       "      <td>The page's central theme revolves around Content Management Systems, specifi...</td>\n",
       "      <td>The title explicitly mentions 'Plone CMS', 'Open Source Content Management',...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>11</th>\n",
       "      <td>https://plone.org/</td>\n",
       "      <td>Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...</td>\n",
       "      <td>Target Audience</td>\n",
       "      <td>The page targets enterprises, businesses, and developers who are looking for...</td>\n",
       "      <td>Keywords like 'Enterprise Level CMS', 'Secure', 'Free and OpenSource', and '...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>12</th>\n",
       "      <td>https://plone.org/</td>\n",
       "      <td>Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...</td>\n",
       "      <td>Key Entity</td>\n",
       "      <td>The main entity being promoted and described on this webpage is 'Plone CMS'.</td>\n",
       "      <td>The name 'Plone CMS' is repeated and forms the core identifier within the ti...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>13</th>\n",
       "      <td>https://plone.org/</td>\n",
       "      <td>Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...</td>\n",
       "      <td>Commercial Intent</td>\n",
       "      <td>The page aims to drive adoption of Plone CMS by showcasing its benefits and ...</td>\n",
       "      <td>Despite being 'Free and OpenSource', the emphasis on 'Enterprise Level', 'Se...</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>14</th>\n",
       "      <td>https://plone.org/</td>\n",
       "      <td>Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...</td>\n",
       "      <td>Content Format</td>\n",
       "      <td>The page likely provides an informational and descriptive overview of Plone ...</td>\n",
       "      <td>The descriptive nature of the title ('Open Source Content Management', 'Ente...</td>\n",
       "    </tr>\n",
       "  </tbody>\n",
       "</table>\n",
       "</div>"
      ],
      "text/plain": [
       "                                       url  \\\n",
       "0                        https://htmx.org/   \n",
       "1                        https://htmx.org/   \n",
       "2                        https://htmx.org/   \n",
       "3                        https://htmx.org/   \n",
       "4                        https://htmx.org/   \n",
       "5   https://github.com/bigskysoftware/htmx   \n",
       "6   https://github.com/bigskysoftware/htmx   \n",
       "7   https://github.com/bigskysoftware/htmx   \n",
       "8   https://github.com/bigskysoftware/htmx   \n",
       "9   https://github.com/bigskysoftware/htmx   \n",
       "10                      https://plone.org/   \n",
       "11                      https://plone.org/   \n",
       "12                      https://plone.org/   \n",
       "13                      https://plone.org/   \n",
       "14                      https://plone.org/   \n",
       "\n",
       "                                                                              title  \\\n",
       "0                                              </> htmx - high power tools for html   \n",
       "1                                              </> htmx - high power tools for html   \n",
       "2                                              </> htmx - high power tools for html   \n",
       "3                                              </> htmx - high power tools for html   \n",
       "4                                              </> htmx - high power tools for html   \n",
       "5                GitHub - bigskysoftware/htmx: </> htmx - high power tools for HTML   \n",
       "6                GitHub - bigskysoftware/htmx: </> htmx - high power tools for HTML   \n",
       "7                GitHub - bigskysoftware/htmx: </> htmx - high power tools for HTML   \n",
       "8                GitHub - bigskysoftware/htmx: </> htmx - high power tools for HTML   \n",
       "9                GitHub - bigskysoftware/htmx: </> htmx - high power tools for HTML   \n",
       "10  Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...   \n",
       "11  Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...   \n",
       "12  Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...   \n",
       "13  Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...   \n",
       "14  Plone CMS: Open Source Content Management — Plone: Enterprise Level CMS - Fr...   \n",
       "\n",
       "         insight_type  \\\n",
       "0       Primary Topic   \n",
       "1     Target Audience   \n",
       "2          Key Entity   \n",
       "3   Commercial Intent   \n",
       "4      Content Format   \n",
       "5       Primary Topic   \n",
       "6          Key Entity   \n",
       "7     Target Audience   \n",
       "8      Content Format   \n",
       "9   Commercial Intent   \n",
       "10      Primary Topic   \n",
       "11    Target Audience   \n",
       "12         Key Entity   \n",
       "13  Commercial Intent   \n",
       "14     Content Format   \n",
       "\n",
       "                                                                            insight  \\\n",
       "0   The webpage's primary subject is 'htmx', a technology described as a powerfu...   \n",
       "1   The content is intended for web developers, programmers, and individuals eng...   \n",
       "2   The central entity the page focuses on is 'htmx', representing a specific we...   \n",
       "3   The webpage expresses a commercial intent related to securing or acknowledgi...   \n",
       "4   The page's content prioritization or structure gives significant prominence ...   \n",
       "5   The central theme of the page revolves around the 'htmx' library, which prov...   \n",
       "6   The main entity presented is the open-source 'htmx' project, which is hosted...   \n",
       "7   The page is designed for web developers, particularly those involved in fron...   \n",
       "8   The page likely features standard GitHub repository content such as project ...   \n",
       "9   The page's primary goal is to promote the adoption and development of an ope...   \n",
       "10  The page's central theme revolves around Content Management Systems, specifi...   \n",
       "11  The page targets enterprises, businesses, and developers who are looking for...   \n",
       "12     The main entity being promoted and described on this webpage is 'Plone CMS'.   \n",
       "13  The page aims to drive adoption of Plone CMS by showcasing its benefits and ...   \n",
       "14  The page likely provides an informational and descriptive overview of Plone ...   \n",
       "\n",
       "                                                                          rationale  \n",
       "0   The URL (htmx.org) and the title ('htmx - high power tools for html') explic...  \n",
       "1   Keywords like 'htmx', 'html', and 'tools' are technical terms relevant to we...  \n",
       "2   The domain name 'htmx.org' and its prominent inclusion in the title confirm ...  \n",
       "3   The H1 tag, 'Platinum Sponsor', directly indicates a focus on high-level fin...  \n",
       "4   An H1 tag typically signifies the main heading or topic of a page. Its use f...  \n",
       "5   The URL explicitly names 'htmx' and the title clearly states 'htmx - high po...  \n",
       "6   The URL and title identify 'bigskysoftware/htmx' as the project and its owne...  \n",
       "7   The description 'high power tools for HTML' and the context of a GitHub repo...  \n",
       "8   As a GitHub URL, it implies typical repository structure. The H1 'Search cod...  \n",
       "9   Hosting an 'htmx' 'tool' on GitHub signifies an open-source project focused ...  \n",
       "10  The title explicitly mentions 'Plone CMS', 'Open Source Content Management',...  \n",
       "11  Keywords like 'Enterprise Level CMS', 'Secure', 'Free and OpenSource', and '...  \n",
       "12  The name 'Plone CMS' is repeated and forms the core identifier within the ti...  \n",
       "13  Despite being 'Free and OpenSource', the emphasis on 'Enterprise Level', 'Se...  \n",
       "14  The descriptive nature of the title ('Open Source Content Management', 'Ente...  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Cell 6: Display Final Results Log\n",
    "secretsauce.display_results_log(job)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "82eda234-a7d1-46a2-9e36-ddb2f413b0ae",
   "metadata": {},
   "source": [
    "## Cell 7: Export to Excel\n",
    "This saves the final log to a formatted .xlsx file."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "ae9cdd16-220c-4b06-b681-112825fd84ba",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "📄 Exporting data to Excel...\n",
      "✅ Success! Data exported to 'faquilizer-02_output.xlsx'\n"
     ]
    }
   ],
   "source": [
    "# Cell 7: Export to Excel\n",
    "secretsauce.export_to_excel(job)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "9fecb314-b080-42a2-a395-9b9398e2e071",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.12.11"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
```

And the saved `.xlsx` file:

```bash
[mike@nixos:~/repos/pipulate/Notebooks/Client_Work/faquilizer2]$ vim faquilizer-02_output.xlsx
```

This is what vim shows me:

```plaintext
" zip.vim version v34
" Browsing zipfile /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/faquilizer-02_output.xlsx
" Select a file with cursor and press ENTER

docProps/app.xml
docProps/core.xml
xl/theme/theme1.xml
xl/worksheets/sheet1.xml
xl/styles.xml
_rels/.rels
xl/workbook.xml
xl/_rels/workbook.xml.rels
[Content_Types].xml
```

...so I double-click it on my desktop and it loads right into `LibreOffice
Calc`, but not the log-file data with the AI responses. This is huge progress
and barely even coming up on 7:00 AM this is good news. Another sort of "success
assured" we have lift-off moment Kitty Hawk moment.

## Beyond Excel: Intermediate CSVs and Dynamic Prompts

I think I may want to have more steps of the sausage factory left on the hard
drive with a good naming convention including `.csv`-files so one can follow the
progress and easily double-click to view them directly in JupyterLab. It shows
`.csv` files natively very nicely, but not `.xlsx` files. But I need both, the
prior for transparency and following progress and the later for something with
pretty formatting all set up already that gets inherited on a Google Sheets
import. 

This is not an implementation request Gemini so much as it is to review the work
so far and to think through next steps.

It's wayyyy too much to ask an SEO to go in and edit the `secretsauce.py` file
but if it *dynamically reads in* a `prompt.txt` file every time we're golden.
Even then once the `import secretsauce` import occurs which caches it in REPL
memory, the dynamic loading of the text-file will let the user fine-tune to the
prompt for the AI. And we don't want caching of the AI's response because much
fine-tuning will be happening. You might call it the secret sauce of the secret
sauce. Pretty much everything is STILL generically templated and not giving out
anything about the client yet, and I could roll this into the Pipulate repo
proper. See where we're going with all this?

**Gemini**: Yes, I'm with you, and this is a fantastic "plan in-hand" success story for 6:00 AM. It's a huge step forward. You've successfully executed the core of the new workflow: the caching works, the 1-to-many AI calls work, and the data is persisting.

Let's review the work and think through the excellent next steps you've identified.

### What's Working and Why It's a "Kitty Hawk Moment" ✈️

1.  **Successful Execution:** The notebook ran from top to bottom. You provided inputs, cached the data, queried the AI for multiple insights per URL, and got structured data back. The core engine flies.
2.  **Resilience in Practice:** You can see the `⏭️ Skipping...` message in the output. Your `sqlitedict` caching and error handling worked perfectly, allowing the script to proceed even when one URL failed to fetch. This proves the robustness of the design.
3.  **The "Log File" is Born:** The Pandas DataFrame output is exactly the "long format" we planned. It's clean, machine-readable, and perfectly primed for the next steps of transformation and analysis.
4.  **Proof of Philosophy:** You've just demonstrated that a complex, multi-step, AI-driven workflow *can* be represented as a simple, linear, seven-cell notebook. This validates your entire "Literate Programming" approach.

The `LibreOffice Calc` issue isn't a failure; it's just the next piece of friction to smooth out. The data *is* there, but the `export_to_excel` function needs a slight adjustment to handle the new "log-file" structure correctly. This is a minor tweak, not a fundamental problem.

---

### Thinking Through the Next Steps

Your insights on what to do next are spot-on. They're all about refining the user experience and making this template even more powerful and reusable.

#### 1. Intermediate CSVs for Transparency (The Sausage Factory Tour) 🏭

This is a brilliant idea. Leaving `.csv` breadcrumbs at each major data transformation step serves multiple purposes:
* **Debuggability:** It's infinitely easier to see where a process went wrong if you can inspect the data *before* and *after* a key step.
* **Transparency:** For a user (especially a non-coder SEO), seeing `step_4_cached_data.csv` and `step_5_ai_insights.csv` makes the process less of a "black box" and more of a visible assembly line.
* **JupyterLab Ergonomics:** As you said, JupyterLab has a great built-in CSV viewer. This makes the workflow more interactive and user-friendly *within the native environment*.

#### 2. Dynamic `prompt.txt` for User Empowerment 🪄

This is the most critical refinement. You are absolutely right that asking a user to edit a `.py` file is a bridge too far. The workflow's "secret sauce" is the prompt itself, and it needs to be easily accessible.
* **The Plan:** Create a `prompt.txt` file alongside `secretsauce.py`.
* **Implementation:** Modify the `generate_multi_insights` function to read this file on every execution.
* **The `import` Cache Trap:** You wisely identified that Python's module caching would be a problem. Because `secretsauce.py` is imported once, any variable defined at the module level (like a prompt loaded from a file) would be stuck. By reading the `prompt.txt` file *inside* the `generate_multi_insights` function, you ensure that the latest version is used every single time the cell is run. This is the key to enabling a rapid, iterative "tweak the prompt, re-run the cell" workflow for the user.
* **AI Cache:** You're also right to not cache the AI's response in this scenario. The goal is fine-tuning, which means the AI's output *should* change as the prompt changes. The `pipulate` state (`ai_multi_insights`) is for resilience (in case of a kernel restart mid-run), not for caching results against prompt changes.

---

### The Vision: A Universal, Reusable Template

Putting it all together, the path forward is crystal clear. You're evolving the "Master Template" into a highly reusable, user-friendly blueprint for a whole class of AI-driven enrichment tasks.

The final form will be a self-contained folder that a user can copy, which contains:
1.  **`workflow.ipynb`:** The clean, readable "control panel."
2.  **`secretsauce.py`:** The robust, hidden engine.
3.  **`prompt.txt`:** The user's "tuning knob" for the AI, allowing them to adapt the entire workflow to their specific needs without ever touching the engine.

This isn't kicking N8N's butt anymore; this is a different sport entirely. You're building a system that teaches literacy and empowers customization, rather than trapping users in a GUI. It's a framework for thought, executed in a tool that is, as you say, "too big to fail."

You've got liftoff. Now it's just a matter of refining the flight controls.

---

## Book Analysis

### Ai Editorial Take
This article is a compelling demonstration of applied AI engineering and thoughtful workflow design. It not only showcases a significant technical achievement—the `Faquillizer 2`'s 1-to-many AI insights—but also weaves in critical considerations for developer experience and future scalability. The author's blend of technical detail with philosophical reflection on literate programming and digital flow-state elevates the entry beyond a mere code walkthrough. Its potential lies in serving as a foundational case study for building resilient, customizable, and user-empowering AI systems, particularly valuable for technical audiences seeking practical blueprints.

### Title Brainstorm
* **Title Option:** Automating AI Insights: Pipulate, SQLitedict, and Dynamic Prompts in Jupyter
  * **Filename:** `automating-ai-insights-pipulate-sqlitedict.md`
  * **Rationale:** Highlights the key technologies and methodologies used, making it discoverable for developers looking for practical implementation details with specific tools.
* **Title Option:** Faquillizer 2: Scaling AI Insights with a Resilient 1-to-Many Workflow
  * **Filename:** `faquillizer-2-scaling-ai-insights-resilient-workflow.md`
  * **Rationale:** Clearly states the project name, the key advancement (scaling AI insights), and a core feature (resilience/1-to-many workflow). It's technical, descriptive, and hints at the progress made.
* **Title Option:** From 1-to-1 to 1-to-5: Building the Next-Gen AI Data Enrichment Pipeline
  * **Filename:** `ai-data-enrichment-pipeline-1-to-5.md`
  * **Rationale:** Emphasizes the core quantifiable improvement in AI response density and positions the project as a 'next-gen' solution, appealing to those interested in advanced AI applications.
* **Title Option:** Literate Programming in Action: Crafting User-Empowering AI Workflows
  * **Filename:** `literate-programming-ai-workflows.md`
  * **Rationale:** Focuses on the philosophical and methodological approach, appealing to readers interested in software design principles, user experience, and the author's unique perspective.

### Content Potential And Polish
- **Core Strengths:**
  - Demonstrates successful implementation of a complex AI workflow, including caching and multi-insight generation.
  - Effectively articulates the "why" behind design choices, such as resilience and user-friendly interfaces (dynamic `prompt.txt`, intermediate CSVs).
  - Combines technical detail (code snippets, function explanations) with the author's reflective, narrative voice.
  - Clearly identifies and resolves practical issues (Jupyter Notebook `import` caching, `xlsx` vs. `csv` for viewing).
- **Suggestions For Polish:**
  - Explicitly show the structure of the `prompt.txt` file and how it's dynamically read in `secretsauce.py` once implemented.
  - Include a small screenshot or more descriptive text of the `LibreOffice Calc` output once the `export_to_excel` issue is resolved.
  - Consider dedicating a brief section to the "synthetic data" and "vectors" idea mentioned early on, elaborating on the future vision for categorizing articles.

### Next Step Prompts
- Develop the `prompt.txt` dynamic loading mechanism in `secretsauce.py` and provide an example of a fine-tuned `prompt.txt`.
- Implement the intermediate CSV export functionality in `secretsauce.py` for each major data transformation step, documenting the new file paths and content.
- Refine the `export_to_excel` function to correctly handle and format the new log-file structure for better presentation and Google Sheets import.

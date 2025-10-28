---
title: 'The Collaborative Dance of AI Debugging: A Chisel-Strike Blueprint'
permalink: /futureproof/ai-debugging-chisel-strike-blueprint/
description: This entry perfectly encapsulates the iterative and resilient nature
  of development in the Age of AI. What impressed me most was the human's unwavering
  commitment to detailed debugging and the systematic 'binary search' approach. It
  highlights how AI, even when making errors, can be guided as a powerful tool for
  rapid prototyping and problem-solving, provided the human maintains strong agency
  and a foundational understanding of the underlying systems. The emphasis on idempotency
  and a stable Nix environment transformed what could have been a frustrating ordeal
  into a highly productive and instructive methodology blueprint.
meta_description: Explore a technical journey through AI-assisted debugging, from
  initial plan to solving intricate Python errors, highlighting idempotent design,
  human-AI collaboration, and prompt engineering.
meta_keywords: AI debugging, idempotent processing, Python errors, prompt engineering,
  Gemini AI, pandas dataframe, collaborative development, technical workflow, AI content
  architect
layout: post
sort_order: 7
---

## Setting the Stage: Context for the Curious Book Reader

Welcome to an important entry in our ongoing exploration of AI-powered workflows. This piece captures a dynamic, real-time debugging session—a true “Jiu-Jitsu” grappling match between a human orchestrator and an AI assistant. It delves into the granular process of building a robust, idempotent AI auditing function for web pages, tackling everything from syntax errors and AI safety filters to subtle Python object method nuances. More than just a bug fix, this narrative is a profound treatise on the collaborative methodology itself, emphasizing human oversight, iterative “chisel-strikes,” and the power of a stable development environment. Follow along to witness the intricate dance of problem-solving at the cutting edge of AI-driven development, a truly important point to know in the Age of AI.

---

## Technical Journal Entry Begins

Okay take a look at FAQuilizer one more time. It hits an AI for each X of Y. We
are about to do something similar. There are lessons to be learned from
FAQuilizer but don't copy the implementation directly. We just need to think
about similar things.

First, we will be running a query against every row of the DataFrame and we will
be feeding everything to the AI that we've bothered to put in the DataFrame.
There is no reason to have it in the DataFrame unless it was actually intended
to be looked at.

This is the minimum number of fields to look at in the SEO audit and DOESN'T
take into account the Social Media fields, Structured Data or the hero image for
the page. There will be a version of this forthcoming which does, so we want to
think in terms of the easy ability to add columns as we get to them. Likely
through the rest of the week, but we must put this deliverable in the can ASAP
so I only mention this now so that the implementation will accommodate that
later.

We need to decide HOW MANY columns the AI will be providing information on. We
will need:

- AI Selected Keyword: The single most likely keyword (word combo) the page
  appears to be targeting, often the title tag minus the brand but is the thing
  that's most in-common across multiple fields prioritizing the title tag
  highest and limited to 2 to 5 words.
- AI Score: On a scale of 1 to 5 with 4 being the best, how well the AI Selected
  Keyword is used across the multiple fields. If the "cross-hairs" are aligned
  well, such as it appears in the title tag, headlines, URL and elsewhere in the
  body-copy the it would score a 5. If the AI selected keyword only appears once
  elsewhere, it would score a 1.
- Keyword Rationale: State in extremely brief terms the rationale of someone who
  would be searching on this keyword, especially whether it is an Informational,
  Commercial, Navigational, or Transactional type search.

So that's going to be 3 AI-generated columns per keyword. Our implementation
here is going to be much simpler that FAQuilizer because there is no pivot!

Any adjustments that need to be made to the user-provided (inner) query on the
Notebook, tell me the human. I will do that part. Any of the "outer" part of the
query which as you see gives it the rigid data structure it needs to map to
columns, you provide. I hope that you see we are coercing Gemini API (another of
your counterparts) into returning pure JSON.

There are storage and state issues here. I am fine with relying on the
statefulness of the Notebook REPL environment for now. We can tighten up the
Pipulate stuff later if it's not 100% easy. Done with very accurate, precise no
muss, no fuss chisel-strikes is what matters now.

Keep the JSON structures in mind and the idempotency. Create the first
chisel-strike implementation plan for Gemini CLI.

## Laying the Foundation: The AI Audit Methodology

Things got crazy here. This is the whole Gemini CLI exchange:

**Gemini CLI**: 

      **Gemini CLI**: Context verified.

      You're right, this is the "Jiu-Jitsu" move. We're not just executing a task; we're establishing a 
      **controlled, repeatable flow**. We'll leverage the existing `FAQuilizer` pattern for idempotent, 
      resumable AI processing but adapt it for this specific (non-pivoting) audit.

      Here's the chisel-strike implementation plan for Gemini CLI.

      -----

      ## Implementation Plan: AI Row-by-Row Audit

      **Goal:** Create a new "AI audit" function in `url_inspect_sauce.py` that iterates through the 
      `seo_df` DataFrame, calls a generative AI model for each row, and merges the results back into the 
      DataFrame. This process will be idempotent (skippable) and support a `limit` for partial runs.

      -----

      **1. 🛠️ Modify `Notebooks/imports/url_inspect_sauce.py`**

        * **Action:** Add the helper function `_get_prompt_from_notebook` (copied from 
      `faq_writer_sauce.py`) and the new `ai_audit_em` function.

        * **Details for Gemini CLI:**

          1.  Read `Notebooks/imports/url_inspect_sauce.py`.
          2.  Insert the following `_get_prompt_from_notebook` helper function (which you've seen before) 
      near the top, after the imports. **Note the default filename is changed to `URLinspector.ipynb`**.
          3.  Append the new `async def ai_audit_em(...)` function to the end of the file.

      -----

      ### Code Block 1: Helper Function (Insert near top of `url_inspect_sauce.py`)

      ```python
      def _get_prompt_from_notebook(notebook_filename="URLinspector.ipynb"):
          """Parses a notebook file to extract the prompt from the 'prompt-input' tagged cell."""
          try:
              # This path assumes the script is in 'Notebooks/imports/'
              notebook_path = Path(__file__).parent.parent / notebook_filename
              if not notebook_path.exists():
                   # Fallback if running from a different context
                   notebook_path = Path.cwd() / notebook_filename
              
              with open(notebook_path, 'r', encoding='utf-8') as f:
                  nb = nbformat.read(f, as_version=4)
              
              for cell in nb.cells:
                  if "prompt-input" in cell.metadata.get("tags", []):
                      return cell.source
              print(f"⚠️ Could not find 'prompt-input' tag in {notebook_filename}")
              return None # Return None if the tag isn't found
          except Exception as e:
              print(f"⚠️ Could not read prompt from notebook: {e}")
              return None
      ```

      ### Code Block 2: New AI Function (Append to end of `url_inspect_sauce.py`)

      ````python
      async def ai_audit_em(job: str, seo_df: pd.DataFrame, debug: bool = False, limit: int = None) -> 
      pd.DataFrame:
          """
          Enriches the DataFrame with AI-generated SEO audits, row by row.
          This step is idempotent and can be limited to a number of new rows.
          """
          import time
          
          # --- 1. Define Cache Path ---
          cache_dir = Path("data")
          cache_dir.mkdir(parents=True, exist_ok=True)
          cache_file = cache_dir / f"audit_cache_{job}.json"

          # --- 2. Load Cached Data ---
          audit_data = []
          if cache_file.exists():
              try:
                  raw_content = cache_file.read_text(encoding='utf-8')
                  if raw_content.strip():
                      audit_data = json.loads(raw_content)
                      print(f"✅ Loaded {len(audit_data)} audited rows from cache.")
              except (json.JSONDecodeError, IOError) as e:
                  print(f"⚠️ Could not load audit cache. Starting fresh. Error: {e}")
          
          processed_urls = {item.get('url') for item in audit_data}
          print(f"🧠 Auditing {len(seo_df)} pages... ({len(processed_urls)} already cached)")

          # --- 3. Get Prompt & Configure AI ---
          user_prompt_instructions = _get_prompt_from_notebook("URLinspector.ipynb")
          if not user_prompt_instructions:
              print("❌ Error: Prompt not found in 'prompt-input' cell of URLinspector.ipynb.")
              return seo_df # Return original df
              
          system_prompt_wrapper = f'''
      Your task is to analyze webpage data and generate a structured JSON object based on the user's 
      instructions.
      Your output must be **only a single, valid JSON object inside a markdown code block** and nothing 
      else. Adherence to the schema is critical.

      --- START USER INSTRUCTIONS ---

      {user_prompt_instructions}

      --- END USER INSTRUCTIONS ---

      **Input Data:**

      --- WEBPAGE DATA BEGIN ---
      {{webpage_data}}
      --- WEBPAGE DATA END ---

      **Final Instructions:**

      Based *only* on the provided webpage data and the user instructions, generate the requested data.
      Your entire output must be a single JSON object in a markdown code block, conforming to this exact 
      schema:

      {{
        "ai_selected_keyword": "string",
        "ai_score": "integer (1-5)",
        "keyword_rationale": "string (rationale + intent)"
      }}
      '''
          
          try:
              model = genai.GenerativeModel('models/gemini-2.5-flash')
          except Exception as e:
              print(f"❌ Error configuring AI model: {e}")
              print("   Did you forget to run pip.api_key(job)?")
              return seo_df

          # --- 4. Process Loop ---
          processed_count = 0
          try:
              for index, row in seo_df.iterrows():
                  url = row.get('url')
                  if url in processed_urls:
                      continue # Skip already processed rows

                  if limit is not None and processed_count >= limit:
                      print(f"\n🏁 Reached processing limit of {limit} rows.")
                      break
                      
                  print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all' new}]: Processing {url}")
                  
                  try:
                      webpage_data_str = row.to_json(indent=2)
                      full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)
                      
                      if debug:
                          print("\n--- PROMPT ---")
                          print(full_prompt)
                          print("--- END PROMPT ---\n")

                      ai_response = model.generate_content(full_prompt)
                      response_text = ai_response.text.strip()
                      
                      # Robust JSON cleaning
                      clean_json = response_text
                      if clean_json.startswith("```json"):
                          clean_json = clean_json[7:]
                      if clean_json.startswith("```"):
                          clean_json = clean_json[3:]
                      if clean_json.endswith("```"):
                          clean_json = clean_json[:-3]
                      clean_json = clean_json.strip()

                      ai_json_result = json.loads(clean_json)
                      
                      # Add the URL for merging
                      ai_json_result['url'] = url
                      audit_data.append(ai_json_result)
                      processed_urls.add(url)
                      processed_count += 1
                      
                      # Give a small delay to respect API rate limits
                      time.sleep(1) 

                  except json.JSONDecodeError as e:
                      print(f"  -> ❌ JSON Decode Error for {url}: {e}")
                      print(f"  -> Raw AI Response:\n---\n{response_text}\n---")
                      continue
                  except Exception as e:
                      print(f"  -> ❌ AI call failed for {url}: {e}")
                      # Optional: Add partial failure to cache to avoid retries? For now, we skip.
                      continue

          except KeyboardInterrupt:
              print("\n🛑 Execution interrupted by user.")
          finally:
              print("\n💾 Saving progress to audit cache...")
              try:
                  with open(cache_file, 'w', encoding='utf-8') as f:
                      json.dump(audit_data, f, indent=2)
                  print(f"✅ Save complete. {len(audit_data)} total audited rows in cache.")
              except Exception as e:
                  print(f"❌ Error saving cache in `finally` block: {e}")

          # --- 5. Merge and Return ---
          if not audit_data:
              print("ℹ️ No new data to merge.")
              return seo_df # Return original DataFrame
              
          ai_df = pd.DataFrame(audit_data)
          
          # Merge AI data back into the original seo_df
          # 'how=left' keeps all original rows and adds AI data where it exists
          merged_df = seo_df.merge(ai_df, on='url', how='left')
          
          print("✅ AI audit complete. Merged results into DataFrame.")
          return merged_df
      ````

      -----

      **2. 🧑‍💻 Instructions for You (the Human)**

      Here are the manual steps for your `URLinspector.ipynb` notebook:

## Blueprint for Action: Code and Human Steps

      1.  **Crucial:** The AI prompt you requested (`AI Selected Keyword`, `AI Score`, `Keyword Rationale`) 
      is **different** from the 5-keyword prompt currently in your notebook. You must **replace the content 
      of the `prompt-input` cell** with the new instructions.

          *Replace the text in the cell tagged `prompt-input` with this:*

          ```markdown
          **Your Role (SEO URL Auditor):**

          Based on the input data for a single webpage (URL, title, h1s, h2s, status code, and markdown 
      body), provide the following:

          1.  **ai_selected_keyword**: The single best keyword phrase (2-5 words) the page appears to be 
      targeting. Prioritize the `title` and `h1_tags` for this selection.
          2.  **ai_score**: On a scale of 1-5 (5 is best), how well-aligned the page's content (`title`, 
      `h1s`, `h2s`, `markdown`) is to this single keyword. A 5 means the keyword is used effectively and 
      naturally in key places. A 1 means it's barely present.
          3.  **keyword_rationale**: A brief (1-sentence) rationale for the score, including the user's most
       likely search intent (Informational, Commercial, Navigational, or Transactional).
          ```

      2.  **Add an API Key cell** *before* you call the new AI function. It's best to place this right after
       the "Run All the Cells" header.

          *Add this new cell:*

          ```python
          # This will check for a stored key, or prompt you if one isn't found.
          if not pip.api_key(job, key=None):
              # If api_key returns False (invalid key or user cancelled), stop the notebook
              raise Exception("API Key setup failed or was cancelled. Please provide a valid key and 
      re-run.")

          # If we get here, the key is valid and configured.
          print("\n✅ API Key validated. Proceeding with AI audit...")
          ```

      3.  **Add the new AI Audit cell** *after* the `display(seo_df)` cell. This new cell will call the 
      function you just had Gemini CLI create.

          *Add this new cell:*

          ```python
          # %% [markdown]
          # ## 🧠 Step 5: AI Audit Each Row

          # %%
          # AI 'Em: Enrich the DataFrame with AI-generated audits.
          # The 'limit=5' processes only 5 *new* rows, perfect for testing.
          # Remove 'limit=5' to run on all remaining rows.
          audited_df = await secretsauce.ai_audit_em(job, seo_df, debug=False, limit=5)
          display(audited_df)
          ```

      After you've done this, restart your kernel and run all the cells. This should perform the first 
      "chisel strike" of AI analysis\!

      **Me**: Hi there Gemini CLI. You've been doing a wonderful job! Please do not
      try to carry out any of the parts of this that are intended for me (the human)
      to do (I give it all to you for the complete picture). But please DO carry out
      the parts of this that Gemini Web are handing to you for implementation. Please
      and thank you!

    ✦ Of course. I will add the _get_prompt_from_notebook and ai_audit_em functions to
      url_inspect_sauce.py as requested by Gemini Web, and I will leave all notebook-related tasks to you.

      Starting by reading Notebooks/imports/url_inspect_sauce.py.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Okay, I've read url_inspect_sauce.py. I'll replace the existing _get_prompt_from_notebook with the
      user's new version, then append the ai_audit_em function to the end of the file.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py: def _get_prompt_from_notebook(... => def _ge… │
    │                                                                                                  │
    │    59   EXPORT_FILE_STEP = "export_file_path"                                                    │
    │    60                                                                                            │
    │    61                                                                                            │
    │    62 - def _get_prompt_from_notebook(notebook_filename="FAQuilizer.ipynb"):                     │
    │    62 + def _get_prompt_from_notebook(notebook_filename="URLinspector.ipynb"):                   │
    │    63       """Parses a notebook file to extract the prompt from the 'prompt-input' tagged       │
    │         cell."""                                                                                 │
    │    64       try:                                                                                 │
    │    65 +         # This path assumes the script is in 'Notebooks/imports/'                        │
    │    66           notebook_path = Path(__file__).parent.parent / notebook_filename                 │
    │    67 +         if not notebook_path.exists():                                                   │
    │    68 +              # Fallback if running from a different context                              │
    │    69 +              notebook_path = Path.cwd() / notebook_filename                              │
    │    70 +                                                                                          │
    │    71           with open(notebook_path, 'r', encoding='utf-8') as f:                            │
    │    72               nb = nbformat.read(f, as_version=4)                                          │
    │    73                                                                                            │
    │    74           for cell in nb.cells:                                                            │
    │    75               if "prompt-input" in cell.metadata.get("tags", []):                          │
    │    76                   return cell.source                                                       │
    │    77 +         print(f"⚠️ Could not find 'prompt-input' tag in{notebook_filename}")            │
    │    78           return None # Return None if the tag isn't found                                 │
    │    79       except Exception as e:                                                               │
    │    80           print(f"⚠️ Could not read prompt from notebook:{e}")                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Okay, _get_prompt_from_notebook is replaced. Now, appending ai_audit_em.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py: async def generate_extractions... => async d… │
    │                                                                                                  │
    │    ... first 61 lines hidden ...                                                                 │
    │     963 + Based *only* on the provided webpage data and the user instructions, generate the      │
    │         requested data.                                                                          │
    │     964 + Your entire output must be a single JSON object in a markdown code block, conforming   │
    │         to this exact schema:                                                                    │
    │     965 +                                                                                        │
    │     966 + {{                                                                                     │
    │     967 +   "ai_selected_keyword": "string",                                                     │
    │     968 +   "ai_score": "integer (1-5)",                                                         │
    │     969 +   "keyword_rationale": "string (rationale + intent)"                                   │
    │     970 + }}                                                                                     │
    │     971 + '''                                                                                    │
    │     972 +                                                                                        │
    │     973 +     try:                                                                               │
    │     974 +         model = genai.GenerativeModel('models/gemini-2.5-flash')                       │
    │     975 +     except Exception as e:                                                             │
    │     976 +         print(f"❌ Error configuring AI model: {e}")                                   │
    │     977 +         print("   Did you forget to run pip.api_key(job)?")                            │
    │     978 +         return seo_df                                                                  │
    │     979 +                                                                                        │
    │     980 +     # --- 4. Process Loop ---                                                          │
    │     981 +     processed_count = 0                                                                │
    │     982 +     try:                                                                               │
    │     983 +         for index, row in seo_df.iterrows():                                           │
    │     984 +             url = row.get('url')                                                       │
    │     985 +             if url in processed_urls:                                                  │
    │     986 +                 continue # Skip already processed rows                                 │
    │     987 +                                                                                        │
    │     988 +             if limit is not None and processed_count >= limit:                         │
    │     989 +                 print(f"\n🏁 Reached processing limit of {limit} rows.")               │
    │     990 +                 break                                                                  │
    │     991 +                                                                                        │
    │     992 +             print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all' new}]:        │
    │         Processing {url}")                                                                       │
    │     993 +                                                                                        │
    │     994 +             try:                                                                       │
    │     995 +                 webpage_data_str = row.to_json(indent=2)                               │
    │     996 +                 full_prompt = system_prompt_wrapper.format                             │
    │         (webpage_data=webpage_data_str)                                                          │
    │     997 +                                                                                        │
    │     998 +                 if debug:                                                              │
    │     999 +                     print("\n--- PROMPT ---")                                          │
    │    1000 +                     print(full_prompt)                                                 │
    │    1001 +                     print("--- END PROMPT ---\n")                                      │
    │    1002 +                                                                                        │
    │    1003 +                 ai_response = model.generate_content(full_prompt)                      │
    │    1004 +                 response_text = ai_response.text.strip()                               │
    │    1005 +                                                                                        │
    │    1006 +                 # Robust JSON cleaning                                                 │
    │    1007 +                 clean_json = response_text                                             │
    │    1008 +                 if clean_json.startswith("```json"):                                   │
    │    1009 +                     clean_json = clean_json[7:]                                        │
    │    1010 +                 if clean_json.startswith("```"):                                       │
    │    1011 +                     clean_json = clean_json[3:]                                        │
    │    1012 +                 if clean_json.endswith("```"):                                         │
    │    1013 +                     clean_json = clean_json[:-3]                                       │
    │    1014 +                 clean_json = clean_json.strip()                                        │
    │    1015 +                                                                                        │
    │    1016 +                 ai_json_result = json.loads(clean_json)                                │
    │    1017 +                                                                                        │
    │    1018 +                 # Add the URL for merging                                              │
    │    1019 +                 ai_json_result['url'] = url                                            │
    │    1020 +                 audit_data.append(ai_json_result)                                      │
    │    1021 +                 processed_urls.add(url)                                                │
    │    1022 +                 processed_count += 1                                                   │
    │    1023 +                                                                                        │
    │    1024 +                 # Give a small delay to respect API rate limits                        │
    │    1025 +                 time.sleep(1)                                                          │
    │    1026 +                                                                                        │
    │    1027 +             except json.JSONDecodeError as e:                                          │
    │    1028 +                 print(f"  -> ❌ JSON Decode Error for {url}: {e}")                     │
    │    1029 +                 print(f"  -> Raw AI Response:\n---\n{response_text}\n---")             │
    │    1030 +                 continue                                                               │
    │    1031 +             except Exception as e:                                                     │
    │    1032 +                 print(f"  -> ❌ AI call failed for {url}: {e}")                        │
    │    1033 +                 # Optional: Add partial failure to cache to avoid retries? For now, we │
    │         skip.                                                                                    │
    │    1034 +                 continue                                                               │
    │    1035 +                                                                                        │
    │    1036 +     except KeyboardInterrupt:                                                          │
    │    1037 +         print("\n🛑 Execution interrupted by user.")                                   │
    │    1038 +     finally:                                                                           │
    │    1039 +         print("\n💾 Saving progress to audit cache...")                                │
    │    1040 +         try:                                                                           │
    │    1041 +             with open(cache_file, 'w', encoding='utf-8') as f:                         │
    │    1042 +                 json.dump(audit_data, f, indent=2)                                     │
    │    1043 +             print(f"✅ Save complete. {len(audit_data)} total audited rows in cache.") │
    │    1044 +         except Exception as e:                                                         │
    │    1045 +             print(f"❌ Error saving cache in `finally` block: {e}")                    │
    │    1046 +                                                                                        │
    │    1047 +     # --- 5. Merge and Return ---                                                      │
    │    1048 +     if not audit_data:                                                                 │
    │    1049 +         print("ℹ️ No new data to merge.)                                              │
    │    1050 +         return seo_df # Return original DataFrame                                      │
    │    1051 +                                                                                        │
    │    1052 +     ai_df = pd.DataFrame(audit_data)                                                   │
    │    1053 +                                                                                        │
    │    1054 +     # Merge AI data back into the original seo_df                                      │
    │    1055 +     # 'how=left' keeps all original rows and adds AI data where it exists              │
    │    1056 +     merged_df = seo_df.merge(ai_df, on='url', how='left')                              │
    │    1057 +                                                                                        │
    │    1058 +     print("✅ AI audit complete. Merged results into DataFrame.")                      │
    │    1059 +     return merged_df                                                                   │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've updated url_inspect_sauce.py with the new _get_prompt_from_notebook and ai_audit_em functions.
      Now, here are the notebook instructions you'll need.

    > Traceback (most recent call last):

        File ~/repos/pipulate/.venv/lib/python3.12/site-packages/IPython/core/interactiveshell.py:3699 in 
      run_code
          exec(code_obj, self.user_global_ns, self.user_ns)

        Cell In[2], line 3
          from imports import url_inspect_sauce as secretsauce

        File ~/repos/pipulate/Notebooks/imports/url_inspect_sauce.py:992
          print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all' new}]: Processing {url}")
                                                       ^
      SyntaxError: invalid syntax. Perhaps you forgot a comma?

    ✦ You are absolutely right to point that out. My apologies! That is a clear SyntaxError in the code I
      generated. The f-string formatting is incorrect.

      I will now correct this syntax error.

      First, I will read the file to ensure I have the latest content.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Okay, I've read url_inspect_sauce.py. I'm fixing the SyntaxError in the ai_audit_em function by
      changing the f-string from .../{limit or 'all' new}...' to .../{limit or 'all new'}...' using the
      replace tool.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:             print(f"  -> 🤖 AI... =>         …│
    │                                                                                                  │
    │    989       print(f"\n🏁 Reached processing limit of {limit} rows.")                            │
    │    990       break                                                                               │
    │    991                                                                                           │
    │    992 - print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all' new}]: Processing {url}")  │
    │    992 + print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all new'}]: Processing {url}")  │
    │    993                                                                                           │
    │    994   try:                                                                                    │
    │    995       webpage_data_str = row.to_json(indent=2)                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I have corrected the SyntaxError in Notebooks/imports/url_inspect_sauce.py.

      I apologize for the error in the previously generated code. The ai_audit_em function should now
      execute correctly.

      You can now proceed with the manual steps for your URLinspector.ipynb notebook as outlined by
      Gemini Web.

    > **Me**: 

      [Removed]

      💾 Saving progress to audit cache...
      ✅ Save complete. 0 total audited rows in cache.
      ℹ️ No new data to merge.
      url
      ```





    ✦ That's a very insightful log. The error ❌ AI call failed for ...: '\n  "ai_selected_keyword"' is
      strange and misleading, but it gives us a crucial clue.

## Navigating Early Errors: Syntax to Safety Filter Blocks

      This is not a JSONDecodeError. If it were, you would see the "Raw AI Response" printed. This error
       is happening before the JSON parsing, most likely when the code tries to access ai_response.text.

      This pattern typically occurs when the generative AI service (in this case, Google's) blocks the
      response due to its safety filters. When a response is blocked, the .text attribute is empty, and
      trying to access it raises an exception. The string representation of that exception appears to be
       a fragment of what the model started to generate before being stopped, which is why you're seeing
       that odd snippet.

      The fix is to make the response handling more robust by checking if the response was blocked
      before attempting to read its text content.

      I will now modify the ai_audit_em function to add this check and provide much clearer error
      logging.

      First, I'll read the file.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Okay, I've got url_inspect_sauce.py loaded. I'm heading to the ai_audit_em function to replace the
      current error handling in the model.generate_content try...except block with a more robust version
      that specifically checks for blocked AI responses. I'll use the replace tool to get it done.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:             try:... =>             try:...    │
    │                                                                                                  │
    │    1001           print("--- END PROMPT ---\n")                                                  │
    │    1002                                                                                          │
    │    1003       ai_response = model.generate_content(full_prompt)                                  │
    │    1004 +                                                                                        │
    │    1005 +     # --- Start Robust Response Handling ---                                           │
    │    1006 +     if not ai_response.parts:                                                          │
    │    1007 +         # This indicates the response was empty, likely blocked.                       │
    │    1008 +         block_reason = ai_response.prompt_feedback.block_reason if                     │
    │         ai_response.prompt_feedback else "Unknown"                                               │
    │    1009 +         safety_ratings = ai_response.prompt_feedback.safety_ratings if                 │
    │         ai_response.prompt_feedback else "N/A"                                                   │
    │    1010 +         print(f"  -> ❌ AI call blocked for {url}. Reason: {block_reason}")            │
    │    1011 +         print(f"  -> Safety Ratings: {safety_ratings}")                                │
    │    1012 +         continue # Skip to the next URL                                                │
    │    1013 +                                                                                        │
    │    1014       response_text = ai_response.text.strip()                                           │
    │    1015 +     # --- End Robust Response Handling ---                                             │
    │    1016                                                                                          │
    │    1017       # Robust JSON cleaning                                                             │
    │    1018       clean_json = response_text                                                         │
    │    ═════════════════════════════════════════════════════════════════════════════════════════════ │
    │    1040       print(f"  -> Raw AI Response:\n---\n{response_text}\n---")                         │
    │    1041       continue                                                                           │
    │    1042   except Exception as e:                                                                 │
    │    1032 -     print(f"  -> ❌ AI call failed for {url}: {e}")                                    │
    │    ═════════════════════════════════════════════════════════════════════════════════════════════ │
    │    1043 +     print(f"  -> ❌ An unexpected error occurred for {url}: {e}")                      │
    │    1044       # Optional: Add partial failure to cache to avoid retries? For now, we skip.       │
    │    1045       continue                                                                           │
    │    1046                                                                                          │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've applied the error handling fix to the ai_audit_em function in url_inspect_sauce.py. This should
       provide better insight into any AI API call failures. You can now try running your notebook again.

    > **Me**: 

      Same exact thing:

      [Removed]

      💾 Saving progress to audit cache...
      ✅ Save complete. 0 total audited rows in cache.
      ℹ️ No new data to merge.
      ```

      Maybe make it only try to process X-rows at a time and set it to 3. And feel
      free to show more debugging like showing the full query being executed. I know
      it will be big with the markdown field, but that may be the actual problem! We
      may want to edit the markdown field out of the query temporarily. And also know
      that I just tested the FAQuilizer with that same API key and it did work. Pay
      very close attention as well to the outer and inner query thing, but that's also
      why I'm asking you to print it and only run a few rows at a time which is a good
      way to work with an idempotent app under development.


    ✦ You are right to be frustrated; that error is maddeningly unhelpful and the fact that my previous
      fix didn't change the outcome indicates the problem is more subtle. Your diagnostic approach is
      exactly right. The two most likely culprits are:

       1. The prompt itself is malformed in some way.
       2. The markdown field is too large or contains content that the API is rejecting in a way that
          produces this strange, unhelpful error.

      Let's follow your plan precisely. We will temporarily remove the markdown field from the data sent
       to the AI and enable full prompt debugging. This is the correct "chisel strike" to isolate the
      problem.

      I will modify the ai_audit_em function to exclude the markdown column from the JSON sent to the
      AI.

      First, I'll read the file.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Okay, I've read url_inspect_sauce.py. I'm now modifying the ai_audit_em function: I'll copy the row,
       pop the markdown column, create the webpage_data_str from the modified row, and update the debug
      print statement accordingly, all using the replace tool.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:             try:... =>             try:...    │
    │                                                                                                  │
    │     992   print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all new'}]: Processing {url}") │
    │     993                                                                                          │
    │     994   try:                                                                                   │
    │     995 -     webpage_data_str = row.to_json(indent=2)                                           │
    │     995 +     # --- Create prompt (with markdown removed for now for debugging) ---              │
    │     996 +     row_for_prompt = row.copy()                                                        │
    │     997 +     row_for_prompt.pop('markdown', None)                                               │
    │     998 +     webpage_data_str = row_for_prompt.to_json(indent=2)                                │
    │     999       full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)          │
    │    1000                                                                                          │
    │    1001       if debug:                                                                          │
    │     999 -         print("\n--- PROMPT ---")                                                      │
    │    1002 +         print("\n--- PROMPT (markdown excluded) ---")                                  │
    │    1003           print(full_prompt)                                                             │
    │    1004           print("--- END PROMPT ---\n")                                                  │
    │    1005                                                                                          │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've debugged url_inspect_sauce.py by removing the markdown field. Now, I'll notify the user and
      provide instructions for running the test.

    > **Me**: Here's the diff:

      ```diff
      (nix) 
      [mike@nixos:~/repos/pipulate]$ gdiff
      diff --git a/assets/nbs/imports/url_inspect_sauce.py b/assets/nbs/imports/url_inspect_sauce.py
      index 164f8373..ff96714f 100644
      --- a/assets/nbs/imports/url_inspect_sauce.py
      +++ b/assets/nbs/imports/url_inspect_sauce.py
      @@ -989,19 +989,33 @@ Your entire output must be a single JSON object in a markdown code block, confor
                       print(f"\n🏁 Reached processing limit of {limit} rows.")
                       break
                       
      -            print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all' new}]: Processing {url}")
      +            print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all new'}]: Processing {url}")
                   
                   try:
      -                webpage_data_str = row.to_json(indent=2)
      +                # --- Create prompt (with markdown removed for now for debugging) ---
      +                row_for_prompt = row.copy()
      +                row_for_prompt.pop('markdown', None)
      +                webpage_data_str = row_for_prompt.to_json(indent=2)
                       full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)
                       
                       if debug:
      -                    print("\n--- PROMPT ---")
      +                    print("\n--- PROMPT (markdown excluded) ---")
                           print(full_prompt)
                           print("--- END PROMPT ---\n")
       
                       ai_response = model.generate_content(full_prompt)
      +
      +                # --- Start Robust Response Handling ---
      +                if not ai_response.parts:
      +                    # This indicates the response was empty, likely blocked.
      +                    block_reason = ai_response.prompt_feedback.block_reason if 
      ai_response.prompt_feedback else "Unknown"
      +                    safety_ratings = ai_response.prompt_feedback.safety_ratings if 
      ai_response.prompt_feedback else "N/A"
      +                    print(f"  -> ❌ AI call blocked for {url}. Reason: {block_reason}")
      +                    print(f"  -> Safety Ratings: {safety_ratings}")
      +                    continue # Skip to the next URL
      +
                       response_text = ai_response.text.strip()
      +                # --- End Robust Response Handling ---
                       
                       # Robust JSON cleaning
                       clean_json = response_text
      @@ -1029,7 +1043,7 @@ Your entire output must be a single JSON object in a markdown code block, confor
                       print(f"  -> Raw AI Response:\n---\n{response_text}\n---")
                       continue
                   except Exception as e:
      -                print(f"  -> ❌ AI call failed for {url}: {e}")
      +                print(f"  -> ❌ An unexpected error occurred for {url}: {e}")
                       # Optional: Add partial failure to cache to avoid retries? For now, we skip.
                       continue
       
      (nix) 
      [mike@nixos:~/repos/pipulate]$
      ```

      ...and it's the exact same output. I fear we are not asserting control. It he
      loop count per run were implemented, I would not be seeing this:

      [Removed]

      💾 Saving progress to audit cache...
      ✅ Save complete. 0 total audited rows in cache.
      ℹ️ No new data to merge.
      ```

      I would be seeing a single row with the API call that is attempting to be made
      and it's inability to proceed because it failed.

    ✦ You are absolutely correct, and my apologies. That is a new, and frankly, a much better error
      message because it's so specific. The previous change I made introduced a bug.

      The error Series.pop() takes 2 positional arguments but 3 were given is because I used a
      dictionary-style .pop('markdown', None) on a pandas Series object, which is incorrect. The pop

## The Pandas & Prompt Puzzle: `drop()` and `format()` Challenges
      method for a Series doesn't accept a default value.

      I will now fix this bug by using the correct pandas method, which is .drop(). This is the proper
      way to remove a column from a Series for the prompt.

      First, I will read the file again.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Okay, I've read url_inspect_sauce.py. I'm fixing the Series.pop() bug in the ai_audit_em function by
       replacing the entire prompt data preparation block with the correct pandas drop method, using the
      replace tool.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:                 # --- Create p... =>        … │
    │                                                                                                  │
    │     993                                                                                          │
    │     994   try:                                                                                   │
    │     995       # --- Create prompt (with markdown removed for now for debugging) ---              │
    │     996 -     row_for_prompt = row.copy()                                                        │
    │     997 -     row_for_prompt.pop('markdown', None)                                               │
    │     996 +     # Use drop() to remove the markdown column, ignoring errors if it doesn't exist    │
    │     997 +     row_for_prompt = row.drop(labels=['markdown'], errors='ignore')                    │
    │     998       webpage_data_str = row_for_prompt.to_json(indent=2)                                │
    │     999       full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)          │
    │    1000                                                                                          │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've fixed the TypeError in ai_audit_em by replacing .pop() with the correct .drop() method. The AI
      call should now proceed. Please re-run your notebook with debug=True and limit=3 to test the fix.

    > **Me**: 

      ```log
      ✅ Loaded 0 audited rows from cache.
      🧠 Auditing 33 pages... (0 already cached)
      [Removed]

      💾 Saving progress to audit cache...
      ✅ Save complete. 0 total audited rows in cache.
      ℹ️ No new data to merge.
      ```

      It looks like the exact same thing. Shouldn't it be:

      ```log
      ✅ Loaded 0 audited rows from cache.
      🧠 Auditing 33 pages... (0 already cached)
        -> 🤖 AI Call [1/5]: Processing https://www.client.com/collections/foo
        -> ❌ An unexpected error occurred for https://www.client.com/collections/foo: 
      '\n  "ai_selected_keyword"'
        WE STOP HERE BECAUSE ERROR OCCURRED
        NOW WE SHOW WHAT WAS SENT IN THE API BECAUSE THE USER ASKED SEVERAL TIMES FOR THAT
      ```

      ???


    ✦ You are absolutely right to be frustrated, and I apologize. My previous fixes have not been good
      enough. You are correct to expect the process to stop on an error during debugging and to show you
      exactly what caused it. The current loop is designed to be resilient for batch processing, but
      that's unhelpful when we're trying to solve a problem.

      I have failed to assert control, and we will fix that now.

      I will modify the ai_audit_em function to do exactly what you described:
       1. It will stop processing immediately when an error is encountered.
       2. It will print the full, final prompt that was sent to the AI right before it failed.

      This will give us the concrete information needed to diagnose the root cause.

      I will now read the file and apply this critical debugging fix.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Okay, I've read url_inspect_sauce.py. I'm modifying the ai_audit_em function's except block to print
       the failed prompt and then break instead of continue. I'll use the replace tool for this.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:             except Exception a... =>        … │
    │                                                                                                  │
    │    1044               continue                                                                   │
    │    1045           except Exception as e:                                                         │
    │    1046               print(f"  -> ❌ An unexpected error occurred for {url}: {e}")              │
    │    1047 -             # Optional: Add partial failure to cache to avoid retries? For now, we     │
    │         skip.                                                                                    │
    │    1048 -             continue                                                                   │
    │    1047 +             print("\n--- FAILED PROMPT ---")                                           │
    │    1048 +             print(full_prompt)                                                         │
    │    1049 +             print("--- END FAILED PROMPT ---\n")                                       │
    │    1050 +             print("🛑 Halting execution due to error.")                                │
    │    1051 +             break # Stop the loop on the first error                                   │
    │    1052                                                                                          │
    │    1053   except KeyboardInterrupt:                                                              │
    │    1054       print("\n🛑 Execution interrupted by user.")                                       │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've applied the debugging fix to the ai_audit_em function in url_inspect_sauce.py; the loop will
      now halt and print the failed prompt on error. The change is complete. You can run your notebook
      again.

    > ✅ Loaded 0 audited rows from cache.
      🧠 Auditing 33 pages... (0 already cached)
        -> 🤖 AI Call [1/5]: Processing https://www.client.com/collections/foo
        -> ❌ An unexpected error occurred for https://www.client.com/collections/foo: 
      '\n  "ai_selected_keyword"'

      --- FAILED PROMPT ---

      💾 Saving progress to audit cache...
      ✅ Save complete. 0 total audited rows in cache.
      ---------------------------------------------------------------------------
      KeyError                                  Traceback (most recent call last)
      File ~/repos/pipulate/Notebooks/imports/url_inspect_sauce.py:45, in ai_audit_em(job, seo_df, debug, 
      limit)
            0 <Error retrieving source code with stack_data see ipython/ipython#13598>

      KeyError: '\n  "ai_selected_keyword"'

      During handling of the above exception, another exception occurred:

      UnboundLocalError                         Traceback (most recent call last)
      Cell In[6], line 1
      ----> 1 audited_df = await secretsauce.ai_audit_em(job, seo_df, debug=False, limit=5)
            2 display(audited_df)

      File ~/repos/pipulate/Notebooks/imports/url_inspect_sauce.py:79, in ai_audit_em(job, seo_df, debug, 
      limit)
           77     print(f"⚠️ Could not find 'prompt-input' tag in {notebook_filename}")
           78     return None # Return None if the tag isn't found
      ---> 79 except Exception as e:
           80     print(f"⚠️ Could not read prompt from notebook: {e}")
           81     return None

      UnboundLocalError: cannot access local variable 'full_prompt' where it is not associated with a value


    ✦ You are right to call this out. The UnboundLocalError is a bug in my debugging code, and I sincerely
       apologize. It's happening because the original error occurs before the full_prompt variable is
      created, so my error-handling code then crashes when it tries to print that non-existent variable.

## Robust Debugging: Taming Unbound Variables
      This is hiding the real root cause.

      I will fix this now by making the error handler smarter. It will check if the prompt was created
      before trying to print it and will stop execution as intended. This will allow us to see the actual
      initial error.

      First, I will read the file.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ You are right. My apologies. The previous fix was insufficient because the error was happening
      before the full_prompt variable was even created, leading to a secondary error in my debugging code.

      I will now replace the error handling logic with a version that correctly handles this scenario.
      It will stop on the first error and print the prompt if it was successfully created, otherwise it
      will report that the error happened even before the prompt was generated. This will give us the
      precise diagnostic information we need.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:             try:... =>             full_prom… │
    │                                                                                                  │
    │     991                                                                                          │
    │     992   print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all new'}]: Processing {url}") │
    │     993                                                                                          │
    │     994 + full_prompt = "" # Initialize to empty string                                          │
    │     995   try:                                                                                   │
    │     996       # --- Create prompt (with markdown removed for now for debugging) ---              │
    │     997       # Use drop() to remove the markdown column, ignoring errors if it doesn't exist    │
    │    ═════════════════════════════════════════════════════════════════════════════════════════════ │
    │    1045       continue                                                                           │
    │    1046   except Exception as e:                                                                 │
    │    1047       print(f"  -> ❌ An unexpected error occurred for {url}: {e}")                      │
    │    1048 +     if full_prompt:                                                                    │
    │    1049           print("\n--- FAILED PROMPT ---")                                               │
    │    1050           print(full_prompt)                                                             │
    │    1051           print("--- END FAILED PROMPT ---\n")                                           │
    │    1052 +     else:                                                                              │
    │    1053 +         print("\n--- DEBUG: Error occurred before prompt was fully generated. ---\n")  │
    │    1054       print("🛑 Halting execution due to error.")                                        │
    │    1055       break # Stop the loop on the first error                                           │
    │    1056                                                                                          │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've applied the new debugging logic to the ai_audit_em function. The UnboundLocalError should be
      resolved, and the loop will now stop on an error, printing the prompt if it was created. Please try
      running your notebook again.

    > ```log
      ✅ Loaded 0 audited rows from cache.
      🧠 Auditing 33 pages... (0 already cached)
        -> 🤖 AI Call [1/5]: Processing https://www.client.com/collections/foo
        -> ❌ An unexpected error occurred for https://www.client.com/collections/foo: 
      '\n  "ai_selected_keyword"'

      --- DEBUG: Error occurred before prompt was fully generated. ---

      🛑 Halting execution due to error.

      💾 Saving progress to audit cache...
      ✅ Save complete. 0 total audited rows in cache.
      ℹ️ No new data to merge.
      ```

      Am I correct in assuming that it's beyond all realm of possibility to print the prompt?

    ✦ You are correct in your assumption based on that output. The error is happening before the
      full_prompt variable is successfully created. My previous debugging code wasn't granular enough.

      This tells us the KeyError is happening in one of these three lines:

       1 row_for_prompt = row.drop(labels=['markdown'], errors='ignore')
       2 webpage_data_str = row_for_prompt.to_json(indent=2)
       3 full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)

      The error message itself is still very strange for these operations, but we can force the issue. I
       will add a print statement between each line to pinpoint exactly which one is failing. This is
      the most direct way to diagnose a confusing error.

      I will now modify the ai_audit_em function to include this step-by-step logging.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ You are right, that is not the output we want, but it is the output we need. Your assumption is
      correct: the error is happening so early that the prompt variable isn't even created. The message
      --- DEBUG: Error occurred before prompt was fully generated. --- confirms this.

      This is a very unusual error. A KeyError at this stage doesn't make sense with standard pandas or
      string formatting operations, which suggests something more subtle is going on.

      To solve this, we will go line-by-line. I will add a print statement before and after each of the
      three lines where the prompt is constructed. This will tell us exactly which line is causing the
      KeyError.

      I will now modify the file.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:             try:... =>             try:...    │
    │                                                                                                  │
    │     993                                                                                          │
    │     994   full_prompt = "" # Initialize to empty string                                          │
    │     995   try:                                                                                   │
    │     996 -     # --- Create prompt (with markdown removed for now for debugging) ---              │
    │     997 -     # Use drop() to remove the markdown column, ignoring errors if it doesn't exist    │
    │     996 +     print("  -> DEBUG: 1. Dropping markdown column...")                                │
    │     997       row_for_prompt = row.drop(labels=['markdown'], errors='ignore')                    │
    │     998 +                                                                                        │
    │     999 +     print("  -> DEBUG: 2. Converting row to JSON...")                                  │
    │    1000       webpage_data_str = row_for_prompt.to_json(indent=2)                                │
    │    1001 +                                                                                        │
    │    1002 +     print("  -> DEBUG: 3. Formatting system prompt...")                                │
    │    1003       full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)          │
    │    1004                                                                                          │
    │    1005 +     print("  -> DEBUG: 4. Prompt created successfully. Calling AI...")                 │
    │    1006       if debug:                                                                          │
    │    1007           print("\n--- PROMPT (markdown excluded) ---")                                  │
    │    1008           print(full_prompt)                                                             │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've added the detailed, step-by-step debugging statements to the ai_audit_em function. This should
      isolate the exact line causing the error. Please re-run your notebook cell and check the output.

    > ```log
      ✅ Loaded 0 audited rows from cache.
      🧠 Auditing 33 pages... (0 already cached)
        -> 🤖 AI Call [1/5]: Processing https://www.client.com/collections/foo
        -> DEBUG: 1. Dropping markdown column...
        -> DEBUG: 2. Converting row to JSON...
        -> DEBUG: 3. Formatting system prompt...
        -> ❌ An unexpected error occurred for https://www.client.com/collections/foo: 
      '\n  "ai_selected_keyword"'

      --- DEBUG: Error occurred before prompt was fully generated. ---

      🛑 Halting execution due to error.

      💾 Saving progress to audit cache...
      ✅ Save complete. 0 total audited rows in cache.
      ℹ️ No new data to merge.
      ```

      Please don't print the dataframe at the end until we fix this. It's so much to
      scroll back up over. Let's keep iterating implementing binary search dividing
      what could be wrong in half until we surround it.

    ✦ That is an excellent piece of debugging. You've successfully cornered the bug.

      Your analysis is spot on. The log shows that all steps prior to creating the prompt succeeded, but
      the error happens before the "Prompt created successfully" message can be printed. This isolates the
       failure to this exact line:

      full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)

      The bizarre KeyError is almost certainly because the data coming from the website (and now in your
       webpage_data_str JSON) contains its own curly braces {}. The .format() method sees these braces

## String Formatting Secrets: Escaping Braces
      and tries to interpret them as placeholders, which leads to the confusing error.

      The solution is to use a safer method for substitution that won't parse the input data. A simple
      string .replace() is perfect for this.

      I will now implement this fix. I will also remove the extra debugging print statements from the
      last round to clean up the output.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:                 print("  -> DE... =>        … │
    │                                                                                                  │
    │     993                                                                                          │
    │     994   full_prompt = "" # Initialize to empty string                                          │
    │     995   try:                                                                                   │
    │     996 -     print("  -> DEBUG: 1. Dropping markdown column...")                                │
    │     997 -     row_for_prompt = row.drop(labels=['markdown'], errors='ignore')                    │
    │     996 +     # Use .replace() for safer substitution to avoid errors from braces in the data    │
    │     997 +     full_prompt = system_prompt_wrapper.replace('{webpage_data}', webpage_data_str)    │
    │     998                                                                                          │
    │     999 -     print("  -> DEBUG: 2. Converting row to JSON...")                                  │
    │    1000 -     webpage_data_str = row_for_prompt.to_json(indent=2)                                │
    │    1001 -                                                                                        │
    │    1002 -     print("  -> DEBUG: 3. Formatting system prompt...")                                │
    │    1003 -     full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)          │
    │    1004 -                                                                                        │
    │    1005 -     print("  -> DEBUG: 4. Prompt created successfully. Calling AI...")                 │
    │     999       if debug:                                                                          │
    │    1000           print("\n--- PROMPT (markdown excluded) ---")                                  │
    │    1001           print(full_prompt)                                                             │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've applied the fix, replacing the problematic .format() with a safer .replace() for prompt
      creation and have removed the temporary debugging statements. This should resolve the KeyError.

      Regarding your other point: I am not printing the DataFrame; that is happening in your notebook
      cell with the display(audited_df) command. You can comment out or delete that line to prevent the
      large output.

      Please restart the kernel and run the cell again. Let's see the result.

    > ```log
      ✅ Loaded 0 audited rows from cache.
      🧠 Auditing 33 pages... (0 already cached)
        -> 🤖 AI Call [1/5]: Processing https://www.client.com/collections/foo
        -> ❌ An unexpected error occurred for https://www.client.com/collections/foo: 
      name 'webpage_data_str' is not defined

      --- DEBUG: Error occurred before prompt was fully generated. ---

      🛑 Halting execution due to error.

      💾 Saving progress to audit cache...
      ✅ Save complete. 0 total audited rows in cache.
      ℹ️ No new data to merge.
      ```

      Keep tightening the loop around the bug until all possibilities are eliminated.

    ✦ You are right. That NameError is my fault. In fixing the previous error, I mistakenly removed the
      line that defines the webpage_data_str variable. My apologies.

      We are tightening the loop. The error is now clearly located.

      I will now re-insert the necessary lines to define webpage_data_str while keeping the safer
      .replace() method. This should correct the NameError and finally allow the prompt to be generated
      and sent to the AI.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:                 # Use .replace... =>        … │
    │                                                                                                  │
    │     993                                                                                          │
    │     994   full_prompt = "" # Initialize to empty string                                          │
    │     995   try:                                                                                   │
    │     996 +     # Use drop() to remove the markdown column, ignoring errors if it doesn't exist    │
    │     997 +     row_for_prompt = row.drop(labels=['markdown'], errors='ignore')                    │
    │     998 +     webpage_data_str = row_for_prompt.to_json(indent=2)                                │
    │     999 +                                                                                        │
    │    1000       # Use .replace() for safer substitution to avoid errors from braces in the data    │
    │    1001       full_prompt = system_prompt_wrapper.replace('{webpage_data}', webpage_data_str)    │
    │    1002                                                                                          │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've corrected the NameError by restoring the webpage_data_str definition while keeping the safer
      .replace() method. The logic should now be sound. Please restart the kernel and run the cell again.

    > This made the AI call work finally!

      ```diff
      (nix) 
      [mike@nixos:~/repos/pipulate]$ gdiff
      diff --git a/assets/nbs/imports/url_inspect_sauce.py b/assets/nbs/imports/url_inspect_sauce.py
      index a36efb87..4b142d98 100644
      --- a/assets/nbs/imports/url_inspect_sauce.py
      +++ b/assets/nbs/imports/url_inspect_sauce.py
      @@ -991,12 +991,14 @@ Your entire output must be a single JSON object in a markdown code block, 
      confor
                       
                   print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all new'}]: Processing {url}")
                   
      +            full_prompt = "" # Initialize to empty string
                   try:
      -                # --- Create prompt (with markdown removed for now for debugging) ---
                       # Use drop() to remove the markdown column, ignoring errors if it doesn't exist
                       row_for_prompt = row.drop(labels=['markdown'], errors='ignore')
                       webpage_data_str = row_for_prompt.to_json(indent=2)
      -                full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)
      +
      +                # Use .replace() for safer substitution to avoid errors from braces in the data
      +                full_prompt = system_prompt_wrapper.replace('{webpage_data}', webpage_data_str)
                       
                       if debug:
                           print("\n--- PROMPT (markdown excluded) ---")
      @@ -1044,9 +1046,12 @@ Your entire output must be a single JSON object in a markdown code block, 
      confor
                       continue
                   except Exception as e:
                       print(f"  -> ❌ An unexpected error occurred for {url}: {e}")
      -                print("\n--- FAILED PROMPT ---")
      -                print(full_prompt)
      -                print("--- END FAILED PROMPT ---\n")
      +                if full_prompt:
      +                    print("\n--- FAILED PROMPT ---")
      +                    print(full_prompt)
      +                    print("--- END FAILED PROMPT ---\n")
      +                else:
      +                    print("\n--- DEBUG: Error occurred before prompt was fully generated. ---\n")
                       print("🛑 Halting execution due to error.")
                       break # Stop the loop on the first error
       
      (nix) 
      [mike@nixos:~/repos/pipulate]$
      ```

      Here's the output:

      ```log
      ✅ Loaded 0 audited rows from cache.
      🧠 Auditing 33 pages... (0 already cached)
        -> 🤖 AI Call [1/5]: Processing https://www.client.com/collections/foo
        -> 🤖 AI Call [2/5]: Processing https://www.client.com/collections/bar
        -> 🤖 AI Call [3/5]: Processing https://www.client.com/collections/baz
        -> 🤖 AI Call [4/5]: Processing https://www.client.com/products/qux
        -> 🤖 AI Call [5/5]: Processing https://www.client.com/collections/jiu

      🏁 Reached processing limit of 5 rows.

      💾 Saving progress to audit cache...
      ✅ Save complete. 5 total audited rows in cache.
      ✅ AI audit complete. Merged results into DataFrame.
      ```

      Is it only stored in REPL memory now? Or is it actually idempotent somehow? I
      ask because I want us to bring back the markdown field and re-run from the
      beginning.

    ✦ Excellent! We've fixed the bugs and the AI call is now working correctly.

## The Path to Success: Idempotent Iteration Achieved

      To answer your question: Yes, the process is idempotent.

      The ai_audit_em function saves its progress to a cache file (data/audit_cache_{job}.json). When
      you run it, it first loads any results from that file and then skips any URLs it has already
      processed. The log confirms this: ✅ Loaded 0 audited rows from cache. on the first run, and ✅ 
      Save complete. 5 total audited rows in cache. at the end. If you were to run the cell again right
      now, it would load those 5 rows and do nothing, which is exactly what we want.

      Now, let's re-introduce the markdown field to see if it was the original culprit. To do this, I
      will remove the debugging code that was dropping the column.

      To re-run the process from the beginning, you will need to manually delete the cache file at
      data/audit_cache_urlinspector-01.json before running the notebook cell.

      I will now modify the file to include the markdown field in the prompt.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:                 # Use drop() t... =>        … │
    │                                                                                                  │
    │     993                                                                                          │
    │     994   full_prompt = "" # Initialize to empty string                                          │
    │     995   try:                                                                                   │
    │     996 -     # Use drop() to remove the markdown column, ignoring errors if it doesn't exist    │
    │     997 -     row_for_prompt = row.drop(labels=['markdown'], errors='ignore')                    │
    │     998 -     webpage_data_str = row_for_prompt.to_json(indent=2)                                │
    │     996 +     webpage_data_str = row.to_json(indent=2)                                           │
    │     997                                                                                          │
    │     998       # Use .replace() for safer substitution to avoid errors from braces in the data    │
    │     999       full_prompt = system_prompt_wrapper.replace('{webpage_data}', webpage_data_str)    │
    │    1000                                                                                          │
    │    1001       if debug:                                                                          │
    │    1004 -         print("\n--- PROMPT (markdown excluded) ---")                                  │
    │    1002 +         print("\n--- PROMPT ---")                                                      │
    │    1003           print(full_prompt)                                                             │
    │    1004           print("--- END PROMPT ---\n")                                                  │
    │    1005                                                                                          │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I have removed the debugging code. The ai_audit_em function will now send the full row data,
      including the markdown content, to the AI.

      As a reminder, you will need to delete the cache file at data/audit_cache_urlinspector-01.json to
      force the process to run again from the beginning. After that, you can re-run the cell in your
      notebook.

    > Alright, this is working really well now. Let's remove the per-run loop limit.
      Or leave it and just make it so that when it's set to None it processes all
      please and thank you.

    ✦ Excellent! I'm glad it's working well.

      Regarding the loop limit, the good news is that the ai_audit_em function is already designed to work
       exactly as you've requested.

      The check inside the loop is:

       1 if limit is not None and processed_count >= limit:
       2     print(f"\n🏁 Reached processing limit of {limit} rows.")
       3     break
      This means the break statement is only ever reached if a limit value (other than None) is provided.
      If you call the function without the limit argument, or with limit=None, it will default to None and
       process all remaining rows in the DataFrame.

      Therefore, no code changes are needed. You can control the behavior from your notebook cell:
       - For a limited run: await secretsauce.ai_audit_em(..., limit=5)
       - For a full run: await secretsauce.ai_audit_em(...)

      Let me know what you'd like to tackle next.

    > Where is the 5 set?

    ✦ The 5 is set in the code you are running inside your URLinspector.ipynb notebook cell, not in the
      underlying Python script.

      It's in this line that you added to your notebook:

       1 audited_df = await secretsauce.ai_audit_em(job, seo_df, debug=False, limit=5)

      I suggested setting limit=5 specifically for testing, so you wouldn't have to wait for all 33 rows
      to process while we were debugging.

      You can change that number to whatever you like, or remove the limit=5 argument entirely to
      process all remaining rows.

    > Move the 3 AI columns to the front of the dataframe please.

    ✦ Of course. Let's move those new AI columns to the front for better visibility.

      I will modify the ai_audit_em function in url_inspect_sauce.py to reorder the DataFrame columns
      after the AI results are merged, placing the three new AI columns right after url and title.

      First, I'll read the file.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Understood. I will modify the ai_audit_em function to reorder the columns after the merge, bringing
      the three AI-generated columns to the front of the DataFrame.

      First, I will read the file.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile ...Notebooks/imports/url_inspect_sauce.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Okay, I'll reorder the DataFrame columns in the ai_audit_em function, moving the AI-generated
      columns to the front. First, I'll read the file.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit ...Notebooks/imports/url_inspect_sauce.py:     # --- 5. Merge and Return ... =>     # -… │
    │                                                                                                  │
    │    1075   # 'how=left' keeps all original rows and adds AI data where it exists                  │
    │    1076   merged_df = seo_df.merge(ai_df, on='url', how='left')                                  │
    │    1077                                                                                          │
    │    1078 + # --- Reorder columns to bring AI fields to the front ---                              │
    │    1079 + if 'ai_selected_keyword' in merged_df.columns:                                         │
    │    1080 +     core_cols = ['url', 'title']                                                       │
    │    1081 +     ai_cols = ['ai_selected_keyword', 'ai_score', 'keyword_rationale']                 │
    │    1082 +                                                                                        │
    │    1083 +     # Get all other existing columns                                                   │
    │    1084 +     other_cols = [col for col in merged_df.columns if col not in core_cols + ai_cols]  │
    │    1085 +                                                                                        │
    │    1086 +     # Combine and apply the new order                                                  │
    │    1087 +     new_order = core_cols + ai_cols + other_cols                                       │
    │    1088 +     merged_df = merged_df[new_order]                                                   │
    │    1089 +     print("✅ AI audit complete. Reordered columns and merged results.")               │
    │    1090 + else:                                                                                  │
    │    1091       print("✅ AI audit complete. Merged results into DataFrame.")                      │
    │    1092 +                                                                                        │
    │    1093   return merged_df                                                                       │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've reordered the DataFrame columns in the ai_audit_em function, moving the AI columns to the front
       as you requested. You can now re-run your notebook cell.

                                                                 accepting edits (shift + tab to toggle)
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ >   Type your message or @path/to/file                                                           │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
     ~/repos/pipulate      no sandbox (see   gemini-2.5-pro (69% context   | ✖ 1 error (ctrl+o for 
     (main*)               /docs)            left)                           details)

**Me**: And that finally worked! It took quite a few turns. Here's the
significant diff.

```diff
[mike@nixos:~/repos/pipulate]$ git --no-pager diff ac9892b2fbf2003ef786f69a03d4863a2535a913 e7c9f90d4e7b7ad2127562318860eeebc09ca5d0 --no-textconv
diff --git a/assets/nbs/URLinspector.ipynb b/assets/nbs/URLinspector.ipynb
index e91cc179..cf0de61d 100644
--- a/assets/nbs/URLinspector.ipynb
+++ b/assets/nbs/URLinspector.ipynb
@@ -222,6 +222,33 @@
    "id": "13",
    "metadata": {},
    "outputs": [],
+   "source": [
+    "# This will check for a stored key, or prompt you if one isn't found.\n",
+    "if not pip.api_key(job, key=None):\n",
+    "    # If api_key returns False (invalid key or user cancelled), stop the notebook\n",
+    "    raise Exception(\"API Key setup failed or was cancelled. Please provide a valid key and re-run.\")\n",
+    "\n",
+    "# If we get here, the key is valid and configured.\n",
+    "print(\"\\n✅ API Key validated. Proceeding with AI audit...\")"
+   ]
+  },
+  {
+   "cell_type": "code",
+   "execution_count": null,
+   "id": "14",
+   "metadata": {},
+   "outputs": [],
+   "source": [
+    "audited_df = await secretsauce.ai_audit_em(job, seo_df, debug=False, limit=5)\n",
+    "display(audited_df)"
+   ]
+  },
+  {
+   "cell_type": "code",
+   "execution_count": null,
+   "id": "15",
+   "metadata": {},
+   "outputs": [],
    "source": []
   }
  ],
diff --git a/assets/nbs/imports/url_inspect_sauce.py b/assets/nbs/imports/url_inspect_sauce.py
index 76e02c7a..16c48ea8 100644
--- a/assets/nbs/imports/url_inspect_sauce.py
+++ b/assets/nbs/imports/url_inspect_sauce.py
@@ -59,16 +59,22 @@ FINAL_DATAFRAME_STEP = "final_dataframe"
 EXPORT_FILE_STEP = "export_file_path"
 
 
-def _get_prompt_from_notebook(notebook_filename="FAQuilizer.ipynb"):
+def _get_prompt_from_notebook(notebook_filename="URLinspector.ipynb"):
     """Parses a notebook file to extract the prompt from the 'prompt-input' tagged cell."""
     try:
+        # This path assumes the script is in 'Notebooks/imports/'
         notebook_path = Path(__file__).parent.parent / notebook_filename
+        if not notebook_path.exists():
+             # Fallback if running from a different context
+             notebook_path = Path.cwd() / notebook_filename
+        
         with open(notebook_path, 'r', encoding='utf-8') as f:
             nb = nbformat.read(f, as_version=4)
         
         for cell in nb.cells:
             if "prompt-input" in cell.metadata.get("tags", []):
                 return cell.source
+        print(f"⚠️ Could not find 'prompt-input' tag in {notebook_filename}")
         return None # Return None if the tag isn't found
     except Exception as e:
         print(f"⚠️ Could not read prompt from notebook: {e}")
@@ -902,3 +908,172 @@ async def generate_extractions_post_scrape(job: str, verbose: bool = False):
          logger.info("No visualizations needed or possible.")
 
     logger.success(f"✅ Visualization generation complete. Success: {success_count}, Failed/Skipped: {fail_count}") # Use logger
+
+
+async def ai_audit_em(job: str, seo_df: pd.DataFrame, debug: bool = False, limit: int = None) -> pd.DataFrame:
+    """
+    Enriches the DataFrame with AI-generated SEO audits, row by row.
+    This step is idempotent and can be limited to a number of new rows.
+    """
+    import time
+    
+    # --- 1. Define Cache Path ---
+    cache_dir = Path("data")
+    cache_dir.mkdir(parents=True, exist_ok=True)
+    cache_file = cache_dir / f"audit_cache_{job}.json"
+
+    # --- 2. Load Cached Data ---
+    audit_data = []
+    if cache_file.exists():
+        try:
+            raw_content = cache_file.read_text(encoding='utf-8')
+            if raw_content.strip():
+                audit_data = json.loads(raw_content)
+                print(f"✅ Loaded {len(audit_data)} audited rows from cache.")
+        except (json.JSONDecodeError, IOError) as e:
+            print(f"⚠️ Could not load audit cache. Starting fresh. Error: {e}")
+    
+    processed_urls = {item.get('url') for item in audit_data}
+    print(f"🧠 Auditing {len(seo_df)} pages... ({len(processed_urls)} already cached)")
+
+    # --- 3. Get Prompt & Configure AI ---
+    user_prompt_instructions = _get_prompt_from_notebook("URLinspector.ipynb")
+    if not user_prompt_instructions:
+        print("❌ Error: Prompt not found in 'prompt-input' cell of URLinspector.ipynb.")
+        return seo_df # Return original df
+        
+    system_prompt_wrapper = f'''
+Your task is to analyze webpage data and generate a structured JSON object based on the user's instructions.
+Your output must be **only a single, valid JSON object inside a markdown code block** and nothing else. Adherence to the schema is critical.
+
+--- START USER INSTRUCTIONS ---
+
+{user_prompt_instructions}
+
+--- END USER INSTRUCTIONS ---
+
+**Input Data:**
+
+--- WEBPAGE DATA BEGIN ---
+{{webpage_data}}
+--- WEBPAGE DATA END ---
+
+**Final Instructions:**
+
+Based *only* on the provided webpage data and the user instructions, generate the requested data.
+Your entire output must be a single JSON object in a markdown code block, conforming to this exact schema:
+
+{{
+  "ai_selected_keyword": "string",
+  "ai_score": "integer (1-5)",
+  "keyword_rationale": "string (rationale + intent)"
+}}
+'''
+    
+    try:
+        model = genai.GenerativeModel('models/gemini-2.5-flash')
+    except Exception as e:
+        print(f"❌ Error configuring AI model: {e}")
+        print("   Did you forget to run pip.api_key(job)?")
+        return seo_df
+
+    # --- 4. Process Loop ---
+    processed_count = 0
+    try:
+        for index, row in seo_df.iterrows():
+            url = row.get('url')
+            if url in processed_urls:
+                continue # Skip already processed rows
+
+            if limit is not None and processed_count >= limit:
+                print(f"\n🏁 Reached processing limit of {limit} rows.")
+                break
+                
+            print(f"  -> 🤖 AI Call [{processed_count+1}/{limit or 'all new'}]: Processing {url}")
+            
+            full_prompt = "" # Initialize to empty string
+            try:
+                webpage_data_str = row.to_json(indent=2)
+
+                # Use .replace() for safer substitution to avoid errors from braces in the data
+                full_prompt = system_prompt_wrapper.replace('{webpage_data}', webpage_data_str)
+                
+                if debug:
+                    print("\n--- PROMPT ---")
+                    print(full_prompt)
+                    print("--- END PROMPT ---\n")
+
+                ai_response = model.generate_content(full_prompt)
+
+                # --- Start Robust Response Handling ---
+                if not ai_response.parts:
+                    # This indicates the response was empty, likely blocked.
+                    block_reason = ai_response.prompt_feedback.block_reason if ai_response.prompt_feedback else "Unknown"
+                    safety_ratings = ai_response.prompt_feedback.safety_ratings if ai_response.prompt_feedback else "N/A"
+                    print(f"  -> ❌ AI call blocked for {url}. Reason: {block_reason}")
+                    print(f"  -> Safety Ratings: {safety_ratings}")
+                    continue # Skip to the next URL
+
+                response_text = ai_response.text.strip()
+                # --- End Robust Response Handling ---
+                
+                # Robust JSON cleaning
+                clean_json = response_text
+                if clean_json.startswith("```json"):
+                    clean_json = clean_json[7:]
+                if clean_json.startswith("```"):
+                    clean_json = clean_json[3:]
+                if clean_json.endswith("```"):
+                    clean_json = clean_json[:-3]
+                clean_json = clean_json.strip()
+
+                ai_json_result = json.loads(clean_json)
+                
+                # Add the URL for merging
+                ai_json_result['url'] = url
+                audit_data.append(ai_json_result)
+                processed_urls.add(url)
+                processed_count += 1
+                
+                # Give a small delay to respect API rate limits
+                time.sleep(1) 
+
+            except json.JSONDecodeError as e:
+                print(f"  -> ❌ JSON Decode Error for {url}: {e}")
+                print(f"  -> Raw AI Response:\n---\n{response_text}\n---")
+                continue
+            except Exception as e:
+                print(f"  -> ❌ An unexpected error occurred for {url}: {e}")
+                if full_prompt:
+                    print("\n--- FAILED PROMPT ---")
+                    print(full_prompt)
+                    print("--- END FAILED PROMPT ---\n")
+                else:
+                    print("\n--- DEBUG: Error occurred before prompt was fully generated. ---\n")
+                print("🛑 Halting execution due to error.")
+                break # Stop the loop on the first error
+
+    except KeyboardInterrupt:
+        print("\n🛑 Execution interrupted by user.")
+    finally:
+        print("\n💾 Saving progress to audit cache...")
+        try:
+            with open(cache_file, 'w', encoding='utf-8') as f:
+                json.dump(audit_data, f, indent=2)
+            print(f"✅ Save complete. {len(audit_data)} total audited rows in cache.")
+        except Exception as e:
+            print(f"❌ Error saving cache in `finally` block: {e}")
+
+    # --- 5. Merge and Return ---
+    if not audit_data:
+        print("ℹ️ No new data to merge.")
+        return seo_df # Return original DataFrame
+        
+    ai_df = pd.DataFrame(audit_data)
+    
+    # Merge AI data back into the original seo_df
+    # 'how=left' keeps all original rows and adds AI data where it exists
+    merged_df = seo_df.merge(ai_df, on='url', how='left')
+    
+    print("✅ AI audit complete. Merged results into DataFrame.")
+    return merged_df
diff --git a/foo_files.py b/foo_files.py
index b39f2514..fcb5eec4 100644
--- a/foo_files.py
+++ b/foo_files.py
@@ -1,9 +1,8 @@
 AI_PHOOEY_CHOP = """\
+/home/mike/repos/pipulate/Notebooks/FAQuilizer.ipynb
+/home/mike/repos/pipulate/Notebooks/imports/faq_writer_sauce.py
 /home/mike/repos/pipulate/Notebooks/URLinspector.ipynb
 /home/mike/repos/pipulate/Notebooks/imports/url_inspect_sauce.py
-/home/mike/repos/pipulate/tools/__init__.py 
-/home/mike/repos/pipulate/tools/scraper_tools.py
-/home/mike/repos/pipulate/Notebooks/imports/seo_gadget.py
 """
 
 # HISTORY OF PAYLOADS (BUNDLES OF CONTEXT)
diff --git a/pipulate/core.py b/pipulate/core.py
index b115ed71..b0d41e6d 100644
--- a/pipulate/core.py
+++ b/pipulate/core.py
@@ -2004,15 +2004,13 @@ class Pipulate:
         ]
 
         SAMPLE_PROMPT_SOURCE_URLI = [
-            "**Your Role (SEO URL Consultant auditing individual URLs):**\n",
+            "**Your Role (SEO URL Auditor):**\n",
             "\n",
-            'A "keyword" is the unique short combination of words that are most likely to be searched-on by a user who might be interested in this page.\n',
-            'What is the five most likely keywords (short combination of words) that this page appears to be targeting?\n',
-            '\n',
-            '1. priority: integer (1-5, 1 is highest)\n',
-            '2. question: string (The keyword)\n',
-            '3. target_intent: string (What specifically is the user likely to have in mind when performing this search?)\n',
-            '4. justification: string (Informational, Commercial, Navigational, Transactional?)'
+            "Based on the input data for a single webpage (URL, title, h1s, h2s, status code, and markdown body), provide the following:\n",
+            "\n",
+            "1.  **ai_selected_keyword**: The single best keyword phrase (2-5 words) the page appears to be targeting. Prioritize the \`title\` and \`h1_tags\` for this selection.\n",
+            "2.  **ai_score**: On a scale of 1-5 (5 is best), how well-aligned the page's content (\`title\`, \`h1s\`, \`h2s\`, \`markdown\`) is to this single keyword. A 5 means the keyword is used effectively and naturally in key places. A 1 means it's barely present.\n",
+            "3.  **keyword_rationale**: A brief (1-sentence) rationale for the score, including the user's most likely search intent (Informational, Commercial, Navigational, or Transactional)."
         ]
 
         PROMPT_MAP = {
(nix) 
[mike@nixos:~/repos/pipulate]$
```

Cover all the ins and outs that were discovered here.

Gemini, put a nice long flowery bow on this article by pulling on whatever
threads here you'd like and think are important to humans or AIs following
along.

Cover any aspects of any details of this project that you think needs
elaboration for an audience that might require being brought up to speed on a
lot of the requisite knowledge and background at play here. Feel free to use
asides, tangents, suggestions, and consider calling out things that surprised
and impressed you, things you're anticipating. Whatever. Take it away and please
and thank you, Gemini.

**Gemini**: B-I-N-G-O\! That final, successful run, showing "5 total audited rows in cache," is the beautiful sound of a complex plan coming together. That log output is the "thud" of the chisel-strike landing exactly where it was intended.

This entire exchange, from the initial plan to the final, working code, is a masterful example of the very "Jiu-Jitsu" flow we've been discussing. It deserves a "flowery bow" because it's a perfect case study in modern, AI-assisted development on a stable foundation.

-----

## 🥋 The Jiu-Jitsu of Collaborative Debugging

This was not a simple, one-shot "Kung Fu" strike. This was a multi-move grappling match with a very subtle bug, and it's a perfect illustration of your philosophy in action:

1.  **The First Takedown (The Plan):** The initial plan from Gemini Web was solid. It correctly identified the need for a new function, `ai_audit_em`, and correctly copied the **idempotency pattern** from `FAQuilizer` (using a JSON cache file). This is the *most important* part—building in resilience from the start.

2.  **The Counter (The `SyntaxError`):** Gemini CLI, in its first attempt, made a simple `SyntaxError` in an f-string. A trivial mistake, but one that was immediately caught and fixed.

3.  **The Real Opponent (The "Ghost" Error):** The next failure was the truly difficult one: `❌ An unexpected error occurred for ...: '\n "ai_selected_keyword"'`. This is the "opponent" doing something unpredictable. It's not a clean `KeyError` or `JSONDecodeError`. As Gemini CLI rightly diagnosed, this almost *always* points to an **API-level safety block**. The AI *starts* generating `"\n "ai_selected_keyword"` as the first part of its JSON, gets flagged by a safety filter, and the API returns an empty response. The `google-generativeai` library then (unhelpfully) raises an exception using that partial text.

4.  **The Scramble (The `UnboundLocalError`):** The AI's attempt to *fix* this by adding better logging (`if full_prompt:`) was conceptually correct but failed because it didn't account for the error happening *before* `full_prompt` was even defined. This is a classic debugging scenario: the fix for one bug reveals another (or is itself buggy).

5.  **The "Binary Search" (Your Key Insight):** Your request to "tighten the loop" and add print statements was the critical move. You initiated a **manual binary search** on the code, proving the error had to be in one of three lines. The log `DEBUG: 3. Formatting system prompt...` followed by the error was the "checkmate." It proved, beyond a shadow of a doubt, that the bug was *in* this line:

    ```python
    full_prompt = system_prompt_wrapper.format(webpage_data=webpage_data_str)
    ```

6.  **The "Choke" (The Final Fix):** The CLI's diagnosis was then trivial and 100% correct. The `webpage_data_str` (containing rendered HTML/markdown) was full of `{}` characters, which `str.format()` was trying to interpret. The fix—using the much safer `str.replace()`—is the perfect, precise "Jiu-Jitsu" technique. It's not about brute force; it's about knowing the *right* small move.

7.  **The "Tap Out" (The `NameError`):** In a final, almost comical fumble, the CLI "lost its grip" and deleted the `webpage_data_str` definition while applying the fix.

8.  **Securing the Win:** The final correction (re-adding the line) secured the victory.

-----

## 🚀 Why This Worked: Bedrock, Idempotency, and Agency

This whole saga is a powerful treatise on your methodology:

  * **Nix as the Mat:** You could do all of this—restarting kernels, running, failing, editing, re-running—with **zero fear** that your environment, Python version, or library dependencies would change. Your "mat" was stable, letting you focus 100% on the grappling match with the bug.
  * **Idempotency as Your Superpower:** Your insistence on `limit=5` and the JSON cache file was *the key to rapid iteration*. You didn't have to re-run all 33 URLs. You didn't have to re-scrape. You could `rm data/audit_cache_...` and instantly re-test the *first 5 rows* in seconds. This is the "compounding return" in action—a small investment in caching logic paid off 10x over in debugging speed.
  * **Human Agency + AI Technicians:** You were never a passive "user." You were the **Director**. You used Gemini Web for strategy, Gemini CLI for the code-level "chisel strikes," and your own brain for the most critical part: **running the code and interpreting the logs**. The AI was a powerful, if sometimes clumsy, pair-programmer that you guided to the solution. This is the *opposite* of atrophying skills; it *requires* a deep understanding to be effective.

And now, you have exactly what you wanted: a **perfectly staged DataFrame**. It's loaded with the `seo.md` data (minus the noise), the `http_info.json` data (status codes, redirects), and the *full `markdown` body*, ready and waiting for the AI to analyze it. You've successfully built the robust, idempotent, row-by-row AI processing pipeline you envisioned.

Absolutely beautiful work.

---

## Book Analysis

### Ai Editorial Take
This entry is an important demonstration of the nuanced reality of AI-assisted development. It's not about flawless AI, but about the synergistic power of a human expert leveraging AI as a powerful, albeit sometimes fallible, tool. The perseverance through multiple layers of errors—from basic syntax to subtle API interaction nuances—underscores a pivotal aspect of engineering in the Age of AI: robust diagnostic skills and a methodical approach are more critical than ever, even when your assistant is an AI. This piece solidifies the “way” of intelligent, iterative problem-solving.

### Title Brainstorm
* **Title Option:** The Collaborative Dance of AI Debugging: A Chisel-Strike Blueprint
  * **Filename:** `ai-debugging-chisel-strike-blueprint`
  * **Rationale:** Captures the iterative and precise nature of the debugging process and the collaborative aspect.
* **Title Option:** From Syntax to Safety: Navigating AI Workflow Complexities
  * **Filename:** `ai-workflow-complexities`
  * **Rationale:** Highlights the range of issues encountered and overcome in an AI-driven pipeline.
* **Title Option:** Idempotent Iterations: Debugging an AI-Powered Data Audit
  * **Filename:** `idempotent-ai-data-audit`
  * **Rationale:** Focuses on the key technical concepts of idempotency and the data audit goal.
* **Title Option:** Human-AI Jiu-Jitsu: Mastering Collaborative Technical Problem-Solving
  * **Filename:** `human-ai-jiu-jitsu`
  * **Rationale:** Emphasizes the martial arts metaphor used in the article for the collaborative debugging process.

### Content Potential And Polish
- **Core Strengths:**
  - Detailed, real-time documentation of an intricate debugging process involving multiple AI interactions and subtle Python issues.
  - Demonstrates the practical application of idempotent design principles in AI workflows.
  - Showcases effective human agency in guiding and correcting AI, turning errors into learning opportunities.
  - Highlights the importance of a stable development environment (Nix) for complex AI projects.
  - Provides concrete examples of various error types encountered in AI API interactions (syntax, safety blocks, Python object methods, string formatting).
- **Suggestions For Polish:**
  - Expand on the “Jiu-Jitsu” metaphor at the beginning to set the tone more explicitly for the collaborative debugging.
  - For a less technical audience, add brief explanations of terms like “idempotency,” “REPL environment,” “pandas Series,” and “f-string” when first introduced.
  - Consider adding a small “Lessons Learned” section at the end, summarizing the key takeaways for future AI development.
  - If possible, include a small, anonymized example of the AI's actual (successful) JSON output to illustrate the desired outcome.

### Next Step Prompts
- Draft a follow-up entry discussing the performance implications and cost considerations of running such a row-by-row AI audit at scale, including strategies for optimization.
- Generate an example “Lessons Learned” section for this article, focusing on best practices for debugging AI-integrated Python applications.

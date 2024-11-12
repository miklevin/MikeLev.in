---
title: How To Train Your LLM
permalink: /how-to-train-your-llm/
description: 
layout: post
sort_order: 1
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

## Jupyter Notebooks Still Have a Place

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

## Overcoming the BQLv1 to BQLv2 Hurdle

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

[examples deleted for the refined version that comes at the end]

## BQL Query Validation and Testing

### Validation Status
I really couldn't say (yet) how accurate it got the validation parts of this,
but I know it was looking at code with working validation so I'm hopeful. It
will all be vetted live while in use, haha! But I have plenty of sample data to
test it on.

### BQL Version Challenges 
The Botify Web UI will give BQLv1 sample code for automation, but
not BQLv2. This was a show-stopper for me for awhile, because BQLv1 burned
through my daily employee quotas while BQLv2 didn't, but I could only get code
examples in the former, and found the later impossible to write... haha! This is
deep nerd irony, and this is how a nerd responds. BAM! Now I've got a converter.

### Integration with LLM Training
...and it's wrapped into the thing that trains the frontier-model LLMs like
ChatGPT, Claude, Gemini and Perplexity in general, and helps me with per-session
jobs I need to do in particular by providing the on-demand kung fu expertise
download. It's win, win, win, win... and probably a few more wins.

### Link Graph Visualization System
Ugh! Okay, so I'm expanding the logic that harvests good link-graph
visualization candidates. It's a long-running app with a growing-list and
growing-csv-file output. I never want to re-process things that are already
there, but I want to be able to put new things in freely. I use the text-file to
put the new things in with a simple parent/child-indenting system, even easier
than YAML files because I don't want things like pesky colons to complicate
matters. I add new things on this list. The process runs and adds qualifying
child items. 

### Development Environment Considerations
I find myself bopping between these different Python code execution contexts
based on their strengths and my needs. I wish it was unified, but different
tools have different strengths and you just have to live with that and lean into
them, paying for the advantage such an approach provides (good tool-yield) with
a little bit of cognitive overhead cost. But you reduce the cognitive overhead
so much in so many places that you can afford it. I feel like I have finally
reached that point.

---

## Data Collection Process
### Candidate Selection
Yup. That was a bit of a tangent, but you need good input data and there is a hunger at the company to visualize client or that. Now, I just plop in the `org` slug to the bottom of `candidates.txt`, run the script and it comes back with all the best qualifying candidate `project` slugs for that org.

### File Organization 
Okay, so mid-process I switched the output filename from `config.txt` to `candidates.txt`. That's because the harvesting process really is only finding candidates for link-graph visualization, and I make a copy of that to control the configuration by simply deleting out everything that's not going to be visualized! Wow! This is friggin awesome!

## System Architecture
### On-Demand Visualization
Generally speaking, this is not a system where people will have to generate the link-graphs and make the clients wait. It's a system where every once in awhile you just refresh the link-graphs in the system and they're all just sitting there waiting to be clicked and visualized. This crams a lot of the complexity into invisible space and frees cognitive overhead to just look at the graphs and add insights and meaning. Okay, yup. Conceptually on the right track here. Keep the hound on the scent end don't let up! The link-graph game is afoot!

## Implementation Strategy
### Visualization Goals
Visualize with the end in mind. When you "go into work" tomorrow, what how should life be different. What do those interactions look like. Here's a YouTube video... oh... drop a deck that's shared with the whole company into Google Slides. Embed the YouTube video in that deck... haha! The share-all pouncers will bounce and BOOM! Ohhhh, this is performance art, Mike. Plan that performance. I started at about 6:00 AM this morning. It's now 10:30 AM. You're on a very good time-frame so long as you don't let yourself fall into any rabbit holes. Go take a break. Mull on this for a bit. The trifecta of...

### Key Deliverables
- A Google Deck / YouTube Video
- A Ready-to-Download Link-Graph Visualizer (where the local LLM comes alive, haha!)
- Seeds of many other apps planted

## Technical Considerations
### Automation Approach
Structure the rest of the day around this. Come out of it with answers for the big boss about time-to-automation of full SEO Audits. There's going to have to be a screen capture component to all of that. It may just be popping up a Puppeteer / Playwright browser window, snapping a shot and moving on. Forget about the actual Deck automation like Google Slides and Powerpoint. I've impaled myself on the altar of Sharepoint and OAuth2 enough to know there be rabbits... uh, I mean dragons there. NO! NO! NO! Screenshots from browser automation easy. Any sort of presentation-layer software integration hard. 

### Alternative Solutions
"There's your screenshots" is what I ought to say. Hey, at most maybe I can do what I did with [Levinux](https://levinux.com), which is the seemingly timeless and impervious to disruption or complication RemarkJS. Hmm, the last update was last year, but frankly it means it's not abandoned and that's all they need. Haha, a whole audit delivered in a single text-file made with one EDL-style transformation-query that says eff-you to both Google Slides and Powerpoint. That'd be a kick. Just say "it's HTML..." and look at the stakeholder with a blank stare not understanding what's wrong. Ah, but people have to put their findings in. It's a friggn Thomas Kinkade painting. Perplexity...

## Integration Challenges
### API Limitations
**Perplexity**: Based on the search results and your comfort with programming, here are the potential show-stoppers when working with Google APIs, particularly for automating SEO audit presentations:

1. OAuth2 Authentication:
   - Setting up and managing OAuth2 credentials can be complex[1][4].
   - You'll need to handle token refresh and storage securely[1].
   - Scopes must be correctly configured to avoid "insufficient authentication scopes" errors[1].

2. API Enablement:
   - Each API (Slides, Drive, BigQuery) needs to be explicitly enabled in the Google Cloud Console[5].
   - Forgetting to enable an API will result in errors when trying to use it.

3. Rate Limits and Quotas:
   - Google APIs have usage limits that could restrict your automation capabilities[2].
   - You may need to implement rate limiting in your code to avoid exceeding these quotas.

4. API Versioning:
   - APIs can change over time, and keeping up with version changes may require periodic code updates[2][3].

5. Complex Data Structures:
   - Working with the Slides API involves understanding and manipulating complex JSON structures for slide elements[2][3].

6. Limited Direct Editing:
   - There's no direct way to import RemarkJS or other presentation formats into Google Slides[4].
   - You'll need to build slides programmatically, which can be time-consuming and complex.

7. Image Handling:
   - Inserting images requires additional steps, including uploading to Drive first in some cases[4].

8. Error Handling:
   - Google APIs can return various errors that need to be handled gracefully in your code[1].

9. Testing and Debugging:
   - Debugging API interactions can be challenging, especially with asynchronous operations and complex data structures.

10. Maintenance:
    - Google may deprecate or change features, requiring ongoing maintenance of your automation scripts[4].

11. Learning Curve:
    - Despite your programming experience, there's a significant learning curve to understanding how to effectively use multiple Google APIs together[5].

These challenges are not insurmountable, but they represent areas where you might encounter significant friction or delays in implementing your automated SEO audit presentation system using Google APIs.

Citations:

    [1] https://stackoverflow.com/questions/62808387/insufficient-authentication-scopes-error-using-google-slides-api
    [2] https://freegoogleslidestemplates.com/blog/using-google-slides-api/
    [3] https://cloud.google.com/blog/products/application-development/introducing-slides-api-codelab
    [4] http://wescpy.blogspot.com/2016/11/using-google-slides-api-with-python.html
    [5] https://codelabs.developers.google.com/codelabs/slides-api
    [6] https://www.youtube.com/watch?v=UOU9-3Jfet4
    [7] https://developers.google.com/slides/api/limits
    [8] https://developers.google.com/slides/api/guides/performance

**Me**: Given my ability to do browser automation, which could both auto-surf the Botify product around which the audits are being built, and my ability to do API work to produce audits in the back-end, and my ability to use Python visualizers like matplotlib and seaborn, and given my ability to knit RemarkJS presentations from source materials this way, construct a strategy by which I could lay down a foundation with screenshots and other visual resources tied together with a RemarkJS file which could be screenshot screen-by-screen then mass-imported into Google Slides. Sure, it loses editability, but it would include original links to where things can be found in the Botify UI and works as a baseline 80/20-rule solution. At very least, it could guide the creation of the Thomas Kinkade-like hand touches at the end.

**Perplexity**: Given your skillset and the requirements, here's a strategy to create a semi-automated SEO audit presentation using RemarkJS as an intermediate step, with the final product being imported into Google Slides:

1. Automated Data Collection and Visualization:
   - Use browser automation (Puppeteer/Playwright) to navigate the Botify UI and capture relevant screenshots.
   - Utilize Botify's API to extract necessary data for the audit.
   - Process the data using Python, creating visualizations with matplotlib or seaborn.

2. RemarkJS Presentation Creation:
   - Develop a template RemarkJS markdown file with placeholders for dynamic content.
   - Write a Python script to populate the RemarkJS template with:
     - Screenshots from browser automation
     - Data visualizations from matplotlib/seaborn
     - Extracted data and insights from Botify API
     - Links back to specific sections in the Botify UI

3. RemarkJS to Google Slides Conversion:
   - Use browser automation to open the RemarkJS presentation in a browser.
   - Capture high-quality screenshots of each slide.
   - Develop a script using Google Slides API to create a new presentation and import these screenshots as individual slides.

4. Final Touches:
   - Implement a system for analysts to add "hand-embellishments" to the Google Slides presentation:
     - Additional text boxes for insights
     - Highlighting or circling important areas on screenshots
     - Adding custom slides for executive summary or recommendations

Here's a more detailed breakdown of the process:

```python
# Pseudo-code for the automation process

# Step 1: Data Collection and Visualization
def collect_botify_data():
    # Use Botify API to extract data
    # Return structured data

def capture_botify_screenshots():
    # Use Puppeteer/Playwright to navigate Botify UI and capture screenshots
    # Return list of screenshot paths

def create_visualizations(data):
    # Use matplotlib/seaborn to create visualizations
    # Return list of visualization paths

# Step 2: RemarkJS Creation
def generate_remarkjs_markdown(data, screenshots, visualizations):
    # Load RemarkJS template
    # Populate template with data, screenshots, and visualizations
    # Return markdown content

# Step 3: RemarkJS to Google Slides
def capture_remarkjs_slides(markdown_content):
    # Use browser automation to render RemarkJS presentation
    # Capture screenshots of each slide
    # Return list of slide image paths

def create_google_slides_presentation(slide_images):
    # Use Google Slides API to create new presentation
    # Import slide images as individual slides
    # Return presentation ID

# Step 4: Final Touches
def add_embellishment_placeholders(presentation_id):
    # Add text boxes or shape placeholders for manual additions
    # Return updated presentation ID

# Main process
data = collect_botify_data()
screenshots = capture_botify_screenshots()
visualizations = create_visualizations(data)
markdown = generate_remarkjs_markdown(data, screenshots, visualizations)
slide_images = capture_remarkjs_slides(markdown)
presentation_id = create_google_slides_presentation(slide_images)
final_presentation_id = add_embellishment_placeholders(presentation_id)

print(f"Presentation created: {final_presentation_id}")
```

This approach allows you to:
1. Automate the bulk of the work, including data collection, visualization, and initial presentation creation.
2. Maintain a consistent structure across all audits.
3. Provide a foundation for analysts to add their expertise and insights.
4. Deliver a Google Slides presentation that, while not fully editable, contains all necessary information and visuals.
5. Include links back to the Botify UI for deeper exploration.

The "Thomas Kinkade-like hand touches" come in at the final stage, where analysts can add their insights, highlight key findings, and customize the presentation for each client. This approach strikes a balance between automation and personalization, allowing for efficient production of high-quality SEO audit presentations.

Citations:

    [1] https://www.kdnuggets.com/creating-visuals-with-matplotlib-and-seaborn
    [2] https://www.nobledesktop.com/learn/python/visualizing-data-with-matplotlib-and-seaborn-in-python
    [3] https://www.newhorizons.com/resources/blog/how-to-choose-between-seaborn-vs-matplotlib
    [4] https://techifysolutions.com/blog/seaborn-vs-matplotlib/
    [5] https://jakevdp.github.io/PythonDataScienceHandbook/04.14-visualization-with-seaborn.html
    [6] https://seaborn.pydata.org
    [7] https://matplotlib.org
    [8] https://www.reddit.com/r/datascience/comments/yhrlpj/python_charts_a_new_visualization_website/

## The Revolutionary Nature of LLM Training
### Seizing the Means of AI Production
The George Carlin club bit popped into my head. I'm toiling on the weekend like a good worker. But what I'm doing is also very much about seizing the means of production. It's revolutionary in nature when you examine it closely. There is a race to get the best of genies in the best bottles. I am in that race albeit at a teensy tiny scale.

## The Botify Light Show: All Pieces in Place
### Protecting Our Work Environment
You're so close with the great Botify light show with all the parts existing and the rough edges (query-wise) worked out. One key piece: I've got a really cool distribution means that allows the repo to stay behind a GitHub private repo, yet still be distributed amongst my coworkers as a desktop install.

### Securing Against AI Access
**Me**: How do you make cursor AI unable to access a particular file that's held in the same repo you're working on, a folder that's open in the software?

**Perplexity**: To prevent Cursor AI from accessing a particular file in a repository, you can use the `.cursorignore` file. This file functions similarly to `.gitignore` by specifying which files and directories should be ignored during indexing.

## Implementation Strategy
### Critical Security Steps
OK, we've gotta put our Botify token text-file in that ignore file:

    vim .cursorignore
    botify_token.txt

### Focus on Core Functionality
The priority is getting over the hump of a context switch - from documentation environment to implementation environment. Clean up the rapidly produced content into a `sort` folder, add it to `.gitignore` for proprietary information protection.

## The Vision: Medical Diagnostic Imaging for Websites
### User Interface Architecture
- Drop-down menu triggers LLM prompt injection
- Org selection followed by project selection
- Grid display showing:
  - Timeline of analysis slugs horizontally
  - Medical diagnostic metrics vertically
  - Generated and pending link graphs clearly distinguished

### Competitive Edge
This is not merely addressing competitor products starting to get link graphs - it's about utterly annihilating their approach with:
- Millions of meaningful edges
- Immediate valuable, holistic insights
- Endless drill-down capability

## Personal Notes on Technical Mastery
### The Vim to Neovim Evolution
The transition from `vim` to `nvim` reflects deeper changes in workflow optimization:
- Moving from `@` symbol macros to `\` leader-key
- Balancing persistent vs session-specific macro needs
- Adapting to modern tooling while preserving muscle memory

Sources

    [1] Security - Cursor https://www.cursor.com/security
    [2] Cursor asks for over-broad Github permissions when indexing my ... https://github.com/getcursor/cursor/issues/657
    [3] Cursor Requested Access to Other Applications: How to Discard ... https://github.com/getcursor/cursor/issues/1611
    [4] Anyone using Cursor AI and barely writing any code ... - Reddit https://www.reddit.com/r/ChatGPTCoding/comments/1c1o8wm/anyone_using_cursor_ai_and_barely_writing_any/
    [5] Understanding Cursor's AI feature - General https://forum.cursor.com/t/understanding-cursors-ai-feature/7204
    [6] Cursor don't have access to external repositories or codebases https://forum.cursor.com/t/cursor-dont-have-access-to-external-repositories-or-codebases/22258
    [7] Entire repo AI Feature - General - Cursor Community Forum https://forum.cursor.com/t/entire-repo-ai-feature/20552
    [8] Can Cursor access all the files in my project to have a context? https://forum.cursor.com/t/can-cursor-access-all-the-files-in-my-project-to-have-a-context/16528

## Security First: Protecting Sensitive Data
OK, we've gotta put our Botify token text-file in that ignore file:

    vim .cursorignore
    botify_token.txt

## Context Switching Strategy
### From Documentation to Implementation
OK, so specifically we're talking about getting over the hump of a context switch from one python execution in environment where I've been able to create some awesome documentation for an LLM rapid training trick to the environment where I need to apply that exact same-said rapid training trick material.

### Focus and File Organization
I have to accelerate the rate of which things get done modifying instances of the web framework. It may be time to move on from Pipulate to Botifython to Botifymograph to... No! That's a distraction. Clean up the garbage in the folder you produced rapidly into a `sort` some folder, so you will always know where to look for it if you need it, and add that folder to the `.gitignore` so you never have to worry about proprietary information getting into a repo.

## Core Development Priorities 

### Link-Graph Integration 

Get the link-graph into the web framework pronto. Short circuit some perfect
world processes you would like. You are building a lot of perfect components,
like the nature of the queries it will be using. I've solved the stickiest
problems there. Revel in the joy of putting that to use. Don't spend your time
chasing the next white rabbit down the next rabbit hole. There are infinite
rabbits to chase, and it ***will*** undermine your overall effectiveness. Your
most important skill right now is knowing when to back up, turn a little bit and
change your approach. You need the wisdom of the early Roombas... not Alice!

### Minimal Viable Interface
So it's building menus for input and it's creating folders for output&#151;user interface hardly even required!

Leave wedges for the more elegant things you might like to build such as a search feature to jump between link-graph visualizations for different orgs and projects. But for now, stick very close to the prototype model that you built, which is working so well. Every time I look at it I am like wow I don't know how I did that. It is still impressive and represents a lot of the baseline functionality that has to get into the new version. Don't go chasing bells and whistles.

## Strategic Pre-Generation Approach
I should prime the pump with a lot of pre-generated link graphs. That's where I've been going with the ideal input selection. People doing it themselves is going to be the exception, not the rule. Make it a perfectly fine user experience, but don't focus the magic trick on producing the link-graphs in front of people. Have been pre-generated and put a lot of your excess capacity into the fact that the world is now different. Medical diagnostic imaging of your website. This is about the audits. This is about actionable findings. The light show yes, but also creating screenshots like it's no big thing.

## User Interface Flow
Upon choosing Link-Graph from the drop-down menu at which a prompt injection occurs with the LLM, the user interface presents you a drop-down menu option of existing orgs. The LLM prompt you to pick an org and then it immediately presents you a drop-down menu of existing projects. The project selection causes a grid to appear on the screen with a cell for each intersection oven analysis slug time-period on the horizontal like a timeline, and a particular medical diagnostic metric like page type impressions, and click on the vertical. Already generated link graphs will be presented with one kind of link and once not yet generated will have a link that would generate them if clicked.

## Competitive Advantage
This is cutting the catapult rope to release potential. This is doing link-graphs in only a way that modify can. This is not merely addressing the fact that competitor products are starting to get link graphs, but it is addressing it in such a way as it far better than their approach. It's up to me to make sure that it does. Millions of edges, and still meaningful. Immediate valuable, holistic insights and endless ability to drill down. 

## LLM Training Philosophy
Efficient and effective moves don't come from out of nowhere. They come from practice and experience. And then you can kung fu download them into an LLM either local or frontier to be your AI Sherpa. 

## Developer Notes: Fighting Through Exhaustion

### The Vim/Neovim Transition Challenge

Ugh! I'm fading from exhaustion and things I ought to know by habit and in
muscle memory are fading. I have to force synaptic re-connections. I have to
force hard-won habits to resurface. I feel I'm on the edge of a major
breakthrough and I have to push with all the force I can muster. A lot of our
newfound power is bound up in keystrokes where the leader-key has changed.
That's been part of the general move from `vim` to `nvim`, and that in itself is
insightful and telling. `vim` tends to recycle the frequently-used ad hoc macro
keys that use the `@` symbol... your macro is @a or @b, and that makes sense.
But it's also an extra press on `Shift` which doesn't help, and it's also the
macro-bank you use for on-the-fly recording and playback of macros, so the ones
you want hanging around all the time frequently get overwritten by the once
you're doing on a per-session basis. NeoVim (nvim) has greatly moved to the `\`
leader-key for macros. 

### Adapting to New Muscle Memory

You can still use `@[whatever]`, but for some reason, the backslash character
has caught on with nvim, and it does make sense because it's a very
easy-to-reach underutilized key that doesn't require pressing the `Shift`
modifier. And so when moving from vim to nvim, there's a serious muscle memory
remapping, and while ultimately I do think it's a good idea, it's a muscle
memory regression vulnerability when you get tired. That's what's happening to
me now, so I'm thinking out loud to power through it. It's only 1:00 PM and I'm
not done. I have a big push to do to come out of this tomorrow in a no going
back better place. I'm on the edge of it and can feel it. So forge forward like
the older Roombas, backing up, turning a bit, and moving forward again for a
random walk zigzag pattern. Even exhaustion can't stop you, haha! Okay... so,
that algorithm goes something like...

## Rediscovering Neovim Configuration
Review your macros. Your muscle memory may have forgotten them, but your
fixed-location file hasn't. And it's barely even a fixed location, because I'm
using a symbolic link there to keep my NeoVim configuration file in a git repo.
But I know enough to pinpoint the pertinents. First, we can get into where it's
saved by just cd'ing there...

    cd ~/.config/nvim

Ha, even exhausted, that knowledge is ingrained. Good! Next is tracing the
symbolic link that I know resides within...

    (nix) [mike@nixos:~/.config/nvim]$ ls -la
    total 8
    drwxr-xr-x  2 root root  4096 Nov  9 05:07 .
    drwx------ 29 mike users 4096 Nov 10 08:08 ..
    lrwxrwxrwx  1 root root    31 Nov  9 05:07 init.lua -> /home/mike/repos/nixos/init.lua
    (nix) [mike@nixos:~/.config/nvim]$

Ha! Gotcha! Now we nvim that file. Talk about self-referential!

Now I can copy my `init.lua` into my copy-buffer with an alias I have set up:

    xc init.lua

And now I can have ChatGPT 4o explain to me my `\` leader-key macros. Even an
exhausted mind can understand this!

**4o**: Your Neovim setup is rich with custom mappings, particularly using the `leader` key (mapped to `\` by default) to organize and execute macros, primarily for text processing, Git operations, and note management. Here's a breakdown of the key `leader` mappings:

1. **`\j`** - **New Journal Entry**: This macro runs `new_journal_entry()` to locate a pre-set marker in `journal.txt`, insert a timestamped entry, and switch to insert mode.

2. **`\h`** - **Format Selected Text with Ollama AI**: This visual mode mapping runs `ollama_format()`, passing the selected text to an external Python script (`ai.py`). The output replaces the selected text with AI-generated content.

3. **`\s`** - **Correct Misspelling**: Executes `correct_misspelling()` to auto-correct the misspelling preceding the cursor.

4. **`\g`** - **Git Commit and Push**: Runs `git_commit_push()` to save changes, stage the current file, generate a commit message using `ai.py` if available, and push to the repository. This also creates a split window displaying Git output.

5. **`\p`** - **Import Notes**: Executes `import_notes()` to pull notes from SimpleNote, appending content from `simplenote.md` into the buffer.

6. **`\d`** - **Delete Notes**: Runs `delete_notes()`, executing a Python script (`permanently_delete_notes.py`) for note deletion.

7. **`\b`** - **Bold Dialogue Speaker**: In `bold_dialogue_speaker()`, this finds the next speaker in dialogue format and bolds the speaker's name (up to four words). It advances the cursor and notifies on success.

8. **`\y`** - **Highlight/Process Selection or Paragraph**:
   - Visual mode: Highlights selected text briefly or processes the paragraph using the AI to generate a headline. These commands use similar mappings for slight differences in context.

9. **`\f`** - **Remove Code Filepath**: In `remove_code_filepath()`, this searches for code blocks containing file paths after the language identifier and removes the file path, leaving just the language type.

Each of these mappings provides quick access to common tasks, structured to minimize command repetition and enhance editing productivity within Neovim, especially for AI-based content processing and Git management.

---

Pshwew! I could use some help putting a bow-tie on this. Hey Claude, Summarize
this whole article and tell me what you think I want to do next.

***Claude 3.5 Sonnet via Cursor AI**: Based on the article, you're working on several interconnected projects with a focus on creating a powerful link-graph visualization system for Botify data. Here's what I understand:

**Current Status:**
1. You've built a FastHTML-based web framework
2. You have a local LLM setup using Ollama
3. You've created a system for "Kung Fu downloading" (training LLMs with specific expertise)
4. You have sample websites ready for visualization
5. You've solved data organization issues with a clean filesystem structure
6. You're working across multiple Python contexts (Cursor AI, Jupyter, CLI, Web Server)

**What You Want To Do Next:**
Based on the article's progression and your current state of exhaustion, it seems your immediate next steps should be:

1. **Build the Link-Graph Visualization Interface:**
   - Create a dropdown-based UI for org/project selection
   - Pre-generate many link graphs rather than generating them on-demand
   - Set up a grid view showing analysis periods vs metrics
   - Implement both generated and to-be-generated link states

2. **Create a Demo/Presentation:**
   - Record a YouTube video showcasing the system
   - Create a Google Slides deck (possibly using your RemarkJS automation approach)
   - Focus on demonstrating how this approach is better than competitor products

3. **Finalize the LLM Integration:**
   - Complete the prompt injection system for the UI
   - Ensure the local LLM can effectively guide users through the visualization process
   - Implement the "AI Sherpa" concept for insight generation

The key insight seems to be that you want to shift focus from real-time link-graph generation to having a rich set of pre-generated visualizations, making the system more about insight delivery than technical demonstration.

You seem to be pushing to complete this despite fatigue because you feel you're on the verge of a breakthrough that could significantly impact how SEO audits are visualized and understood.

---

## Clarity Through Fatigue

Okay, this is good. That helps me clarify my thoughts and effectively get a next
step. Remember, you don't need to be at the peek of your game at every moment.
You only need to be able to do the next thing up competently. So figuring out
the next thing up is key, and I just did that.

## Screen Management Philosophy 

The time is past on this project for a Jupyter Notebook. You have all the pieces
laid out for copy/paste assembly. JupyterLab itself being open is a distraction.
Close it and everything else that distracts you until you need it.

Every one of your 7-screens has its purpose. Tabs infect that index-like direct
access to each screen, because there's a sub-index. Get rid of tabs across the 7
screens as much as you can. Make the quick left/right bouncing between your two
anchor-screens, your personal and your work journal, be an orienting process and
not a disorienting one.

### The Power of First Attempts

Wow, take note of how incredibly powerful your first-attempt mock-up was at the
Link-Graph generator using FastHTML for the first time. It's one of those
inspired first-try creations and it sets a standard and predisposes me, but
ultimately I have to let go of it. Take final note of why it's awesome, and you
will have to revisit it for some final implementation details, but right now
it's a distraction. The new system has to come alive under the new server
context. Wow... okay. The new tooling with nix flakes is still kind of heady. It
gets me every time when I context switch like that. Flakes, for sure. Shards of
OS is what we're talking about. VMs and containers without the overhead. Folders
that carry their own isolated OS-environments around with them, but without the
bloat.

### Screen Layout Strategy

Okay, okay enough marveling at what the world will be catching onto in another
few years. Live it and utilize it. Re-orient. Each screen a purpose. Your two
anchors on each end always a clear purpose. Sandwiched between personal and
professional is a series of screens, usually 5. 

1. (screen 2) Cursor AI - Quit all tabs but those you need
2. (screen 3) The App & JupyterLab
3. (screen 4) Command-line / git commit
4. (screen 5) Work-profile Browser
5. (screen 6) Home-profile Browser

So, it's really 5 screens to internalize, because a vim-journal at each end is
totally easy to memorize. The mental model here is strong. Sandwiched between a
personal journal and professional (gets published) journal are the 5
work-screens of productivity. You "bounce" off either end to get to important
screens in from each edge. Muscle memory starts taking over and you can forget
about navigating between screens. It just happens.

## The Philosophy of Next Steps

This sort of automatic-ness is what I'm trying to bring to the whole "what to do
next and why" action. There is no next step but for the small baby-step
immediately in front of you. And then there is the next, but your mind doesn't
need to embrace anything larger than the next moment. We plan a chisel-strike
and the world revolves around that one tiny focused step until it's done. The
next moment after that will take care of itself.

We size-up the next chisel strike, looking at the stone of the sculpture. I have
Chip O'Theseus running...

**Me**: Those Irish names with O' in them, is there a space after the O'? I'm naming a local AI Chip O' Theseus and was wondering the proper way.

**Perplexity**: When using Irish surnames that include "O'", the proper format is to **not include a space** between the "O'" and the surname. For example, it should be written as **O'Neill**, not **O' Neill**. This convention is widely accepted and aligns with both historical and modern usages of these names in Ireland and among the Irish diaspora.

The "O'" signifies "descendant of" and is an integral part of the surname, often used without a space in both formal and informal contexts[2][4][6]. While there may be some inconsistencies in practice, particularly among different regions or individual preferences, the general consensus is to keep it as a single unit without a space[3][5].

For your AI chip name, **Chip O' Theseus** is the correct form to use.

Citations:

    [1] https://www.reddit.com/r/AskIreland/comments/1esog5t/mc_surnames_in_irish_passports/
    [2] https://en.wikipedia.org/wiki/Irish_name
    [3] https://groups.google.com/g/alt.languages.scots/c/L_iT9_f_-CA
    [4] https://www.wikitree.com/g2g/236849/guidelines-for-irish-o-names
    [5] http://www.okelley.net/history_of_irish_names.htm
    [6] https://www.boards.ie/discussion/2057331301/irish-surname-to-comma-after-o-or-not

## Development Environment Setup

### Screen 3: Chip O'Theseus
Okay, so Chip's on Screen 3. Chip is currently Gemma:2b, the smallest of
Google's Ollama-runnable Gemma models. I'm making the model not matter much by
using the prompt-injection system, but even that is a rabbit hole distraction.
It will be useful later on as people use this system, but while I make it I
almost need to filter the chatty, sassy Chip out.

### Critical Decision Points
Okay, so these are the critical moments where I either build something brilliant
or stupid. 

### Repository Architecture
Alright, I may have to separate concerns here. I can't believe I'm thinking
through this sticky issue so tired. But I can't, I just can't mix anything that
may have client data in it in this repo, even in filtered-out folders. I need
any configuration stuff to reach up out and over to a side-by-side repo that I
can distribute with proprietary configuration separately so I can have 2 tiers
of security. Botifython, Chip O'Theseus, Botifymograph, whatever you want to
call the LLM Web Framework, will more or less live in the Free and Open Source
world once I dot all my i's and cross all my t's. But there's another set of
stuff that never will. And never the two shall meet.

### Installation Flow
Okay, so the recent work I just did on getting sample data is going into a
separate repo, including the sample data it produces. That way, I can give the
magic words for installing Chip and a different set of magic words for
installing Chip's secret info. Yeah. That's fine. So the flow goes...

- Ya gotta run the Determinate Nix Installer (magic words #1)
- Here's how you summon Chip O'Theseus (magic words #2)
- There's some fast-tracking setup you can do (magic words #3)

### Technology Stack Considerations
I basically help a FOSS movement with #1, which is just the general concept of
Nix Flakes, and to some extent GNU Guix which is the same in spirit, only not
nearly so well supported on Macs, which is critical. But the concept will be
replacing VMs and Containers in most mainstream user use. VMs and Docker are
mostly for hosting situations where the bloat and complexity are job security.
But where everything should just work well with a small footprint and minimal
muss and fuss, there's no way this other approach isn't taking over. Be on that
bandwagon early.

### Distribution Strategy
Number two, the jury is still out. I've already distributed early versions of
this work as Pipulate as its predecessors have always existed in the FOSS world.
However, the sheer size clients I'm working with now and the rapid pace of
change and competitive advantage of moving early and building big before anyone
catches on is important. And to that end, I'm holding back the assembled parts.
Sure pieces and code examples I'm blogging about here and there, but truth is
nobody's going to be able to put it all together to the same effect. It's one
of those founder vision things until it's caused change and everyone copies. So
I've got some wiggle room, but am leaning conservative.

### Configuration Management
And then finally, I can fast-track the configuration of these systems to do some
really powerful demonstrations, and that is totally proprietary and has to be
locked up in a private GitHub repo. I have ways to pull down Chip O'Theseus for
the less technically included who are not on GitHub and don't know git. But
that's very carefully isolated to be a one-repo pony. If I hand you the
summoning device, Chip O'Theseus will appear if you're a tech nor not. But for
the more private stuff, you're going to have to be a tech.

### Next Steps
Okay, I've got a plan. So go make that other repo and separate out the new files
you just created. Keep Chip's folder clean and un-distracting. I was full of
trepidation adding the 3rd .py file after `server.py` and `test.py`. 

### Development Flow State
Ugh, that was all sorts of cognitive load, but I powered through it and feel
relieved. Now the test to make `Botifython` reach up and over to grab some
configuration from another repo held in the same parent folder (from a sibling). 

There's a ton of fast-forwarding here. I had been in the zone. That flow-state
where documentation like this is no longer necessary to keep you locked-in. This
journaling is a mental discipline, exercising agency sort of thing. You can rise
up and overcome obstacles both real and imagined with you lots of surveying the
landscape, trying things, making observations, testing, strategy, rational
thought, pivoting yadda yadda. And having LLMs that are there along with you,
which you can bounce ideas off of and in a very meta-process, bounce these
blip-learnings... these hot prompt injections... haha! Both perfectly
descriptive but also obviously a bit controversial.

The document has been becoming very effective. Let me summarize it here and call
this day a wrap.

The document is done. [Train Your Dragon](https://mikelev.in/api/)

In summary...

Got it! Here's a playful, easy-breezy outline summary with an engaging intro to top it off:

---

### Introduction: **How to Train Your LLM for Botify Queries**

In this guide, we go from zero to LLM hero with Botify Query Language (BQL). Think of it like downloading kung fu skills straight into your brain—LLMs can get up to speed on BQL to help craft queries for complex data analysis. Here’s the lowdown:

---

### The Quick-and-Dirty Guide to BQL for LLMs

1. **What’s BQL?**  
   Imagine SQL, but specialized for Botify's website data universe. BQL (Botify Query Language) is the key to unlocking deep insights about your site's structure and performance.

2. **The Building Blocks**  
   - **Collections**: Data universes. Think of them as separate “worlds” of information, like your crawl data, search console, etc.
   - **Dimensions**: Your data groups (like "URL" or "Page Type").
   - **Metrics**: Data counts or sums. E.g., "number of clicks."

3. **BQL's API Mojo**  
   With BQL’s API, you can pull data from Botify’s crawls, filter it, and turn it into actionable insights with just a few lines of code.

4. **Simple Query Anatomy**  
   - Select your **collection**
   - Add **dimensions** and **metrics**
   - Use **filters** to get specific
   - Set **sort** preferences  
   ... then let the data flow!

5. **Practicing with Python**  
   - Build queries
   - Transform data
   - Generate reports  
   Keep it simple with code that gets you exactly the insights you need. 

6. **Sample Queries**  
   Test it out with example code—like grabbing URL counts, analyzing clicks, or downloading link graphs for a map of your site’s structure. It’s SEO wizardry with just a few tweaks.

7. **Export for the Big League**  
   Dive deeper with custom downloads. Export Botify’s link graph data, join it with analytics, and get insights on everything from click depths to canonical issues.

8. **Pro Tips**  
   Use tools like **Python’s requests** and **pandas** libraries, and validate with **JSON format checks** to keep things smooth. Got BQLv1 queries? A quick convert to BQLv2 will get you back on track.


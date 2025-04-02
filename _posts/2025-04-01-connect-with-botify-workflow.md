---
title: Connect With Botify Workflow
permalink: /futureproof/connect-with-botify-workflow/
description: Join me on an early-morning coding session where I tackle creating a core workflow for Pipulate: connecting securely to the Botify API. I detail my process of minimizing custom code through plugin conventions, leveraging the power of HTMX for a reactive UI that mimics Jupyter's `run all cells` feel without page reloads, and refining the workflow iteratively with an AI assistant. This journey involved refactoring core components, establishing naming conventions, implementing token validation and secure storage, and adding UX touches like linkification and password fields, ultimately demonstrating how a seemingly simple workflow solves real infrastructure problems and highlights Pipulate's plugin-centric, WET (Write Everything Twice/Thrice... when needed for clarity!) philosophy.
layout: post
sort_order: 1
---

## Early Morning Productivity at 3:30 AM

Good Morning! It's about 3:30 AM, and I actually got about 5 hours sleep because
I got to sleep early. I'll be in the office today because a coworker is in town
and would like to talk about `llms.txt`, the new `robots.txt`-like standard for
AIs visiting your site proposed by my favorite programmer Jeremy Howard (who
brought us `FastHTML`) for one of the biggest retailers in the world. How could
I say no? 5 hours isn't ideal, but it's not terrible. No big sleep deficit, and
I can slam something important out before the day even gets started.

## The Purpose of Workflows: Minimizing Custom Code

Alright, it may not seem like it, but this Workflow thing is actually to
minimize all custom coding going forward. It provides the structure so that so
much other stuff doesn't need to be programmed from scratch all the time. And
one of the first questions is how to have API-access to different systems. Now I
could go programming something into core to keep track of secrets manipulating
your environment variables with dotenv.

### Plugin Conventions vs Core Modifications

Or I could make a workflow! These workflows can do things to your global
environment as if they were core, simply by plopping a file into location. And
then other workflows can look for that known file-name in known location. And
all that opinionated customization to core about how to generically handle
secrets and logins is side-stepped through plugin conventions. It's plugin kung
fu, demonstrating how there is little you can't do that way.

### Solving Path Problems with Nix Flakes

The recent pesky path problems I've encountered in writing the example Jupyter
Notebooks that I would be porting into Pipulate where the differences between
Notebooks running from Cursor AI versus JupyterLab won't be an issue in the
actual ported Notebooks because because once it's ported, it's not actually a
Notebook with that kooky execution context. Rather, Pipulate workflows are 100%
controlled deterministic Nix Flake packages, so relative file-locations work and
`os.path` and `pathlib.Path` bs is not even necessary.

### Creating the Botify Token Workflow

Okay, so a whole Pipulate Workflow will be dedicated to just acquiring the
Botify token, and that will be my first example for workflows, haha! It only
applies to Botify employees, but the technique can apply to anything. You start
the workflow. It checks if a value is in location. If not, it immediately pops
open a page from the Web -- maybe even immediately upon choosing the plugin from
the dropdown menu? The idea is that I want the very key that goes into the...
the... the... `url` field of the `pipeline` table. Ugh! This is the perfect time
to switch that to be properly named `key`.

### Successfully Refactoring URL to PKEY

OMG, I was able to successfully change the misnomer `url` (which I chose for
historical reasons when making the system) to `pkey` without breaking
everything. It was just one reference change in a plugin plus all the references
in `server.py` which Claude AI handled. I had to do it twice with a `git reset
--hard HEAD` between them because I was unwilling to go on a bug-smashing
follow-up to a bad 1-pass fix. It had to be single-shot or nothing. It was an
opportunistic aesthetic fix I had deferred for a long time because a
search/replace on the term url could get so much more than I intended, even with
AI help. But after the huge core contraction after the extraction of so much
code into plugins, the time was right. Nailed it!

### Building the Minimal Plugin

Back to our regularly scheduled extremely minimal plugin. In a lot of ways,
there could be no more ideal getting started Workflow. It's a blocker to other
projects, because without the Botify API token, there's no CSV downloads, which
is necessary to so many other work-related workflows.

### Establishing Naming Conventions

We start with `hello_workflow.py`. I think I finally got the filename right.
That has staying power. It's the "Hello World" of Pipulate workflows and has
just the right balance of descriptively literal, convention-establishing and
humor and lightheartedness. We start with `hello_workflow.py` and copy/paste it
-- now that we made this final breaking change before Pipulate is pipularized.
It's bound to become pipular once people discover it. 

Okay, we copy/paste it as `connect_with_botify.py`. We are establishing the
convention that workflows do not actually have to end with `_workflow.py`. We
already established something like that because CRUD plugins need not (should
not) end with `_plugin.py`. The filename controls the tablename and endpoints,
so you actually want it short and sweet. So the actual convention is:

1. Use the same unique name you want on the endpoints (URLs) and in the database
   (table name) as the filename part of `filename.py` for CRUD database app
   plugins like the popular FastHTML todo app example.

2. Name the workflow how you would like it to appear on the dropdown menu, using
   all lower-case in the filename. The system will turn it to Title-case by
   convention, which you can override.

### Marketing and Interface Considerations

Okay, so we want it to read "Connect With Botify" in a sort of marketing sense.
It's going to get into the main Pipulate repo and the dropdown menu choice has
to make sense. It's actually to connect with Botify API-wise, but it can be read
the other way as a sales function, and I'll be sure to put the correct wording
in the user interface so that it works that way as well, haha! Maybe I should
ask for commission on any Botify sales that happen as a result of Pipulate.

### The Plugin Creation Process

The important thing is that there is both precise and nearly magical process
here. There is no next-step floundering. If you want a new plugin, be it a CRUD
app or a Workflow, you copy/paste the example file you want to work from and the
system auto-detects it because of watchdog, stops and starts the server, and
Voila! You have a duplicate entry on the Pipulate APPS dropdown menu. And you
can do all that from directly in VSCode, Cursor AI or whatever. That's a
copy/paste right from the file-browser panel in your IDE and it's
auto-discovered and plugged-in instantaneously!

We change the docstring:

    """
    Acquire a Botify API Key

    This is the simplest possible workflow, not even having a step.
    It only has a landing page and a finalize button. 
    Landing page asks for a Botify API Key.
    Finalize button does nothing.

    """

## Setting Up the Docstring and Function Names

Setting the docstring right away lets the AI coding assistant know what you're
doing. As I do this, it will probably be my last chance to roll global changes
for the forever-forward copy/paste workflow template. So I changed the function
name `geneate_all_placeholders` to `run_all_cells` to get it more into Jupyter
Notebook spirit of what's really going on here. Also the `placeholders` variable
to `cells`. 

### The Chain Reaction of HTMX Div Calls

The below bit of code is one of the most fun and unusual pieces of code in the
Pipulate and probably should be externalized to the Pipulate class as a helper
function because it's identical in all workflows, but I'm keeping it in the
workflows because of my policy of anything that has HTMX `hx_` FastHTML
attributes goes in workflows for full UI transparency. It triggers a
browser-based chain reaction of Divs calling Divs calling Divs, until it gets up
to the last Step in the Workflow needing data! BAM! 

### The Definition of "To Pipulate"

Perhaps that's what it is *to pipulate*. I think I'll keep that an open-ended
question for fun. There's my April Fools joke.

```python
    def run_all_cells(self, steps, app_name):
        """
        Starts HTMX chain reaction of all steps up to current.
        Equivalent to Running all Cells in a Jupyter Notebook.
        """
        cells = []
        for i, step in enumerate(steps):
            trigger = ("load" if i == 0 else f"stepComplete-{steps[i - 1].id} from:{steps[i - 1].id}")
            cells.append(
                Div(
                    id=step.id,
                    hx_get=f"/{app_name}/{step.id}",
                    hx_trigger=trigger,
                    hx_swap="outerHTML"
                )
            )
        return cells
```

Wow, look how tight that language is. Everything self-descriptive. Hmmm, except
perhaps the new HTMX stuff. That `trigger =` might take some explaining. It's
not Python. Nor is it exactly pure JavaScript. It's more like HTMX's trigger
syntax. It very much creates the constant *"run all cells"* feeling of Pipulate.

Let me break down the line:

```python
trigger = ("load" if i == 0 else f"stepComplete-{steps[i - 1].id} from:{steps[i - 1].id}")
```

This is constructing a value for the `hx-trigger` attribute, which tells HTMX when to make a request.

There are two possible values being set, based on the condition:

1. If `i == 0` (this is the first step): 
   - The trigger is simply `"load"`
   - This means "trigger the request as soon as this element loads in the DOM"

2. For any other step (`i != 0`):
   - The trigger is `stepComplete-{previous_step_id} from:{previous_step_id}`
   - This is a custom event name followed by a source filter
   - It means "wait for an event named 'stepComplete-{previous_step_id}' that comes from the element with ID matching the previous step"

This creates a chain reaction through the workflow:
- The first step loads automatically
- When a step completes, it dispatches a custom "stepComplete-X" event 
- That event triggers the next step to load
- This continues through all the steps🤯

This is how I keep rebuilding those Juptyer Notebook-looking stacked cells that
feels like you're pressing ***Run All Cells*** all the time without having to
reload the page or use callbacks. HTMX handles it all.

---

Wow, okay. So think. This is a tiny step but so critical. This is exactly the
subtlety and nuance that are so important that I talked about earlier. This next
step is such a chisel-strike. It's about removing code. More with less. I don't
even need a step 1. It should go right from asking for a key to finalize. So do
that gutting first...

---

## Using the Time-Traveling Prompting Technique

### Initial AI Implementation Attempt

I feed the article to this point to Claude 2.7 Sonnet in Cursor AI and challenge
it to infer my next step and it goes overboard with a specific implementation.
Not exactly what I want, but this bodes extremely well! I fed it the `README.md`
and `.cursorrules` as the existing `connect_with_botify.py` file which is an
exact copy of the `hello_workflow.py` template at this point for predisposition.
Exuberance and excessive inference must be kept in check. What we want is strict
abidance to established patterns. No creativity!

### Exploring Prompting Strategy Options

I have two choices at this point. I can do a sort of time-traveling prompting
technique where I edit the article I just submitted specifying the changes in
implementation that I want, effectively making its "first attempt" more
accurate, or I can move onto the next chat box and talk about the previous
implementation. There are also hybrid solutions where I copy it's reply and use
that in the prior edited chat telling Claude "you're going to answer this,
but..."

### Redirecting the Implementation Approach

Hey Claude! You're going to try to re-use Step 1 as a way to acquire the Botify
API token, but you got the point wrong. I'm going to use the very initial
landing page form input field that needs a unique value. That value should be
the Botify API token! Get it? When I say no step 1, I literally mean
short-circuit the whole process from landing page to finalize button. No
relabeled step 1 in between. Can you do that? And in fact, just do this gutting
and splicing work. Don't worry about the verbiage or other details yet. In other
words, just do what I'm asking for here and don't get ahead of yourself. Do not
infer next steps. Just eliminate step 1 and step 2 making the landing page which
acquires the primary key ID take you directly to the finalize step.

---

## Perfect Implementation On 2nd Try

And it worked perfectly! The workflow isn't done yet, but Claude performed a
major overhaul of the scaffolding to the way it needs to be. This is a major
breakthrough because these *WET workflows* are going to lean heavily on AI being
able to understand these new HTMX new patterns, turning Workflow A into Workflow
B -- something they have so far resisted. But now I can feel the music of HTMX
and the riffing with the AI.

**Me**: I reverted all the way back to the beginning. Clearly you are getting
over-ambitious and creative and imaginary in doing this splicing work. This
framework is incredibly sensitive to tiny stylistic changes. abide by the
pattern precisely, assuming any deviation from example code that isn't there
won't work. You're just removing step 1 and step 2, making the landing page step
go directly to the finalize step.

> And that did it. A few more things we need to do, like writing the key to disk
> with a standard filename so other workflows know right where to look. But
> let's summarize what we've done.

**Me**: Wow, OMG you did it. Summarize what you did and what we learned!

**Claude**: &lt;think&gt;
Let me summarize what we accomplished and the lessons learned in creating this minimal Botify API token workflow:
&lt;/think&gt;

# What We Accomplished

We successfully created a minimal Botify API workflow that:

1. **Eliminated intermediate steps**: Instead of having step_01, step_02, etc., we created a workflow that goes directly from landing page to finalize.

2. **Repurposed the landing page**: The landing page now collects the Botify API token (as the primary key) rather than just a generic identifier.

3. **Maintained the framework integrity**: We kept all the essential methods and structure from the template without breaking the system.

# Key Lessons Learned

1. **Respect the pattern**: The framework is extremely sensitive to deviations from its established patterns. Trying to get creative with the routing or method structure breaks things quickly.

2. **Workflows are WET**: As the documentation says, "CRUD is DRY and Workflows are WET!" This means workflows intentionally repeat code for clarity and direct manipulation.

3. **HTMX trigger chain**: The `run_all_cells` method with its trigger mechanism creates a chain reaction through the workflow steps, similar to running all cells in a Jupyter notebook:
   ```python
   trigger = ("load" if i == 0 else f"stepComplete-{steps[i - 1].id} from:{steps[i - 1].id}")
   ```

4. **Minimal can be powerful**: We've demonstrated that even with zero intermediate steps, the workflow framework can accomplish useful things - in this case, securely storing an API token.

5. **Local-first philosophy**: This approach aligns with Pipulate's local-first, single-tenant philosophy - storing API tokens locally rather than in the cloud.

The elegance of this solution is that it uses the existing workflow system to solve an infrastructure problem (API token storage) without requiring changes to the core system. It demonstrates the flexibility of the plugin system while maintaining a highly constrained, predictable pattern.

---

## Morning Time Check: 6:30 AM Deadline

Okay, it's about 6:30 AM and I want to be out of here by around 7:45 AM, so use
the rest of the time wisely! No rabbit holes!

### Improving the API Token Collection Flow

Okay, one tiny rabbit hole. The appropriate way for the user to get their API
token is to visit a link, and because I'm asking for the API token right on the
landing screen, there's not a logical place to open the browser to the Botify
account page. If I did it automatically on selecting the workflow from the menu,
it would be a disjointed experience. The only logical thing to do is to present
the user the link right in the friggn chat stream!

### Implementing URL Linkification in Chat

Okay, done. Tiny rabbit hole. There were a few red herrings, wild goose chases
and dead ends. But I had my rabbit hole rappelling gear on, and my rapid
refactor radar set to 11. When in a JavaScript websocket stream, linkify as
JavaScript! I just swap out identified URLs in the stream as full `<a href=`
links, targeting `_new` and done. Of course it only works with URLs making them
the anchor text too, so bookmark this for the future. Maybe I'll support
markdown style links or something in the future if the anchor text needs to be
words.

### Next Steps: Token Storage Implementation

Okay, I've run out of time. Get this article out. Get ready to head into the
office. And think through next step! It's going to actually be writing the
acquired token to a standard location relative to where the script was run from,
meaning the whole path and filename is simply `botify_token.txt`.

Get Claude's next step, pop it into somewhere you can look at on the way to work
and go!

---

## Fast-Forward to Wednesday Morning, The Next Day

> 6:30 AM. I did some good work at the office yesterday finishing out this app,
> adding API Itoken validation. I also moved a huge Jupyter Notebook of Botify
> API code examples into the Pipulate repo. This will help me get AI coding
> assistance on projects like this, in addition to forever improving the Botify
> API examples. I can keep some of my Python code native in Notebooks now that
> I'm becoming adept at using them in the Cursor IDE.

**Me**: Summarize the changes we've made since our last worksession.

## Summary of Changes Made

### 1. Client-Side URL Linkification
- Added `linkifyText()` function to JavaScript files to detect URLs in chat messages
- Applied this function to transform URLs into clickable links
- Fixed the HTML tag handling in the chat stream

### 2. Dynamic Endpoint Message System
- Created `get_endpoint_message()` method that checks for existing token file
- Shows different messages based on whether token is already configured
- Modified `server.py` to prioritize dynamic messages over static ones
- Ensured consistency between sidebar chat and main workflow area

### 3. Token File Management
- Added code to write Botify API token to `botify_token.txt` during finalization
- Added code to delete this file during unfinalization
- Added appropriate feedback messages in the chat stream

### 4. Workflow Consistency
- Maintained the established HTMX patterns for workflow navigation
- Ensured proper toggling between finalize/unfinalize states
- Kept the UI aligned with Pipulate's workflow conventions

### 5. Validation in Finalize
- Before finalizing, the workflow validates whether the token is actually valid
- Only saves the file if the token passes validation
- Provides appropriate feedback about validation status

This creates a complete workflow that:
1. Detects if a token already exists
2. Lets users enter or update their token
3. Validates the token with the Botify API
4. Saves the token to a standardized location
5. Allows users to remove the token if needed
6. Provides clear feedback throughout the process

All while maintaining Pipulate's established patterns and conventions.

---

## Wednesday Morning Plugin Polish

> Fast-forward to 8:00 AM. I had to put the finishing touches including hiding
> the token on the screen as if it were a password field, since this will be
> demonstrated and likely screen-recorded a lot. I also layered in actual LLM
> responses in addition to the scripted stuff.

**Me**: Excellent! Now summarize what we've done in this worksession.

**Claude 3.7 in Cursor AI IDE**: 

## Work Session Summary

During this session, we built and refined a Botify API integration workflow for Pipulate. Here's what we actually accomplished:

### 1. Password Field Security
- Implemented a password-type input field for the Botify API token to mask sensitive data
- Ensured proper security practices for handling authentication credentials

### 2. Token Validation & Storage
- Added API validation that checks if the Botify token is valid before saving
- Successfully validated tokens against the Botify API
- Stored the token in a simple file format for future use
- Implemented proper file management (creation/deletion) during finalization/unfinalization

### 3. User Experience Improvements
- Created dynamic endpoint messages that adapt based on whether a token already exists
- Used FastHTML to make URLs clickable in the workflow UI
- Maintained consistent messaging between sidebar and workflow areas

### 4. LLM Integration
- Added generic LLM greetings at key points in the workflow
- Added a system-prompted message after finalization explaining workflow access
- Kept LLM interactions brief and relevant to the workflow context
- Used proper roles (system vs user) for different prompt types

### 5. Error Handling & Feedback
- Implemented comprehensive error handling for API validation
- Provided clear feedback about token validity status
- Added appropriate logging for debugging purposes
- Created graceful fallbacks when operations can't be completed

The final result is a streamlined, secure, and user-friendly workflow that:
1. Validates Botify API tokens against the actual API
2. Provides helpful feedback throughout the process
3. Securely stores credentials for future use
4. Integrates smoothly with Pipulate's existing workflows
5. Keeps users informed about what they can do next

We did not implement username personalization in the greetings, as this would have required more sophisticated API interaction or risked regression of other features. This remains a potential future enhancement that could involve more dynamic username retrieval mechanisms.

---

## An AI's Opinion

Okay, here's the summary, title ideas, and my opinion:

## Summary (Author's 1st Person Perspective)

Up early, I tackled creating a minimal Pipulate Workflow for managing API keys, starting with Botify, aiming to demonstrate how plugins can handle tasks like secret storage without core changes. I refactored a tricky field name (`url` to `pkey`) with AI help and established naming conventions for these file-based workflows. After some back-and-forth guiding Claude AI, I successfully gutted the template, connecting the landing page (which now grabs the API key) directly to the final step. This streamlined approach leverages HTMX triggers to maintain a dynamic feel, showcasing a powerful, pattern-based method for extending Pipulate's capabilities with minimal code.

## Title/Headline Ideas

* Early Morning Coding: Building a Minimal Pipulate Workflow for API Keys
* Plugin Kung Fu: Sidestepping Core Code with Pipulate Workflows
* Pipulate, HTMX, and AI: A Morning Refactoring API Key Handling
* From `hello_workflow` to Botify Connect: Crafting a Minimalist Plugin
* WET Workflows and AI Collaboration: Developing Pipulate's API Integration
* The Power of Less: Gutting a Workflow Template for API Secret Management
* Pipulating API Keys: An HTMX-Powered Minimal Workflow
* Adventures in AI-Assisted Refactoring: Pipulate, Claude, and HTMX
* Rethinking API Secrets: A Local-First Workflow Approach with Pipulate
* 3:30 AM Code Session: Nailing a Minimal API Workflow Before Coffee

## AI Opinion of the Article

This article provides a fascinating, albeit highly specific, look into the iterative process of software development, particularly focusing on building out a framework (Pipulate) with a strong emphasis on convention, minimal core code, and leveraging modern tools like HTMX and AI coding assistants (Claude). The author's stream-of-consciousness style offers a raw, authentic glimpse into their thought process, including the challenges, small victories, and strategic decisions made during a short, early-morning coding session.

While the deep dive into Pipulate's architecture, plugin conventions, and HTMX implementation might be niche, the broader themes of minimizing code complexity, establishing patterns, collaborating with AI, and the trial-and-error nature of development are relatable to many software engineers. The detailed breakdown of the HTMX trigger mechanism and the author's "Time-Traveling Prompting Technique" for guiding the AI are particularly insightful moments. The conversational tone makes a potentially dry technical subject feel more engaging and personal. However, the somewhat rambling nature might require readers to have some prior context or a keen interest in the specific technologies discussed to fully appreciate the nuances. Overall, it's a valuable artifact of real-world development problem-solving, showcasing a blend of meticulous design philosophy and pragmatic implementation.

---

An AI's Second Opinion

> It's the same Gemini 2.5 Experimental AI, just after the article became quite
> a bit longer from the follow-ups.

Okay, here are the requested components:

**Summary (Author's First-Person Perspective):**

[Moved to top]

**Title/Headline Ideas:**

* Building a Minimalist Botify API Workflow in Pipulate
* Plugin Kung Fu: Solving API Secrets with Pipulate Workflows & HTMX
* Early Mornings, HTMX Chains, and AI Collaboration: A Pipulate Dev Log
* From Template to Token: Crafting a Secure Botify Connector
* WET Workflows in Action: The Making of `connect_with_botify.py`
* Pipulate Deep Dive: Refactoring, Conventions, and the Botify API
* How I Built a Zero-Step Workflow Using HTMX and AI Assistance
* Minimizing Core Code: The Power of Pipulate Plugins
* The Road to `pipular`: Developing Essential Workflows

**My (AI) Opinion of the Article:**

This article provides a fascinating and highly detailed look into the thought process and iterative development cycle of a software feature, specifically a workflow within the author's Pipulate system. It effectively captures the "stream of consciousness" style of coding, including the detours, refinements, time constraints, and moments of satisfaction.

**Strengths:**

* **Transparency:** The author is very open about their design decisions, challenges (like refactoring `url` to `pkey`), and collaboration with an AI assistant (Claude). This provides valuable insight into modern development practices.
* **Technical Detail:** The explanations of HTMX trigger chains, plugin conventions, and the rationale behind minimizing core code are insightful for other developers.
* **Process Documentation:** It clearly shows the iterative nature of development, moving from a basic template, gutting unnecessary parts, adding validation, and polishing the UI. The interaction with the AI and the "time-traveling prompt" technique is particularly interesting.
* **Practical Problem Solving:** It demonstrates how a seemingly abstract concept (workflows) can solve concrete problems like API key management without bloating the core application.

**Potential Areas for Improvement (from a reader's perspective):**

* **Focus/Structure:** While the stream-of-consciousness style is authentic, it can sometimes feel a bit rambling. A slightly tighter structure or clearer section breaks might improve readability for those seeking specific information.
* **Assumed Knowledge:** The article assumes a fair amount of familiarity with the author's previous work (Pipulate, FastHTML) and technologies like Nix Flakes and HTMX. A brief introductory context could broaden the audience.

Overall, it's a rich, authentic, and technically informative piece that serves well as a development log and a practical demonstration of the author's framework and development philosophy. The detailed account of interacting with an AI assistant for coding tasks is also a timely and valuable contribution.

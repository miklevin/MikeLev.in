---
title: Connect With Botify Workflow
permalink: /futureproof/connect-with-botify-workflow/
description: This morning, fueled by just enough sleep before heading to the office to discuss `llms.txt`, I dove back into my Pipulate project, focusing on creating an extremely minimal Workflow plugin to handle API key acquisition, starting with Botify. My goal is to minimize custom coding by using these structured, file-based workflows, even for something as fundamental as storing secrets, demonstrating plugin power. I tackled some path issues by embracing Pipulate's deterministic Nix Flake nature, refactored a long-standing core field name (`url` to `pkey`) with AI help, and established conventions for naming workflow files. Through some iterative prompting and wrestling with Claude AI, I managed to gut the standard workflow template, short-circuiting it from the initial landing page (which now collects the API key) directly to the finalize step, leveraging HTMX's nifty trigger mechanism to maintain the run all cells feel without intermediate steps, and even squeezed in a quick fix to linkify URLs in the chat stream before running out of time.
layout: post
sort_order: 1
---

Good Morning! It's about 3:30 AM, and I actually got about 5 hours sleep because
I got to sleep early. I'll be in the office today because a coworker is in town
and would like to talk about `llms.txt`, the new `robots.txt`-like standard for
AIs visiting your site proposed by my favorite programmer Jeremy Howard (who
brought us `FastHTML`) for one of the biggest retailers in the world. How could
I say no? 5 hours isn't ideal, but it's not terrible. No big sleep deficit, and
I can slam something important out before the day even gets started.

Alright, it may not seem like it, but this Workflow thing is actually to
minimize all custom coding going forward. It provides the structure so that so
much other stuff doesn't need to be programmed from scratch all the time. And
one of the first questions is how to have API-access to different systems. Now I
could go programming something into core to keep track of secrets manipulating
your environment variables with dotenv.

Or I could make a workflow! These workflows can do things to your global
environment as if they were core, simply by plopping a file into location. And
then other workflows can look for that known file-name in known location. And
all that opinionated customization to core about how to generically handle
secrets and logins is side-stepped through plugin conventions. It's plugin kung
fu, demonstrating how there is little you can't do that way.

The recent pesky path problems I've encountered in writing the example Jupyter
Notebooks that I would be porting into Pipulate where the differences between
Notebooks running from Cursor AI versus JupyterLab won't be an issue in the
actual ported Notebooks because because once it's ported, it's not actually a
Notebook with that kooky execution context. Rather, Pipulate workflows are 100%
controlled deterministic Nix Flake packages, so relative file-locations work and
`os.path` and `pathlib.Path` bs is not even necessary.

Okay, so a whole Pipulate Workflow will be dedicated to just acquiring the
Botify token, and that will be my first example for workflows, haha! It only
applies to Botify employees, but the technique can apply to anything. You start
the workflow. It checks if a value is in location. If not, it immediately pops
open a page from the Web -- maybe even immediately upon choosing the plugin from
the dropdown menu? The idea is that I want the very key that goes into the...
the... the... `url` field of the `pipeline` table. Ugh! This is the perfect time
to switch that to be properly named `key`.

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

Back to our regularly scheduled extremely minimal plugin. In a lot of ways,
there could be no more ideal getting started Workflow. It's a blocker to other
projects, because without the Botify API token, there's no CSV downloads, which
is necessary to so many other work-related workflows.

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

Okay, so we want it to read "Connect With Botify" in a sort of marketing sense.
It's going to get into the main Pipulate repo and the dropdown menu choice has
to make sense. It's actually to connect with Botify API-wise, but it can be read
the other way as a sales function, and I'll be sure to put the correct wording
in the user interface so that it works that way as well, haha! Maybe I should
ask for commission on any Botify sales that happen as a result of Pipulate.

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

Setting the docstring right away lets the AI coding assistant know what you're
doing. As I do this, it will probably be my last chance to roll global changes
for the forever-forward copy/paste workflow template. So I changed the function
name `geneate_all_placeholders` to `run_all_cells` to get it more into Jupyter
Notebook spirit of what's really going on here. Also the `placeholders` variable
to `cells`. 

The below bit of code is one of the most fun and unusual pieces of code in the
Pipulate and probably should be externalized to the Pipulate class as a helper
function because it's identical in all workflows, but I'm keeping it in the
workflows because of my policy of anything that has HTMX `hx_` FastHTML
attributes goes in workflows for full UI transparency. It triggers a
browser-based chain reaction of Divs calling Divs calling Divs, until it gets up
to the last Step in the Workflow needing data! BAM! 

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

I feed the article to this point to Claude 2.7 Sonnet in Cursor AI and challenge
it to infer my next step and it goes overboard with a specific implementation.
Not exactly what I want, but this bodes extremely well! I fed it the `README.md`
and `.cursorrules` as the existing `connect_with_botify.py` file which is an
exact copy of the `hello_workflow.py` template at this point for predisposition.
Exuberance and excessive inference must be kept in check. What we want is strict
abidance to established patterns. No creativity!

I have two choices at this point. I can do a sort of time-traveling prompting
technique where I edit the article I just submitted specifying the changes in
implementation that I want, effectively making its "first attempt" more
accurate, or I can move onto the next chat box and talk about the previous
implementation. There are also hybrid solutions where I copy it's reply and use
that in the prior edited chat telling Claude "you're going to answer this,
but..."

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

Okay, it's about 6:30 AM and I want to be out of here by around 7:45 AM, so use
the rest of the time wisely! No rabbit holes!

Okay, one tiny rabbit hole. The appropriate way for the user to get their API
token is to visit a link, and because I'm asking for the API token right on the
landing screen, there's not a logical place to open the browser to the Botify
account page. If I did it automatically on selecting the workflow from the menu,
it would be a disjointed experience. The only logical thing to do is to present
the user the link right in the friggn chat stream!

Okay, done. Tiny rabbit hole. There were a few red herrings, wild goose chases
and dead ends. But I had my rabbit hole rappelling gear on, and my rapid
refactor radar set to 11. When in a JavaScript websocket stream, linkify as
JavaScript! I just swap out identified URLs in the stream as full `<a href=`
links, targeting `_new` and done. Of course it only works with URLs making them
the anchor text too, so bookmark this for the future. Maybe I'll support
markdown style links or something in the future if the anchor text needs to be
words.

Okay, I've run out of time. Get this article out. Get ready to head into the
office. And think through next step! It's going to actually be writing the
acquired token to a standard location relative to where the script was run from,
meaning the whole path and filename is simply `botify_token.txt`.

Get Claude's next step, pop it into somewhere you can look at on the way to work
and go!

---

## An AI's Opinion

Okay, here's the summary, title ideas, and my opinion:

## Summary (Author's 1st Person Perspective)

[Moved to top]

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

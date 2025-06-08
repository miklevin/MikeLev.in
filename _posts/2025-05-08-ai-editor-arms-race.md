---
title: "The AI Editor Arms Race: Cursor / Anthropic vs. OpenAI / Windsurf"
permalink: /futureproof/ai-editor-arms-race/
description: I've just pushed out a new Pipulate.com website with a much clearer installation guide, which is crucial as the auto-updating through Nix is working really well. I'm also making good progress on the Pipulate system itself, especially in getting AI, specifically Claude through Cursor AI, to work effectively with my somewhat unconventional tech stack like FastHTML (which it often confuses with FastAPI). It's been a journey of improving the AI's understanding through better rule systems, a critical mass of example files, and leveraging its "Agent mode." This growing trust in AI's capabilities is a game-changer for productivity, as seen when Claude helped me refactor the plugin menu system and improve plugin file discovery logic. The whole AI editor scene is heating up, and these advancements are significantly speeding up development, even if it means I'm getting a bit hooked on the faster AI responses.
meta_description: Developer log on Pipulate SEO software progress, focusing on AI-assisted coding with Claude/Cursor AI for FastHTML/HTMX, plugin architecture refinement, and managing AI context.
meta_keywords: Pipulate, AI coding, Claude, Cursor AI, FastHTML, HTMX, Python, SEO software, Nix, git, agent mode, plugin architecture, AI editor, AI development, LLM, developer log, Cursor Rules, PicoCSS, AI code assistant, software development, open source
layout: post
sort_order: 1
---

## Understanding Pipulate Development & AI-Assisted Coding: Getting Started

In the rapidly evolving landscape of AI-assisted development, I find myself at the forefront of an exciting experiment: building Pipulate, a Free and Open Source SEO framework, while leveraging cutting-edge AI tools. This journey has been particularly fascinating as I navigate the intersection of modern web technologies and AI capabilities, using Claude through Cursor AI as my primary coding assistant.

The development process has revealed both the promise and limitations of current AI tools. While these assistants excel at understanding common frameworks, they sometimes struggle with less conventional choices - like our use of FastHTML instead of the more ubiquitous FastAPI, or our heavy reliance on HTMX for dynamic functionality. This challenge has led to an interesting exploration of how to effectively communicate architectural decisions to AI systems, turning what could be a limitation into an opportunity for innovation.

What makes this story particularly compelling is how it reflects the broader "AI Editor Arms Race" currently unfolding in the development world. As different platforms compete to offer the most effective AI-powered coding assistance, developers like myself are becoming early adopters and testers of these emerging capabilities. This article chronicles my experience adapting to and leveraging these rapidly evolving tools, offering insights into both the practical challenges and the remarkable productivity gains that come with AI-assisted development.

---

## Website and Documentation Progress

Yesterday I managed to slam out a new Pipulate.com website that very accurately
shows how to do the Pipulate install on the homepage. I should really adjust the
site to have traditional "Install" and "Documentation" sections, but for now the
home page works as the install page, and documentation is really split up over
architecture and development. I'll polish it over time, but the important thing
as that the install procedure is well documented, easy-to-find, easy to do and
tested. I got a bit of testing of the installer in on macOS and it's seeming
pretty solid. Extremely importantly, the auto-updating process is working. It
will do an automatic git pull every time it's run even for people who are
git-unaware or who don't have git on their machines! That's the power of Nix.

## Blog and Framework Evolution

I also have a very clean blog over there to document the progress of the
Pipulate system as it actually becomes general purpose Free and Open Source SEO
software. Right now, it's more of a framework allowing the production of new
things easily... well, relatively easily. And easily for me being the person who
made the system and am familiar with all its ins and outs. But with the with AI
and all the Cursor Rules I filled it with recently, I think it might be becoming
easier in general. How smart AIs are right now is the most dumb they will ever
be. They're only getting smarter from here, and they're doing a pretty competent
job working with Pipulate today.

## Early Struggles with AI Understanding

It started out as a struggle at first. The system is old-school simple,
stripping away many moving parts and levels of abstractions, installing it all
on your local machine, but using all modern and designed-to-be future-proof
components. It has yet to bear out quite how future-proof it all is, but in
principle it's choosing pure HTTP/HTML over JavaScript and particularly over the
constantly churning heavyweight client-side JavaScript libraries like Angular,
React and Vue. However, to get all that benefit it uses HTMX which minimizes
JavaScript while still giving you many of its benefits and staying tightly
coupled to the HTML standard. It uses HTMX through Python through a new web
framework called FastHTML — and FastHTML is not FastAPI and the profoundly
over-trained on FastAPI LLMs don't like that. No siree, they don't like that one
bit. And from the beginning, it has been a struggle.

The way this is overcome is a combination of converging factors.

### The Rules System Is Getting Better

During the course of this project, the original "rules" standard of a single
`.cursorrules` file has been replaced by a potentially vast set of `.mdc`
sub-rule files in a `.cursor/rules` directory. The AI can navigate this
directory looking at filenames and their associated metadata conveniently
storied in YAML header top-matter (markdown files) to find just the right rule
for its situation. And to make these new rules capturing the *"lightning in a
bottle"* context you might be sitting on top of at any moment, you just type
`/Generate Cursor Rules`

### A Critical Mass of Example Files Has Accumulated

It's all a statistics game. It was the start with the AIs being next-token
predictors, but it's still that way as they come into your codebase and
encounter stuff. With AI's newfound ability to do multiple back-and-forth
tool-calls inspecting your files with their new Agent modes (aka agentic), they
can actually and often do poke around your repository and rules and see what's
what's what — beyond the initial prompt and deliberate context you provided. 

### Agent Mode

Agent mode is almost another factor of what's changed, but it's more like a
critical contributing piece towards the fact that if you have gobs of evidence
that something should be a certain way, it will discover it eventually. In other
words, if you provide a preponderance of good evidence of how something is
supposed to work no matter which way the AI turns to investigate your stuff,
then it just keeps re-discovering the new patterns you want it to use. You
effectively corner it into accepting that FastHTML is not FastAPI. They are
clearly something different and their patterns are radically different under a
thin veneer of similarity, and code is obviously going to break if you start
borrowing patterns associated with one to perform work in the other.

This is a result of copious examples accumulating, as evidenced by:

- Cursor rules
- Example code
- Training guides & documentation

## AI Model Improvements Without Version Changes

The net result is that it feels like the models are getting smarter, suddenly
knowing how to use the terminal and git. It's really an astounding
transformation. But this entire thing has happened without the AI built into
Cursor AI, Claude 3.7 Sonnet, even having a version number incremented. These
improvements apparently all happened under the same base models. They're
squeezing more juice from that lemon I believe merely by improving process. The
Cursor AI framework, the coupling, all those little nuanced details just make
the models better. They certainly let work get done more cleanly and
efficiently.

## The AI Editor Arms Race Heated Up

The arms race happening inside the AI Code Assistant text editors and IDEs is
its own sort of arms race related to but separate from the arms race going on
with the AIs themselves, as evidenced by OpenAI's recent acquisition of Windsurf
for $3 billion. Anthropic getting Clause as the default into Cursor AI was
absolutely brilliant. Can you imagine not only the money they're making off of
it, but the righteous positive feedback loop of training data that they get off
of the deal? Some of the recent announcements from OpenAI regarding ChatGPT o3
and o4 models have come off as *please use us in Cursor AI* but few are willing
to switch off Claude because that $20/mo is almost like an unlimited backdoor
loophole access to Claude. The AI early mover advantage OpenAI lost the early
mover advantage in coding to Anthropic because Cursor.

## Microsoft's Return to the AI Editor Race

If you want more evidence of this AI Editor arms race, look no further than
Microsoft jumping back into the game. They were never out because they were the
first to introduce GitHub CoPilot with direct (ChatGPT) integration directly
into VSCode in the very early days, however they failed to compete in the arms
race when Cursor AI came along and showed how much more elegant AI Assistance
can be. But only a few weeks ago Microsoft released radically new versions of
VSCode that more or less rips off Cursor's innovations and the innovations that
Cursor itself ripped off such as Agent mode. Now this special thing that you
needed exclusive inside-access invite from Manus for is just an everyday feature
in VSCode, Cursor, Windsurf and plugins like Cline. I haven't even used my Manus
invite that finally arrived. The AI Editor arms race is in full swing.

## Practical Application: Menu Management

Alright, so let's put this together into an edit I did last night on Pipulate.
The dropdown menu was getting overloaded with experimental plugins I'm
developing, part of that plethora of examples I mentioned. But I don't want it
to be a mess for the user. And I don't want to get into hierarchical menus,
partially because PicoCSS doesn't support them and partially because I think the
almost videogame-like nature of steering through dropdown menus is one of the
worst things to happen to software since... well, point-and-click. It's like the
worst point-and-click OS pattern ever! That's why `Ctrl`+`Shift`+`P` command
mode is becoming so popular in VSCode. Ubuntu did something similar with
search-driven command palettes. I'll be going to that soon, but in the meanwhile
I wanted to just hide/show some menu options.

Here was my query:

**Me**: Excellent! Thank you.

Okay, so PicoCSS doesn't have hierarchical dropdown menus without hacking, and I
want to keep the number of dropdowns to a minimum. But many of the menu items
I've added are very much for developers, not day-to-day SEO practitioners who
this system is meant for. I need a way to subdue or hide or otherwise make
non-distracting a portion of the active plugins so I can "concentrate" the story
that's told on the dropdown menu into the story I need told:

- Home
- Tasks
- Hello Workflow
- Connect With Botify
- Parameter Buster

All the rest are "Dev-like". And in case the idea occurs to you to make Dev mode
and Prod mode the filter... well, maybe. But even in Dev mode where they're all
accessible, I need a way to do it so I don't have to toggle back and forth with
a server restart constantly. Maybe a "Show all..." or something like that as one
of the menu options that can let you toggle back and forth. Then we would just
need that as an endpoint or something, and a way to define which plugins are of
that hide-able sort or not.

...and here was Claude's 1-shot solution:

**Claude**: I understand you want to create a cleaner menu experience for end-users while still maintaining access to developer tools, without requiring environment switches. Let's implement this with a "Show All" toggle in the menu.

First, we'll need a way to mark plugins as "dev" or "core". Let's add this to the state management and create a toggle mechanism:

```python
# Near the top with other constants
CORE_PLUGINS = {
    "",  # Home
    "tasks",
    "hello_workflow",
    "connect_with_botify",
    "parameter_buster"
}

# After the MENU_ITEMS definition
def is_core_plugin(plugin_name):
    """Determine if a plugin is part of the core workflow."""
    return plugin_name in CORE_PLUGINS

# Modify create_app_menu function
def create_app_menu(menux):
    menu_items = []
    show_all = db.get("show_all_plugins", "0") == "1"
    
    # First add all core items
    for item in MENU_ITEMS:
        # Skip profile app in Apps menu
        if item == profile_app.name:
            continue
            
        # Skip non-core items unless show_all is enabled
        if not show_all and not is_core_plugin(item):
            continue

        # Normalize both the current selection and menu item for comparison
        norm_menux = normalize_menu_path(menux)
        norm_item = normalize_menu_path(item)

        is_selected = norm_item == norm_menux
        item_style = "background-color: var(--pico-primary-background); "if is_selected else ""
        menu_items.append(Li(
            A(endpoint_name(item), 
              href=f"/redirect/{item}", 
              cls="dropdown-item", 
              style=f"{NOWRAP_STYLE} {item_style}"), 
            style="display: block;"
        ))
    
    # Add a divider before the Show All toggle
    menu_items.append(Li(
        Hr(style="margin: 0.5rem 0;"),
        style="display: block;"
    ))
    
    # Add the Show All toggle
    toggle_style = f"{NOWRAP_STYLE} background-color: var(--pico-primary-background);" if show_all else NOWRAP_STYLE
    menu_items.append(Li(
        A("Show All Plugins" if not show_all else "Show Core Plugins",
          hx_post="/toggle_show_all",
          hx_target="body",
          hx_swap="outerHTML",
          cls="dropdown-item",
          style=toggle_style),
        style="display: block;"
    ))

    return Details(
        Summary(
            f"APP: {endpoint_name(menux)}", 
            id="app-id", 
            style="white-space: nowrap; display: inline-block; min-width: max-content;"
        ), 
        Ul(*menu_items, cls="dropdown-menu",), 
        cls="dropdown",
    )

# Add the toggle endpoint
@rt('/toggle_show_all', methods=['POST'])
async def toggle_show_all(request):
    """Toggle between showing all plugins or just core plugins."""
    current = db.get("show_all_plugins", "0")
    db["show_all_plugins"] = "1" if current == "0" else "0"
    
    # Get the current URL to redirect back to
    redirect_url = db.get("last_visited_url", "/")
    return Redirect(redirect_url)
```

Oops, I forgot to add the `is_core_plugin` function. Let me add that:

```python
# After CORE_PLUGINS definition
def is_core_plugin(plugin_name):
    """Determine if a plugin is part of the core workflow."""
    return plugin_name in CORE_PLUGINS
```

This implementation:

1. Defines a `CORE_PLUGINS` set at the top of the file that lists the core plugins you want to always show
2. Adds a `is_core_plugin()` helper function to check if a plugin is core
3. Modifies the `create_app_menu()` function to:
   - Check the `show_all_plugins` state from the database
   - Only show core plugins by default
   - Add a divider and a toggle button at the bottom of the menu
   - The toggle button says either "Show All Plugins" or "Show Core Plugins"
4. Adds a new `/toggle_show_all` endpoint that toggles the state and refreshes the page

The menu will now:
- By default, only show your core plugins (Home, Tasks, Hello Workflow, etc.)
- Have a toggle at the bottom to show/hide the dev plugins
- Remember the toggle state between page loads
- Not require any server restarts to switch between views

The toggle is HTMX-powered and will instantly update the menu when clicked. This gives you a clean, focused menu for end-users while still maintaining easy access to developer tools when needed.

To add new plugins to the core set, just add them to the `CORE_PLUGINS` set at the top of the file. All other plugins will be considered "dev" plugins and will only show when "Show All Plugins" is enabled.

---

## AIs Know Git

And that was it. I had this significant new capability in my software. There's a
certain element of faith and trust here, but the proof is in the working code.
It used to be in the past that a mistake like this would send you spiraling, and
you had to have some forethought and git kung fu to recover, having recently
made a commit and clever branches when you get experimental. However now, it
seems that Cursor AI is maintaining their own git repo in the background as a
sort of secondary git for all your git. There's nothing like 2-git's acting as a
safety-net against downward-spiraling mistakes. You can bet that AI can git
branch, revert and cherry-pick in the background better than any human ever
could. The dance between AI and git is a match made in heaven.

When I realized what a good match AI and git were, now that Agent mode was here
and they knew how to use terminals, my natural first thought was that I would
teach it how to use my terminal to use git. However I do believe that this is
such a sweet spot for productivity, and such a special ingredient in the secret
sauce of the AI Editor arms race that they're doing it for you on their end.
Most people don't really know how to use git on the best of days, so far be it
for them to teach AI how to use it on their behalf. Let the vendors do that! And
I do believe they did. This is why running an AI Editor is not just a couple of
API calls and what made Windsurf worth $3-billion to OpenAI. There's a lot of
secret sauce tool-call development that goes into this. 

### Trust The AI

And with this newfound trust you can put in the AI because you know it's going
to use its tool-calling ability to create its own super-context from the
plethora of rules and example code you provide, even if the context you
originally provided sucks, you can... you can... well, here's another from just
this morning:

**Me**: Get familiar with the plugin architecture.

Look through the rules about making a new plugin.

Find where it keeps things with `xx_` and parenthesis from becoming a plugin.

It prevents copied and pasted files that look like this:

20_hello_workflow (Copy).py

...from getting registered right away.

But copying and pasting in VSCode makes files that look like this:

20_hello_workflow Copy.py

...and so we shooed be able to identify space-copy in the file name and use that to prevent the plugin from being registers too.

**Claude**: I'll help you understand the plugin architecture and suggest an improvement for handling copied files with spaces.

Let me find the relevant code first:

Search files...
I see! Looking at the code, I can help explain the plugin architecture and suggest an improvement for handling copied files with spaces.

Currently, in the `discover_plugin_files()` function, there are two key checks that prevent certain files from being registered as plugins:

1. Files with parentheses:
```python
# Skip files with parentheses (like "tasks (Copy).py")
if '(' in filename or ')' in filename:
    logger.debug(f"Skipping file with parentheses: {filename}")
    continue
```

2. Files with experimental prefix:
```python
# Skip files prefixed with xx_ or XX_ (experimental plugins)
if filename.lower().startswith('xx_'):
    logger.debug(f"Skipping experimental plugin: {filename}")
    continue
```

However, as you noted, when copying files in VSCode, it creates files with a space and "Copy" like this:
`20_hello_workflow Copy.py`

To handle this case, we should add another check. Let me propose an edit to improve this:


This improvement adds a new check that will skip any files containing " Copy" or " copy" in their names. This handles the VSCode copy pattern while still allowing the other existing checks.

The plugin architecture in Pipulate has several key aspects:

1. **Plugin Discovery**:
   - Scans the `plugins/` directory for Python files
   - Uses numeric prefixes (like `20_`) to determine menu order
   - Skips files that are:
     - Starting with `__` (like `__init__.py`)
     - Starting with `xx_` or `XX_` (experimental plugins)
     - Containing parentheses (like `tasks (Copy).py`)
     - And now also containing " Copy" in the name

2. **Plugin Requirements**:
   - Must have a `landing` method
   - Must have either:
     - Direct attributes: `NAME`/`APP_NAME` and `DISPLAY_NAME` (workflow plugins)
     - Or properties: `name` and `DISPLAY_NAME` (CRUD UI plugins)

3. **Plugin Initialization**:
   - Plugins are instantiated with required parameters: `app`, `pipulate`, `pipeline`, and `db`
   - They're automatically registered and added to the navigation menu

4. **Development Workflow**:
   1. Start by copying a template (e.g., `500_hello_workflow.py`)
   2. VSCode will create a copy like `20_hello_workflow Copy.py` (which won't be registered)
   3. Develop and test your plugin in this copy
   4. When ready, rename it with your desired numeric prefix (e.g., `30_my_workflow.py`)

This architecture makes it easy to develop new plugins without them interfering with the running system until they're ready to be activated.

---

## The Cost of Speed: Doubling Down on Fast AI Responses

And that was it. Done. No muss no fuss. I can't tell you what a shift this is. I
actually doubled the money I'm spending for "fast-calls" from what I had
previously upped it to, $40/mo limit to $80/mo limit. I got hit by "slow calls"
and it got frustrating waiting for slower AI responses. This seems in
contradiction to the $20/mo backdoor to Claude I mentioned earlier, and it is.

### The Boiling Frog Effect: Cursor AI's Brilliant Strategy

But this is me slowly getting cooked like the frog by Cursor AI. This is why
Cursor's moves have been so brilliant and why habits are being formed right now
that will determine who makes all that piles of money. I'm going to lower that
limit as soon as I'm through this enormous push I'm in right now to get Pipulate
done. I can live with the slower responses when I am not feeling the heat and
putting the pressure on myself to get it done now.

---

## AI Analysis

**Title/Headline Ideas & Filenames:**

* Title: Pipulate Progress: Taming AI for FastHTML and Streamlined SEO Tool Development
    Filename: `pipulate-ai-fasthtml-seo-tool-development.md`
* Title: AI in the Trenches: How Claude and Cursor AI are Shaping Pipulate's Future
    Filename: `ai-claude-cursor-pipulate-software-development.md`
* Title: Overcoming AI Quirks: Building Pipulate with HTMX, FastHTML, and Agent Mode
    Filename: `ai-pipulate-htmx-fasthtml-agent-mode-challenges.md`
* Title: The AI Editor Arms Race & Pipulate: A Developer's Journey with Claude
    Filename: `ai-editor-arms-race-pipulate-claude-developer-log.md`
* Title: From Confused LLMs to Code Partners: Refining Pipulate's Plugin Architecture with AI
    Filename: `pipulate-plugin-architecture-ai-llm-code-refinement.md`

**Strengths:**

* **Authentic Developer Perspective:** Offers a genuine, in-the-moment account of working with cutting-edge AI tools in a real-world project, highlighting both frustrations and breakthroughs.
* **Specific Technical Insights:** Provides concrete examples of AI interaction (prompts and AI-generated code/solutions), which are valuable for others working with similar technologies (Claude, Cursor AI, FastHTML, HTMX).
* **Highlights Emerging Trends:** Discusses the "AI Editor Arms Race" and the evolution of AI capabilities like "Agent mode" and better context understanding, offering timely observations.
* **Practical Problem Solving:** Demonstrates how the author is actively working to improve AI understanding and utility within their specific project context (e.g., rule systems, example files).

**Weaknesses:**

* **Highly Context-Dependent:** Assumes significant familiarity with the author's project (Pipulate), specific software (Cursor AI, Nix, PicoCSS), and advanced technical concepts, making it difficult for outsiders to fully grasp without the provided introductory context.
* **Conversational and Meandering Structure:** While typical for a journal, the flow jumps between topics (website updates, AI framework struggles, specific coding problems, industry commentary), which could be streamlined for broader readability.
* **Subjectivity:** The author's personal experiences and opinions, while valuable, are central. A more objective analysis of tools or trends would require a different format.
* **Use of Acronyms and Jargon:** Terms like "LLMs," "HTMX," "FastHTML," "PicoCSS," "CRUD UI," and "Nix" are used extensively without in-text definition, relying on the reader's existing knowledge.

**AI Opinion:**

This article provides a valuable and detailed snapshot of a developer's experience integrating advanced AI tools into a niche software development project. Its strength lies in its authenticity and the specific, real-world examples of interactions with AI, particularly Claude via Cursor AI, for coding tasks involving technologies like FastHTML and HTMX. For developers working in similar areas or evaluating these AI tools, the insights into challenges (like AI model confusion) and solutions (like rule systems and "Agent mode") are highly practical.

While its raw, journal-like format makes it dense and jargon-heavy for a general audience, it's a rich source of information for those with the requisite technical background. The discussions around the "AI Editor Arms Race" and the evolving capabilities of AI in code generation and understanding offer a pertinent commentary on current trends in software development. The detailed problem-solving instances, such as refining the plugin menu and handling copied files, showcase the tangible benefits and the learning curve associated with leveraging AI in complex projects.

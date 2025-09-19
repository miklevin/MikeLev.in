---
title: "Command-Line Surgery: A Live Refactor to Untangle a Codebase"
permalink: /futureproof/command-line-surgery-python-refactor/
description: "The conceptual overlap between `plugins`, `modules`, and the upcoming `tools` system is creating too much ambiguity. I've decided to tackle this head-on by renaming them to reflect their true purpose: `apps`, `imports`, and `tools`. This is going to be a formidable refactor, but it's a necessary step to assert control and clarify the architecture. I'll start with the easier rename of `modules` to `imports`, and then, after careful preparation and setting a `git` tag as a safety net, I'll perform the much larger surgery on `plugins` to `apps`."
meta_description: A live, command-by-command journal of a major Python codebase refactor, renaming core directories (modules to imports, plugins to apps) using rg and sed.
meta_keywords: code refactoring, Python, command-line, rg, ripgrep, sed, git, git tag, software architecture, technical debt, plugins, modules, apps, imports
layout: post
sort_order: 1
---

## Setting the Stage: Context for the Curious Book Reader

This entry provides a candid, real-time look into a significant architectural refactoring of the **Pipulate** software project. The author's primary goal is to bring clarity and consistency to the codebase by resolving conceptual overlap between its different extensibility systems. Previously, Pipulate had a `plugins/` directory for user-facing applications and a `modules/` directory for shared library code. This session documents the ambitious decision to rename these to `apps/` and `imports/` respectively, creating a clearer mental model for development. This is not a trivial change; it's a deep, cross-cutting refactor that touches dozens of files.

The reader is given a front-row seat to a masterclass in **methodical, command-line-driven software surgery**. The author uses powerful tools like `ripgrep` (`rg`) and `sed` to perform precise, project-wide search-and-replace operations. The process is a testament to the power of a "bedrock" of Unix-like skills, demonstrating how a developer can confidently execute complex changes that would challenge many graphical IDEs. It also showcases a pragmatic approach to risk management, using `git tag` to create a safe return point before embarking on the "bloody mess" of a major rename.

---

## Confronting Architectural Ambiguity

I'm about to create a SECOND plugin system in Pipulate, this time for the MCP
tool-calling system.

The first plugin system was for workflows and CRUD apps. Workflows are really
apps too, so the first type of plugin that's already in there and working is
called `plugins`. I even already have a folder called `modules`. So there's
already 2 things with overlapping concepts and I'm about to add a third called
`tools`. So tools are plugins too! I have three overlapping concepts... Ugh!

> This cannot stand. The dude does not abide.

However, I will not dive down rabbit holes. I must make sure today is about
actually turning the monolithic tool-calling system into a real plugin system
that handles the real MCP protocol in addition to my superior progressive
enhancement approach. That's the big win for today — not mere file-renaming.

> But we do need stronger mental models.

The win is big having both AIs and humans coming into this repo and everything
just making sense at quick glance. It cuts down on the need for documentation —
which is the #1 way to shoot yourself in the foot these days because AI coding
assistants will drown you in markdown files. I only just dug my way out moving
all that shit to a `cruft` directory.

So this is worth it, but risk must be managed. And I know I can manage risk
because `git` and my newfound `rg | xargs sed` global search and replace
command-line powers... not to mention giving up Cursor AI.

If I were to clarify directory names and use perfect idioms I would probably
call modules `imports` because they really use the Python `import` keyword for
Python modules. I'd probably call the current `plugins` system `app` because
there are all sub-applications within Pipulate taking over the page and
controlling a whole "outer" framework of behavior. App plugins are not quite as
"outer" of a shim wrapper as `server.py` itself but still everything but the
navigation and sectioning up the screen between navigation, application area and
chat area. 

And then there's this new plugin-type we're about to work on which is
appropriately named `tools` right from the start, being tools that are MCP
callable such as they are. Don't go changing anything in the code but do go
analyze the repo to see what I'm talking about.

---

## Let's Consult Gemini CLI

> Note to Human Reader: You're about to see A LOT of code, `rg` and `git`
> output. I mean like yeah sure it's sorta for you as the reader. But even more
> so it's for the AIs that need that meticulous record-keeping to help me with
> surgical code edits. You'll see.

**Me**: [Feeds whole article so far]

**Gemini CLI**: 

```
✦ You've hit on a crucial point of architectural clarity. Having multiple, conceptually
  overlapping systems (plugins, modules, tools) can definitely lead to confusion down the road.
  Your instinct to define and perhaps rename them based on their distinct functions is a great
  one for long-term maintainability.

  I will now analyze the repository to confirm your observations about these three systems. I
  will not change any code. My goal is to explore the structure and purpose of each directory
  and report back on how they align with your proposed clarification (imports, apps, and tools).


  First, I'll start by listing the contents of the plugins/ and modules/ directories to see
  their structure.
 ╭──────────────────────────────────────────────────────────────────────────────────────────╮
 │ ✓  ReadFolder plugins                                                                    │
 │                                                                                          │
 │    Listed 40 item(s).                                                                    │
 │                                                                                          │
 │ ✓  ReadFolder modules                                                                    │
 │                                                                                          │
 │    Listed 15 item(s).                                                                    │
 ╰──────────────────────────────────────────────────────────────────────────────────────────╯
✦ Okay, the directory listings are very revealing and support your assessment:

   * `plugins/`: The numbered file names (010_introduction.py, 040_hello_workflow.py) strongly
     imply a system where modules are loaded in a specific order to build the application's
     navigation and features. This fits your "apps" concept perfectly.
   * `modules/`: These look exactly like standard Python library code (crud.py,
     voice_synthesis.py). They are self-contained units of functionality, fitting your "imports"
     concept.

  To confirm this, I'll now dive one level deeper. I will read a sample file from each directory
   (plugins/040_hello_workflow.py and modules/crud.py) and, most importantly, I'll search
  server.py to find the custom logic that loads the plugins/ directory, as you correctly
  suspected it's not a standard import system.
 ╭───────────────────────────────────────────────────────────────────────────────────────╮
 │ ✓  ReadFile plugins/040_hello_workflow.py                                             │
 │                                                                                       │
 │ ✓  ReadFile modules/crud.py                                                           │
 │                                                                                       │
 │ x  SearchText {"pattern":"plugins/","path":"/home/mike/repos/pipulate/server.py"}     │
 │                                                                                       │
 │    Failed to access path stats for /home/mike/repos/pipulate/server.py: Error: Path   │
 │    is not a directory: /home/mike/repos/pipulate/server.py                            │
 ╰───────────────────────────────────────────────────────────────────────────────────────╯
✦ You are absolutely correct in your assessment. My analysis of the codebase confirms that you
  have three distinct systems with different purposes, and your proposed naming clarification
  (imports, apps, tools) is spot on.

  Here is the evidence from the repository:

  1. modules/ are indeed "Imports"

   * What's Inside: This directory contains files like crud.py, voice_synthesis.py, and
     server_logging.py.
   * My Analysis: Reading modules/crud.py shows that it provides a generic BaseCrud class and a
     Step definition. It contains no user-facing UI or specific application logic. It's a library
     of reusable components.
   * Proof: The plugins/040_hello_workflow.py file explicitly imports from it with the line: from 
     modules.crud import Step.
   * Conclusion: You are correct. modules/ serves as an internal library of shared code, and
     "imports" is a perfectly descriptive name for its function.

  2. plugins/ are indeed "Apps"

   * What's Inside: This directory contains numbered files like 010_introduction.py,
     040_hello_workflow.py, and 110_parameter_buster.py.
   * My Analysis: The 040_hello_workflow.py file is a self-contained web application. It defines a
      HelloFlow class with methods that handle HTTP requests (landing, step_01, step_01_submit),
     generate HTML for a user interface, and manage a specific piece of application logic.
   * The Loading Mechanism: I was unable to search inside server.py to find the loading mechanism.
      However, the structure of the plugins directory and the contents of the files strongly
     suggest a custom loader that iterates through the numbered files, instantiates the classes
     within them, and uses a method like the pipulate.register_workflow_routes(self) call I saw to
      integrate them into the main application.
   * Conclusion: You are correct. These are not simple plugins; they are full-featured "apps" or
     "workflows" that take over the main UI.

  3. tools/ are indeed "Tools"

   * What's Inside: As we've just worked on, this directory contains modules like mcp_tools.py
     and botify_tools.py.
   * My Analysis: These files export individual, non-UI functions (browser_scrape_page,
     botify_ping) that are designed to be called programmatically, either from the command line
     or by an AI assistant. They perform specific, discrete actions.
   * Conclusion: You are correct. "Tools" is the perfect name for this system of callable,
     command-like functions.

  You have a very clear understanding of your own architecture. The conceptual overlap is real,
  and your proposed clarification into Imports, Apps, and Tools accurately reflects the distinct
   role each system plays in Pipulate.
```

## The First Cut: Renaming `modules` to `imports`

> I have an intense worksession ahead of me. I cannot allow an early failure to
> punch me in the stomach and demoralize. I have to throw myself a softball and
> bank that small-win that creates that upward-spiraling of accomplishments.

**Me**: Okay, but renaming plugins would be a bloody mess, at least if I tried
starting with that. But making the modules folder was relatively recently. The
term `modules` is quite unique as is the term `imports` that I plan on changing
it too and that is perfectly in line with my recent `rg | xargs sed` pattern
practice. We're also in a recently created experimental `tools` branch which is
for the explicit purpose of making the `tools` plugin system. And this is also a
good opportunity to generally assert my control over the code again. So I'm
going to start with the still ambitious and somewhat formidable renaming of
`modules` — which is actually a valid name for the purpose but only among Python
"insiders" who know *modules* is the *technically correct* word for importable
Python files, but still it doesn't match the `import` keyword that they're used
with, so for explicitness especially between 3 overlapping concepts, I think
this is the best one to start with. And so...

1. ripgrep that shit

```bash
[mike@nixos:~/repos/pipulate]$ rg modules
pyproject.toml
46:py-modules = ["cli", "server", "common", "config", "ai_dictdb", "__init__"]

tools/__init__.py
2:Tools package for Pipulate - Focused MCP tool modules

requirements.txt
209:pyasn1_modules==0.4.2

tools/botify_tools.py
206:        from modules.botify.true_schema_discoverer import \

config.py
288:# Add current directory to path to import modules

discover_tools.py
51:    for name, obj in inspect.getmembers(sys.modules['tools.mcp_tools']):
107:            func = getattr(sys.modules['tools.mcp_tools'], tool)

server.py
10:- Root cause: modules.append_only_conversation system created concurrent SQLite connections
74:from modules import botify_code_generation
75:from modules.ascii_displays import (ai_breadcrumb_summary, chip_says,
84:from modules.server_logging import console, rich_json_display, setup_logging
163:# Theme and logging functions are now imported from modules.server_logging.py
167:# All ASCII display functions now imported from modules.ascii_displays.py
170:# Logging functions are now imported from modules.server_logging.py
468:# DebugConsole and console now imported from modules.server_logging
471:# rich_json_display now imported from modules.server_logging
614:                    from modules.append_only_conversation import \
675:                from modules.append_only_conversation import \
1356:    Root Cause: modules.append_only_conversation.get_conversation_system() creates a
2983:    # Level 3: python -c "from modules.ai_tool_discovery_simple_parser import execute_simple_command..."
3338:                response_text += f"\nLevel 3: `python -c \"from modules.ai_tool_discovery_simple_parser import execute_simple_command; import asyncio; print(asyncio.run(execute_simple_command('mcp')))\"`"
3966:        plugin_module = sys.modules.get(plugin_instance_obj.__module__)
4060:    plugin_modules = {}
4065:        return plugin_modules
4088:                plugin_modules[clean_name] = module
4093:    logger.debug(f'Discovered plugin modules: {list(plugin_modules.keys())}')
4094:    return plugin_modules
4097:def find_plugin_classes(plugin_modules, discovered_modules):
4098:    """Find all plugin classes in the given modules."""
4100:    for module_or_name in plugin_modules:
4104:                original_name = getattr(discovered_modules[module_name], '_original_filename', module_name)
4140:discovered_modules = discover_plugin_files()
4141:discovered_classes = find_plugin_classes(discovered_modules, discovered_modules)
4187:            original_name = getattr(discovered_modules[module_name], '_original_filename', module_name)
4257:    plugin_module_obj = sys.modules.get(instance.__module__)
4351:        from modules.durable_backup_system import DurableBackupManager
4823:    if plugin_key in discovered_modules:
4824:        original_filename = getattr(discovered_modules[plugin_key], '_original_filename', plugin_key)
4854:    plugin_module = sys.modules.get(plugin_module_path)
4890:    plugin_module = sys.modules.get(plugin_module_path)
5495:        from modules.voice_synthesis import (VOICE_SYNTHESIS_AVAILABLE,
5761:        # Build searchable plugin data from discovered modules
6066:        from modules.durable_backup_system import DurableBackupManager
6643:            from modules.crud import check_ollama_availability

tools/advanced_automation_tools.py
2528:        server_module = sys.modules.get('server')
2613:        server_module = sys.modules.get('server')
2678:        server_module = sys.modules.get('server')
2733:        server_module = sys.modules.get('server')
2805:        server_module = sys.modules.get('server')
2904:        server_module = sys.modules.get('server')

cli.py
10:    Level 3: python -c "from modules.ai_tool_discovery_simple_parser import execute_simple_command..."
30:    Level 3: python -c "from modules.ai_tool_discovery_simple_parser import execute_simple_command; import asyncio; print(asyncio.run(execute_simple_command('mcp')))"

plugins/820_selenium.py
11:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

tools/mcp_tools.py
17:Level 3 (Python): python -c "from modules.ai_tool_discovery_simple_parser import execute_simple_command; import asyncio; print(asyncio.run(execute_simple_command('mcp')))"
60:    from modules.voice_synthesis import (VOICE_SYNTHESIS_AVAILABLE,
80:# Import functions from extracted modules
165:        server_module = sys.modules.get('server') or sys.modules.get('__main__')
330:        server_module = sys.modules.get('server') or sys.modules.get('__main__')
531:        server_module = sys.modules.get('server') or sys.modules.get('__main__')
938:    server_module = sys.modules.get('server')
1604:        server_module = sys.modules.get('server')
1771:        server_module = sys.modules.get('server')
1977:                from modules.dom_processing.enhanced_dom_processor import \
3427:        from modules.botify.true_schema_discoverer import \
3948:            mcp_module = sys.modules.get('tools.mcp_tools')
3963:            server_module = sys.modules.get('server')
3968:                main_module = sys.modules.get('__main__')
4378:        server_module = sys.modules.get('server')
4667:        server_module = sys.modules.get('server')
4705:        server_module = sys.modules.get('server')
4741:        server_module = sys.modules.get('server')
4776:        server_module = sys.modules.get('server')

plugins/120_link_graph.py
24:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

modules/server_logging.py
64:    from modules.server_logging import console

plugins/620_mermaid.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

modules/append_only_conversation.py
141:            from modules.conversation_backup_system import create_conversation_backup
321:            from modules.conversation_backup_system import restore_conversation_backup
485:    from modules.conversation_architecture_migration import ConversationArchitectureMigration

modules/botify/true_schema_discoverer.py
1:# modules.botify.true_schema_discoverer.py

modules/ai_dictdb.py
7:# Get the directory of the current file (e.g., /path/to/pipulate/modules)

modules/crud.py
37:    from modules.durable_backup_system import backup_manager
529:# from modules.crud import Step
600:# Extracted from modules.crud patterns in large workflow files
608:    """Utility functions extracted from modules.crud workflow patterns.

plugins/640_javascript.py
10:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/540_checkboxes.py
6:from modules.crud import Step, VALID_ROLES

plugins/810_webbrowser.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/720_rich.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/440_browser_automation.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/100_connect_with_botify.py
7:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/580_upload.py
11:from modules.crud import Step, VALID_ROLES

plugins/240_simon_mcp.py
11:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/130_gap_analysis.py
11:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/730_matplotlib.py
15:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/510_text_field.py
5:from modules.crud import Step, VALID_ROLES

plugins/030_roles.py
14:from modules.crud import BaseCrud
294:        from modules.crud import check_ollama_availability
667:                plugin_module = sys.modules.get(plugin_instance.__module__)

plugins/020_profiles.py
14:from modules.crud import BaseCrud

browser_automation/google_search_automation_demo.py
33:from modules.dom_processing.enhanced_dom_processor import EnhancedDOMProcessor

plugins/070_history.py
26:    from modules.append_only_conversation import (

plugins/040_hello_workflow.py
5:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition
130:# 🎯 STEP DEFINITION: Now imported from modules.crud.py (eliminates 34+ duplications)

plugins/520_text_area.py
5:from modules.crud import Step, VALID_ROLES

plugins/300_blank_placeholder.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition
13:# 🎯 STEP DEFINITION: Now imported from modules.crud.py (eliminates 34+ duplications)

plugins/570_switch.py
5:from modules.crud import Step, VALID_ROLES

plugins/610_markdown.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/210_widget_examples.py
11:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/110_parameter_buster.py
21:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/400_botify_trifecta.py
22:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition
2613:        from modules.botify.code_generators import execute_qualifier_logic

plugins/230_dev_assistant.py
13:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/430_tab_opener.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/060_tasks.py
10:from modules.crud import BaseCrud

helpers/prompt_foo/generate_files_list.py
129:        'node_modules',
278:        FileEntry("modules.ascii_displays.py", True, "Externalized ASCII art functions"),

plugins/530_dropdown.py
5:from modules.crud import Step, VALID_ROLES

plugins/001_dom_visualizer.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/550_radios.py
5:from modules.crud import Step, VALID_ROLES

browser_automation/interactive_google_search.py
30:from modules.dom_processing.enhanced_dom_processor import EnhancedDOMProcessor

browser_automation/google_search_example.py
26:from modules.dom_processing.ai_dom_beautifier import AIDOMBeautifier

plugins/560_range.py
5:from modules.crud import Step, VALID_ROLES

plugins/200_workflow_genesis.py
13:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/710_pandas.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/630_prism.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

helpers/release/sync_ascii_art.py
734:    skip_dirs = {'.git', '_site', '.bundle', 'node_modules', '.gem', '.jekyll-cache'}

[mike@nixos:~/repos/pipulate]$
```

## Word Combos For Search & Replace Safety

> One of the best moves I made was using `rg` for getting rapid holistic
> overviews of codebases. You literally just type 2 words and you get back
> nothing less than every occurrence of that word in full-context color-coded
> glory! That's how you spot important "safety patterns" for search and replace.

Yikes! There's `sys.modules` I don't want to conflict with. If I had known that
beforehand I would have probably not chosen `modules` for `modules`. Okay, so
the patterns I'll really be replacing are:

`from modules`

This is also an excellent example of why I'm living with having to backslash
`rg` all the time in the actual search/place operations because with a huge list
of output like that it's helpful to pip the output of `rg` to less and to still
see it color-coded. The backslash strips the color-coding for the piping
operations where that would interfere. But first we look at the target
replacements only where we do the imports `from modules`:

```bash
[mike@nixos:~/repos/pipulate]$ rg 'from modules'
tools/botify_tools.py
206:        from modules.botify.true_schema_discoverer import \

tools/mcp_tools.py
17:Level 3 (Python): python -c "from modules.ai_tool_discovery_simple_parser import execute_simple_command; import asyncio; print(asyncio.run(execute_simple_command('mcp')))"
60:    from modules.voice_synthesis import (VOICE_SYNTHESIS_AVAILABLE,
1977:                from modules.dom_processing.enhanced_dom_processor import \
3427:        from modules.botify.true_schema_discoverer import \

plugins/820_selenium.py
11:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/550_radios.py
5:from modules.crud import Step, VALID_ROLES

plugins/620_mermaid.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/640_javascript.py
10:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/710_pandas.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/540_checkboxes.py
6:from modules.crud import Step, VALID_ROLES

browser_automation/google_search_automation_demo.py
33:from modules.dom_processing.enhanced_dom_processor import EnhancedDOMProcessor

plugins/440_browser_automation.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/230_dev_assistant.py
13:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/130_gap_analysis.py
11:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

browser_automation/interactive_google_search.py
30:from modules.dom_processing.enhanced_dom_processor import EnhancedDOMProcessor

plugins/300_blank_placeholder.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition
13:# 🎯 STEP DEFINITION: Now imported from modules.crud.py (eliminates 34+ duplications)

plugins/120_link_graph.py
24:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/030_roles.py
14:from modules.crud import BaseCrud
294:        from modules.crud import check_ollama_availability

browser_automation/google_search_example.py
26:from modules.dom_processing.ai_dom_beautifier import AIDOMBeautifier

plugins/001_dom_visualizer.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/070_history.py
26:    from modules.append_only_conversation import (

plugins/430_tab_opener.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/810_webbrowser.py
9:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/200_workflow_genesis.py
13:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/210_widget_examples.py
11:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/730_matplotlib.py
15:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/630_prism.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/610_markdown.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/240_simon_mcp.py
11:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/720_rich.py
8:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/580_upload.py
11:from modules.crud import Step, VALID_ROLES

plugins/110_parameter_buster.py
21:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/100_connect_with_botify.py
7:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition

plugins/060_tasks.py
10:from modules.crud import BaseCrud

plugins/400_botify_trifecta.py
22:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition
2613:        from modules.botify.code_generators import execute_qualifier_logic

plugins/530_dropdown.py
5:from modules.crud import Step, VALID_ROLES

plugins/040_hello_workflow.py
5:from modules.crud import Step  # 🎯 STANDARDIZED: Import centralized Step definition
130:# 🎯 STEP DEFINITION: Now imported from modules.crud.py (eliminates 34+ duplications)

plugins/560_range.py
5:from modules.crud import Step, VALID_ROLES

cli.py
10:    Level 3: python -c "from modules.ai_tool_discovery_simple_parser import execute_simple_command..."
30:    Level 3: python -c "from modules.ai_tool_discovery_simple_parser import execute_simple_command; import asyncio; print(asyncio.run(execute_simple_command('mcp')))"

plugins/510_text_field.py
5:from modules.crud import Step, VALID_ROLES

plugins/570_switch.py
5:from modules.crud import Step, VALID_ROLES

plugins/520_text_area.py
5:from modules.crud import Step, VALID_ROLES

server.py
74:from modules import botify_code_generation
75:from modules.ascii_displays import (ai_breadcrumb_summary, chip_says,
84:from modules.server_logging import console, rich_json_display, setup_logging
163:# Theme and logging functions are now imported from modules.server_logging.py
167:# All ASCII display functions now imported from modules.ascii_displays.py
170:# Logging functions are now imported from modules.server_logging.py
468:# DebugConsole and console now imported from modules.server_logging
471:# rich_json_display now imported from modules.server_logging
614:                    from modules.append_only_conversation import \
675:                from modules.append_only_conversation import \
2983:    # Level 3: python -c "from modules.ai_tool_discovery_simple_parser import execute_simple_command..."
3338:                response_text += f"\nLevel 3: `python -c \"from modules.ai_tool_discovery_simple_parser import execute_simple_command; import asyncio; print(asyncio.run(execute_simple_command('mcp')))\"`"
4351:        from modules.durable_backup_system import DurableBackupManager
5495:        from modules.voice_synthesis import (VOICE_SYNTHESIS_AVAILABLE,
6066:        from modules.durable_backup_system import DurableBackupManager
6643:            from modules.crud import check_ollama_availability

modules/crud.py
37:    from modules.durable_backup_system import backup_manager
529:# from modules.crud import Step
600:# Extracted from modules.crud patterns in large workflow files
608:    """Utility functions extracted from modules.crud workflow patterns.

plugins/020_profiles.py
14:from modules.crud import BaseCrud

modules/server_logging.py
64:    from modules.server_logging import console

modules/append_only_conversation.py
141:            from modules.conversation_backup_system import create_conversation_backup
321:            from modules.conversation_backup_system import restore_conversation_backup
485:    from modules.conversation_architecture_migration import ConversationArchitectureMigration

[mike@nixos:~/repos/pipulate]$
```

Okay, I'm confident about this. 

```bash
[mike@nixos:~/repos/pipulate]$ \rg 'from modules' --null -l | xargs -0 sed 's/from modules/from imports/g' -i

[mike@nixos:~/repos/pipulate]$ git mv modules imports

[mike@nixos:~/repos/pipulate]$
```

BAM! Wow, these global grepping abilities are really coming together though
technically it's neither global nor grepping. It's recursive from the repo root
(or wherever I'm executing the command from) on down, but while abiding by
`.gitignore`! And it's not `grep` but rather "ripgrep" which is the `rg`
command. So I guess I should technically think of this as recursively
ripgrepping.

And after I did it I `exit`ed out of `python server.py` in the terminal console
running the server and showing its output and then ran `nix develop .#dev` which
is like stopping and starting the server but actually has a bit more of the
installation process as part of it and is a good test as to whether big edits
like this that touch lots of files broke anything or not.

The next thing I want to do because I don't want the concept of `apps` to
overlap with anything and because I am working up the courage to do this because
the dropdown menu for these things in the Pipulate UI is already called `APPS`
so it would make the language more consistent, to make a new *app* for the
`APPS` menu you go to the `apps/` folder yadda yadda. Everything's a plugin.
It's too ambiguous. But saying both *workflows* and *CRUD apps* are *APPS* —
see, they both reside in the APPS dropdown menu — makes perfect sense.

## The Main Surgery: A Multi-Pass `sed` Operation to Rename `plugins`

> All that prior stuff was warm-up. What I'm about to do is not for the faint of
> heart. I'm doing multiple search-and-replaces essentially on the same word,
> but each one laser-focused on a particular arrangement to isolate the
> collateral damage I might do to the rest of the codebase were I to be sloppy.

Pshew! This is huge. Deep breath...

```bash
rg plugins | less
```

This is DEFINITELY a time when you pipe it to `less`, are thankful for the
color-coding and use `Ctrl`+`f` for forward and `Ctrl`+`b` for back paging
through screens and similarly `j` and `k` for up and down by 1-line and `g` for
*top-of-file* (paged `less` output) and `G` for *bottom-of-file* (paged `less`
output). These are `vim` controls that the `less` program also uses which is
typical of *nerd-level* software throughout the world and another excellent
example of why there is a bedrock of tech. Saying that there is a *bedrock* of
tech absolutely does have a Unix/C/vim bias to it, but that's what won. You lean
into what won — so long as that's not JavaScript in the browser, ahaha!

## Pre-Op: Setting a `git tag` Safety Net

> The deep breath before jumping into work that you know will be formidable and
> error-prone is the very moment when you want to guarantee your success. And
> there's nothing that screams success more than a well-labeled go-back undo
> safety-net to that moment you took the leap of faith. Faith is good. Infinite
> undo is better.

Anyhoo... this is *very scalpel precision work!*

Stuff will break.

But it's a controlled break.

First we make sure we recently committed. We take note of the git commit message
and the hash. But better yet, let's use git labels!

How do you label a git hash for later easy go-back?

**Gemini**: You label a git hash for easy go-back using the `git tag` command. 🏷️

Tags create a permanent, human-readable pointer to a specific commit, which is ideal for marking release points, major updates, or any significant moment in your project's history.

-----

## How to Create a Tag

There are two main ways to create a tag: on your current commit or on a past commit.

  * **To tag your current commit** (the one `HEAD` is pointing to):

    ```bash
    git tag <tag_name>
    ```

  * **To tag a past commit**, you first need its hash. You can find this using `git log`. Once you have the hash, run:

    ```bash
    git tag <tag_name> <commit_hash>
    ```

    For example:

    ```bash
    git tag v1.0.1 a1b2c3d4
    ```

-----

## Lightweight vs. Annotated Tags

Git has two types of tags, and it's important to know the difference.

### Annotated Tags (Recommended)

**Annotated tags** are the best practice for any official or shared label. They are stored as full objects in the Git database and include the tagger's name, email, date, and a tagging message.

To create an annotated tag, use the `-a` (annotate) and `-m` (message) flags:

```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
```

### Lightweight Tags

A **lightweight tag** is simply a pointer to a commit—it's just a name for a hash without any extra information. They are useful for temporary or private labels.

To create a lightweight tag, just provide the name:

```bash
git tag v1.0.0-beta
```

-----

## Viewing and Managing Tags

Here are the essential commands for working with your tags.

  * **List all tags:**

    ```bash
    git tag
    ```

  * **View information about a tag** (shows the commit and the annotation message):

    ```bash
    git show <tag_name>
    ```

  * **Push tags to a remote repository:** By default, `git push` does not send tags. You must push them explicitly.

      * To push a single tag:
        ```bash
        git push origin <tag_name>
        ```
      * To push all of your local tags at once:
        ```bash
        git push --tags
        ```

  * **Check out a tag:** To go back to the state of the repository at a specific tag, you use `git checkout`.

    ```bash
    git checkout v1.0.0
    ```

    **Note:** This will put you in a **"detached HEAD"** state, which is perfect for inspecting old code. If you want to start making changes from this point, you should create a new branch with `git checkout -b <new_branch_name>`.

---

**Me**: 

```bash
[mike@nixos:~/repos/pipulate]$ git tag
CROSS_PLATFORM_MASTERY_v1.0.0
ascii-multiplication-defense-v1.0
on-a-role
platform-detection-checkpoint
voice-synthesis-breakthrough
yellowbrickroad

[mike@nixos:~/repos/pipulate]$ git tag pre-plugin-renaming 114e0a816e795af76a025e8889cc3ca7b889b8bb

[mike@nixos:~/repos/pipulate]$ git tag
CROSS_PLATFORM_MASTERY_v1.0.0
ascii-multiplication-defense-v1.0
on-a-role
platform-detection-checkpoint
pre-plugin-renaming
voice-synthesis-breakthrough
yellowbrickroad

[mike@nixos:~/repos/pipulate]$
```

Okay, how do I delete all the tag names except for pre-plugin-renaming?

**Gemini**: You can do this with a single, piped command that lists all tags, filters out the one you want to keep, and then passes the rest to the delete command.

```bash
git tag | grep -v pre-plugin-renaming | xargs git tag -d
```

-----

### How It Works 🤓

This one-liner chains together three standard Unix commands:

1.  **`git tag`**: This command, by itself, lists all the tags in your local repository, with each tag on a new line.

2.  **`grep -v pre-plugin-renaming`**: The output from `git tag` is "piped" (`|`) as input to `grep`. The **`-v`** flag is the key here; it **inverts** the search, meaning it will output every line that **does not** match "pre-plugin-renaming".

3.  **`xargs git tag -d`**: The filtered list of tags (all except the one you're keeping) is then piped to `xargs`. The `xargs` command takes the incoming list and runs the specified command (`git tag -d`) for each item in the list.

The result is that `git tag -d` is executed for every tag except `pre-plugin-renaming`.

-----

### Important Note on Remote Tags

This command only deletes the tags from your **local** repository. If you have pushed these tags to a remote repository (like GitHub), they will still exist there.

To delete the tags from your remote (usually named `origin`), you would need to run `git push origin --delete <tagname>` for each tag. You could adapt the command above for that purpose if needed.

---

**Me**: 

```bash
[mike@nixos:~/repos/pipulate]$ git tag | grep -v pre-plugin-renaming | xargs git tag -d
Deleted tag 'CROSS_PLATFORM_MASTERY_v1.0.0' (was 0c7873f)
Deleted tag 'ascii-multiplication-defense-v1.0' (was 06eca28)
Deleted tag 'on-a-role' (was 48ae3cc)
Deleted tag 'platform-detection-checkpoint' (was 6986c78)
Deleted tag 'voice-synthesis-breakthrough' (was 0d99ee8)
Deleted tag 'yellowbrickroad' (was 8dc5102)

[mike@nixos:~/repos/pipulate]$ git tag
pre-plugin-renaming

[mike@nixos:~/repos/pipulate]$
```

Gemini is as nerdy as I am! You have to love its use of the 🤓 emoji.

This is a great example of the pre-surgery work.

Now we jump in headfirst and rename the plugin folder to apps:

```bash
[mike@nixos:~/repos/pipulate]$ git mv plugins apps

[mike@nixos:~/repos/pipulate]$ git status
On branch tools
Your branch is up to date with 'origin/tools'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	renamed:    plugins/001_dom_visualizer.py -> apps/001_dom_visualizer.py
	renamed:    plugins/010_introduction.py -> apps/010_introduction.py
	renamed:    plugins/020_profiles.py -> apps/020_profiles.py
	renamed:    plugins/030_roles.py -> apps/030_roles.py
	renamed:    plugins/040_hello_workflow.py -> apps/040_hello_workflow.py
	renamed:    plugins/050_documentation.py -> apps/050_documentation.py
	renamed:    plugins/060_tasks.py -> apps/060_tasks.py
	renamed:    plugins/070_history.py -> apps/070_history.py
	renamed:    plugins/100_connect_with_botify.py -> apps/100_connect_with_botify.py
	renamed:    plugins/110_parameter_buster.py -> apps/110_parameter_buster.py
	renamed:    plugins/120_link_graph.py -> apps/120_link_graph.py
	renamed:    plugins/130_gap_analysis.py -> apps/130_gap_analysis.py
	renamed:    plugins/200_workflow_genesis.py -> apps/200_workflow_genesis.py
	renamed:    plugins/210_widget_examples.py -> apps/210_widget_examples.py
	renamed:    plugins/220_roadmap.py -> apps/220_roadmap.py
	renamed:    plugins/230_dev_assistant.py -> apps/230_dev_assistant.py
	renamed:    plugins/240_simon_mcp.py -> apps/240_simon_mcp.py
	renamed:    plugins/300_blank_placeholder.py -> apps/300_blank_placeholder.py
	renamed:    plugins/400_botify_trifecta.py -> apps/400_botify_trifecta.py
	renamed:    plugins/430_tab_opener.py -> apps/430_tab_opener.py
	renamed:    plugins/440_browser_automation.py -> apps/440_browser_automation.py
	renamed:    plugins/450_stream_simulator.py -> apps/450_stream_simulator.py
	renamed:    plugins/510_text_field.py -> apps/510_text_field.py
	renamed:    plugins/520_text_area.py -> apps/520_text_area.py
	renamed:    plugins/530_dropdown.py -> apps/530_dropdown.py
	renamed:    plugins/540_checkboxes.py -> apps/540_checkboxes.py
	renamed:    plugins/550_radios.py -> apps/550_radios.py
	renamed:    plugins/560_range.py -> apps/560_range.py
	renamed:    plugins/570_switch.py -> apps/570_switch.py
	renamed:    plugins/580_upload.py -> apps/580_upload.py
	renamed:    plugins/610_markdown.py -> apps/610_markdown.py
	renamed:    plugins/620_mermaid.py -> apps/620_mermaid.py
	renamed:    plugins/630_prism.py -> apps/630_prism.py
	renamed:    plugins/640_javascript.py -> apps/640_javascript.py
	renamed:    plugins/710_pandas.py -> apps/710_pandas.py
	renamed:    plugins/720_rich.py -> apps/720_rich.py
	renamed:    plugins/730_matplotlib.py -> apps/730_matplotlib.py
	renamed:    plugins/810_webbrowser.py -> apps/810_webbrowser.py
	renamed:    plugins/820_selenium.py -> apps/820_selenium.py


[mike@nixos:~/repos/pipulate]$
```

And now we do the first major bit of file surgery. It's not going to get
everything because I noticed that I build paths to the `plugins` folder all over
the place. But those will be much easier after I take care of the most common
use case and assuredly an actual folder reference, which is "plugins" followed
by a slash. But before we do that and because we know we can enlist AI to check
our work and help us make sure we did this all correctly, we first capture the
"before" output long as it might be:

```bash
[mike@nixos:~/repos/pipulate]$ rg plugins > /tmp/deleteme.txt

[mike@nixos:~/repos/pipulate]$ xc /tmp/deleteme.txt

[mike@nixos:~/repos/pipulate]$
```

That puts in in my copy-buffer. The `xc` command is an alias for `xclip
-selection clipboard <` and the backslash is to turn off color-coding which I
automatically have turned on by default unless overwritten, which is very
important to remember when I pipe things and redirect output to files like I
just did. Here's the "before":

```
README.md:   - Left sidebar with workflow plugins (Introduction, Profiles, etc.)
README.md:- Check out `plugins/010_introduction.py` to see workflow code structure
README.md:│   │   │   ├── Input [id='nav-plugin-search', role='searchbox', aria-label='Search plugins']
README.md:    ├── plugins/                   # Workflow plugins (010_introduction.py, 400_trifecta.py, etc.)
README.md:plugins/
README.md:* Files in `plugins/` directory are auto-discovered
README.md:plugins/                    # Your workflows (auto-discovered)
README.md:The repository includes not only polished plugins but also experimental scripts and notebooks under development (e.g., in the root directory or marked with `xx_` prefix in plugin directories). These represent ongoing work and exploration.
requirements.txt:mdit-py-plugins==0.4.2
config.py:            'description': 'Essential plugins available to all users.',
config.py:            'description': 'Tools for creating, debugging, and managing workflows and plugins.',
server.py:    logger.warning(f'🚨 PRODUCTION_DATABASE_WARNING: If demo is triggered, plugins using static DB_FILENAME may cause issues!')
server.py:# This registry allows plugins to register MCP tools that can be called
server.py:# Global registry for MCP tools - populated by plugins during startup
server.py:    This class serves as the main interface for plugins to access
server.py:        Centralizes the folder button pattern used across many plugins.
server.py:            blank_placeholder_module = importlib.import_module('plugins.910_blank_placeholder')
server.py:# BaseCrud class moved to plugins/crud.py to avoid circular imports
server.py:if not os.path.exists('plugins'):
server.py:    os.makedirs('plugins')
server.py:    logger.info('📁 FINDER_TOKEN: PLUGINS_DIR - Created plugins directory')
server.py:    """Discover and import all Python files in the plugins directory.
server.py:    This function scans the 'plugins' directory and imports each .py file
server.py:    - Starting with 'xx_' or 'XX_' (indicating experimental/in-progress plugins)
server.py:    plugins_dir = os.path.join(os.path.dirname(__file__), 'plugins')
server.py:    logger.debug(f'Looking for plugins in: {plugins_dir}')
server.py:    if not os.path.isdir(plugins_dir):
server.py:        logger.warning(f'Plugins directory not found: {plugins_dir}')
server.py:    sorted_files = sorted(os.listdir(plugins_dir), key=numeric_prefix_sort)
server.py:                module = importlib.import_module(f'plugins.{original_name}')
server.py:                module = importlib.import_module(f'plugins.{original_name}')
server.py:                        # Only log classes that look like they might be plugins (have common plugin attributes)
server.py:    figlet_banner("plugins", "Pipulate Workflows and CRUD Apps", font='standard', color='orange3')
server.py:            module = importlib.import_module(f'plugins.{original_name}')
server.py:                            # Inject centralized configuration for plugins that need it
server.py:ordered_plugins = []
server.py:    if module_name not in ordered_plugins and module_name in plugin_instances:
server.py:        ordered_plugins.append(module_name)
server.py:        plugins_discovered=discovered_count,
server.py:        plugins_registered=registered_count,
server.py:    failed_plugins = []
server.py:            failed_plugins.append(f'{module_name}.{class_name}')
server.py:    server_whisper(f"Some plugins need attention: {', '.join(failed_plugins)}", "⚠️")
server.py:    logger.warning(f'FINDER_TOKEN: PLUGIN_REGISTRATION_SUMMARY - Failed plugins: {", ".join(failed_plugins)}')
server.py:    chip_says("All plugins loaded successfully! The workshop is fully equipped.", BANNER_COLORS['plugin_registry_success'])
server.py:MENU_ITEMS = base_menu_items + ordered_plugins + additional_menu_items
server.py:            placeholder='Search plugins (Ctrl+K)',
server.py:            hx_post='/search-plugins',
server.py:            aria_label='Search plugins',
server.py:    plugins_by_role = group_plugins_by_role(active_role_names)
server.py:            role_plugins = plugins_by_role.get(role_name, [])
server.py:            role_plugins.sort(key=lambda x: get_plugin_numeric_prefix(x))
server.py:            for plugin_key in role_plugins:
server.py:def group_plugins_by_role(active_role_names):
server.py:    """Group plugins by their primary role for hierarchical menu organization."""
server.py:    plugins_by_role = {}
server.py:    for plugin_key in ordered_plugins:
server.py:            if role_name not in plugins_by_role:
server.py:                plugins_by_role[role_name] = []
server.py:            plugins_by_role[role_name].append(plugin_key)
server.py:    logger.debug(f'Plugins grouped by role: {plugins_by_role}')
server.py:    return plugins_by_role
server.py:@rt('/search-plugins', methods=['POST'])
server.py:async def search_plugins(request):
server.py:    """Search plugins based on user input - Carson Gross style active search."""
server.py:        searchable_plugins = []
server.py:            if module_name in ['profiles', 'roles']:  # Skip system plugins
server.py:            searchable_plugins.append(plugin_entry)
server.py:        # Filter plugins based on search term
server.py:            filtered_plugins = []
server.py:            for plugin in searchable_plugins:
server.py:                    filtered_plugins.append(plugin)
server.py:            # Show ALL plugins on empty search (dropdown menu behavior)
server.py:            filtered_plugins = searchable_plugins
server.py:        if filtered_plugins:
server.py:            auto_select_single = len(filtered_plugins) == 1
server.py:            for i, plugin in enumerate(filtered_plugins):  # Show all results - no artificial limit
server.py:        logger.error(f"Error in search_plugins: {e}")
server.py:                "plugins": "Workflow applications and business logic",
pyproject.toml:include = ["plugins*", "static*"]
tools/advanced_automation_tools.py:            "command": "ls -la server.py plugins browser_automation"
tools/mcp_tools.py:        chrome_options.add_argument('--disable-plugins')
tools/mcp_tools.py:        plugin_name = plugin_filename.replace('plugins/', '').replace('.py', '')
tools/mcp_tools.py:            plugin_name = plugin_filename.replace('plugins/', '').replace('.py', '')
tools/mcp_tools.py:                    # For file upload plugins, we need to initialize the workflow first
tools/mcp_tools.py:        plugins_exists = os.path.exists("plugins/")
tools/mcp_tools.py:            "plugins_directory_exists": plugins_exists,
tools/mcp_tools.py:            "environment_ready": server_exists and plugins_exists
assets/pipulate-init.js:- plugins/ (41 plugin files)
training/roles.md:The Roles system is Pipulate's **homepage and menu control center** - a sophisticated CRUD application that determines which plugins appear in your APP menu. It's both the **landing page** and the **role-based access control system** that customizes your experience.
training/roles.md:2. **Menu Control System**: Determines which plugins appear in the APP dropdown
training/roles.md:- **Self-discovering**: New plugins automatically appear in the appropriate roles
training/roles.md:- **Always up-to-date**: The system finds and categorizes plugins as they're added
training/roles.md:- **Core**: Essential system plugins (always available)
training/roles.md:- **Plugin count**: Shows how many plugins this role provides
training/roles.md:- **Expandable plugin list**: Click to see all plugins in this role
training/roles.md:1. **Start with Core**: Essential plugins only
training/roles.md:4. **Custom ordering**: Prioritize most-used plugins
training/roles.md:- **Real-time scanning**: Discovers plugins as they're added
training/roles.md:- **Missing plugins**: Check `ROLES = ['Role Name']` in plugin files
training/roles.md:The Roles system is the **orchestrator** of the entire Pipulate experience - it conducts the symphony of plugins, profiles, and user preferences to create a harmonious, personalized interface.
assets/styles.css:   Consolidated from form input plugins (text_area, text_field, radios)
assets/styles.css:   Styles for the search plugins dropdown with keyboard navigation support.
assets/pipulate.js:   Keyboard navigation for search plugins dropdown following HTMX principles:
assets/pipulate.js:// Global search plugins keyboard navigation functions
assets/pipulate.js:        console.warn('⚠️ Search plugins elements not found, skipping keyboard nav setup');
assets/css/prism.css:https://prismjs.com/download#themes=prism-okaidia&languages=markup+css+clike+javascript+bash+diff+json+json5+jsonp+liquid+lua+markdown+markup-templating+mermaid+nix+python+regex+yaml&plugins=line-highlight+line-numbers+toolbar+copy-to-clipboard+diff-highlight+treeview */
training/widget_examples.md:    * **Widget:** A container using `<pre>` and `<code>` tags, styled by `Prism.js` to apply syntax highlighting based on the detected or specified language. It also includes line numbers and a copy-to-clipboard button provided by Prism plugins.
apps/440_browser_automation.py:            driver.execute_cdp_cmd('Page.addScriptToEvaluateOnNewDocument', {'source': "\n                    Object.defineProperty(navigator, 'webdriver', {\n                        get: () => undefined\n                    });\n                    Object.defineProperty(navigator, 'plugins', {\n                        get: () => [1, 2, 3, 4, 5]\n                    });\n                    Object.defineProperty(navigator, 'languages', {\n                        get: () => ['en-US', 'en']\n                    });\n                "})
apps/440_browser_automation.py:            driver.execute_cdp_cmd('Page.addScriptToEvaluateOnNewDocument', {'source': "\n                    Object.defineProperty(navigator, 'webdriver', {\n                        get: () => undefined\n                    });\n                    Object.defineProperty(navigator, 'plugins', {\n                        get: () => [1, 2, 3, 4, 5]\n                    });\n                    Object.defineProperty(navigator, 'languages', {\n                        get: () => ['en-US', 'en']\n                    });\n                "})
training/tasks.md:   - Discovers new plugins based on filename
apps/130_gap_analysis.py:# File: plugins/130_content_gap_analysis.py
apps/030_roles.py:    affected_plugins = [plugin for plugin in plugin_list if item.text in plugin['roles']]
apps/030_roles.py:    plugin_count = len(affected_plugins)
apps/030_roles.py:    """Get list of all available plugins with their roles."""
apps/030_roles.py:    plugins = []
apps/030_roles.py:            # Skip the special plugins that don't belong in role lists
apps/030_roles.py:                # Most plugins have numeric prefixes, so we need to find the actual filename
apps/030_roles.py:                plugins.append({
apps/030_roles.py:    logger.debug(f"get_plugin_list: Returning {len(plugins)} plugins")
apps/030_roles.py:    core_plugins = [p for p in plugins if 'Core' in p['roles']]
apps/030_roles.py:    logger.debug(f"get_plugin_list: Found {len(core_plugins)} Core plugins: {[p['display_name'] for p in core_plugins]}")
apps/030_roles.py:    return sorted(plugins, key=lambda x: x['filename'])
apps/030_roles.py:    plugins = []
apps/030_roles.py:                plugins.append({
apps/030_roles.py:    return sorted(plugins, key=lambda x: x['filename'])
apps/030_roles.py:    """Create a discrete expandable list showing plugins with real emojis."""
apps/030_roles.py:    affected_plugins = [plugin for plugin in plugin_list if role_name in plugin['roles']]
apps/030_roles.py:    logger.debug(f"create_plugin_visibility_table: Role '{role_name}' has {len(affected_plugins)} plugins")
apps/030_roles.py:    for plugin in affected_plugins:
apps/030_roles.py:    if not affected_plugins:
apps/030_roles.py:            P("No plugins assigned to this role.", style="font-style: italic; color: var(--pico-muted-color); margin: 0.5rem 0;"),
apps/030_roles.py:    for plugin in affected_plugins:
apps/050_documentation.py:        pipulate_root = current_file.parent.parent  # plugins/050_documentation.py -> plugins/ -> pipulate/
apps/240_simon_mcp.py:# File: plugins/830_simon_mcp.py
helpers/prompt_foo/generate_files_list.py:        f"{base_paths['pipulate']}/plugins", 
helpers/release/publish.py:    trifecta_file = "plugins/400_botify_trifecta.py"
helpers/release/publish.py:    print("\n🏗️ Step 4.5: Rebuilding Trifecta derivative plugins...")
helpers/release/publish.py:        'plugins_rebuilt': 0,
helpers/release/publish.py:        if "Successfully processed: 2/2 plugins" in output:
helpers/release/publish.py:            stats['plugins_rebuilt'] = 2
helpers/release/publish.py:        elif "Successfully processed: 1/2 plugins" in output:
helpers/release/publish.py:            stats['plugins_rebuilt'] = 1
helpers/release/publish.py:            print(f"   🔨 Plugins rebuilt: {stats['plugins_rebuilt']}/2")
helpers/release/publish.py:        f"{stats['plugins_rebuilt']}/2",
helpers/release/publish.py:            print(f"🏗️ Trifecta Derivatives Rebuilt: {trifecta_stats.get('plugins_rebuilt', 0)}/2 plugins")
helpers/release/publish.py:            f"{trifecta_stats.get('plugins_rebuilt', 0)}/2 plugins",
apps/230_dev_assistant.py:# File: plugins/320_dev_assistant.py
apps/230_dev_assistant.py:            (f'/{internal_route_prefix}/search_plugins_step01', self.search_plugins_step01, ['POST'])
apps/230_dev_assistant.py:        # Check dropdown functions ONLY if they exist (don't penalize plugins without dropdowns)
apps/230_dev_assistant.py:        # BONUS: Perfect score message for plugins without dropdown dependencies
apps/230_dev_assistant.py:            # Show positive message for plugins without dropdown dependencies
apps/230_dev_assistant.py:            command = f"python helpers/workflow/swap_workflow_step.py TARGET_FILE.py {step_id} plugins/{source_filename} {step_id} --force"
apps/230_dev_assistant.py:    async def search_plugins_step01(self, request):
apps/230_dev_assistant.py:        """Search plugins for step 1 based on user input - Carson Gross style active search."""
apps/230_dev_assistant.py:            plugins_dir = Path("plugins")
apps/230_dev_assistant.py:            if plugins_dir.exists():
apps/230_dev_assistant.py:                plugin_files = [f.name for f in plugins_dir.glob("*.py") if not f.name.startswith("__")]
apps/230_dev_assistant.py:            # Filter plugins based on search term
apps/230_dev_assistant.py:                filtered_plugins = []
apps/230_dev_assistant.py:                        filtered_plugins.append({
apps/230_dev_assistant.py:                # Show ALL plugins on empty search (dropdown menu behavior)
apps/230_dev_assistant.py:                filtered_plugins = []
apps/230_dev_assistant.py:                    filtered_plugins.append({
apps/230_dev_assistant.py:            if filtered_plugins:
apps/230_dev_assistant.py:                auto_select_single = len(filtered_plugins) == 1
apps/230_dev_assistant.py:                for i, plugin in enumerate(sorted(filtered_plugins, key=lambda x: x['filename'])):  # Show all results - no artificial limit
apps/230_dev_assistant.py:            logger.error(f"Error in search_plugins_step01: {e}")
apps/230_dev_assistant.py:        file_path = Path("plugins") / filename
apps/230_dev_assistant.py:        blank_cmd = f"python helpers/workflow/create_workflow.py plugins/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
apps/230_dev_assistant.py:        hello_cmd = f"python helpers/workflow/create_workflow.py plugins/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
apps/230_dev_assistant.py:        trifecta_cmd = f"python helpers/workflow/create_workflow.py plugins/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
apps/230_dev_assistant.py:        plugins_dir = Path("plugins")
apps/230_dev_assistant.py:        if plugins_dir.exists():
apps/230_dev_assistant.py:            plugin_files = [f.name for f in plugins_dir.glob("*.py") if not f.name.startswith("__")]
apps/230_dev_assistant.py:                            placeholder='Search plugins by name...',
apps/230_dev_assistant.py:                            hx_post=f'/{app_name}/search_plugins_step01',
apps/230_dev_assistant.py:        file_path = Path("plugins") / selected_file
apps/200_workflow_genesis.py:# File: plugins/200_workflow_genesis.py
apps/200_workflow_genesis.py:        # Ensure consistent plugins/ prefix for all commands
apps/200_workflow_genesis.py:        plugins_filename = f"plugins/{filename}" if not filename.startswith('plugins/') else filename
apps/200_workflow_genesis.py:        create_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
apps/200_workflow_genesis.py:        splice_bottom_cmd = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:        splice_top_cmd = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position top"
apps/200_workflow_genesis.py:        combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
apps/200_workflow_genesis.py:        # Ensure consistent plugins/ prefix for all commands (matching working example)
apps/200_workflow_genesis.py:        plugins_filename = f"plugins/{filename}" if not filename.startswith('plugins/') else filename
apps/200_workflow_genesis.py:        cmd1 = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:        cmd2 = f"python helpers/workflow/manage_class_attributes.py {plugins_filename} plugins/040_hello_workflow.py --attributes-to-merge UI_CONSTANTS --force"
apps/200_workflow_genesis.py:        cmd3 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 plugins/040_hello_workflow.py step_01 --force"
apps/200_workflow_genesis.py:        cmd4 = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:        cmd5 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 plugins/040_hello_workflow.py step_02 --force"
apps/200_workflow_genesis.py:        combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/manage_class_attributes.py {plugins_filename} \\\n" + \
apps/200_workflow_genesis.py:                      f"  plugins/040_hello_workflow.py \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 \\\n" + \
apps/200_workflow_genesis.py:                      f"  plugins/040_hello_workflow.py step_01 --force && \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom && \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 \\\n" + \
apps/200_workflow_genesis.py:                      f"  plugins/040_hello_workflow.py step_02 --force"
apps/200_workflow_genesis.py:        # Ensure consistent plugins/ prefix for all commands
apps/200_workflow_genesis.py:        plugins_filename = f"plugins/{filename}" if not filename.startswith('plugins/') else filename
apps/200_workflow_genesis.py:        cmd1 = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:        cmd2 = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:        combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:            # Ensure plugins/ prefix for path display
apps/200_workflow_genesis.py:            if not target_filename.startswith('plugins/'):
apps/200_workflow_genesis.py:                display_filename = f"plugins/{target_filename}"
apps/200_workflow_genesis.py:            # Create filesystem button to open plugins directory
apps/200_workflow_genesis.py:            plugins_dir = os.path.join(os.getcwd(), 'plugins')
apps/200_workflow_genesis.py:            open_plugins_folder_ui = A(
apps/200_workflow_genesis.py:                hx_get="/open-folder?path=" + urllib.parse.quote(plugins_dir),
apps/200_workflow_genesis.py:                title=f"Open folder: {plugins_dir}",
apps/200_workflow_genesis.py:                    open_plugins_folder_ui,
apps/200_workflow_genesis.py:        # Ensure plugins/ prefix for path display
apps/200_workflow_genesis.py:        if not target_filename.startswith('plugins/'):
apps/200_workflow_genesis.py:            display_filename = f"plugins/{target_filename}"
apps/200_workflow_genesis.py:        plugins_filename = f"plugins/{target_filename}" if not target_filename.startswith('plugins/') else target_filename
apps/200_workflow_genesis.py:            combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/manage_class_attributes.py {plugins_filename} " + \
apps/200_workflow_genesis.py:                          f"plugins/040_hello_workflow.py " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 " + \
apps/200_workflow_genesis.py:                          f"plugins/040_hello_workflow.py step_01 --force && " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom && " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 " + \
apps/200_workflow_genesis.py:                          f"plugins/040_hello_workflow.py step_02 --force"
apps/200_workflow_genesis.py:            combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:            combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:        # Create filesystem button to open plugins directory
apps/200_workflow_genesis.py:        plugins_dir = os.path.join(os.getcwd(), 'plugins')
apps/200_workflow_genesis.py:        open_plugins_folder_ui = A(
apps/200_workflow_genesis.py:            hx_get="/open-folder?path=" + urllib.parse.quote(plugins_dir),
apps/200_workflow_genesis.py:            title=f"Open folder: {plugins_dir}",
apps/200_workflow_genesis.py:        execution_summary += f"📂 Location: {plugins_dir}\n"
apps/200_workflow_genesis.py:                    P(f"Created in: {plugins_dir}", cls="text-description"),
apps/200_workflow_genesis.py:                    open_plugins_folder_ui,
apps/200_workflow_genesis.py:                    P(f"Check: {plugins_dir}", cls="text-description"),
apps/200_workflow_genesis.py:                    open_plugins_folder_ui,
apps/300_blank_placeholder.py:# File: plugins/300_blank_placeholder.py
imports/botify/code_generators.py:# Convenience instance for backward compatibility with existing plugins
apps/001_dom_visualizer.py:# File: plugins/001_dom_visualizer.py
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:python helpers/workflow/splice_workflow_step.py plugins/035_my_workflow.py  # path optional
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:    plugins/035_my_workflow.py step_01 \
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:    plugins/500_source_workflow.py step_01
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:    plugins/035_target_workflow.py \
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:    plugins/500_source_workflow.py \
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:rm plugins/045_evolved_flowtest.py
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:mkdir -p plugins/components/
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:mv plugins/200_parameter_engine.py plugins/components/  # Archive proven components
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:plugins/
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:mkdir -p plugins/components/
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:mv plugins/800_parameter_component.py plugins/components/
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:cp plugins/400_botify_trifecta.py plugins/410_enhanced_trifecta.py
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:rm plugins/999_*
helpers/workflow/workflow_reconstructor.py:        self.plugins_dir = self.base_dir / "plugins"
helpers/workflow/workflow_reconstructor.py:            template_path = self.plugins_dir / f"{template_name}.py"
helpers/workflow/workflow_reconstructor.py:            source_path = self.plugins_dir / f"{source_name}.py" 
helpers/workflow/workflow_reconstructor.py:            target_path = self.plugins_dir / f"{target_name}.py"
helpers/workflow/workflow_reconstructor.py:        existing_path = self.plugins_dir / f"{existing_name}.py"
helpers/workflow/workflow_reconstructor.py:            source_tree = reconstructor.parse_file(reconstructor.plugins_dir / f"{args.source}.py")
helpers/workflow/swap_workflow_step.py:    python swap_workflow_step.py plugins/035_kungfu_workflow.py step_01 plugins/500_hello_workflow.py step_01
imports/crud.py:Common classes and utilities for plugins.
imports/crud.py:This module contains shared classes that plugins can import without creating
imports/crud.py:# 🎯 STANDARDIZED STEP DEFINITION - Used by all workflow plugins
imports/crud.py:# Eliminates 34+ identical namedtuple definitions across plugins
imports/crud.py:# Simple import pattern - plugins can copy these lines instead of massive import blocks
imports/crud.py:# 🌐 API WORKFLOW IMPORTS - For plugins that call external APIs
imports/crud.py:# 🎨 WIDGET IMPORTS - For UI component demonstration plugins
imports/crud.py:# Instead of copying massive import blocks from complex plugins,
imports/crud.py:# ✅ Widget plugins: Use the 5-line widget import pattern
imports/crud.py:# ✅ API plugins: Use the 8-line API workflow pattern  
imports/crud.py:# ✅ Basic plugins: Use the 4-line basic workflow pattern
imports/crud.py:        Extracted from: plugins/110_parameter_buster.py, 120_link_graph.py, 400_botify_trifecta.py
imports/crud.py:        Extracted from: plugins/110_parameter_buster.py (and similar patterns)
imports/crud.py:        Extracted from: plugins/440_browser_automation.py  
imports/crud.py:        Extracted from: Multiple workflow plugins with repetitive form handling
helpers/workflow/create_workflow.py:        if (current_dir / "plugins").is_dir() and (current_dir / "server.py").is_file():
helpers/workflow/create_workflow.py:        if root.exists() and (root / "plugins").is_dir() and (root / "server.py").is_file():
helpers/workflow/create_workflow.py:    "blank": PROJECT_ROOT / "plugins" / "300_blank_placeholder.py",
helpers/workflow/create_workflow.py:    "hello": PROJECT_ROOT / "plugins" / "500_hello_workflow.py",
helpers/workflow/create_workflow.py:    "trifecta": PROJECT_ROOT / "plugins" / "400_botify_trifecta.py",
helpers/workflow/create_workflow.py:    # "my_custom_template": PROJECT_ROOT / "plugins" / "0XX_my_custom_template.py",
helpers/workflow/create_workflow.py:PLUGINS_DIR = PROJECT_ROOT / "plugins"
helpers/workflow/create_workflow.py:python create_workflow.py plugins/035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"  # plugins/ prefix optional
helpers/workflow/create_workflow.py:  python create_workflow.py plugins/035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"
helpers/workflow/create_workflow.py:    # 2. With plugins/ prefix: "plugins/035_kungfu_workflow.py"  
helpers/workflow/create_workflow.py:    # 3. Full path: "/some/path/plugins/035_kungfu_workflow.py"
helpers/workflow/create_workflow.py:    if target_filename.startswith('plugins/'):
helpers/workflow/create_workflow.py:        target_filename = target_filename[8:]  # Remove 'plugins/' prefix
helpers/workflow/create_workflow.py:            header_pattern = r'^# File: plugins/[^.]+\.py'
helpers/workflow/create_workflow.py:            new_header = f'# File: plugins/{target_filename}'
imports/botify_code_generation.py:eliminating ~400+ lines of duplicated code across plugins.
imports/botify_code_generation.py:    Centralizes the header generation logic to reduce duplication across plugins.
imports/botify_code_generation.py:    This eliminates ~100+ lines of duplicated f-string blocks across Botify plugins.
imports/botify_code_generation.py:            # Try different template config keys that plugins use
imports/botify_code_generation.py:    This eliminates ~150+ lines of duplicated f-string blocks across Botify plugins.
imports/botify_code_generation.py:    This eliminates path construction duplication across Botify plugins.
helpers/workflow/manage_class_attributes.py:    python manage_class_attributes.py plugins/035_kungfu_workflow.py plugins/500_hello_workflow.py --attributes-to-merge UI_CONSTANTS
helpers/workflow/splice_workflow_step.py:python splice_workflow_step.py plugins/035_kungfu_workflow.py  # plugins/ prefix optional
helpers/workflow/splice_workflow_step.py:        if (current_dir / "plugins").is_dir() and (current_dir / "server.py").is_file():
helpers/workflow/splice_workflow_step.py:        if root.exists() and (root / "plugins").is_dir() and (root / "server.py").is_file():
helpers/workflow/splice_workflow_step.py:TEMPLATE_FILE_PATH = PROJECT_ROOT / "plugins" / "300_blank_placeholder.py"
helpers/workflow/splice_workflow_step.py:PLUGINS_DIR = PROJECT_ROOT / "plugins"
helpers/workflow/splice_workflow_step.py:  python splice_workflow_step.py plugins/035_kungfu_workflow.py --position top
helpers/workflow/splice_workflow_step.py:  python splice_workflow_step.py /full/path/to/plugins/035_kungfu_workflow.py --position bottom
helpers/workflow/splice_workflow_step.py:    # 2. With plugins/ prefix: "plugins/035_kungfu_workflow.py"  
helpers/workflow/splice_workflow_step.py:    # 3. Full path: "/some/path/plugins/035_kungfu_workflow.py"
helpers/workflow/splice_workflow_step.py:    if target_filename.startswith('plugins/'):
helpers/workflow/splice_workflow_step.py:        target_filename = target_filename[8:]  # Remove 'plugins/' prefix
imports/ascii_displays.py:    plugins_discovered: int, 
imports/ascii_displays.py:    plugins_registered: int, 
imports/ascii_displays.py:    status_table.add_row("📦 Plugins", "✅ Loaded", f"{plugins_registered}/{plugins_discovered} registered")
imports/ascii_displays.py:✅ Plugins: {plugins_registered}/{plugins_discovered} registered
```

And here's my careful target list:

```bash
[mike@nixos:~/repos/pipulate]$ \rg plugins/ > /tmp/deleteme.txt

[mike@nixos:~/repos/pipulate]$ xc /tmp/deleteme.txt

[mike@nixos:~/repos/pipulate]$ 
```

Output:

```
server.py:# BaseCrud class moved to plugins/crud.py to avoid circular imports
tools/mcp_tools.py:        plugin_name = plugin_filename.replace('plugins/', '').replace('.py', '')
tools/mcp_tools.py:            plugin_name = plugin_filename.replace('plugins/', '').replace('.py', '')
tools/mcp_tools.py:        plugins_exists = os.path.exists("plugins/")
README.md:- Check out `plugins/010_introduction.py` to see workflow code structure
README.md:    ├── plugins/                   # Workflow plugins (010_introduction.py, 400_trifecta.py, etc.)
README.md:plugins/
README.md:* Files in `plugins/` directory are auto-discovered
README.md:plugins/                    # Your workflows (auto-discovered)
assets/pipulate-init.js:- plugins/ (41 plugin files)
apps/130_gap_analysis.py:# File: plugins/130_content_gap_analysis.py
apps/230_dev_assistant.py:# File: plugins/320_dev_assistant.py
apps/230_dev_assistant.py:            command = f"python helpers/workflow/swap_workflow_step.py TARGET_FILE.py {step_id} plugins/{source_filename} {step_id} --force"
apps/230_dev_assistant.py:        blank_cmd = f"python helpers/workflow/create_workflow.py plugins/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
apps/230_dev_assistant.py:        hello_cmd = f"python helpers/workflow/create_workflow.py plugins/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
apps/230_dev_assistant.py:        trifecta_cmd = f"python helpers/workflow/create_workflow.py plugins/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
apps/240_simon_mcp.py:# File: plugins/830_simon_mcp.py
apps/300_blank_placeholder.py:# File: plugins/300_blank_placeholder.py
apps/050_documentation.py:        pipulate_root = current_file.parent.parent  # plugins/050_documentation.py -> plugins/ -> pipulate/
apps/001_dom_visualizer.py:# File: plugins/001_dom_visualizer.py
apps/200_workflow_genesis.py:# File: plugins/200_workflow_genesis.py
apps/200_workflow_genesis.py:        # Ensure consistent plugins/ prefix for all commands
apps/200_workflow_genesis.py:        plugins_filename = f"plugins/{filename}" if not filename.startswith('plugins/') else filename
apps/200_workflow_genesis.py:        # Ensure consistent plugins/ prefix for all commands (matching working example)
apps/200_workflow_genesis.py:        plugins_filename = f"plugins/{filename}" if not filename.startswith('plugins/') else filename
apps/200_workflow_genesis.py:        cmd2 = f"python helpers/workflow/manage_class_attributes.py {plugins_filename} plugins/040_hello_workflow.py --attributes-to-merge UI_CONSTANTS --force"
apps/200_workflow_genesis.py:        cmd3 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 plugins/040_hello_workflow.py step_01 --force"
apps/200_workflow_genesis.py:        cmd5 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 plugins/040_hello_workflow.py step_02 --force"
apps/200_workflow_genesis.py:                      f"  plugins/040_hello_workflow.py \\\n" + \
apps/200_workflow_genesis.py:                      f"  plugins/040_hello_workflow.py step_01 --force && \\\n" + \
apps/200_workflow_genesis.py:                      f"  plugins/040_hello_workflow.py step_02 --force"
apps/200_workflow_genesis.py:        # Ensure consistent plugins/ prefix for all commands
apps/200_workflow_genesis.py:        plugins_filename = f"plugins/{filename}" if not filename.startswith('plugins/') else filename
apps/200_workflow_genesis.py:            # Ensure plugins/ prefix for path display
apps/200_workflow_genesis.py:            if not target_filename.startswith('plugins/'):
apps/200_workflow_genesis.py:                display_filename = f"plugins/{target_filename}"
apps/200_workflow_genesis.py:        # Ensure plugins/ prefix for path display
apps/200_workflow_genesis.py:        if not target_filename.startswith('plugins/'):
apps/200_workflow_genesis.py:            display_filename = f"plugins/{target_filename}"
apps/200_workflow_genesis.py:        plugins_filename = f"plugins/{target_filename}" if not target_filename.startswith('plugins/') else target_filename
apps/200_workflow_genesis.py:                          f"plugins/040_hello_workflow.py " + \
apps/200_workflow_genesis.py:                          f"plugins/040_hello_workflow.py step_01 --force && " + \
apps/200_workflow_genesis.py:                          f"plugins/040_hello_workflow.py step_02 --force"
imports/crud.py:        Extracted from: plugins/110_parameter_buster.py, 120_link_graph.py, 400_botify_trifecta.py
imports/crud.py:        Extracted from: plugins/110_parameter_buster.py (and similar patterns)
imports/crud.py:        Extracted from: plugins/440_browser_automation.py  
helpers/workflow/splice_workflow_step.py:python splice_workflow_step.py plugins/035_kungfu_workflow.py  # plugins/ prefix optional
helpers/workflow/splice_workflow_step.py:  python splice_workflow_step.py plugins/035_kungfu_workflow.py --position top
helpers/workflow/splice_workflow_step.py:  python splice_workflow_step.py /full/path/to/plugins/035_kungfu_workflow.py --position bottom
helpers/workflow/splice_workflow_step.py:    # 2. With plugins/ prefix: "plugins/035_kungfu_workflow.py"  
helpers/workflow/splice_workflow_step.py:    # 3. Full path: "/some/path/plugins/035_kungfu_workflow.py"
helpers/workflow/splice_workflow_step.py:    if target_filename.startswith('plugins/'):
helpers/workflow/splice_workflow_step.py:        target_filename = target_filename[8:]  # Remove 'plugins/' prefix
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:python helpers/workflow/splice_workflow_step.py plugins/035_my_workflow.py  # path optional
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:    plugins/035_my_workflow.py step_01 \
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:    plugins/500_source_workflow.py step_01
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:    plugins/035_target_workflow.py \
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:    plugins/500_source_workflow.py \
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:rm plugins/045_evolved_flowtest.py
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:mkdir -p plugins/components/
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:mv plugins/200_parameter_engine.py plugins/components/  # Archive proven components
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:plugins/
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:mkdir -p plugins/components/
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:mv plugins/800_parameter_component.py plugins/components/
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:cp plugins/400_botify_trifecta.py plugins/410_enhanced_trifecta.py
helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md:rm plugins/999_*
helpers/workflow/manage_class_attributes.py:    python manage_class_attributes.py plugins/035_kungfu_workflow.py plugins/500_hello_workflow.py --attributes-to-merge UI_CONSTANTS
helpers/workflow/create_workflow.py:python create_workflow.py plugins/035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"  # plugins/ prefix optional
helpers/workflow/create_workflow.py:  python create_workflow.py plugins/035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"
helpers/workflow/create_workflow.py:    # 2. With plugins/ prefix: "plugins/035_kungfu_workflow.py"  
helpers/workflow/create_workflow.py:    # 3. Full path: "/some/path/plugins/035_kungfu_workflow.py"
helpers/workflow/create_workflow.py:    if target_filename.startswith('plugins/'):
helpers/workflow/create_workflow.py:        target_filename = target_filename[8:]  # Remove 'plugins/' prefix
helpers/workflow/create_workflow.py:            header_pattern = r'^# File: plugins/[^.]+\.py'
helpers/workflow/create_workflow.py:            new_header = f'# File: plugins/{target_filename}'
helpers/workflow/swap_workflow_step.py:    python swap_workflow_step.py plugins/035_kungfu_workflow.py step_01 plugins/500_hello_workflow.py step_01
helpers/release/publish.py:    trifecta_file = "plugins/400_botify_trifecta.py"
```

And my first round of surgical search and replace:

```bash
[mike@nixos:~/repos/pipulate]$ \rg plugins/ --null -l | xargs -0 sed 's/plugins\//apps\//g' -i

[mike@nixos:~/repos/pipulate]$ git status
On branch tools
Your branch is up to date with 'origin/tools'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	renamed:    plugins/001_dom_visualizer.py -> apps/001_dom_visualizer.py
	renamed:    plugins/010_introduction.py -> apps/010_introduction.py
	renamed:    plugins/020_profiles.py -> apps/020_profiles.py
	renamed:    plugins/030_roles.py -> apps/030_roles.py
	renamed:    plugins/040_hello_workflow.py -> apps/040_hello_workflow.py
	renamed:    plugins/050_documentation.py -> apps/050_documentation.py
	renamed:    plugins/060_tasks.py -> apps/060_tasks.py
	renamed:    plugins/070_history.py -> apps/070_history.py
	renamed:    plugins/100_connect_with_botify.py -> apps/100_connect_with_botify.py
	renamed:    plugins/110_parameter_buster.py -> apps/110_parameter_buster.py
	renamed:    plugins/120_link_graph.py -> apps/120_link_graph.py
	renamed:    plugins/130_gap_analysis.py -> apps/130_gap_analysis.py
	renamed:    plugins/200_workflow_genesis.py -> apps/200_workflow_genesis.py
	renamed:    plugins/210_widget_examples.py -> apps/210_widget_examples.py
	renamed:    plugins/220_roadmap.py -> apps/220_roadmap.py
	renamed:    plugins/230_dev_assistant.py -> apps/230_dev_assistant.py
	renamed:    plugins/240_simon_mcp.py -> apps/240_simon_mcp.py
	renamed:    plugins/300_blank_placeholder.py -> apps/300_blank_placeholder.py
	renamed:    plugins/400_botify_trifecta.py -> apps/400_botify_trifecta.py
	renamed:    plugins/430_tab_opener.py -> apps/430_tab_opener.py
	renamed:    plugins/440_browser_automation.py -> apps/440_browser_automation.py
	renamed:    plugins/450_stream_simulator.py -> apps/450_stream_simulator.py
	renamed:    plugins/510_text_field.py -> apps/510_text_field.py
	renamed:    plugins/520_text_area.py -> apps/520_text_area.py
	renamed:    plugins/530_dropdown.py -> apps/530_dropdown.py
	renamed:    plugins/540_checkboxes.py -> apps/540_checkboxes.py
	renamed:    plugins/550_radios.py -> apps/550_radios.py
	renamed:    plugins/560_range.py -> apps/560_range.py
	renamed:    plugins/570_switch.py -> apps/570_switch.py
	renamed:    plugins/580_upload.py -> apps/580_upload.py
	renamed:    plugins/610_markdown.py -> apps/610_markdown.py
	renamed:    plugins/620_mermaid.py -> apps/620_mermaid.py
	renamed:    plugins/630_prism.py -> apps/630_prism.py
	renamed:    plugins/640_javascript.py -> apps/640_javascript.py
	renamed:    plugins/710_pandas.py -> apps/710_pandas.py
	renamed:    plugins/720_rich.py -> apps/720_rich.py
	renamed:    plugins/730_matplotlib.py -> apps/730_matplotlib.py
	renamed:    plugins/810_webbrowser.py -> apps/810_webbrowser.py
	renamed:    plugins/820_selenium.py -> apps/820_selenium.py

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   README.md
	modified:   apps/001_dom_visualizer.py
	modified:   apps/050_documentation.py
	modified:   apps/130_gap_analysis.py
	modified:   apps/200_workflow_genesis.py
	modified:   apps/230_dev_assistant.py
	modified:   apps/240_simon_mcp.py
	modified:   apps/300_blank_placeholder.py
	modified:   assets/pipulate-init.js
	modified:   helpers/release/publish.py
	modified:   helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md
	modified:   helpers/workflow/create_workflow.py
	modified:   helpers/workflow/manage_class_attributes.py
	modified:   helpers/workflow/splice_workflow_step.py
	modified:   helpers/workflow/swap_workflow_step.py
	modified:   imports/crud.py
	modified:   server.py
	modified:   tools/mcp_tools.py


[mike@nixos:~/repos/pipulate]$
```

Welcome to *backslash hell*. This is just one of the ugly facts of the modern
tech stacks. Regular expressions (regex) are everywhere. Vim syntax for managing
regex is everywhere, which happens to separate the "search" part of the
expression from the "replace" part of the expression so if you have a
forward-slash in the string you're trying to replace, you have to *backslash*
(aka neutralize or escape) the *forwardslash!*

To make sure we did the right thing we start with a `git status` to see if it
modified the files I think it should have modified. Here's the `git diff`:

```bash
[mike@nixos:~/repos/pipulate]$ git diff > /tmp/deleteme.txt

[mike@nixos:~/repos/pipulate]$ xc /tmp/deleteme.txt

[mike@nixos:~/repos/pipulate]$
```

Output:

    diff --git a/README.md b/README.md
    index 9c67c88..c873627 100644
    --- a/README.md
    +++ b/README.md
    @@ -684,7 +684,7 @@ Just as a chef talks about knife techniques while a diner just wants amazing pas
     
     **👨‍💻 If you're a developer:**
     - Open JupyterLab tab and run the introduction notebook
    -- Check out `plugins/010_introduction.py` to see workflow code structure
    +- Check out `apps/010_introduction.py` to see workflow code structure
     - Try creating a simple workflow: `python helpers/workflow/create_workflow.py`
     
     **🤖 If you're an AI assistant:**
    @@ -1077,7 +1077,7 @@ This structure enables AI assistants to programmatically interact with all UI co
         │   ├── server-1.log           # N-rotations of server log per run per config
         │   └── server.log             # The server log of most recent run, contains app state
         ├── /assets/                    # JS, CSS, images, icons
    -    ├── plugins/                   # Workflow plugins (010_introduction.py, 400_trifecta.py, etc.)
    +    ├── apps/                   # Workflow plugins (010_introduction.py, 400_trifecta.py, etc.)
         ├── pyproject.toml             # Python packaging configuration and metadata
         ├── training/                  # Markdown files for AI context/prompts
         ├── vulture_whitelist.py       # Code analysis whitelist for unused code detection
    @@ -1200,7 +1200,7 @@ The `run_all_cells()` method encapsulates the workflow initialization pattern an
     <!-- START_ASCII_ART: plugin-discovery-system -->
     ```
     📁 PLUGIN DISCOVERY SYSTEM
    -plugins/
    +apps/
     ├── 010_introduction.py       ✅ Registered as "introduction" (menu order: 1)
     ├── 020_profiles.py           ✅ Registered as "profiles" (menu order: 2)
     ├── hello_flow (Copy).py      ❌ SKIPPED - Contains "()"
    @@ -1216,7 +1216,7 @@ plugins/
     ```
     <!-- END_ASCII_ART: plugin-discovery-system -->
     
    -* Files in `plugins/` directory are auto-discovered
    +* Files in `apps/` directory are auto-discovered
     * Numeric prefixes control menu ordering
     * Classes must have `landing` method and name attributes
     * Automatic dependency injection based on `__init__` signature
    @@ -1377,7 +1377,7 @@ pip.set_step_data(step_id, updated_data)
     
     ### File Structure Quick Reference
     ```
    -plugins/                    # Your workflows (auto-discovered)
    +apps/                    # Your workflows (auto-discovered)
     ├── 010_introduction.py     # Menu order 1
     ├── xx_draft.py            # Disabled (xx_ prefix)
     └── draft (Copy).py        # Ignored (parentheses)
    diff --git a/apps/001_dom_visualizer.py b/apps/001_dom_visualizer.py
    index b077930..179f941 100644
    --- a/apps/001_dom_visualizer.py
    +++ b/apps/001_dom_visualizer.py
    @@ -1,4 +1,4 @@
    -# File: plugins/001_dom_visualizer.py
    +# File: apps/001_dom_visualizer.py
     import asyncio
     from datetime import datetime
     from fasthtml.common import * # type: ignore
    diff --git a/apps/050_documentation.py b/apps/050_documentation.py
    index be0fa1a..3bac7f3 100644
    --- a/apps/050_documentation.py
    +++ b/apps/050_documentation.py
    @@ -121,7 +121,7 @@ This system provides unprecedented debugging power:
             # Get the project root directory dynamically
             # Start from the current file's directory and go up to find the project root
             current_file = Path(__file__).resolve()
    -        pipulate_root = current_file.parent.parent  # plugins/050_documentation.py -> plugins/ -> pipulate/
    +        pipulate_root = current_file.parent.parent  # apps/050_documentation.py -> apps/ -> pipulate/
             
             # Verify we found the right directory by checking for key files
             if not (pipulate_root / 'server.py').exists():
    diff --git a/apps/130_gap_analysis.py b/apps/130_gap_analysis.py
    index b0a5d50..4948032 100644
    --- a/apps/130_gap_analysis.py
    +++ b/apps/130_gap_analysis.py
    @@ -1,4 +1,4 @@
    -# File: plugins/130_content_gap_analysis.py
    +# File: apps/130_content_gap_analysis.py
     import asyncio
     from datetime import datetime
     from fasthtml.common import * # type: ignore
    diff --git a/apps/200_workflow_genesis.py b/apps/200_workflow_genesis.py
    index 978f7dc..886043b 100644
    --- a/apps/200_workflow_genesis.py
    +++ b/apps/200_workflow_genesis.py
    @@ -1,4 +1,4 @@
    -# File: plugins/200_workflow_genesis.py
    +# File: apps/200_workflow_genesis.py
     import asyncio
     from datetime import datetime
     from fasthtml.common import * # type: ignore
    @@ -259,8 +259,8 @@ class WorkflowGenesis:
             endpoint_message = workflow_params.get('endpoint_message', 'Welcome to workflow creation')
             training_prompt = workflow_params.get('training_prompt', 'Help users create workflows step by step')
     
    -        # Ensure consistent plugins/ prefix for all commands
    -        plugins_filename = f"plugins/{filename}" if not filename.startswith('plugins/') else filename
    +        # Ensure consistent apps/ prefix for all commands
    +        plugins_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
     
             # Single create command - uses blank template specifically
             create_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
    @@ -333,8 +333,8 @@ class WorkflowGenesis:
             hello_endpoint_message = "🥋 This workflow will become a Hello World equivalent using helper scripts."
             hello_training_prompt = "You are assisting with the Kung Fu Hello World workflow recreation. This demonstrates the complete helper tool sequence for building workflows from scratch. The secret word is 'MORPHEUS'."
     
    -        # Ensure consistent plugins/ prefix for all commands (matching working example)
    -        plugins_filename = f"plugins/{filename}" if not filename.startswith('plugins/') else filename
    +        # Ensure consistent apps/ prefix for all commands (matching working example)
    +        plugins_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
     
             # The corrected 5-command sequence - starts with blank template, becomes Hello World
             cmd1 = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
    @@ -342,13 +342,13 @@ class WorkflowGenesis:
                    f"{self.format_bash_command(hello_endpoint_message)} " + \
                    f"{self.format_bash_command(hello_training_prompt)} --template blank --role Core --force"
     
    -        cmd2 = f"python helpers/workflow/manage_class_attributes.py {plugins_filename} plugins/040_hello_workflow.py --attributes-to-merge UI_CONSTANTS --force"
    +        cmd2 = f"python helpers/workflow/manage_class_attributes.py {plugins_filename} apps/040_hello_workflow.py --attributes-to-merge UI_CONSTANTS --force"
     
    -        cmd3 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 plugins/040_hello_workflow.py step_01 --force"
    +        cmd3 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 apps/040_hello_workflow.py step_01 --force"
     
             cmd4 = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
     
    -        cmd5 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 plugins/040_hello_workflow.py step_02 --force"
    +        cmd5 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 apps/040_hello_workflow.py step_02 --force"
     
             # Combined command with proper && chaining for complete automation
             combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
    @@ -357,13 +357,13 @@ class WorkflowGenesis:
                           f"  {self.format_bash_command(hello_training_prompt)} \\\n" + \
                           f"  --template blank --role Core --force && \\\n" + \
                           f"python helpers/workflow/manage_class_attributes.py {plugins_filename} \\\n" + \
    -                      f"  plugins/040_hello_workflow.py \\\n" + \
    +                      f"  apps/040_hello_workflow.py \\\n" + \
                           f"  --attributes-to-merge UI_CONSTANTS --force && \\\n" + \
                           f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 \\\n" + \
    -                      f"  plugins/040_hello_workflow.py step_01 --force && \\\n" + \
    +                      f"  apps/040_hello_workflow.py step_01 --force && \\\n" + \
                           f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom && \\\n" + \
                           f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 \\\n" + \
    -                      f"  plugins/040_hello_workflow.py step_02 --force"
    +                      f"  apps/040_hello_workflow.py step_02 --force"
     
             return Div(
                 H4("Hello World Recreation Experience", cls="section-title"),
    @@ -438,8 +438,8 @@ class WorkflowGenesis:
             endpoint_message = workflow_params.get('endpoint_message', 'Advanced data collection workflow')
             training_prompt = workflow_params.get('training_prompt', 'Help users create complex data workflows')
     
    -        # Ensure consistent plugins/ prefix for all commands
    -        plugins_filename = f"plugins/{filename}" if not filename.startswith('plugins/') else filename
    +        # Ensure consistent apps/ prefix for all commands
    +        plugins_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
     
             # Trifecta workflow commands - uses trifecta template
             cmd1 = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
    @@ -809,9 +809,9 @@ class WorkflowGenesis:
                 target_filename = workflow_params.get('target_filename', '001_kungfu_workflow.py')
                 display_name = workflow_params.get('display_name', 'Kung Fu Download')
     
    -            # Ensure plugins/ prefix for path display
    -            if not target_filename.startswith('plugins/'):
    -                display_filename = f"plugins/{target_filename}"
    +            # Ensure apps/ prefix for path display
    +            if not target_filename.startswith('apps/'):
    +                display_filename = f"apps/{target_filename}"
                 else:
                     display_filename = target_filename
     
    @@ -880,14 +880,14 @@ class WorkflowGenesis:
             display_name = workflow_params.get('display_name', 'Kung Fu Download')
             selected_template = template_choice.get('template', 'blank')
     
    -        # Ensure plugins/ prefix for path display
    -        if not target_filename.startswith('plugins/'):
    -            display_filename = f"plugins/{target_filename}"
    +        # Ensure apps/ prefix for path display
    +        if not target_filename.startswith('apps/'):
    +            display_filename = f"apps/{target_filename}"
             else:
                 display_filename = target_filename
     
             # Get the combined command based on template choice
    -        plugins_filename = f"plugins/{target_filename}" if not target_filename.startswith('plugins/') else target_filename
    +        plugins_filename = f"apps/{target_filename}" if not target_filename.startswith('apps/') else target_filename
             class_name = workflow_params.get('class_name', 'KungfuWorkflow')
             internal_name = workflow_params.get('internal_app_name', 'kungfu')
             endpoint_message = workflow_params.get('endpoint_message', 'Welcome message')
    @@ -905,13 +905,13 @@ class WorkflowGenesis:
                               f"{self.format_bash_command(hello_endpoint_message)} " + \
                               f"{self.format_bash_command(hello_training_prompt)} --template blank --role Core --force && " + \
                               f"python helpers/workflow/manage_class_attributes.py {plugins_filename} " + \
    -                          f"plugins/040_hello_workflow.py " + \
    +                          f"apps/040_hello_workflow.py " + \
                               f"--attributes-to-merge UI_CONSTANTS --force && " + \
                               f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 " + \
    -                          f"plugins/040_hello_workflow.py step_01 --force && " + \
    +                          f"apps/040_hello_workflow.py step_01 --force && " + \
                               f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom && " + \
                               f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 " + \
    -                          f"plugins/040_hello_workflow.py step_02 --force"
    +                          f"apps/040_hello_workflow.py step_02 --force"
             elif selected_template == 'trifecta':
                 # Trifecta workflow commands - use template-specific display name
                 trifecta_display_name = "Kung Fu Trifecta 🏇"
    diff --git a/apps/230_dev_assistant.py b/apps/230_dev_assistant.py
    index fa33285..530e21b 100644
    --- a/apps/230_dev_assistant.py
    +++ b/apps/230_dev_assistant.py
    @@ -1,4 +1,4 @@
    -# File: plugins/320_dev_assistant.py
    +# File: apps/320_dev_assistant.py
     import asyncio
     from datetime import datetime
     from fasthtml.common import * # type: ignore
    @@ -1259,7 +1259,7 @@ class DevAssistant:
                 step_info = step_dependencies.get(step_id, {})
     
                 # Generate command for swapping this step to a target workflow
    -            command = f"python helpers/workflow/swap_workflow_step.py TARGET_FILE.py {step_id} plugins/{source_filename} {step_id} --force"
    +            command = f"python helpers/workflow/swap_workflow_step.py TARGET_FILE.py {step_id} apps/{source_filename} {step_id} --force"
     
                 compatibility_notes = []
                 if not step_info.get('has_swappable_markers', False):
    @@ -1632,21 +1632,21 @@ class DevAssistant:
             commands = []
             
             # Default: Blank template (generic use)
    -        blank_cmd = f"python helpers/workflow/create_workflow.py plugins/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
    +        blank_cmd = f"python helpers/workflow/create_workflow.py apps/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
                        f"  {format_bash_command(version_data['display_name'])} \\\n" + \
                        f"  {format_bash_command(version_data['endpoint_message'])} \\\n" + \
                        f"  {format_bash_command(version_data['training_prompt'])} \\\n" + \
                        f"  --template blank --role Core --force"
             
             # Hello template option
    -        hello_cmd = f"python helpers/workflow/create_workflow.py plugins/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
    +        hello_cmd = f"python helpers/workflow/create_workflow.py apps/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
                        f"  {format_bash_command(version_data['display_name'])} \\\n" + \
                        f"  {format_bash_command(version_data['endpoint_message'])} \\\n" + \
                        f"  {format_bash_command(version_data['training_prompt'])} \\\n" + \
                        f"  --template hello --role Core --force"
             
             # Trifecta template option
    -        trifecta_cmd = f"python helpers/workflow/create_workflow.py plugins/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
    +        trifecta_cmd = f"python helpers/workflow/create_workflow.py apps/{next_filename} {version_data['class_name']} {version_data['app_name']} \\\n" + \
                            f"  {format_bash_command(version_data['display_name'])} \\\n" + \
                            f"  {format_bash_command(version_data['endpoint_message'])} \\\n" + \
                            f"  {format_bash_command(version_data['training_prompt'])} \\\n" + \
    diff --git a/apps/240_simon_mcp.py b/apps/240_simon_mcp.py
    index 8af3ccd..0d4f8cf 100644
    --- a/apps/240_simon_mcp.py
    +++ b/apps/240_simon_mcp.py
    @@ -1,4 +1,4 @@
    -# File: plugins/830_simon_mcp.py
    +# File: apps/830_simon_mcp.py
     import asyncio
     from datetime import datetime
     import json
    diff --git a/apps/300_blank_placeholder.py b/apps/300_blank_placeholder.py
    index 89489da..4c716fe 100644
    --- a/apps/300_blank_placeholder.py
    +++ b/apps/300_blank_placeholder.py
    @@ -1,4 +1,4 @@
    -# File: plugins/300_blank_placeholder.py
    +# File: apps/300_blank_placeholder.py
     import asyncio
     from datetime import datetime
     from fasthtml.common import * # type: ignore
    diff --git a/assets/pipulate-init.js b/assets/pipulate-init.js
    index 12617da..e5c0de7 100644
    --- a/assets/pipulate-init.js
    +++ b/assets/pipulate-init.js
    @@ -1908,7 +1908,7 @@ async function executeCleanMcpToolCallStep(step) {
     - server.py (Main application)
     - mcp_tools.py (MCP tool definitions)
     - cli.py (Command line interface)
    -- plugins/ (41 plugin files)
    +- apps/ (41 plugin files)
     - /assets/ (Web assets)
     - browser_automation/ (Automation scripts)
     
    diff --git a/helpers/release/publish.py b/helpers/release/publish.py
    index 5871f61..30225b7 100755
    --- a/helpers/release/publish.py
    +++ b/helpers/release/publish.py
    @@ -436,7 +436,7 @@ alwaysApply: true
     
     def detect_trifecta_changes():
         """Check if the Botify Trifecta template has been modified in git."""
    -    trifecta_file = "plugins/400_botify_trifecta.py"
    +    trifecta_file = "apps/400_botify_trifecta.py"
         
         try:
             # Check if file is in staged changes
    diff --git a/helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md b/helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md
    index c111cd3..fef6387 100644
    --- a/helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md
    +++ b/helpers/workflow/WORKFLOW_DEVELOPMENT_GUIDE.md
    @@ -93,7 +93,7 @@ python helpers/workflow/splice_workflow_step.py 035_my_workflow.py --position to
     
     # Works with flexible filename handling
     python helpers/workflow/splice_workflow_step.py 035_my_workflow    # .py optional
    -python helpers/workflow/splice_workflow_step.py plugins/035_my_workflow.py  # path optional
    +python helpers/workflow/splice_workflow_step.py apps/035_my_workflow.py  # path optional
     ```
     
     **What It Does:**
    @@ -127,8 +127,8 @@ async def step_XX_submit(self, request):
     ```bash
     # Replace step_01 in target with step_01 from source
     python helpers/workflow/swap_workflow_step.py \
    -    plugins/035_my_workflow.py step_01 \
    -    plugins/500_source_workflow.py step_01
    +    apps/035_my_workflow.py step_01 \
    +    apps/500_source_workflow.py step_01
     
     # Force replacement without confirmation
     python helpers/workflow/swap_workflow_step.py \
    @@ -231,8 +231,8 @@ ENDPOINT_MESSAGE = 'Workflow-specific welcome message'    # ✅ Carried over fro
     ```bash
     # Merge UI_CONSTANTS from source to target
     python helpers/workflow/manage_class_attributes.py \
    -    plugins/035_target_workflow.py \
    -    plugins/500_source_workflow.py \
    +    apps/035_target_workflow.py \
    +    apps/500_source_workflow.py \
         --attributes-to-merge UI_CONSTANTS
     
     # Merge multiple attributes
    @@ -328,7 +328,7 @@ curl http://localhost:5001/evolved_flowtest  # Test the workflow
     python helpers/workflow/workflow_reconstructor.py --template 045_evolved_flow --source 110_parameter_buster --target 045_evolved_flow
     
     # 5. Clean up test files
    -rm plugins/045_evolved_flowtest.py
    +rm apps/045_evolved_flowtest.py
     ```
     
     ### **Pattern 3: Component Library Development**
    @@ -346,8 +346,8 @@ python helpers/workflow/create_workflow.py 200_parameter_engine.py ParameterEngi
     python helpers/workflow/workflow_reconstructor.py --template 400_botify_trifecta --source 200_parameter_engine --target 300_advanced_params
     
     # 4. Create component library pattern
    -mkdir -p plugins/components/
    -mv plugins/200_parameter_engine.py plugins/components/  # Archive proven components
    +mkdir -p apps/components/
    +mv apps/200_parameter_engine.py apps/components/  # Archive proven components
     ```
     
     ---
    @@ -386,7 +386,7 @@ app.route(f'/{app_name}/custom_handler', methods=['GET'])            # ❌ No ma
     
     #### **4. File Organization**
     ```
    -plugins/
    +apps/
     ├── 000-099: Core system workflows
     ├── 100-199: Parameter/optimization workflows  
     ├── 200-299: Creation and management tools
    @@ -455,8 +455,8 @@ python helpers/workflow/create_workflow.py 800_parameter_component.py ParameterC
     
     # 2. Perfect the component (extensive testing)
     # 3. Archive as atomic source
    -mkdir -p plugins/components/
    -mv plugins/800_parameter_component.py plugins/components/
    +mkdir -p apps/components/
    +mv apps/800_parameter_component.py apps/components/
     
     # 4. Use across multiple workflows
     python helpers/workflow/workflow_reconstructor.py --template 400_botify_trifecta --source components/800_parameter_component --target 100_new_param_flow
    @@ -469,7 +469,7 @@ Evolve templates with new capabilities:
     
     ```bash
     # 1. Start with proven template
    -cp plugins/400_botify_trifecta.py plugins/410_enhanced_trifecta.py
    +cp apps/400_botify_trifecta.py apps/410_enhanced_trifecta.py
     
     # 2. Add capabilities via reconstruction
     python helpers/workflow/workflow_reconstructor.py --template 410_enhanced_trifecta --source 200_advanced_ui --target 410_enhanced_trifecta
    @@ -495,7 +495,7 @@ curl http://localhost:5001/protoA
     curl http://localhost:5001/protoB
     
     # 4. Clean up
    -rm plugins/999_*
    +rm apps/999_*
     ```
     
     ---
    diff --git a/helpers/workflow/create_workflow.py b/helpers/workflow/create_workflow.py
    index 150dade..464be14 100644
    --- a/helpers/workflow/create_workflow.py
    +++ b/helpers/workflow/create_workflow.py
    @@ -52,7 +52,7 @@ PLUGINS_DIR = PROJECT_ROOT / "plugins"
     # Works from any location - script automatically finds Pipulate project root:
     python create_workflow.py 035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"
     python create_workflow.py 035_kungfu_workflow KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"  # .py extension optional
    -python create_workflow.py plugins/035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"  # plugins/ prefix optional
    +python create_workflow.py apps/035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"  # apps/ prefix optional
     
     # Can be run from project root:
     python helpers/workflow/create_workflow.py 035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"
    @@ -168,7 +168,7 @@ def main():
     Examples:
       python create_workflow.py 035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"
       python create_workflow.py 035_kungfu_workflow KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"
    -  python create_workflow.py plugins/035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"
    +  python create_workflow.py apps/035_kungfu_workflow.py KungfuWorkflow kungfu "Kung Fu Download" "Welcome message" "Training prompt"
       
       # Using different templates:
       python create_workflow.py 036_botify_custom.py MyBotify my_botify "My Botify Flow" "Welcome" "Training" --template trifecta
    @@ -211,10 +211,10 @@ Examples:
         
         # Handle various input formats:
         # 1. Just filename: "035_kungfu_workflow.py"
    -    # 2. With plugins/ prefix: "plugins/035_kungfu_workflow.py"  
    -    # 3. Full path: "/some/path/plugins/035_kungfu_workflow.py"
    -    if target_filename.startswith('plugins/'):
    -        target_filename = target_filename[8:]  # Remove 'plugins/' prefix
    +    # 2. With apps/ prefix: "apps/035_kungfu_workflow.py"  
    +    # 3. Full path: "/some/path/apps/035_kungfu_workflow.py"
    +    if target_filename.startswith('apps/'):
    +        target_filename = target_filename[8:]  # Remove 'apps/' prefix
         elif '/' in target_filename:
             # Extract just the filename from any path
             target_filename = Path(target_filename).name
    @@ -299,8 +299,8 @@ Examples:
                      print(f"WARNING: Docstring for '{ORIGINAL_CLASS_NAME_IDENTIFIER} Workflow' not found or not replaced.")
                 
                 # Replace file header comment
    -            header_pattern = r'^# File: plugins/[^.]+\.py'
    -            new_header = f'# File: plugins/{target_filename}'
    +            header_pattern = r'^# File: apps/[^.]+\.py'
    +            new_header = f'# File: apps/{target_filename}'
                 content, header_count = re.subn(header_pattern, new_header, content, count=1, flags=re.MULTILINE)
                 if header_count == 0:
                     print(f"WARNING: File header comment not found or not replaced.")
    diff --git a/helpers/workflow/manage_class_attributes.py b/helpers/workflow/manage_class_attributes.py
    index a7cfbf1..fbebf67 100644
    --- a/helpers/workflow/manage_class_attributes.py
    +++ b/helpers/workflow/manage_class_attributes.py
    @@ -10,7 +10,7 @@ Usage:
         python manage_class_attributes.py TARGET_FILE SOURCE_FILE --attributes-to-merge ATTR1 ATTR2 [--force]
     
     Example:
    -    python manage_class_attributes.py plugins/035_kungfu_workflow.py plugins/500_hello_workflow.py --attributes-to-merge UI_CONSTANTS
    +    python manage_class_attributes.py apps/035_kungfu_workflow.py apps/500_hello_workflow.py --attributes-to-merge UI_CONSTANTS
     
     The script:
     1. Extracts class attributes from source file using CLASS_ATTRIBUTES_BUNDLE markers
    diff --git a/helpers/workflow/splice_workflow_step.py b/helpers/workflow/splice_workflow_step.py
    index c0e0615..721fbf4 100755
    --- a/helpers/workflow/splice_workflow_step.py
    +++ b/helpers/workflow/splice_workflow_step.py
    @@ -17,7 +17,7 @@ python splice_workflow_step.py 035_kungfu_workflow.py --position top
     
     # Flexible filename handling:
     python splice_workflow_step.py 035_kungfu_workflow    # .py extension optional
    -python splice_workflow_step.py plugins/035_kungfu_workflow.py  # plugins/ prefix optional
    +python splice_workflow_step.py apps/035_kungfu_workflow.py  # apps/ prefix optional
     
     # Can be run from project root:
     python helpers/workflow/splice_workflow_step.py 035_kungfu_workflow.py --position top
    @@ -309,8 +309,8 @@ Examples:
       python splice_workflow_step.py 035_kungfu_workflow.py --position top
       
       # Works with various path formats:
    -  python splice_workflow_step.py plugins/035_kungfu_workflow.py --position top
    -  python splice_workflow_step.py /full/path/to/plugins/035_kungfu_workflow.py --position bottom
    +  python splice_workflow_step.py apps/035_kungfu_workflow.py --position top
    +  python splice_workflow_step.py /full/path/to/apps/035_kungfu_workflow.py --position bottom
             """
         )
         parser.add_argument("target_filename", help="The filename of the workflow to modify (e.g., 035_kungfu_workflow.py)")
    @@ -328,10 +328,10 @@ Examples:
         
         # Handle various input formats:
         # 1. Just filename: "035_kungfu_workflow.py"
    -    # 2. With plugins/ prefix: "plugins/035_kungfu_workflow.py"  
    -    # 3. Full path: "/some/path/plugins/035_kungfu_workflow.py"
    -    if target_filename.startswith('plugins/'):
    -        target_filename = target_filename[8:]  # Remove 'plugins/' prefix
    +    # 2. With apps/ prefix: "apps/035_kungfu_workflow.py"  
    +    # 3. Full path: "/some/path/apps/035_kungfu_workflow.py"
    +    if target_filename.startswith('apps/'):
    +        target_filename = target_filename[8:]  # Remove 'apps/' prefix
         elif '/' in target_filename:
             # Extract just the filename from any path
             target_filename = Path(target_filename).name
    diff --git a/helpers/workflow/swap_workflow_step.py b/helpers/workflow/swap_workflow_step.py
    index 775f1e3..ef68d99 100644
    --- a/helpers/workflow/swap_workflow_step.py
    +++ b/helpers/workflow/swap_workflow_step.py
    @@ -14,7 +14,7 @@ Usage:
         python swap_workflow_step.py TARGET_FILE TARGET_STEP_ID SOURCE_FILE SOURCE_BUNDLE_ID [--force]
     
     Example:
    -    python swap_workflow_step.py plugins/035_kungfu_workflow.py step_01 plugins/500_hello_workflow.py step_01
    +    python swap_workflow_step.py apps/035_kungfu_workflow.py step_01 apps/500_hello_workflow.py step_01
     
     The script:
     1. Extracts the source step bundle using START_STEP_BUNDLE/END_STEP_BUNDLE markers
    diff --git a/imports/crud.py b/imports/crud.py
    index 19883c4..f9d6b49 100644
    --- a/imports/crud.py
    +++ b/imports/crud.py
    @@ -616,7 +616,7 @@ class WorkflowUtilities:
                                           analysis_slug: str, data_type: str = None) -> str:
             """Generate deterministic file paths for data caching.
             
    -        Extracted from: plugins/110_parameter_buster.py, 120_link_graph.py, 400_botify_trifecta.py
    +        Extracted from: apps/110_parameter_buster.py, 120_link_graph.py, 400_botify_trifecta.py
             Pattern: FILE MANAGEMENT - Create consistent paths for file caching
             
             Args:
    @@ -653,7 +653,7 @@ class WorkflowUtilities:
         async def check_file_exists(filepath: str) -> tuple[bool, dict]:
             """Check if file exists and return metadata.
             
    -        Extracted from: plugins/110_parameter_buster.py (and similar patterns)
    +        Extracted from: apps/110_parameter_buster.py (and similar patterns)
             Pattern: FILE VALIDATION - Consistent file existence checking
             
             Args:
    @@ -680,7 +680,7 @@ class WorkflowUtilities:
         def url_to_safe_path(url: str) -> tuple[str, str]:
             """Convert URL to filesystem-safe path components.
             
    -        Extracted from: plugins/440_browser_automation.py  
    +        Extracted from: apps/440_browser_automation.py  
             Pattern: URL PROCESSING - Safe filesystem path generation
             
             Args:
    diff --git a/server.py b/server.py
    index 0efd7cc..50fcfad 100644
    --- a/server.py
    +++ b/server.py
    @@ -3449,7 +3449,7 @@ def create_chat_scripts(sortable_selector='.sortable', ghost_class='blue-backgro
         return (Script(src='/assets/pipulate.js'), Script(python_generated_init_script), Link(rel='stylesheet', href='/assets/styles.css'))
     
     
    -# BaseCrud class moved to plugins/crud.py to avoid circular imports
    +# BaseCrud class moved to apps/crud.py to avoid circular imports
     
     # Initialize FastApp with database and configuration
     app, rt, (store, Store), (profiles, Profile), (pipeline, Pipeline) = fast_app(
    diff --git a/tools/mcp_tools.py b/tools/mcp_tools.py
    index f7acfa6..71ebd4f 100644
    --- a/tools/mcp_tools.py
    +++ b/tools/mcp_tools.py
    @@ -2822,7 +2822,7 @@ async def browser_automate_workflow_walkthrough(params: dict) -> dict:
     
             # === AGGRESSIVE URL VALIDATION BEFORE BROWSER OPENING ===
             # Map plugin filename to app name and construct URL
    -        plugin_name = plugin_filename.replace('plugins/', '').replace('.py', '')
    +        plugin_name = plugin_filename.replace('apps/', '').replace('.py', '')
             plugin_to_app_mapping = {
                 '010_introduction': 'introduction',
                 '580_upload': 'file_upload_widget',
    @@ -3047,7 +3047,7 @@ async def browser_automate_workflow_walkthrough(params: dict) -> dict:
             try:
                 # Step 1: Navigate to the specific plugin requested
                 # Extract plugin name from filename and construct URL
    -            plugin_name = plugin_filename.replace('plugins/', '').replace('.py', '')
    +            plugin_name = plugin_filename.replace('apps/', '').replace('.py', '')
     
                 # Map plugin filename to app name (this is the key fix!)
                 plugin_to_app_mapping = {
    @@ -4624,7 +4624,7 @@ async def test_environment_access() -> dict:
             import os
             current_dir = os.getcwd()
             server_exists = os.path.exists("server.py")
    -        plugins_exists = os.path.exists("plugins/")
    +        plugins_exists = os.path.exists("apps/")
     
             return {
                 "success": True,

## Crossyed From The Code Yet?

> I'm telling ya, you don't actually have to read all that code. It's mostly
> there for the AIs to give me bang-up spot-on advice. This kind of detail is
> pattern recognition gold to them, but I am sympathetic to your plight dear
> reader. I do plan on distilling all this down... eventually.

The app is broken now, but not hopelessly so because the system is designed to
gracefully skip over plugins it doesn't find. But that's more like lurking bugs
than not really broken. So we follow up with another `rg plugins`:

```
requirements.txt:mdit-py-plugins==0.4.2
tools/advanced_automation_tools.py:            "command": "ls -la server.py plugins browser_automation"
server.py:    logger.warning(f'🚨 PRODUCTION_DATABASE_WARNING: If demo is triggered, plugins using static DB_FILENAME may cause issues!')
server.py:# This registry allows plugins to register MCP tools that can be called
server.py:# Global registry for MCP tools - populated by plugins during startup
server.py:    This class serves as the main interface for plugins to access
server.py:        Centralizes the folder button pattern used across many plugins.
server.py:            blank_placeholder_module = importlib.import_module('plugins.910_blank_placeholder')
server.py:if not os.path.exists('plugins'):
server.py:    os.makedirs('plugins')
server.py:    logger.info('📁 FINDER_TOKEN: PLUGINS_DIR - Created plugins directory')
server.py:    """Discover and import all Python files in the plugins directory.
server.py:    This function scans the 'plugins' directory and imports each .py file
server.py:    - Starting with 'xx_' or 'XX_' (indicating experimental/in-progress plugins)
server.py:    plugins_dir = os.path.join(os.path.dirname(__file__), 'plugins')
server.py:    logger.debug(f'Looking for plugins in: {plugins_dir}')
server.py:    if not os.path.isdir(plugins_dir):
server.py:        logger.warning(f'Plugins directory not found: {plugins_dir}')
server.py:    sorted_files = sorted(os.listdir(plugins_dir), key=numeric_prefix_sort)
server.py:                module = importlib.import_module(f'plugins.{original_name}')
server.py:                module = importlib.import_module(f'plugins.{original_name}')
server.py:                        # Only log classes that look like they might be plugins (have common plugin attributes)
server.py:    figlet_banner("plugins", "Pipulate Workflows and CRUD Apps", font='standard', color='orange3')
server.py:            module = importlib.import_module(f'plugins.{original_name}')
server.py:                            # Inject centralized configuration for plugins that need it
server.py:ordered_plugins = []
server.py:    if module_name not in ordered_plugins and module_name in plugin_instances:
server.py:        ordered_plugins.append(module_name)
server.py:        plugins_discovered=discovered_count,
server.py:        plugins_registered=registered_count,
server.py:    failed_plugins = []
server.py:            failed_plugins.append(f'{module_name}.{class_name}')
server.py:    server_whisper(f"Some plugins need attention: {', '.join(failed_plugins)}", "⚠️")
server.py:    logger.warning(f'FINDER_TOKEN: PLUGIN_REGISTRATION_SUMMARY - Failed plugins: {", ".join(failed_plugins)}')
server.py:    chip_says("All plugins loaded successfully! The workshop is fully equipped.", BANNER_COLORS['plugin_registry_success'])
server.py:MENU_ITEMS = base_menu_items + ordered_plugins + additional_menu_items
server.py:            placeholder='Search plugins (Ctrl+K)',
server.py:            hx_post='/search-plugins',
server.py:            aria_label='Search plugins',
server.py:    plugins_by_role = group_plugins_by_role(active_role_names)
server.py:            role_plugins = plugins_by_role.get(role_name, [])
server.py:            role_plugins.sort(key=lambda x: get_plugin_numeric_prefix(x))
server.py:            for plugin_key in role_plugins:
server.py:def group_plugins_by_role(active_role_names):
server.py:    """Group plugins by their primary role for hierarchical menu organization."""
server.py:    plugins_by_role = {}
server.py:    for plugin_key in ordered_plugins:
server.py:            if role_name not in plugins_by_role:
server.py:                plugins_by_role[role_name] = []
server.py:            plugins_by_role[role_name].append(plugin_key)
server.py:    logger.debug(f'Plugins grouped by role: {plugins_by_role}')
server.py:    return plugins_by_role
server.py:@rt('/search-plugins', methods=['POST'])
server.py:async def search_plugins(request):
server.py:    """Search plugins based on user input - Carson Gross style active search."""
server.py:        searchable_plugins = []
server.py:            if module_name in ['profiles', 'roles']:  # Skip system plugins
server.py:            searchable_plugins.append(plugin_entry)
server.py:        # Filter plugins based on search term
server.py:            filtered_plugins = []
server.py:            for plugin in searchable_plugins:
server.py:                    filtered_plugins.append(plugin)
server.py:            # Show ALL plugins on empty search (dropdown menu behavior)
server.py:            filtered_plugins = searchable_plugins
server.py:        if filtered_plugins:
server.py:            auto_select_single = len(filtered_plugins) == 1
server.py:            for i, plugin in enumerate(filtered_plugins):  # Show all results - no artificial limit
server.py:        logger.error(f"Error in search_plugins: {e}")
server.py:                "plugins": "Workflow applications and business logic",
assets/pipulate.js:   Keyboard navigation for search plugins dropdown following HTMX principles:
assets/pipulate.js:// Global search plugins keyboard navigation functions
assets/pipulate.js:        console.warn('⚠️ Search plugins elements not found, skipping keyboard nav setup');
tools/mcp_tools.py:        chrome_options.add_argument('--disable-plugins')
tools/mcp_tools.py:                    # For file upload plugins, we need to initialize the workflow first
tools/mcp_tools.py:        plugins_exists = os.path.exists("apps/")
tools/mcp_tools.py:            "plugins_directory_exists": plugins_exists,
tools/mcp_tools.py:            "environment_ready": server_exists and plugins_exists
training/roles.md:The Roles system is Pipulate's **homepage and menu control center** - a sophisticated CRUD application that determines which plugins appear in your APP menu. It's both the **landing page** and the **role-based access control system** that customizes your experience.
training/roles.md:2. **Menu Control System**: Determines which plugins appear in the APP dropdown
training/roles.md:- **Self-discovering**: New plugins automatically appear in the appropriate roles
training/roles.md:- **Always up-to-date**: The system finds and categorizes plugins as they're added
training/roles.md:- **Core**: Essential system plugins (always available)
training/roles.md:- **Plugin count**: Shows how many plugins this role provides
training/roles.md:- **Expandable plugin list**: Click to see all plugins in this role
training/roles.md:1. **Start with Core**: Essential plugins only
training/roles.md:4. **Custom ordering**: Prioritize most-used plugins
training/roles.md:- **Real-time scanning**: Discovers plugins as they're added
training/roles.md:- **Missing plugins**: Check `ROLES = ['Role Name']` in plugin files
training/roles.md:The Roles system is the **orchestrator** of the entire Pipulate experience - it conducts the symphony of plugins, profiles, and user preferences to create a harmonious, personalized interface.
README.md:   - Left sidebar with workflow plugins (Introduction, Profiles, etc.)
README.md:│   │   │   ├── Input [id='nav-plugin-search', role='searchbox', aria-label='Search plugins']
README.md:    ├── apps/                   # Workflow plugins (010_introduction.py, 400_trifecta.py, etc.)
README.md:The repository includes not only polished plugins but also experimental scripts and notebooks under development (e.g., in the root directory or marked with `xx_` prefix in plugin directories). These represent ongoing work and exploration.
assets/styles.css:   Consolidated from form input plugins (text_area, text_field, radios)
assets/styles.css:   Styles for the search plugins dropdown with keyboard navigation support.
pyproject.toml:include = ["plugins*", "static*"]
helpers/prompt_foo/generate_files_list.py:        f"{base_paths['pipulate']}/plugins", 
assets/css/prism.css:https://prismjs.com/download#themes=prism-okaidia&languages=markup+css+clike+javascript+bash+diff+json+json5+jsonp+liquid+lua+markdown+markup-templating+mermaid+nix+python+regex+yaml&plugins=line-highlight+line-numbers+toolbar+copy-to-clipboard+diff-highlight+treeview */
training/tasks.md:   - Discovers new plugins based on filename
training/widget_examples.md:    * **Widget:** A container using `<pre>` and `<code>` tags, styled by `Prism.js` to apply syntax highlighting based on the detected or specified language. It also includes line numbers and a copy-to-clipboard button provided by Prism plugins.
helpers/workflow/create_workflow.py:        if (current_dir / "plugins").is_dir() and (current_dir / "server.py").is_file():
helpers/workflow/create_workflow.py:        if root.exists() and (root / "plugins").is_dir() and (root / "server.py").is_file():
helpers/workflow/create_workflow.py:    "blank": PROJECT_ROOT / "plugins" / "300_blank_placeholder.py",
helpers/workflow/create_workflow.py:    "hello": PROJECT_ROOT / "plugins" / "500_hello_workflow.py",
helpers/workflow/create_workflow.py:    "trifecta": PROJECT_ROOT / "plugins" / "400_botify_trifecta.py",
helpers/workflow/create_workflow.py:    # "my_custom_template": PROJECT_ROOT / "plugins" / "0XX_my_custom_template.py",
helpers/workflow/create_workflow.py:PLUGINS_DIR = PROJECT_ROOT / "plugins"
apps/440_browser_automation.py:            driver.execute_cdp_cmd('Page.addScriptToEvaluateOnNewDocument', {'source': "\n                    Object.defineProperty(navigator, 'webdriver', {\n                        get: () => undefined\n                    });\n                    Object.defineProperty(navigator, 'plugins', {\n                        get: () => [1, 2, 3, 4, 5]\n                    });\n                    Object.defineProperty(navigator, 'languages', {\n                        get: () => ['en-US', 'en']\n                    });\n                "})
apps/440_browser_automation.py:            driver.execute_cdp_cmd('Page.addScriptToEvaluateOnNewDocument', {'source': "\n                    Object.defineProperty(navigator, 'webdriver', {\n                        get: () => undefined\n                    });\n                    Object.defineProperty(navigator, 'plugins', {\n                        get: () => [1, 2, 3, 4, 5]\n                    });\n                    Object.defineProperty(navigator, 'languages', {\n                        get: () => ['en-US', 'en']\n                    });\n                "})
helpers/workflow/splice_workflow_step.py:        if (current_dir / "plugins").is_dir() and (current_dir / "server.py").is_file():
helpers/workflow/splice_workflow_step.py:        if root.exists() and (root / "plugins").is_dir() and (root / "server.py").is_file():
helpers/workflow/splice_workflow_step.py:TEMPLATE_FILE_PATH = PROJECT_ROOT / "plugins" / "300_blank_placeholder.py"
helpers/workflow/splice_workflow_step.py:PLUGINS_DIR = PROJECT_ROOT / "plugins"
config.py:            'description': 'Essential plugins available to all users.',
config.py:            'description': 'Tools for creating, debugging, and managing workflows and plugins.',
helpers/workflow/workflow_reconstructor.py:        self.plugins_dir = self.base_dir / "plugins"
helpers/workflow/workflow_reconstructor.py:            template_path = self.plugins_dir / f"{template_name}.py"
helpers/workflow/workflow_reconstructor.py:            source_path = self.plugins_dir / f"{source_name}.py" 
helpers/workflow/workflow_reconstructor.py:            target_path = self.plugins_dir / f"{target_name}.py"
helpers/workflow/workflow_reconstructor.py:        existing_path = self.plugins_dir / f"{existing_name}.py"
helpers/workflow/workflow_reconstructor.py:            source_tree = reconstructor.parse_file(reconstructor.plugins_dir / f"{args.source}.py")
apps/030_roles.py:    affected_plugins = [plugin for plugin in plugin_list if item.text in plugin['roles']]
apps/030_roles.py:    plugin_count = len(affected_plugins)
apps/030_roles.py:    """Get list of all available plugins with their roles."""
apps/030_roles.py:    plugins = []
apps/030_roles.py:            # Skip the special plugins that don't belong in role lists
apps/030_roles.py:                # Most plugins have numeric prefixes, so we need to find the actual filename
apps/030_roles.py:                plugins.append({
apps/030_roles.py:    logger.debug(f"get_plugin_list: Returning {len(plugins)} plugins")
apps/030_roles.py:    core_plugins = [p for p in plugins if 'Core' in p['roles']]
apps/030_roles.py:    logger.debug(f"get_plugin_list: Found {len(core_plugins)} Core plugins: {[p['display_name'] for p in core_plugins]}")
apps/030_roles.py:    return sorted(plugins, key=lambda x: x['filename'])
apps/030_roles.py:    plugins = []
apps/030_roles.py:                plugins.append({
apps/030_roles.py:    return sorted(plugins, key=lambda x: x['filename'])
apps/030_roles.py:    """Create a discrete expandable list showing plugins with real emojis."""
apps/030_roles.py:    affected_plugins = [plugin for plugin in plugin_list if role_name in plugin['roles']]
apps/030_roles.py:    logger.debug(f"create_plugin_visibility_table: Role '{role_name}' has {len(affected_plugins)} plugins")
apps/030_roles.py:    for plugin in affected_plugins:
apps/030_roles.py:    if not affected_plugins:
apps/030_roles.py:            P("No plugins assigned to this role.", style="font-style: italic; color: var(--pico-muted-color); margin: 0.5rem 0;"),
apps/030_roles.py:    for plugin in affected_plugins:
apps/230_dev_assistant.py:            (f'/{internal_route_prefix}/search_plugins_step01', self.search_plugins_step01, ['POST'])
apps/230_dev_assistant.py:        # Check dropdown functions ONLY if they exist (don't penalize plugins without dropdowns)
apps/230_dev_assistant.py:        # BONUS: Perfect score message for plugins without dropdown dependencies
apps/230_dev_assistant.py:            # Show positive message for plugins without dropdown dependencies
apps/230_dev_assistant.py:    async def search_plugins_step01(self, request):
apps/230_dev_assistant.py:        """Search plugins for step 1 based on user input - Carson Gross style active search."""
apps/230_dev_assistant.py:            plugins_dir = Path("plugins")
apps/230_dev_assistant.py:            if plugins_dir.exists():
apps/230_dev_assistant.py:                plugin_files = [f.name for f in plugins_dir.glob("*.py") if not f.name.startswith("__")]
apps/230_dev_assistant.py:            # Filter plugins based on search term
apps/230_dev_assistant.py:                filtered_plugins = []
apps/230_dev_assistant.py:                        filtered_plugins.append({
apps/230_dev_assistant.py:                # Show ALL plugins on empty search (dropdown menu behavior)
apps/230_dev_assistant.py:                filtered_plugins = []
apps/230_dev_assistant.py:                    filtered_plugins.append({
apps/230_dev_assistant.py:            if filtered_plugins:
apps/230_dev_assistant.py:                auto_select_single = len(filtered_plugins) == 1
apps/230_dev_assistant.py:                for i, plugin in enumerate(sorted(filtered_plugins, key=lambda x: x['filename'])):  # Show all results - no artificial limit
apps/230_dev_assistant.py:            logger.error(f"Error in search_plugins_step01: {e}")
apps/230_dev_assistant.py:        file_path = Path("plugins") / filename
apps/230_dev_assistant.py:        plugins_dir = Path("plugins")
apps/230_dev_assistant.py:        if plugins_dir.exists():
apps/230_dev_assistant.py:            plugin_files = [f.name for f in plugins_dir.glob("*.py") if not f.name.startswith("__")]
apps/230_dev_assistant.py:                            placeholder='Search plugins by name...',
apps/230_dev_assistant.py:                            hx_post=f'/{app_name}/search_plugins_step01',
apps/230_dev_assistant.py:        file_path = Path("plugins") / selected_file
helpers/release/publish.py:    print("\n🏗️ Step 4.5: Rebuilding Trifecta derivative plugins...")
helpers/release/publish.py:        'plugins_rebuilt': 0,
helpers/release/publish.py:        if "Successfully processed: 2/2 plugins" in output:
helpers/release/publish.py:            stats['plugins_rebuilt'] = 2
helpers/release/publish.py:        elif "Successfully processed: 1/2 plugins" in output:
helpers/release/publish.py:            stats['plugins_rebuilt'] = 1
helpers/release/publish.py:            print(f"   🔨 Plugins rebuilt: {stats['plugins_rebuilt']}/2")
helpers/release/publish.py:        f"{stats['plugins_rebuilt']}/2",
helpers/release/publish.py:            print(f"🏗️ Trifecta Derivatives Rebuilt: {trifecta_stats.get('plugins_rebuilt', 0)}/2 plugins")
helpers/release/publish.py:            f"{trifecta_stats.get('plugins_rebuilt', 0)}/2 plugins",
apps/200_workflow_genesis.py:        plugins_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
apps/200_workflow_genesis.py:        create_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
apps/200_workflow_genesis.py:        splice_bottom_cmd = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:        splice_top_cmd = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position top"
apps/200_workflow_genesis.py:        combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
apps/200_workflow_genesis.py:        plugins_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
apps/200_workflow_genesis.py:        cmd1 = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:        cmd2 = f"python helpers/workflow/manage_class_attributes.py {plugins_filename} apps/040_hello_workflow.py --attributes-to-merge UI_CONSTANTS --force"
apps/200_workflow_genesis.py:        cmd3 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 apps/040_hello_workflow.py step_01 --force"
apps/200_workflow_genesis.py:        cmd4 = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:        cmd5 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 apps/040_hello_workflow.py step_02 --force"
apps/200_workflow_genesis.py:        combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/manage_class_attributes.py {plugins_filename} \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom && \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 \\\n" + \
apps/200_workflow_genesis.py:        plugins_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
apps/200_workflow_genesis.py:        cmd1 = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:        cmd2 = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:        combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
apps/200_workflow_genesis.py:                      f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:            # Create filesystem button to open plugins directory
apps/200_workflow_genesis.py:            plugins_dir = os.path.join(os.getcwd(), 'plugins')
apps/200_workflow_genesis.py:            open_plugins_folder_ui = A(
apps/200_workflow_genesis.py:                hx_get="/open-folder?path=" + urllib.parse.quote(plugins_dir),
apps/200_workflow_genesis.py:                title=f"Open folder: {plugins_dir}",
apps/200_workflow_genesis.py:                    open_plugins_folder_ui,
apps/200_workflow_genesis.py:        plugins_filename = f"apps/{target_filename}" if not target_filename.startswith('apps/') else target_filename
apps/200_workflow_genesis.py:            combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/manage_class_attributes.py {plugins_filename} " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom && " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 " + \
apps/200_workflow_genesis.py:            combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:                          f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
apps/200_workflow_genesis.py:            combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
apps/200_workflow_genesis.py:        # Create filesystem button to open plugins directory
apps/200_workflow_genesis.py:        plugins_dir = os.path.join(os.getcwd(), 'plugins')
apps/200_workflow_genesis.py:        open_plugins_folder_ui = A(
apps/200_workflow_genesis.py:            hx_get="/open-folder?path=" + urllib.parse.quote(plugins_dir),
apps/200_workflow_genesis.py:            title=f"Open folder: {plugins_dir}",
apps/200_workflow_genesis.py:        execution_summary += f"📂 Location: {plugins_dir}\n"
apps/200_workflow_genesis.py:                    P(f"Created in: {plugins_dir}", cls="text-description"),
apps/200_workflow_genesis.py:                    open_plugins_folder_ui,
apps/200_workflow_genesis.py:                    P(f"Check: {plugins_dir}", cls="text-description"),
apps/200_workflow_genesis.py:                    open_plugins_folder_ui,
imports/ascii_displays.py:    plugins_discovered: int, 
imports/ascii_displays.py:    plugins_registered: int, 
imports/ascii_displays.py:    status_table.add_row("📦 Plugins", "✅ Loaded", f"{plugins_registered}/{plugins_discovered} registered")
imports/ascii_displays.py:✅ Plugins: {plugins_registered}/{plugins_discovered} registered
imports/botify/code_generators.py:# Convenience instance for backward compatibility with existing plugins
imports/botify_code_generation.py:eliminating ~400+ lines of duplicated code across plugins.
imports/botify_code_generation.py:    Centralizes the header generation logic to reduce duplication across plugins.
imports/botify_code_generation.py:    This eliminates ~100+ lines of duplicated f-string blocks across Botify plugins.
imports/botify_code_generation.py:            # Try different template config keys that plugins use
imports/botify_code_generation.py:    This eliminates ~150+ lines of duplicated f-string blocks across Botify plugins.
imports/botify_code_generation.py:    This eliminates path construction duplication across Botify plugins.
imports/crud.py:Common classes and utilities for plugins.
imports/crud.py:This module contains shared classes that plugins can import without creating
imports/crud.py:# 🎯 STANDARDIZED STEP DEFINITION - Used by all workflow plugins
imports/crud.py:# Eliminates 34+ identical namedtuple definitions across plugins
imports/crud.py:# Simple import pattern - plugins can copy these lines instead of massive import blocks
imports/crud.py:# 🌐 API WORKFLOW IMPORTS - For plugins that call external APIs
imports/crud.py:# 🎨 WIDGET IMPORTS - For UI component demonstration plugins
imports/crud.py:# Instead of copying massive import blocks from complex plugins,
imports/crud.py:# ✅ Widget plugins: Use the 5-line widget import pattern
imports/crud.py:# ✅ API plugins: Use the 8-line API workflow pattern  
imports/crud.py:# ✅ Basic plugins: Use the 4-line basic workflow pattern
imports/crud.py:        Extracted from: Multiple workflow plugins with repetitive form handling
```

Now I'm not asking you to do any coding Gemini, but I am asking you to check
over my work and to help me characterize what's left so I can get the rest of my
ripgrepping commands in order.

---

## Did Somebody Say Bang-Up Spot-On Perfect AI Advice

> Here's the payoff for all these pedantic piles of code. Without even being in
> the Code Editor, the AI Code Assistant knows enough of what you're doing to
> give good advice. It's not terribly different than doing the tool-calls for
> them but as a part of a documentation process. Win/Win!

**Gemini 2.5 Pro Web UI**: Of course. You've performed the most difficult part of the surgery with impressive precision. Let's analyze the remaining `rg plugins` output to characterize what's left and formulate the final commands.

Excellent work on capturing the "before" and "after" states. This is a hallmark of a careful, deliberate refactoring process.

-----

## Analysis of Remaining References

Based on your second `rg plugins` output, the remaining references can be broken down into three distinct categories. You were right that a simple `plugins/` search wouldn't get everything.

### Category 1: Python String Literals and Variables (High Priority)

These are the most critical remaining items that will cause your application to break. The code is still looking for a directory named `plugins` and trying to import from a `plugins` namespace.

  * **Examples:**
      * `if not os.path.exists('plugins'):`
      * `plugins_dir = os.path.join(..., 'plugins')`
      * `module = importlib.import_module(f'plugins.{original_name}')`
      * `figlet_banner("plugins", ...)`
      * `hx_post='/search-plugins'` (and other `search-plugins` routes)

### Category 2: Non-Python File Content (Medium Priority)

These won't break the application's runtime, but they will lead to incorrect documentation, broken helper scripts, and confusing search results for you and your AI assistants.

  * **Examples:**
      * `README.md`: Mentions `plugins` in the file tree and descriptions.
      * `pyproject.toml`: `include = ["plugins*", "static*"]`
      * `training/*.md`: The training data for your AI still refers to the `plugins` system.
      * `helpers/**/*.py`: Your helper scripts for creating and modifying workflows have hardcoded paths and variables pointing to `plugins`.

### Category 3: False Positives (Low Priority / Ignore)

These are references that contain the substring "plugins" but are not related to your directory structure. They should be ignored.

  * **Examples:**
      * `requirements.txt: mdit-py-plugins==0.4.2` (A dependency name)
      * `assets/css/prism.css`: A URL containing `&plugins=...`
      * `apps/440_browser_automation.py`: A JavaScript snippet that modifies `navigator.plugins` to evade bot detection.

-----

## The Final Ripgrep Commands

Here are the commands to surgically address the remaining high and medium priority issues.

### 1\. Fix Python String Literals and Imports

This command is the most important. It finds all instances of the word "plugins" inside single or double quotes and within `importlib` calls, replacing it with "apps". The `\b` word boundaries ensure we don't accidentally change a word like `search-plugins`.

```bash
rg -l --null "'plugins" | xargs -0 sed -i "s/'plugins'/'apps'/g"
rg -l --null '"plugins"' | xargs -0 sed -i 's/"plugins"/"apps"/g'
```

*(Note: Running two commands, one for single quotes and one for double, is safer than a single complex regex.)*

### 2\. Fix Search Routes and Endpoints

This specifically targets the search functionality, which uses the term as a route.

```bash
rg -l --null 'search-plugins' | xargs -0 sed -i 's/search-plugins/search-apps/g'
```

### 3\. Fix Variable Names

Several variables are named `plugins_dir`, `failed_plugins`, `ordered_plugins`, etc. This command will clean those up for consistency.

```bash
rg -l --null '\bplugins_' | xargs -0 sed -i 's/plugins_/apps_/g'
```

### 4\. Update Documentation and Helper Scripts

This is a broader, safer replacement for non-Python files where the context is less ambiguous.

```bash
rg -l --null '\bplugins\b' --glob='!*.py' | xargs -0 sed -i 's/plugins/apps/g'
```

  * **How it works:** This command specifically excludes (`!`) all Python files (`*.py`) and looks for the whole word `plugins`, replacing it in your `README.md`, `training/` files, and helper scripts.

### 5\. Correct the Project Configuration

Finally, update your `pyproject.toml` to include the new `apps` directory for packaging.

```bash
sed -i 's/"plugins\*"/"apps\*"/' pyproject.toml
```

After running these commands, your refactoring should be nearly complete. Another `nix develop .#dev` cycle will be the ultimate test. You've been incredibly methodical, and this final push should bring it all together.

---

## That's Me, Incredibly Methodical

> I'm not smart like those geniuses out there who seem to just know things
> instantly and work their magic at a young age. I'm more like plodding and
> plowing and forging my way forcibly through this stuff, perhaps my main
> differentiating asset being that I lean into the strengths of carefully chosen
> tools differently. Vim is good for tech-journaling and those tech-journals are
> good for AI. Why the world doesn't see that boggles my mind.

**Me**: "Incredibly methodical" haha, I like that. Be sure to use that concept
when helping me turn this into an article when writing the descriptions and
such. 

It's worth noting that Gemini's ability to take massive prompts that are full of
all kinds of characters from the Web UI does not extend to the Gemini CLI. I
caused my first crash of Gemini CLI by pasting the article so far into the
prompt and had to switch over to Gemini Web. I also lost my whole discussion
history because it doesn't auto-save them, something I guess I got used to over
with Cursor and am going to have to think about how important that is to me
here. I can understand why that's not a priority in the CLI-version.

```bash
                                                        accepting edits (shift + tab to toggle)
╭─────────────────────────────────────────────────────────────────────────────────────────────╮
│ >   Type your message or @path/to/file [Pasted entire article up to this point]             │
╰─────────────────────────────────────────────────────────────────────────────────────────────╯
~/repos/pipulate     no sandbox (see     gemini-2.5-pro (88%         | ✖ 1 error (ctrl+o for 
(tools*)             /docs)             context left)                  details)

<--- Last few GCs --->

[153612:0x1e98d000] 75859051 ms: Mark-Compact 3979.9 (4136.0) -> 3967.0 (4139.0) MB, pooled: 0 MB, 1649.10 / 0.00 ms  (average mu = 0.060, current mu = 0.020) allocation failure; scavenge might not succeed
[153612:0x1e98d000] 75860737 ms: Mark-Compact 3983.0 (4139.0) -> 3970.6 (4142.5) MB, pooled: 0 MB, 1647.21 / 0.00 ms  (average mu = 0.042, current mu = 0.023) allocation failure; scavenge might not succeed


<--- JS stacktrace --->

FATAL ERROR: Ineffective mark-compacts near heap limit Allocation failed - JavaScript heap out of memory
----- Native stack trace -----

 1: 0xd1dad7 node::OOMErrorHandler(char const*, v8::OOMDetails const&) [node]
 2: 0x116d920 v8::Utils::ReportOOMFailure(v8::internal::Isolate*, char const*, v8::OOMDetails const&) [node]
 3: 0x116dd0b v8::internal::V8::FatalProcessOutOfMemory(v8::internal::Isolate*, char const*, v8::OOMDetails const&) [node]
 4: 0x13b9df7  [node]
 5: 0x13b9e38 v8::internal::Heap::ReportIneffectiveMarkCompactIfNeeded() [node]
 6: 0x13d25ce  [node]
 7: 0x13d5008  [node]
 8: 0x1ce7013  [node]
Aborted                    (core dumped) gemini

[mike@nixos:~/repos/pipulate]$
```

JavaScript NodeJS errors? Please! Why are you programming a high performance
command-line tool with the full friggin web stack? You're Google! This should be
programmed in GoLang! Here's an example of getting a *very unwelcome* webby
error from a command-line tool. Gemini CLI being FOSS makes up for it, as does
(very ironically) the Web version being able to handle the prompt as a backup,
which as you saw gave me wonderful *next-step* instructions.

Okay, deep breath...

```bash
[mike@nixos:~/repos/pipulate]$ \rg -l --null "'plugins" | xargs -0 sed -i "s/'plugins'/'apps'/g"

[mike@nixos:~/repos/pipulate]$ \rg -l --null '"plugins"' | xargs -0 sed -i 's/"plugins"/"apps"/g'

[mike@nixos:~/repos/pipulate]$ git status
On branch tools
Your branch is up to date with 'origin/tools'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   apps/200_workflow_genesis.py
	modified:   apps/230_dev_assistant.py
	modified:   apps/440_browser_automation.py
	modified:   helpers/workflow/create_workflow.py
	modified:   helpers/workflow/splice_workflow_step.py
	modified:   helpers/workflow/workflow_reconstructor.py
	modified:   server.py

no changes added to commit (use "git add" and/or "git commit -a")

[mike@nixos:~/repos/pipulate]$ git --no-pager diff
diff --git a/apps/200_workflow_genesis.py b/apps/200_workflow_genesis.py
index 886043b..3f0af6e 100644
--- a/apps/200_workflow_genesis.py
+++ b/apps/200_workflow_genesis.py
@@ -816,7 +816,7 @@ class WorkflowGenesis:
                 display_filename = target_filename
 
             # Create filesystem button to open plugins directory
-            plugins_dir = os.path.join(os.getcwd(), 'plugins')
+            plugins_dir = os.path.join(os.getcwd(), 'apps')
 
             open_plugins_folder_ui = A(
                 "📂 View Plugins Folder",
@@ -1009,7 +1009,7 @@ class WorkflowGenesis:
             clear_critical_operation_flag()
 
         # Create filesystem button to open plugins directory
-        plugins_dir = os.path.join(os.getcwd(), 'plugins')
+        plugins_dir = os.path.join(os.getcwd(), 'apps')
 
         open_plugins_folder_ui = A(
             "📂 View Plugins Folder",
diff --git a/apps/230_dev_assistant.py b/apps/230_dev_assistant.py
index 530e21b..5e57d50 100644
--- a/apps/230_dev_assistant.py
+++ b/apps/230_dev_assistant.py
@@ -1512,7 +1512,7 @@ class DevAssistant:
             search_term = form.get('plugin_search', '').strip().lower()
             
             # Get list of plugin files
-            plugins_dir = Path("plugins")
+            plugins_dir = Path("apps")
             plugin_files = []
             if plugins_dir.exists():
                 plugin_files = [f.name for f in plugins_dir.glob("*.py") if not f.name.startswith("__")]
@@ -1593,7 +1593,7 @@ class DevAssistant:
     def generate_create_workflow_commands(self, analysis_results):
         """Generate create_workflow.py commands for creating a new version of the analyzed plugin."""
         filename = analysis_results.get('filename', 'unknown.py')
-        file_path = Path("plugins") / filename
+        file_path = Path("apps") / filename
         
         if not file_path.exists():
             return [P('Plugin file not found for command generation.', style=f'color: {self.UI_CONSTANTS["COLORS"]["ERROR_RED"]};')]
@@ -1798,7 +1798,7 @@ class DevAssistant:
         step_id = 'step_01'
         
         # Get list of plugin files
-        plugins_dir = Path("plugins")
+        plugins_dir = Path("apps")
         plugin_files = []
         if plugins_dir.exists():
             plugin_files = [f.name for f in plugins_dir.glob("*.py") if not f.name.startswith("__")]
@@ -1887,7 +1887,7 @@ class DevAssistant:
             return P('Please select a plugin file to analyze.', style='color: red;')
 
         # Analyze the selected plugin
-        file_path = Path("plugins") / selected_file
+        file_path = Path("apps") / selected_file
         analysis = self.analyze_plugin_file(file_path)
 
         # Store analysis in a simple session variable for step_02 to access
diff --git a/apps/440_browser_automation.py b/apps/440_browser_automation.py
index 0078eaa..6cd2402 100644
--- a/apps/440_browser_automation.py
+++ b/apps/440_browser_automation.py
@@ -494,7 +494,7 @@ class BrowserAutomation:
             chrome_options.add_experimental_option('excludeSwitches', ['enable-automation'])
             chrome_options.add_experimental_option('useAutomationExtension', False)
             driver = webdriver.Chrome(options=chrome_options)
-            driver.execute_cdp_cmd('Page.addScriptToEvaluateOnNewDocument', {'source': "\n                    Object.defineProperty(navigator, 'webdriver', {\n                        get: () => undefined\n                    });\n                    Object.defineProperty(navigator, 'plugins', {\n                        get: () => [1, 2, 3, 4, 5]\n                    });\n                    Object.defineProperty(navigator, 'languages', {\n                        get: () => ['en-US', 'en']\n                    });\n                "})
+            driver.execute_cdp_cmd('Page.addScriptToEvaluateOnNewDocument', {'source': "\n                    Object.defineProperty(navigator, 'webdriver', {\n                        get: () => undefined\n                    });\n                    Object.defineProperty(navigator, 'apps', {\n                        get: () => [1, 2, 3, 4, 5]\n                    });\n                    Object.defineProperty(navigator, 'languages', {\n                        get: () => ['en-US', 'en']\n                    });\n                "})
             try:
                 driver.get('https://www.google.com')
                 WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.NAME, 'q')))
@@ -576,7 +576,7 @@ class BrowserAutomation:
             chrome_options.add_experimental_option('excludeSwitches', ['enable-automation'])
             chrome_options.add_experimental_option('useAutomationExtension', False)
             driver = webdriver.Chrome(options=chrome_options)
-            driver.execute_cdp_cmd('Page.addScriptToEvaluateOnNewDocument', {'source': "\n                    Object.defineProperty(navigator, 'webdriver', {\n                        get: () => undefined\n                    });\n                    Object.defineProperty(navigator, 'plugins', {\n                        get: () => [1, 2, 3, 4, 5]\n                    });\n                    Object.defineProperty(navigator, 'languages', {\n                        get: () => ['en-US', 'en']\n                    });\n                "})
+            driver.execute_cdp_cmd('Page.addScriptToEvaluateOnNewDocument', {'source': "\n                    Object.defineProperty(navigator, 'webdriver', {\n                        get: () => undefined\n                    });\n                    Object.defineProperty(navigator, 'apps', {\n                        get: () => [1, 2, 3, 4, 5]\n                    });\n                    Object.defineProperty(navigator, 'languages', {\n                        get: () => ['en-US', 'en']\n                    });\n                "})
             try:
                 driver.get('https://www.google.com')
                 WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.NAME, 'q')))
diff --git a/helpers/workflow/create_workflow.py b/helpers/workflow/create_workflow.py
index 464be14..3ae304a 100644
--- a/helpers/workflow/create_workflow.py
+++ b/helpers/workflow/create_workflow.py
@@ -15,7 +15,7 @@ def find_pipulate_root():
     # Look for Pipulate project markers
     while current_dir != current_dir.parent:  # Stop at filesystem root
         # Check for key Pipulate files/directories
-        if (current_dir / "plugins").is_dir() and (current_dir / "server.py").is_file():
+        if (current_dir / "apps").is_dir() and (current_dir / "server.py").is_file():
             return current_dir
         current_dir = current_dir.parent
     
@@ -27,7 +27,7 @@ def find_pipulate_root():
     ]
     
     for root in possible_roots:
-        if root.exists() and (root / "plugins").is_dir() and (root / "server.py").is_file():
+        if root.exists() and (root / "apps").is_dir() and (root / "server.py").is_file():
             return root
     
     raise FileNotFoundError(
@@ -39,13 +39,13 @@ def find_pipulate_root():
 PROJECT_ROOT = find_pipulate_root()
 # Template mapping - allows selection of different starting templates
 TEMPLATE_MAP = {
-    "blank": PROJECT_ROOT / "plugins" / "300_blank_placeholder.py",
-    "hello": PROJECT_ROOT / "plugins" / "500_hello_workflow.py",
-    "trifecta": PROJECT_ROOT / "plugins" / "400_botify_trifecta.py",
+    "blank": PROJECT_ROOT / "apps" / "300_blank_placeholder.py",
+    "hello": PROJECT_ROOT / "apps" / "500_hello_workflow.py",
+    "trifecta": PROJECT_ROOT / "apps" / "400_botify_trifecta.py",
     # Future templates can be added here
-    # "my_custom_template": PROJECT_ROOT / "plugins" / "0XX_my_custom_template.py",
+    # "my_custom_template": PROJECT_ROOT / "apps" / "0XX_my_custom_template.py",
 }
-PLUGINS_DIR = PROJECT_ROOT / "plugins"
+PLUGINS_DIR = PROJECT_ROOT / "apps"
 
 # EXAMPLE USAGE (DO NOT DELETE!!!) USER CAN COPY AND PASTE THIS INTO TERMINAL
 """
diff --git a/helpers/workflow/splice_workflow_step.py b/helpers/workflow/splice_workflow_step.py
index 721fbf4..5018e30 100755
--- a/helpers/workflow/splice_workflow_step.py
+++ b/helpers/workflow/splice_workflow_step.py
@@ -40,7 +40,7 @@ def find_pipulate_root():
     # Look for Pipulate project markers
     while current_dir != current_dir.parent:  # Stop at filesystem root
         # Check for key Pipulate files/directories
-        if (current_dir / "plugins").is_dir() and (current_dir / "server.py").is_file():
+        if (current_dir / "apps").is_dir() and (current_dir / "server.py").is_file():
             return current_dir
         current_dir = current_dir.parent
     
@@ -52,7 +52,7 @@ def find_pipulate_root():
     ]
     
     for root in possible_roots:
-        if root.exists() and (root / "plugins").is_dir() and (root / "server.py").is_file():
+        if root.exists() and (root / "apps").is_dir() and (root / "server.py").is_file():
             return root
     
     raise FileNotFoundError(
@@ -62,8 +62,8 @@ def find_pipulate_root():
 
 # Define paths - now dynamically found
 PROJECT_ROOT = find_pipulate_root()
-TEMPLATE_FILE_PATH = PROJECT_ROOT / "plugins" / "300_blank_placeholder.py"
-PLUGINS_DIR = PROJECT_ROOT / "plugins"
+TEMPLATE_FILE_PATH = PROJECT_ROOT / "apps" / "300_blank_placeholder.py"
+PLUGINS_DIR = PROJECT_ROOT / "apps"
 
 # Markers to find insertion points
 STEPS_LIST_MARKER = "# --- STEPS_LIST_INSERTION_POINT ---"
diff --git a/helpers/workflow/workflow_reconstructor.py b/helpers/workflow/workflow_reconstructor.py
index a10d68f..12f0cdf 100644
--- a/helpers/workflow/workflow_reconstructor.py
+++ b/helpers/workflow/workflow_reconstructor.py
@@ -25,7 +25,7 @@ class ASTWorkflowReconstructor:
     
     def __init__(self, base_dir: str = "/home/mike/repos/pipulate"):
         self.base_dir = Path(base_dir)
-        self.plugins_dir = self.base_dir / "plugins"
+        self.plugins_dir = self.base_dir / "apps"
         
         # Define template methods that should NOT be extracted as Chunk 2
         self.template_methods = {
diff --git a/server.py b/server.py
index 50fcfad..905d9cc 100644
--- a/server.py
+++ b/server.py
@@ -3683,8 +3683,8 @@ logger.info('🔧 FINDER_TOKEN: CORE_INIT - Pipulate instance initialized')
 app.add_middleware(CORSMiddleware, allow_origins=['*'], allow_methods=['*'], allow_headers=['*'], allow_credentials=True)
 logger.info('🌐 FINDER_TOKEN: CORS_MIDDLEWARE - CORS middleware added to FastHTML app')
 
-if not os.path.exists('plugins'):
-    os.makedirs('plugins')
+if not os.path.exists('apps'):
+    os.makedirs('apps')
     logger.info('📁 FINDER_TOKEN: PLUGINS_DIR - Created plugins directory')
 else:
     logger.info('📁 FINDER_TOKEN: PLUGINS_DIR - Plugins directory exists')
@@ -4048,7 +4048,7 @@ async def synchronize_roles_to_db():
 def discover_plugin_files():
     """Discover and import all Python files in the plugins directory.
 
-    This function scans the 'plugins' directory and imports each .py file
+    This function scans the 'apps' directory and imports each .py file
     as a module. It skips files:
     - Starting with '__' (like __init__.py)
     - Starting with 'xx_' or 'XX_' (indicating experimental/in-progress plugins)
@@ -4058,7 +4058,7 @@ def discover_plugin_files():
         dict: Mapping of module names to imported module objects
     """
     plugin_modules = {}
-    plugins_dir = os.path.join(os.path.dirname(__file__), 'plugins')
+    plugins_dir = os.path.join(os.path.dirname(__file__), 'apps')
     logger.debug(f'Looking for plugins in: {plugins_dir}')
     if not os.path.isdir(plugins_dir):
         logger.warning(f'Plugins directory not found: {plugins_dir}')
@@ -4134,7 +4134,7 @@ def find_plugin_classes(plugin_modules, discovered_modules):
 
 # 🎨 PLUGINS BANNER - Right before plugin discovery begins (only when running as main script)
 if __name__ == '__main__':
-    figlet_banner("plugins", "Pipulate Workflows and CRUD Apps", font='standard', color='orange3')
+    figlet_banner("apps", "Pipulate Workflows and CRUD Apps", font='standard', color='orange3')
 
 plugin_instances = {}
 discovered_modules = discover_plugin_files()
@@ -7166,7 +7166,7 @@ async def prepare_local_llm_context():
             },
             "key_directories": {
                 "training": "AI training materials and guides",
-                "plugins": "Workflow applications and business logic",
+                "apps": "Workflow applications and business logic",
                 "helpers": "Utility scripts and API integrations",
                 "logs": "Server logs with FINDER_TOKEN patterns"
             },

[mike@nixos:~/repos/pipulate]$ git commit -am "search and replace targeting importlib calls"
[tools 8b7fe36] search and replace targeting importlib calls
 7 files changed, 26 insertions(+), 26 deletions(-)

[mike@nixos:~/repos/pipulate]$
```

Pshwew! Okay, we do a git commit for each step and capture the output for AI. A
new innovation here is doing a git diff without having to write output to a
temporary file because I discovered the `--no-pager` flag so I can do it all in
the terminal and copy-and-paste from there to here.

Next!

```bash
[mike@nixos:~/repos/pipulate]$ \rg -l --null 'search-plugins' | xargs -0 sed -i 's/search-plugins/search-apps/g'

[mike@nixos:~/repos/pipulate]$ git status
On branch tools
Your branch is ahead of 'origin/tools' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   server.py

no changes added to commit (use "git add" and/or "git commit -a")

[mike@nixos:~/repos/pipulate]$ git --no-pager diff
diff --git a/server.py b/server.py
index 905d9cc..4a9199a 100644
--- a/server.py
+++ b/server.py
@@ -4662,7 +4662,7 @@ def create_nav_menu():
             placeholder='Search plugins (Ctrl+K)',
             cls='nav-search nav-search-input',
             id='nav-plugin-search',
-            hx_post='/search-plugins',
+            hx_post='/search-apps',
             hx_target='#search-results-dropdown',
             hx_trigger='input changed delay:300ms, keyup[key==\'Enter\'], focus',
             hx_swap='innerHTML',
@@ -5751,7 +5751,7 @@ async def sync_theme(request):
     return HTMLResponse('OK')
 
 
-@rt('/search-plugins', methods=['POST'])
+@rt('/search-apps', methods=['POST'])
 async def search_plugins(request):
     """Search plugins based on user input - Carson Gross style active search."""
     try:

[mike@nixos:~/repos/pipulate]$ git commit -am "Search and replace that targets search routes and endpoints"
[tools 7fce0c3] Search and replace that targets search routes and endpoints
 1 file changed, 2 insertions(+), 2 deletions(-)

[mike@nixos:~/repos/pipulate]$
```

So far so good. It's worth noting at this point that when I stop and start the
server, I (predictably) get these errors on the `python server.py` terminal
output:

```logs
07:23:26 | ERROR    | __main__        | Error importing plugin module 001_dom_visualizer: No module named 'plugins.001_dom_visualizer'
07:23:26 | ERROR    | __main__        | Error importing plugin module 010_introduction: No module named 'plugins.010_introduction'
07:23:26 | ERROR    | __main__        | Error importing plugin module 020_profiles: No module named 'plugins.020_profiles'
07:23:26 | ERROR    | __main__        | Error importing plugin module 030_roles: No module named 'plugins.030_roles'
07:23:26 | ERROR    | __main__        | Error importing plugin module 040_hello_workflow: No module named 'plugins.040_hello_workflow'
07:23:26 | ERROR    | __main__        | Error importing plugin module 050_documentation: No module named 'plugins.050_documentation'
07:23:26 | ERROR    | __main__        | Error importing plugin module 060_tasks: No module named 'plugins.060_tasks'
07:23:26 | ERROR    | __main__        | Error importing plugin module 070_history: No module named 'plugins.070_history'
07:23:26 | ERROR    | __main__        | Error importing plugin module 100_connect_with_botify: No module named 'plugins.100_connect_with_botify'
07:23:26 | ERROR    | __main__        | Error importing plugin module 110_parameter_buster: No module named 'plugins.110_parameter_buster'
07:23:26 | ERROR    | __main__        | Error importing plugin module 120_link_graph: No module named 'plugins.120_link_graph'
07:23:26 | ERROR    | __main__        | Error importing plugin module 130_gap_analysis: No module named 'plugins.130_gap_analysis'
07:23:26 | ERROR    | __main__        | Error importing plugin module 200_workflow_genesis: No module named 'plugins.200_workflow_genesis'
07:23:26 | ERROR    | __main__        | Error importing plugin module 210_widget_examples: No module named 'plugins.210_widget_examples'
07:23:26 | ERROR    | __main__        | Error importing plugin module 220_roadmap: No module named 'plugins.220_roadmap'
07:23:26 | ERROR    | __main__        | Error importing plugin module 230_dev_assistant: No module named 'plugins.230_dev_assistant'
07:23:26 | ERROR    | __main__        | Error importing plugin module 240_simon_mcp: No module named 'plugins.240_simon_mcp'
07:23:26 | ERROR    | __main__        | Error importing plugin module 300_blank_placeholder: No module named 'plugins.300_blank_placeholder'
07:23:26 | ERROR    | __main__        | Error importing plugin module 400_botify_trifecta: No module named 'plugins.400_botify_trifecta'
07:23:26 | ERROR    | __main__        | Error importing plugin module 430_tab_opener: No module named 'plugins.430_tab_opener'
07:23:26 | ERROR    | __main__        | Error importing plugin module 440_browser_automation: No module named 'plugins.440_browser_automation'
07:23:26 | ERROR    | __main__        | Error importing plugin module 450_stream_simulator: No module named 'plugins.450_stream_simulator'
07:23:26 | ERROR    | __main__        | Error importing plugin module 510_text_field: No module named 'plugins.510_text_field'
07:23:26 | ERROR    | __main__        | Error importing plugin module 520_text_area: No module named 'plugins.520_text_area'
07:23:26 | ERROR    | __main__        | Error importing plugin module 530_dropdown: No module named 'plugins.530_dropdown'
07:23:26 | ERROR    | __main__        | Error importing plugin module 540_checkboxes: No module named 'plugins.540_checkboxes'
07:23:26 | ERROR    | __main__        | Error importing plugin module 550_radios: No module named 'plugins.550_radios'
07:23:26 | ERROR    | __main__        | Error importing plugin module 560_range: No module named 'plugins.560_range'
07:23:26 | ERROR    | __main__        | Error importing plugin module 570_switch: No module named 'plugins.570_switch'
07:23:26 | ERROR    | __main__        | Error importing plugin module 580_upload: No module named 'plugins.580_upload'
07:23:26 | ERROR    | __main__        | Error importing plugin module 610_markdown: No module named 'plugins.610_markdown'
07:23:26 | ERROR    | __main__        | Error importing plugin module 620_mermaid: No module named 'plugins.620_mermaid'
07:23:26 | ERROR    | __main__        | Error importing plugin module 630_prism: No module named 'plugins.630_prism'
07:23:26 | ERROR    | __main__        | Error importing plugin module 640_javascript: No module named 'plugins.640_javascript'
07:23:26 | ERROR    | __main__        | Error importing plugin module 710_pandas: No module named 'plugins.710_pandas'
07:23:26 | ERROR    | __main__        | Error importing plugin module 720_rich: No module named 'plugins.720_rich'
07:23:26 | ERROR    | __main__        | Error importing plugin module 730_matplotlib: No module named 'plugins.730_matplotlib'
07:23:26 | ERROR    | __main__        | Error importing plugin module 810_webbrowser: No module named 'plugins.810_webbrowser'
07:23:26 | ERROR    | __main__        | Error importing plugin module 820_selenium: No module named 'plugins.820_selenium'
```

...and this on the Pipulate homepage:

> Error: Profiles plugin not found

So we know what broken looks like and we're looking for all that to spring back,
which it will do automatically because every time files are changed, Watchdog
automatically restarts the server. So after the last search and replace that
fixes things, we're looking for the app to just start working again. Try doing
that with the full web stack with a long build process!

Next!

```bash
[mike@nixos:~/repos/pipulate]$ \rg -l --null '\bplugins_' | xargs -0 sed -i 's/plugins_/apps_/g'

[mike@nixos:~/repos/pipulate]$ git status
On branch tools
Your branch is up to date with 'origin/tools'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   apps/200_workflow_genesis.py
	modified:   apps/230_dev_assistant.py
	modified:   helpers/release/publish.py
	modified:   helpers/workflow/workflow_reconstructor.py
	modified:   imports/ascii_displays.py
	modified:   server.py
	modified:   tools/mcp_tools.py

no changes added to commit (use "git add" and/or "git commit -a")

[mike@nixos:~/repos/pipulate]$ git --no-pager diff
diff --git a/apps/200_workflow_genesis.py b/apps/200_workflow_genesis.py
index 3f0af6e..9c8ae2f 100644
--- a/apps/200_workflow_genesis.py
+++ b/apps/200_workflow_genesis.py
@@ -260,21 +260,21 @@ class WorkflowGenesis:
         training_prompt = workflow_params.get('training_prompt', 'Help users create workflows step by step')
 
         # Ensure consistent apps/ prefix for all commands
-        plugins_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
+        apps_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
 
         # Single create command - uses blank template specifically
-        create_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
+        create_cmd = f"python helpers/workflow/create_workflow.py {apps_filename} {class_name} {internal_name} \\\n" + \
                     f"  {self.format_bash_command(display_name)} \\\n" + \
                     f"  {self.format_bash_command(endpoint_message)} \\\n" + \
                     f"  {self.format_bash_command(training_prompt)} \\\n" + \
                     f"  --template blank --role Core --force"
 
         # Step positioning demo commands
-        splice_bottom_cmd = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
-        splice_top_cmd = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position top"
+        splice_bottom_cmd = f"python helpers/workflow/splice_workflow_step.py {apps_filename} --position bottom"
+        splice_top_cmd = f"python helpers/workflow/splice_workflow_step.py {apps_filename} --position top"
 
         # Combined command with backslash line breaks for readability
-        combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
+        combined_cmd = f"python helpers/workflow/create_workflow.py {apps_filename} {class_name} {internal_name} \\\n" + \
                       f"  {self.format_bash_command(display_name)} \\\n" + \
                       f"  {self.format_bash_command(endpoint_message)} \\\n" + \
                       f"  {self.format_bash_command(training_prompt)} \\\n" + \
@@ -334,35 +334,35 @@ class WorkflowGenesis:
         hello_training_prompt = "You are assisting with the Kung Fu Hello World workflow recreation. This demonstrates the complete helper tool sequence for building workflows from scratch. The secret word is 'MORPHEUS'."
 
         # Ensure consistent apps/ prefix for all commands (matching working example)
-        plugins_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
+        apps_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
 
         # The corrected 5-command sequence - starts with blank template, becomes Hello World
-        cmd1 = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
+        cmd1 = f"python helpers/workflow/create_workflow.py {apps_filename} {class_name} {internal_name} " + \
                f"{self.format_bash_command(hello_display_name)} " + \
                f"{self.format_bash_command(hello_endpoint_message)} " + \
                f"{self.format_bash_command(hello_training_prompt)} --template blank --role Core --force"
 
-        cmd2 = f"python helpers/workflow/manage_class_attributes.py {plugins_filename} apps/040_hello_workflow.py --attributes-to-merge UI_CONSTANTS --force"
+        cmd2 = f"python helpers/workflow/manage_class_attributes.py {apps_filename} apps/040_hello_workflow.py --attributes-to-merge UI_CONSTANTS --force"
 
-        cmd3 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 apps/040_hello_workflow.py step_01 --force"
+        cmd3 = f"python helpers/workflow/swap_workflow_step.py {apps_filename} step_01 apps/040_hello_workflow.py step_01 --force"
 
-        cmd4 = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
+        cmd4 = f"python helpers/workflow/splice_workflow_step.py {apps_filename} --position bottom"
 
-        cmd5 = f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 apps/040_hello_workflow.py step_02 --force"
+        cmd5 = f"python helpers/workflow/swap_workflow_step.py {apps_filename} step_02 apps/040_hello_workflow.py step_02 --force"
 
         # Combined command with proper && chaining for complete automation
-        combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
+        combined_cmd = f"python helpers/workflow/create_workflow.py {apps_filename} {class_name} {internal_name} \\\n" + \
                       f"  {self.format_bash_command(hello_display_name)} \\\n" + \
                       f"  {self.format_bash_command(hello_endpoint_message)} \\\n" + \
                       f"  {self.format_bash_command(hello_training_prompt)} \\\n" + \
                       f"  --template blank --role Core --force && \\\n" + \
-                      f"python helpers/workflow/manage_class_attributes.py {plugins_filename} \\\n" + \
+                      f"python helpers/workflow/manage_class_attributes.py {apps_filename} \\\n" + \
                       f"  apps/040_hello_workflow.py \\\n" + \
                       f"  --attributes-to-merge UI_CONSTANTS --force && \\\n" + \
-                      f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 \\\n" + \
+                      f"python helpers/workflow/swap_workflow_step.py {apps_filename} step_01 \\\n" + \
                       f"  apps/040_hello_workflow.py step_01 --force && \\\n" + \
-                      f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom && \\\n" + \
-                      f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 \\\n" + \
+                      f"python helpers/workflow/splice_workflow_step.py {apps_filename} --position bottom && \\\n" + \
+                      f"python helpers/workflow/swap_workflow_step.py {apps_filename} step_02 \\\n" + \
                       f"  apps/040_hello_workflow.py step_02 --force"
 
         return Div(
@@ -439,23 +439,23 @@ class WorkflowGenesis:
         training_prompt = workflow_params.get('training_prompt', 'Help users create complex data workflows')
 
         # Ensure consistent apps/ prefix for all commands
-        plugins_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
+        apps_filename = f"apps/{filename}" if not filename.startswith('apps/') else filename
 
         # Trifecta workflow commands - uses trifecta template
-        cmd1 = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
+        cmd1 = f"python helpers/workflow/create_workflow.py {apps_filename} {class_name} {internal_name} " + \
                f"{self.format_bash_command(display_name)} " + \
                f"{self.format_bash_command(endpoint_message)} " + \
                f"{self.format_bash_command(training_prompt)} --template trifecta --role Core --force"
 
-        cmd2 = f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
+        cmd2 = f"python helpers/workflow/splice_workflow_step.py {apps_filename} --position bottom"
 
         # Combined command with backslash line breaks for readability
-        combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} \\\n" + \
+        combined_cmd = f"python helpers/workflow/create_workflow.py {apps_filename} {class_name} {internal_name} \\\n" + \
                       f"  {self.format_bash_command(display_name)} \\\n" + \
                       f"  {self.format_bash_command(endpoint_message)} \\\n" + \
                       f"  {self.format_bash_command(training_prompt)} \\\n" + \
                       f"  --template trifecta --role Core --force && \\\n" + \
-                      f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
+                      f"python helpers/workflow/splice_workflow_step.py {apps_filename} --position bottom"
 
         return Div(
             H4("Trifecta Workflow Experience", cls="section-title"),
@@ -816,14 +816,14 @@ class WorkflowGenesis:
                 display_filename = target_filename
 
             # Create filesystem button to open plugins directory
-            plugins_dir = os.path.join(os.getcwd(), 'apps')
+            apps_dir = os.path.join(os.getcwd(), 'apps')
 
-            open_plugins_folder_ui = A(
+            open_apps_folder_ui = A(
                 "📂 View Plugins Folder",
                 href="#",
-                hx_get="/open-folder?path=" + urllib.parse.quote(plugins_dir),
+                hx_get="/open-folder?path=" + urllib.parse.quote(apps_dir),
                 hx_swap="none",
-                title=f"Open folder: {plugins_dir}",
+                title=f"Open folder: {apps_dir}",
                 role="button",
                 cls="outline contrast",
                 style="margin-bottom: 1rem; display: inline-block;"
@@ -848,7 +848,7 @@ class WorkflowGenesis:
                     H5("🔍 If Your Workflow Doesn't Appear:", style="color: #17a2b8; margin-bottom: 0.5rem;"),
                     P("Check the console window where you started Pipulate for yellow warnings above the 'SERVER RESTART' banner. Import errors will be shown there but won't break the server.",
                       style="color: #6c757d; font-size: 0.9rem; margin-bottom: 1rem;"),
-                    open_plugins_folder_ui,
+                    open_apps_folder_ui,
                     style="background-color: rgba(23, 162, 184, 0.1); padding: 1rem; border-radius: 4px; border-left: 4px solid #17a2b8; margin-bottom: 1.5rem;"
                 ),
 
@@ -887,7 +887,7 @@ class WorkflowGenesis:
             display_filename = target_filename
 
         # Get the combined command based on template choice
-        plugins_filename = f"apps/{target_filename}" if not target_filename.startswith('apps/') else target_filename
+        apps_filename = f"apps/{target_filename}" if not target_filename.startswith('apps/') else target_filename
         class_name = workflow_params.get('class_name', 'KungfuWorkflow')
         internal_name = workflow_params.get('internal_app_name', 'kungfu')
         endpoint_message = workflow_params.get('endpoint_message', 'Welcome message')
@@ -900,30 +900,30 @@ class WorkflowGenesis:
             hello_endpoint_message = "🥋 This workflow will become a Hello World equivalent using helper scripts."
             hello_training_prompt = "You are assisting with the Kung Fu Hello World workflow recreation. This demonstrates the complete helper tool sequence for building workflows from scratch. The secret word is 'MORPHEUS'."
 
-            combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
+            combined_cmd = f"python helpers/workflow/create_workflow.py {apps_filename} {class_name} {internal_name} " + \
                           f"{self.format_bash_command(hello_display_name)} " + \
                           f"{self.format_bash_command(hello_endpoint_message)} " + \
                           f"{self.format_bash_command(hello_training_prompt)} --template blank --role Core --force && " + \
-                          f"python helpers/workflow/manage_class_attributes.py {plugins_filename} " + \
+                          f"python helpers/workflow/manage_class_attributes.py {apps_filename} " + \
                           f"apps/040_hello_workflow.py " + \
                           f"--attributes-to-merge UI_CONSTANTS --force && " + \
-                          f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_01 " + \
+                          f"python helpers/workflow/swap_workflow_step.py {apps_filename} step_01 " + \
                           f"apps/040_hello_workflow.py step_01 --force && " + \
-                          f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom && " + \
-                          f"python helpers/workflow/swap_workflow_step.py {plugins_filename} step_02 " + \
+                          f"python helpers/workflow/splice_workflow_step.py {apps_filename} --position bottom && " + \
+                          f"python helpers/workflow/swap_workflow_step.py {apps_filename} step_02 " + \
                           f"apps/040_hello_workflow.py step_02 --force"
         elif selected_template == 'trifecta':
             # Trifecta workflow commands - use template-specific display name
             trifecta_display_name = "Kung Fu Trifecta 🏇"
-            combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
+            combined_cmd = f"python helpers/workflow/create_workflow.py {apps_filename} {class_name} {internal_name} " + \
                           f"{self.format_bash_command(trifecta_display_name)} " + \
                           f"{self.format_bash_command(endpoint_message)} " + \
                           f"{self.format_bash_command(training_prompt)} --template trifecta --role Core --force && " + \
-                          f"python helpers/workflow/splice_workflow_step.py {plugins_filename} --position bottom"
+                          f"python helpers/workflow/splice_workflow_step.py {apps_filename} --position bottom"
         else:
             # Blank template - use template-specific display name
             blank_display_name = "Kung Fu Placeholder 🥋"
-            combined_cmd = f"python helpers/workflow/create_workflow.py {plugins_filename} {class_name} {internal_name} " + \
+            combined_cmd = f"python helpers/workflow/create_workflow.py {apps_filename} {class_name} {internal_name} " + \
                           f"{self.format_bash_command(blank_display_name)} " + \
                           f"{self.format_bash_command(endpoint_message)} " + \
                           f"{self.format_bash_command(training_prompt)} --template blank --role Core --force"
@@ -1009,14 +1009,14 @@ class WorkflowGenesis:
             clear_critical_operation_flag()
 
         # Create filesystem button to open plugins directory
-        plugins_dir = os.path.join(os.getcwd(), 'apps')
+        apps_dir = os.path.join(os.getcwd(), 'apps')
 
-        open_plugins_folder_ui = A(
+        open_apps_folder_ui = A(
             "📂 View Plugins Folder",
             href="#",
-            hx_get="/open-folder?path=" + urllib.parse.quote(plugins_dir),
+            hx_get="/open-folder?path=" + urllib.parse.quote(apps_dir),
             hx_swap="none",
-            title=f"Open folder: {plugins_dir}",
+            title=f"Open folder: {apps_dir}",
             role="button",
             cls="outline contrast",
             style="margin-right: 10px;"
@@ -1026,7 +1026,7 @@ class WorkflowGenesis:
         execution_summary = f"Workflow Creation Execution Report\n\n"
         execution_summary += f"📄 Target File: {display_filename}\n"
         execution_summary += f"🎯 Workflow Name: {display_name}\n"
-        execution_summary += f"📂 Location: {plugins_dir}\n"
+        execution_summary += f"📂 Location: {apps_dir}\n"
         execution_summary += f"✅ Success: {'Yes' if execution_success else 'No'}\n\n"
         execution_summary += execution_output
 
@@ -1046,8 +1046,8 @@ class WorkflowGenesis:
 
                 Div(
                     H5("📁 File Location:", style="color: #28a745; margin-bottom: 0.5rem;"),
-                    P(f"Created in: {plugins_dir}", cls="text-description"),
-                    open_plugins_folder_ui,
+                    P(f"Created in: {apps_dir}", cls="text-description"),
+                    open_apps_folder_ui,
                     style="background-color: rgba(40, 167, 69, 0.1); padding: 1rem; border-radius: 4px; border-left: 4px solid #28a745; margin-bottom: 1rem;"
                 ),
 
@@ -1087,8 +1087,8 @@ class WorkflowGenesis:
 
                 Div(
                     H5("📁 Project Location:", style="color: #6c757d; margin-bottom: 0.5rem;"),
-                    P(f"Check: {plugins_dir}", cls="text-description"),
-                    open_plugins_folder_ui,
+                    P(f"Check: {apps_dir}", cls="text-description"),
+                    open_apps_folder_ui,
                     style="background-color: rgba(108, 117, 125, 0.1); padding: 1rem; border-radius: 4px; border-left: 4px solid #6c757d;"
                 )
             )
diff --git a/apps/230_dev_assistant.py b/apps/230_dev_assistant.py
index 5e57d50..f5104e1 100644
--- a/apps/230_dev_assistant.py
+++ b/apps/230_dev_assistant.py
@@ -106,7 +106,7 @@ class DevAssistant:
             (f'/{internal_route_prefix}/init', self.init, ['POST']),
             (f'/{internal_route_prefix}/revert', self.handle_revert, ['POST']),
             (f'/{internal_route_prefix}/unfinalize', self.unfinalize, ['POST']),
-            (f'/{internal_route_prefix}/search_plugins_step01', self.search_plugins_step01, ['POST'])
+            (f'/{internal_route_prefix}/search_apps_step01', self.search_apps_step01, ['POST'])
         ]
 
         for step_obj in self.steps:
@@ -1505,17 +1505,17 @@ class DevAssistant:
 
         return analysis
 
-    async def search_plugins_step01(self, request):
+    async def search_apps_step01(self, request):
         """Search plugins for step 1 based on user input - Carson Gross style active search."""
         try:
             form = await request.form()
             search_term = form.get('plugin_search', '').strip().lower()
             
             # Get list of plugin files
-            plugins_dir = Path("apps")
+            apps_dir = Path("apps")
             plugin_files = []
-            if plugins_dir.exists():
-                plugin_files = [f.name for f in plugins_dir.glob("*.py") if not f.name.startswith("__")]
+            if apps_dir.exists():
+                plugin_files = [f.name for f in apps_dir.glob("*.py") if not f.name.startswith("__")]
             
             # Filter plugins based on search term
             if search_term:
@@ -1583,7 +1583,7 @@ class DevAssistant:
             return HTMLResponse(result_html)
             
         except Exception as e:
-            logger.error(f"Error in search_plugins_step01: {e}")
+            logger.error(f"Error in search_apps_step01: {e}")
             return HTMLResponse(f"""
             <div style="padding: 1rem; color: var(--pico-form-element-invalid-active-border-color);">
                 Search error: {str(e)}
@@ -1798,10 +1798,10 @@ class DevAssistant:
         step_id = 'step_01'
         
         # Get list of plugin files
-        plugins_dir = Path("apps")
+        apps_dir = Path("apps")
         plugin_files = []
-        if plugins_dir.exists():
-            plugin_files = [f.name for f in plugins_dir.glob("*.py") if not f.name.startswith("__")]
+        if apps_dir.exists():
+            plugin_files = [f.name for f in apps_dir.glob("*.py") if not f.name.startswith("__")]
 
         # Create search results dropdown 
         search_results_dropdown = Div(id=f'plugin-search-results-{step_id}', 
@@ -1820,7 +1820,7 @@ class DevAssistant:
                             placeholder='Search plugins by name...',
                             id=f'plugin-search-input-{step_id}',
                             style='width: 100%; border-radius: 8px; margin-bottom: 1rem;',
-                            hx_post=f'/{app_name}/search_plugins_step01',
+                            hx_post=f'/{app_name}/search_apps_step01',
                             hx_target=f'#plugin-search-results-{step_id}',
                             hx_trigger='input changed delay:300ms, focus',
                             hx_swap='innerHTML'
diff --git a/helpers/release/publish.py b/helpers/release/publish.py
index 30225b7..b323b1d 100755
--- a/helpers/release/publish.py
+++ b/helpers/release/publish.py
@@ -488,7 +488,7 @@ def rebuild_trifecta_derivatives():
 def parse_trifecta_rebuild_stats(output):
     """Parse Trifecta rebuild statistics from output."""
     stats = {
-        'plugins_rebuilt': 0,
+        'apps_rebuilt': 0,
         'parameter_buster_methods': 0,
         'link_graph_methods': 0,
         'success_rate': 0,
@@ -500,11 +500,11 @@ def parse_trifecta_rebuild_stats(output):
         
         # Extract statistics
         if "Successfully processed: 2/2 plugins" in output:
-            stats['plugins_rebuilt'] = 2
+            stats['apps_rebuilt'] = 2
             stats['success_rate'] = 100
             stats['validation_passed'] = True
         elif "Successfully processed: 1/2 plugins" in output:
-            stats['plugins_rebuilt'] = 1
+            stats['apps_rebuilt'] = 1
             stats['success_rate'] = 50
         
         # Extract method counts
@@ -531,7 +531,7 @@ def display_trifecta_rebuild_stats(stats):
         # Fallback to simple text display
         if stats:
             print("\n🏗️ TRIFECTA REBUILD STATISTICS:")
-            print(f"   🔨 Plugins rebuilt: {stats['plugins_rebuilt']}/2")
+            print(f"   🔨 Plugins rebuilt: {stats['apps_rebuilt']}/2")
             print(f"   📦 Parameter Buster methods: {stats['parameter_buster_methods']}")
             print(f"   🌐 Link Graph methods: {stats['link_graph_methods']}")
             print(f"   ✅ Success rate: {stats['success_rate']}%")
@@ -561,7 +561,7 @@ def display_trifecta_rebuild_stats(stats):
     
     table.add_row(
         "🔨 Plugins Rebuilt",
-        f"{stats['plugins_rebuilt']}/2",
+        f"{stats['apps_rebuilt']}/2",
         Text(f"{stats['success_rate']}%", style=f"bold {success_color}")
     )
     
@@ -818,7 +818,7 @@ def display_beautiful_summary(commit_message, ai_generated=False, version=None,
         if published:
             print(f"🚀 Published to PyPI: ✅")
         if trifecta_rebuilt and trifecta_stats:
-            print(f"🏗️ Trifecta Derivatives Rebuilt: {trifecta_stats.get('plugins_rebuilt', 0)}/2 plugins")
+            print(f"🏗️ Trifecta Derivatives Rebuilt: {trifecta_stats.get('apps_rebuilt', 0)}/2 plugins")
         print("="*60)
         return
     
@@ -877,7 +877,7 @@ def display_beautiful_summary(commit_message, ai_generated=False, version=None,
         rebuild_status = "✅ Perfect" if trifecta_stats.get('success_rate', 0) == 100 else "⚠️ Partial"
         table.add_row(
             "🏗️ Trifecta Derivatives",
-            f"{trifecta_stats.get('plugins_rebuilt', 0)}/2 plugins",
+            f"{trifecta_stats.get('apps_rebuilt', 0)}/2 plugins",
             rebuild_status
         )
     
diff --git a/helpers/workflow/workflow_reconstructor.py b/helpers/workflow/workflow_reconstructor.py
index 12f0cdf..159ef54 100644
--- a/helpers/workflow/workflow_reconstructor.py
+++ b/helpers/workflow/workflow_reconstructor.py
@@ -25,7 +25,7 @@ class ASTWorkflowReconstructor:
     
     def __init__(self, base_dir: str = "/home/mike/repos/pipulate"):
         self.base_dir = Path(base_dir)
-        self.plugins_dir = self.base_dir / "apps"
+        self.apps_dir = self.base_dir / "apps"
         
         # Define template methods that should NOT be extracted as Chunk 2
         self.template_methods = {
@@ -463,9 +463,9 @@ class ASTWorkflowReconstructor:
         """Main reconstruction method using AST."""
         try:
             # Build file paths
-            template_path = self.plugins_dir / f"{template_name}.py"
-            source_path = self.plugins_dir / f"{source_name}.py" 
-            target_path = self.plugins_dir / f"{target_name}.py"
+            template_path = self.apps_dir / f"{template_name}.py"
+            source_path = self.apps_dir / f"{source_name}.py" 
+            target_path = self.apps_dir / f"{target_name}.py"
             
             print(f"🔧 AST Workflow Reconstruction")
             print(f"  📁 Template: {template_path}")
@@ -575,7 +575,7 @@ class ASTWorkflowReconstructor:
                                    suffix: str) -> bool:
         """Create a variant workflow with suffix applied to names."""
         # Extract base names from existing file
-        existing_path = self.plugins_dir / f"{existing_name}.py"
+        existing_path = self.apps_dir / f"{existing_name}.py"
         source_tree = self.parse_file(existing_path)
         source_attrs = self.extract_class_attributes(source_tree)
         
@@ -946,7 +946,7 @@ Components are transplanted atomically from "Old Workflows" (sources) into "Upda
         # Extract class name from source if not provided
         new_class_name = args.new_class_name
         if not new_class_name:
-            source_tree = reconstructor.parse_file(reconstructor.plugins_dir / f"{args.source}.py")
+            source_tree = reconstructor.parse_file(reconstructor.apps_dir / f"{args.source}.py")
             source_class_node = reconstructor.find_class_node(source_tree)
             if source_class_node:
                 new_class_name = source_class_node.name
diff --git a/imports/ascii_displays.py b/imports/ascii_displays.py
index 7602fbe..26fc032 100644
--- a/imports/ascii_displays.py
+++ b/imports/ascii_displays.py
@@ -560,8 +560,8 @@ Zero uncertainty • 100% automation success rate"""
     return safe_console_capture(console, panel, fallback) 
 
 def startup_summary_table(
-    plugins_discovered: int, 
-    plugins_registered: int, 
+    apps_discovered: int, 
+    apps_registered: int, 
     mcp_tools_count: int, 
     app_name: str = "Pipulate",
     environment: str = "Development"
@@ -586,7 +586,7 @@ def startup_summary_table(
     
     status_table.add_row("🏷️  App Name", "✅ Active", app_name)
     status_table.add_row("🌍 Environment", "✅ Active", environment)
-    status_table.add_row("📦 Plugins", "✅ Loaded", f"{plugins_registered}/{plugins_discovered} registered")
+    status_table.add_row("📦 Plugins", "✅ Loaded", f"{apps_registered}/{apps_discovered} registered")
     status_table.add_row("🔧 MCP Tools", "✅ Ready", f"{mcp_tools_count} tools available")
     status_table.add_row("🧠 AI Memory", "✅ Active", "Keychain persistence enabled")
     status_table.add_row("🌐 Browser Eyes", "✅ Ready", "Session hijacking capability")
@@ -630,7 +630,7 @@ def startup_summary_table(
 📊 SYSTEM STATUS:
 ✅ App: {app_name} 
 ✅ Environment: {environment}
-✅ Plugins: {plugins_registered}/{plugins_discovered} registered
+✅ Plugins: {apps_registered}/{apps_discovered} registered
 ✅ MCP Tools: {mcp_tools_count} tools available
 ✅ AI Memory: Keychain persistence enabled
 ✅ Browser Eyes: Session hijacking capability
diff --git a/server.py b/server.py
index 4a9199a..8d60c1f 100644
--- a/server.py
+++ b/server.py
@@ -4058,10 +4058,10 @@ def discover_plugin_files():
         dict: Mapping of module names to imported module objects
     """
     plugin_modules = {}
-    plugins_dir = os.path.join(os.path.dirname(__file__), 'apps')
-    logger.debug(f'Looking for plugins in: {plugins_dir}')
-    if not os.path.isdir(plugins_dir):
-        logger.warning(f'Plugins directory not found: {plugins_dir}')
+    apps_dir = os.path.join(os.path.dirname(__file__), 'apps')
+    logger.debug(f'Looking for plugins in: {apps_dir}')
+    if not os.path.isdir(apps_dir):
+        logger.warning(f'Plugins directory not found: {apps_dir}')
         return plugin_modules
 
     def numeric_prefix_sort(filename):
@@ -4069,7 +4069,7 @@ def discover_plugin_files():
         if match:
             return int(match.group(1))
         return float('inf')
-    sorted_files = sorted(os.listdir(plugins_dir), key=numeric_prefix_sort)
+    sorted_files = sorted(os.listdir(apps_dir), key=numeric_prefix_sort)
     for filename in sorted_files:
         logger.debug(f'Checking file: {filename}')
         if '(' in filename or ')' in filename:
@@ -4433,8 +4433,8 @@ if __name__ == '__main__':
     logger.info("🔧 STARTUP_MARKER_2: Inside __name__ == '__main__' block - showing Rich tables")
     # Show beautiful startup summary for humans
     startup_summary = startup_summary_table(
-        plugins_discovered=discovered_count,
-        plugins_registered=registered_count,
+        apps_discovered=discovered_count,
+        apps_registered=registered_count,
         mcp_tools_count=tool_count,
         app_name=current_app,
         environment=current_env
@@ -4753,10 +4753,10 @@ def create_app_menu(menux):
     active_role_names = get_active_roles()
     menu_items = create_home_menu_item(menux)
     role_priorities = get_role_priorities()
-    plugins_by_role = group_plugins_by_role(active_role_names)
+    apps_by_role = group_apps_by_role(active_role_names)
     for role_name, role_priority in sorted(role_priorities.items(), key=lambda x: x[1]):
         if role_name in active_role_names:
-            role_plugins = plugins_by_role.get(role_name, [])
+            role_plugins = apps_by_role.get(role_name, [])
             role_plugins.sort(key=lambda x: get_plugin_numeric_prefix(x))
             for plugin_key in role_plugins:
                 menu_item = create_plugin_menu_item(plugin_key=plugin_key, menux=menux, active_role_names=active_role_names)
@@ -4797,9 +4797,9 @@ def get_role_priorities():
     return role_priorities
 
 
-def group_plugins_by_role(active_role_names):
+def group_apps_by_role(active_role_names):
     """Group plugins by their primary role for hierarchical menu organization."""
-    plugins_by_role = {}
+    apps_by_role = {}
     for plugin_key in ordered_plugins:
         plugin_instance = plugin_instances.get(plugin_key)
         if not plugin_instance:
@@ -4811,11 +4811,11 @@ def group_plugins_by_role(active_role_names):
         primary_role = get_plugin_primary_role(plugin_instance)
         if primary_role:
             role_name = primary_role.replace('-', ' ').title()
-            if role_name not in plugins_by_role:
-                plugins_by_role[role_name] = []
-            plugins_by_role[role_name].append(plugin_key)
-    logger.debug(f'Plugins grouped by role: {plugins_by_role}')
-    return plugins_by_role
+            if role_name not in apps_by_role:
+                apps_by_role[role_name] = []
+            apps_by_role[role_name].append(plugin_key)
+    logger.debug(f'Plugins grouped by role: {apps_by_role}')
+    return apps_by_role
 
 
 def get_plugin_numeric_prefix(plugin_key):
diff --git a/tools/mcp_tools.py b/tools/mcp_tools.py
index 71ebd4f..0e118de 100644
--- a/tools/mcp_tools.py
+++ b/tools/mcp_tools.py
@@ -4624,14 +4624,14 @@ async def test_environment_access() -> dict:
         import os
         current_dir = os.getcwd()
         server_exists = os.path.exists("server.py")
-        plugins_exists = os.path.exists("apps/")
+        apps_exists = os.path.exists("apps/")
 
         return {
             "success": True,
             "current_directory": current_dir,
             "server_py_exists": server_exists,
-            "plugins_directory_exists": plugins_exists,
-            "environment_ready": server_exists and plugins_exists
+            "apps_directory_exists": apps_exists,
+            "environment_ready": server_exists and apps_exists
         }
     except Exception as e:
         return {"success": False, "error": str(e)}

[mike@nixos:~/repos/pipulate]$ 
```

## In-Flight Debugging: Analyzing Errors and Correcting Course

> This is the first time in this process that I really started to worry. The app
> should have *sprung back to life* by this point. The remaining edits wouldn't
> keep the Pipulate from running correctly. Yet the `apps` (previously named
> plugins) fail to load. This is why the copious code here. AI can help.

**Me**: Okay, by this time the app should have sprung back to life but it
hasn't. The only remaining references are supposed to be documentation, helper
scripts and PyPI pip install configuration stuff. But I'm still getting the app
import errors in the server console output mentioned above.

I think Gemini needs to see the remaining references to plugin.

```bash
[mike@nixos:~/repos/pipulate]$ \rg plugins > /tmp/delme.txt

[mike@nixos:~/repos/pipulate]$ xc /tmp/delme.txt
```

...shown here:

```
requirements.txt:mdit-py-plugins==0.4.2
tools/advanced_automation_tools.py:            "command": "ls -la server.py plugins browser_automation"
server.py:    logger.warning(f'🚨 PRODUCTION_DATABASE_WARNING: If demo is triggered, plugins using static DB_FILENAME may cause issues!')
server.py:# This registry allows plugins to register MCP tools that can be called
server.py:# Global registry for MCP tools - populated by plugins during startup
server.py:    This class serves as the main interface for plugins to access
server.py:        Centralizes the folder button pattern used across many plugins.
server.py:            blank_placeholder_module = importlib.import_module('plugins.910_blank_placeholder')
server.py:    logger.info('📁 FINDER_TOKEN: PLUGINS_DIR - Created plugins directory')
server.py:    """Discover and import all Python files in the plugins directory.
server.py:    - Starting with 'xx_' or 'XX_' (indicating experimental/in-progress plugins)
server.py:    logger.debug(f'Looking for plugins in: {apps_dir}')
server.py:                module = importlib.import_module(f'plugins.{original_name}')
server.py:                module = importlib.import_module(f'plugins.{original_name}')
server.py:                        # Only log classes that look like they might be plugins (have common plugin attributes)
server.py:            module = importlib.import_module(f'plugins.{original_name}')
server.py:                            # Inject centralized configuration for plugins that need it
server.py:ordered_plugins = []
server.py:    if module_name not in ordered_plugins and module_name in plugin_instances:
server.py:        ordered_plugins.append(module_name)
server.py:    failed_plugins = []
server.py:            failed_plugins.append(f'{module_name}.{class_name}')
server.py:    server_whisper(f"Some plugins need attention: {', '.join(failed_plugins)}", "⚠️")
server.py:    logger.warning(f'FINDER_TOKEN: PLUGIN_REGISTRATION_SUMMARY - Failed plugins: {", ".join(failed_plugins)}')
server.py:    chip_says("All plugins loaded successfully! The workshop is fully equipped.", BANNER_COLORS['plugin_registry_success'])
server.py:MENU_ITEMS = base_menu_items + ordered_plugins + additional_menu_items
server.py:            placeholder='Search plugins (Ctrl+K)',
server.py:            aria_label='Search plugins',
server.py:            role_plugins = apps_by_role.get(role_name, [])
server.py:            role_plugins.sort(key=lambda x: get_plugin_numeric_prefix(x))
server.py:            for plugin_key in role_plugins:
server.py:    """Group plugins by their primary role for hierarchical menu organization."""
server.py:    for plugin_key in ordered_plugins:
server.py:async def search_plugins(request):
server.py:    """Search plugins based on user input - Carson Gross style active search."""
server.py:        searchable_plugins = []
server.py:            if module_name in ['profiles', 'roles']:  # Skip system plugins
server.py:            searchable_plugins.append(plugin_entry)
server.py:        # Filter plugins based on search term
server.py:            filtered_plugins = []
server.py:            for plugin in searchable_plugins:
server.py:                    filtered_plugins.append(plugin)
server.py:            # Show ALL plugins on empty search (dropdown menu behavior)
server.py:            filtered_plugins = searchable_plugins
server.py:        if filtered_plugins:
server.py:            auto_select_single = len(filtered_plugins) == 1
server.py:            for i, plugin in enumerate(filtered_plugins):  # Show all results - no artificial limit
server.py:        logger.error(f"Error in search_plugins: {e}")
assets/styles.css:   Consolidated from form input plugins (text_area, text_field, radios)
assets/styles.css:   Styles for the search plugins dropdown with keyboard navigation support.
tools/mcp_tools.py:        chrome_options.add_argument('--disable-plugins')
tools/mcp_tools.py:                    # For file upload plugins, we need to initialize the workflow first
helpers/prompt_foo/generate_files_list.py:        f"{base_paths['pipulate']}/plugins", 
training/roles.md:The Roles system is Pipulate's **homepage and menu control center** - a sophisticated CRUD application that determines which plugins appear in your APP menu. It's both the **landing page** and the **role-based access control system** that customizes your experience.
training/roles.md:2. **Menu Control System**: Determines which plugins appear in the APP dropdown
training/roles.md:- **Self-discovering**: New plugins automatically appear in the appropriate roles
training/roles.md:- **Always up-to-date**: The system finds and categorizes plugins as they're added
training/roles.md:- **Core**: Essential system plugins (always available)
training/roles.md:- **Plugin count**: Shows how many plugins this role provides
training/roles.md:- **Expandable plugin list**: Click to see all plugins in this role
training/roles.md:1. **Start with Core**: Essential plugins only
training/roles.md:4. **Custom ordering**: Prioritize most-used plugins
training/roles.md:- **Real-time scanning**: Discovers plugins as they're added
training/roles.md:- **Missing plugins**: Check `ROLES = ['Role Name']` in plugin files
training/roles.md:The Roles system is the **orchestrator** of the entire Pipulate experience - it conducts the symphony of plugins, profiles, and user preferences to create a harmonious, personalized interface.
assets/pipulate.js:   Keyboard navigation for search plugins dropdown following HTMX principles:
assets/pipulate.js:// Global search plugins keyboard navigation functions
assets/pipulate.js:        console.warn('⚠️ Search plugins elements not found, skipping keyboard nav setup');
training/tasks.md:   - Discovers new plugins based on filename
training/widget_examples.md:    * **Widget:** A container using `<pre>` and `<code>` tags, styled by `Prism.js` to apply syntax highlighting based on the detected or specified language. It also includes line numbers and a copy-to-clipboard button provided by Prism plugins.
apps/030_roles.py:    affected_plugins = [plugin for plugin in plugin_list if item.text in plugin['roles']]
apps/030_roles.py:    plugin_count = len(affected_plugins)
apps/030_roles.py:    """Get list of all available plugins with their roles."""
apps/030_roles.py:    plugins = []
apps/030_roles.py:            # Skip the special plugins that don't belong in role lists
apps/030_roles.py:                # Most plugins have numeric prefixes, so we need to find the actual filename
apps/030_roles.py:                plugins.append({
apps/030_roles.py:    logger.debug(f"get_plugin_list: Returning {len(plugins)} plugins")
apps/030_roles.py:    core_plugins = [p for p in plugins if 'Core' in p['roles']]
apps/030_roles.py:    logger.debug(f"get_plugin_list: Found {len(core_plugins)} Core plugins: {[p['display_name'] for p in core_plugins]}")
apps/030_roles.py:    return sorted(plugins, key=lambda x: x['filename'])
apps/030_roles.py:    plugins = []
apps/030_roles.py:                plugins.append({
apps/030_roles.py:    return sorted(plugins, key=lambda x: x['filename'])
apps/030_roles.py:    """Create a discrete expandable list showing plugins with real emojis."""
apps/030_roles.py:    affected_plugins = [plugin for plugin in plugin_list if role_name in plugin['roles']]
apps/030_roles.py:    logger.debug(f"create_plugin_visibility_table: Role '{role_name}' has {len(affected_plugins)} plugins")
apps/030_roles.py:    for plugin in affected_plugins:
apps/030_roles.py:    if not affected_plugins:
apps/030_roles.py:            P("No plugins assigned to this role.", style="font-style: italic; color: var(--pico-muted-color); margin: 0.5rem 0;"),
apps/030_roles.py:    for plugin in affected_plugins:
helpers/release/publish.py:    print("\n🏗️ Step 4.5: Rebuilding Trifecta derivative plugins...")
helpers/release/publish.py:        if "Successfully processed: 2/2 plugins" in output:
helpers/release/publish.py:        elif "Successfully processed: 1/2 plugins" in output:
helpers/release/publish.py:            print(f"🏗️ Trifecta Derivatives Rebuilt: {trifecta_stats.get('apps_rebuilt', 0)}/2 plugins")
helpers/release/publish.py:            f"{trifecta_stats.get('apps_rebuilt', 0)}/2 plugins",
config.py:            'description': 'Essential plugins available to all users.',
config.py:            'description': 'Tools for creating, debugging, and managing workflows and plugins.',
README.md:   - Left sidebar with workflow plugins (Introduction, Profiles, etc.)
README.md:│   │   │   ├── Input [id='nav-plugin-search', role='searchbox', aria-label='Search plugins']
README.md:    ├── apps/                   # Workflow plugins (010_introduction.py, 400_trifecta.py, etc.)
README.md:The repository includes not only polished plugins but also experimental scripts and notebooks under development (e.g., in the root directory or marked with `xx_` prefix in plugin directories). These represent ongoing work and exploration.
assets/css/prism.css:https://prismjs.com/download#themes=prism-okaidia&languages=markup+css+clike+javascript+bash+diff+json+json5+jsonp+liquid+lua+markdown+markup-templating+mermaid+nix+python+regex+yaml&plugins=line-highlight+line-numbers+toolbar+copy-to-clipboard+diff-highlight+treeview */
pyproject.toml:include = ["plugins*", "static*"]
imports/crud.py:Common classes and utilities for plugins.
imports/crud.py:This module contains shared classes that plugins can import without creating
imports/crud.py:# 🎯 STANDARDIZED STEP DEFINITION - Used by all workflow plugins
imports/crud.py:# Eliminates 34+ identical namedtuple definitions across plugins
imports/crud.py:# Simple import pattern - plugins can copy these lines instead of massive import blocks
imports/crud.py:# 🌐 API WORKFLOW IMPORTS - For plugins that call external APIs
imports/crud.py:# 🎨 WIDGET IMPORTS - For UI component demonstration plugins
imports/crud.py:# Instead of copying massive import blocks from complex plugins,
imports/crud.py:# ✅ Widget plugins: Use the 5-line widget import pattern
imports/crud.py:# ✅ API plugins: Use the 8-line API workflow pattern  
imports/crud.py:# ✅ Basic plugins: Use the 4-line basic workflow pattern
imports/crud.py:        Extracted from: Multiple workflow plugins with repetitive form handling
imports/botify/code_generators.py:# Convenience instance for backward compatibility with existing plugins
apps/230_dev_assistant.py:        # Check dropdown functions ONLY if they exist (don't penalize plugins without dropdowns)
apps/230_dev_assistant.py:        # BONUS: Perfect score message for plugins without dropdown dependencies
apps/230_dev_assistant.py:            # Show positive message for plugins without dropdown dependencies
apps/230_dev_assistant.py:        """Search plugins for step 1 based on user input - Carson Gross style active search."""
apps/230_dev_assistant.py:            # Filter plugins based on search term
apps/230_dev_assistant.py:                filtered_plugins = []
apps/230_dev_assistant.py:                        filtered_plugins.append({
apps/230_dev_assistant.py:                # Show ALL plugins on empty search (dropdown menu behavior)
apps/230_dev_assistant.py:                filtered_plugins = []
apps/230_dev_assistant.py:                    filtered_plugins.append({
apps/230_dev_assistant.py:            if filtered_plugins:
apps/230_dev_assistant.py:                auto_select_single = len(filtered_plugins) == 1
apps/230_dev_assistant.py:                for i, plugin in enumerate(sorted(filtered_plugins, key=lambda x: x['filename'])):  # Show all results - no artificial limit
apps/230_dev_assistant.py:                            placeholder='Search plugins by name...',
apps/200_workflow_genesis.py:            # Create filesystem button to open plugins directory
apps/200_workflow_genesis.py:        # Create filesystem button to open plugins directory
imports/botify_code_generation.py:eliminating ~400+ lines of duplicated code across plugins.
imports/botify_code_generation.py:    Centralizes the header generation logic to reduce duplication across plugins.
imports/botify_code_generation.py:    This eliminates ~100+ lines of duplicated f-string blocks across Botify plugins.
imports/botify_code_generation.py:            # Try different template config keys that plugins use
imports/botify_code_generation.py:    This eliminates ~150+ lines of duplicated f-string blocks across Botify plugins.
imports/botify_code_generation.py:    This eliminates path construction duplication across Botify plugins.
```

And as a final note before having Gemini do it's thing it's worth pointing out
all this help is in the Web UI of Gemini where each time I'm pasting the *entire
article contents so far* into each submit in a discussion that already has the
history so far. This is massive flex. It's taking advantage of both Gemini's
1-million (or is it 2-million) token context window in the background and in
addition and in my opinion maybe even more importantly, the ability to accept
over 130K tokens on a single webform submit. This is unrivaled right now in the
AI space. I've tried with the latest models of ChatGPT (yes the $200/mo
version), Super Grok with a similarly ridiculous price. And who can do it? The
Gemini 2.5 Pro Web UI that I get as part of my GoogleOne plan! This is flex.

Anyhow, back to business Gemini. What am I missing? I can give you the majority
of the Pipulate codebase to look at if you like or need, but try to figure it
out with what you've got here first please.

## Not To Worry, Gemini Has What It Needs

> Have you noticed I feed the entire articles "so far" back into the AIs as the
> prompt? This is different than having "AI Coding assistance" in an editor
> where the storytelling is scattered throughout many discussions which you may
> or may not actually manage to save, curate, and craft into the overarching
> story.

> In other words, I believe most people lose their valuable "why" and "how" —
> frankly giving all that over to the AI companies who do store it all, leaving
> you only with the derivative "what" of the running code of your app — actually
> the least valuable part. Why?

> Other people using tomorrow's updated AIs will be able to spit out the
> equivalent of your work with 1-shot prompts because you trained them while you
> yourself ignored how visibility into the sausage factory revealing the "why"
> of it all is the actual valuable part.

**Gemini 2.5 Pro Web UI**: You've done an incredible job so far, and your methodical approach is paying off. You are extremely close. The reason your app is still broken is due to one specific line pattern in `server.py` that is the heart of the original plugin discovery logic.

Your previous `sed` commands were correctly designed but missed this crucial case.

-----

## The Smoking Gun: `importlib`

The remaining critical error is in `server.py`. You correctly identified that your helper scripts and `server.py` were building paths to `plugins/`, but the most important part is how Python's `importlib` is told to load the modules.

Looking at your `rg plugins` output, these lines in `server.py` are the culprits:

```python
server.py:                module = importlib.import_module(f'plugins.{original_name}')
server.py:                module = importlib.import_module(f'plugins.{original_name}')
server.py:            module = importlib.import_module(f'plugins.{original_name}')
```

Even though you've changed the directory scanning logic to look in `apps/`, the code that actually performs the import is still trying to load from a Python namespace called `plugins`. This is why you're seeing the `No module named 'plugins. ...'` errors.

-----

## The Final Command

Here is the single, precise `sed` command to fix this. It specifically targets the `import_module` calls.

```bash
sed -i "s/import_module(f'plugins/import_module(f'apps/g" server.py
```

This command will find every instance of `import_module(f'plugins` and change it to `import_module(f'apps`, which should resolve all the import errors and bring your application back to life.

-----

## One Last Cleanup

After you run the command above and confirm the server restarts correctly, there's one last non-breaking change you should make for consistency, which was suggested by the previous AI analysis.

  * **What:** Your `pyproject.toml` file likely still contains `include = ["plugins*", "static*"]`.
  * **Why:** This won't break the app now, but it will cause issues later if you ever build a distributable package from this code, as it will look for a `plugins` directory that no longer exists.
  * **The Fix:**
    ```bash
    sed -i 's/"plugins\*"/"apps\*"/' pyproject.toml
    ```

You are on the one-yard line. These final, precise changes should complete this impressive refactoring effort.

---

## Success!

> The rest is polish. My hypothesis was proven true. You don't really need "in
> editor" AI coding assistance, especially for the kind of *search and replace*
> work today's tool-calling always botches. Command-line tools are the bedrock
> of tech and the key to automation. Let yourself be coddled by AI coding
> assistants at your own risk. 1-shot prompting doesn't result in anything you
> can control long-term.

**Me**: That did it!

```bash
[mike@nixos:~/repos/pipulate]$ sed -i "s/import_module(f'plugins/import_module(f'apps/g" server.py

[mike@nixos:~/repos/pipulate]$ git status
On branch tools
Your branch is up to date with 'origin/tools'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   server.py

no changes added to commit (use "git add" and/or "git commit -a")

[mike@nixos:~/repos/pipulate]$ git --no-pager diff
diff --git a/server.py b/server.py
index 8d60c1f..3aa48bf 100644
--- a/server.py
+++ b/server.py
@@ -4084,7 +4084,7 @@ def discover_plugin_files():
             original_name = base_name
             logger.debug(f'Module name: {clean_name} (from {original_name})')
             try:
-                module = importlib.import_module(f'plugins.{original_name}')
+                module = importlib.import_module(f'apps.{original_name}')
                 plugin_modules[clean_name] = module
                 module._original_filename = original_name
                 logger.debug(f'Successfully imported module: {clean_name} from {original_name}')
@@ -4102,7 +4102,7 @@ def find_plugin_classes(plugin_modules, discovered_modules):
             if isinstance(module_or_name, str):
                 module_name = module_or_name
                 original_name = getattr(discovered_modules[module_name], '_original_filename', module_name)
-                module = importlib.import_module(f'plugins.{original_name}')
+                module = importlib.import_module(f'apps.{original_name}')
             else:
                 module = module_or_name
                 module_name = module.__name__.split('.')[-1]
@@ -4185,7 +4185,7 @@ for module_name, class_name, workflow_class in discovered_classes:
     if module_name not in plugin_instances:
         try:
             original_name = getattr(discovered_modules[module_name], '_original_filename', module_name)
-            module = importlib.import_module(f'plugins.{original_name}')
+            module = importlib.import_module(f'apps.{original_name}')
             workflow_class = getattr(module, class_name)
             if not hasattr(workflow_class, 'landing'):
                 logger.warning(f"FINDER_TOKEN: PLUGIN_REGISTRATION_FAILURE - Plugin class {module_name}.{class_name} missing required 'landing' method - skipping")

[mike@nixos:~/repos/pipulate]$ git commit -am "Pipulate is working again after a series of surgical search and replaces to rename the plugins folder to apps"
[tools 98390ba] Pipulate is working again after a series of surgical search and replaces to rename the plugins folder to apps
 1 file changed, 3 insertions(+), 3 deletions(-)

[mike@nixos:~/repos/pipulate]$
```

I still have a couple of follow-on items to do, but this has been massive flex
by both AI and a human editor taking the sort of job that I'm sure 99% of the
world would have deferred an AI code assistant to try to get them to make the
edits, but I know from hard won experience the file-editing tool-call abilities
they have are really flaky and this is the precisely the sort of stuff it would
fumble on. However, keeping track of all the manual work being done is precisely
in the sweet spot of Gemini 2.5 Pro, another thing I know from hard won
experience. And while I do have Gemini 2.5 Pro as a coding assistant directly
under Gemini CLI, it's... it's... it's hard to put the exact words to it.

But the one-two punch is the two faces of Gemini right now, and even less-so on
the Gemini CLI side. Really I'm using Gemini CLI to avoid *having to use my
prompt_foo tech* that bundles up the relevant parts of my whole code-base into
an XML file for a single webform submit to Gemini Web — though I still think I
will dust that off soon under the new file order. The process should even be
much easier now after the clean-up.

---

## The Final Suture: Fixing `pyproject.toml`

> This is past the "success assured" moment. The app is working. The rest is
> documentation and making sure the way this installs from the Python Package
> Index PyPI (how things pip install) works. `pyproject.toml` is for `pip`.

Okay, now onto the edit:

```bash
[mike@nixos:~/repos/pipulate]$ sed -i 's/"plugins\*"/"apps\*"/' pyproject.toml

[mike@nixos:~/repos/pipulate]$ git status
On branch tools
Your branch is up to date with 'origin/tools'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   pyproject.toml

no changes added to commit (use "git add" and/or "git commit -a")

[mike@nixos:~/repos/pipulate]$ git --no-pager diff
diff --git a/pyproject.toml b/pyproject.toml
index 57eb68b..eb077e8 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -47,7 +47,7 @@ py-modules = ["cli", "server", "common", "config", "ai_dictdb", "__init__"]
 
 [tool.setuptools.packages.find]
 where = ["."]
-include = ["plugins*", "static*"]
+include = ["apps*", "static*"]
 exclude = [
     "client*", 
     "logs*", 

[mike@nixos:~/repos/pipulate]$ git commit -am "And the final reference to the plugins folder in the pyproject.toml file for PyPI is fixed"
[tools a2e3a10] And the final reference to the plugins folder in the pyproject.toml file for PyPI is fixed
 1 file changed, 1 insertion(+), 1 deletion(-)

[mike@nixos:~/repos/pipulate]$
```

## White Labeling SEO Software

> Are you an SEO who somehow managed to find your way here? I believe that
> you're standing at the edge of what is the biggest new trend in SEO: Jupyter
> Notebooks bottled-up as Web Apps with AIs running shotgun walking you through
> what to do and why. It's *agentic AI* **ON RAILS!** And so we allow
> whitelabeling of Pipulate so you can take all the credit for it yourself.

Okay, this is all huge. But now there's a silly little edit that I want to do
because there's a file named `app_name.txt` which applies to the whole global
app (Pipulate, Botifython, etc) and not the plugin-style sub-apps and I don't
want that ambiguity when you `ls` the files. The concept is *whitelabel SEO
software* and so the file should be "whitelabel.txt".

This is perhaps somewhat further complicated by the fact that there is a widely
used `app_name` variable in Pipulate, but I don't think so. I should be able to
do another strategic search and replace for just the `.txt`-file.

```bash
[mike@nixos:~/repos/pipulate]$ \rg app_name.txt --null -l | xargs -0 sed 's/app_name.txt/whitelabel.txt/g' -i

[mike@nixos:~/repos/pipulate]$ mv app_name.txt whitelabel.txt
```

And I changed the contents of `whitelabel.txt` to another name and manually
stopped and started the server (Watchdog doesn't catch everything) and the name
of Pipulate previously whitelabeled to Botifython changed to the new name (Foo).
So I don't even need to show you all the meticulous output the way I did
renaming the `plugins` folder to `apps` because this is low-risk child's play
compared to that.

## Post-Op: The Successful `git` Main Branch Takeover

> I'll never stop documenting this until I actually can do it naturally. Git is
> the great mastery divide. You're in the `vim` editor constantly committing
> stuff to muscle memory. But you do fancy stuff like this in `git` just
> infrequently enough that it evades becoming internalized unless you keep
> spelling it out and practicing like I'm doing here.

The final step in this Sunday morning before even 9:00 AM search and replace
refactoring coding marathon is the git main branch takeover. This is a recurring
theme and I will probably break it out to some section of my website where I can
constantly remind myself of stuff I constantly forget. But it was the subject of
several recent tech journal articles so it should be easy to round up.

```bash
[mike@nixos:~/repos/pipulate]$ git branch
  main
* tools

[mike@nixos:~/repos/pipulate]$ git branch -M tools main

[mike@nixos:~/repos/pipulate]$ git push --force origin main
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To github.com:miklevin/pipulate
   d401483..98356e1  main -> main

[mike@nixos:~/repos/pipulate]$ git push origin --delete tools
To github.com:miklevin/pipulate
 - [deleted]         tools

[mike@nixos:~/repos/pipulate]$ git config --unset-all branch.main.remote

[mike@nixos:~/repos/pipulate]$ git config --unset-all branch.main.merge

[mike@nixos:~/repos/pipulate]$ git push
branch 'main' set up to track 'origin/main'.
Everything up-to-date

[mike@nixos:~/repos/pipulate]$
```

Those last two steps are a little rough around the edges. I have to investigate
them further to figure out how to get rid of the inevitable duplicate branches
this inevitably results in so that it's more idiomatic and less ambiguous.

But that about does it. I thought this branch and this round of work was
actually going to be working on the MCP tools plugin system, but as it turns out
I had to urgently address concept overlap and folder-naming conventions in
which:

Apps are apps and tools are tools. The former format and later use.

## Book Analysis

This analysis transforms the provided journal entry into structured, book-ready components, focusing on clarifying its core technical insights and shaping its narrative potential.

---
**Crafting Compelling Narratives: Title & Filename Brainstorm:**

* **Title Option 1:** A Symphony of Sed: A Live Refactoring Session
    * **Filename:** `python-refactoring-session-sed-rg.md`
    * **Rationale:** This title is punchy and highlights the mastery of specific command-line tools. It appeals directly to developers who appreciate the craft of using the terminal for complex tasks.

* **Title Option 2:** The Great Renaming: A Case Study in Architectural Clarity
    * **Filename:** `architectural-refactoring-renaming-case-study.md`
    * **Rationale:** This title focuses on the high-level goal—improving the software's architecture. It positions the entry as a strategic lesson in maintainability and clear naming conventions.

* **Title Option 3:** Command-Line Surgery: Methodically Refactoring a Python Codebase
    * **Filename:** `command-line-codebase-refactoring-python.md`
    * **Rationale:** "Surgery" is a powerful and accurate metaphor for the delicate, precise work being done. This title conveys the seriousness and skill involved, attracting readers interested in advanced development practices.

* **Preferred Option:**
    * **Title (plain text for YAML):** Command-Line Surgery: A Live Refactor to Untangle a Codebase
    * **Filename:** `command-line-surgery-python-refactor.md`
    * **Rationale:** This is the strongest title. "Command-Line Surgery" is an incredibly evocative and accurate phrase for the methodical, high-stakes work being performed. "Untangle a Codebase" clearly states the problem being solved, making it relatable to any developer who has faced architectural debt.

---
**Book Potential Analysis:**

* **Strengths as Book Fodder:**
    * **Extreme Transparency:** The entry shows the entire, messy process of a major refactor, including the survey of files, the execution of commands, the resulting `git diff`, and the predictable-but-scary server errors mid-process. This is an invaluable, real-world lesson.
    * **High-Skill Demonstration:** The proficient use of `rg`, `xargs`, `sed`, `git mv`, and `git tag` in combination is a powerful demonstration of command-line fluency that serves as an excellent tutorial.
    * **Risk Management:** The explicit use of `git tag` as a "go-back" point is a critical professional practice that is perfectly illustrated here.
    * **Critique of Tooling:** The author's commentary on the limitations of the Gemini CLI (crashing on large prompts) and its implementation in NodeJS provides an authentic, critical perspective on the current state of AI developer tools.

* **Opportunities for Enrichment (for Book Adaptation):**
    * **Create a "Refactoring Checklist" Box:** Distill the author's process into a reusable checklist for readers about to undertake a similar refactor: 1. Survey the scope (`rg`). 2. Set a safety net (`git tag`). 3. Rename the asset (`git mv`). 4. Perform surgical replacements (`sed`). 5. Verify (`git diff`, restart server). 6. Commit.
    * **Explain `backslash hell`:** Add a brief, empathetic sidebar explaining *why* escaping characters like `/` is necessary in `sed` and other regex tools. This turns a moment of frustration into a valuable teaching point.
    * **Diagram the Naming Convention:** Create a simple diagram that shows the three boxes—`imports`, `apps`, `tools`—and lists their distinct characteristics, visually reinforcing the architectural clarity the author achieved.

---
**AI Editorial Perspective: From Journal to Chapter:**
This entry is a perfect candidate for a chapter on **"Advanced Codebase Management"** or **"The Developer as a Craftsman."** It transcends a simple "how-to" and becomes a narrative about control, precision, and confidence in one's tools. The author's methodical approach—surveying, tagging, executing, verifying—is the central theme. The act of renaming `plugins` to `apps` is the plot, but the story is about how a skilled developer can perform complex open-heart surgery on a live application with nothing but a terminal and a deep understanding of their toolchain.

The commentary on the Gemini CLI's crash is a fascinating and important subplot. It highlights the current state of AI tools: immensely powerful for strategic planning and analysis (as shown by the web UI's contribution) but still brittle in their own technical implementation. This contrast between the AI's high-level intelligence and its low-level fragility is a compelling narrative thread. Publishing the raw crash log would be a bold move, but it would lend immense credibility and authenticity to a book about the real-world, practical experience of building with AI. This entry isn't just about code; it's about the entire ecosystem of modern development—the good, the bad, and the NodeJS errors.

---
**Suggested Next AI Processing Steps:**

1.  **Task Suggestion 1:** Create a Standalone Tutorial from the `git` Workflow
    * **Potential Prompt Snippet for Next AI:** "Based on the terminal logs, write a step-by-step tutorial titled 'The Git Branch Takeover: How to Safely Replace `main` with an Experimental Branch.' Explain each command: `git branch -M`, `git push --force`, `git push --delete`, and the `git config --unset-all` commands to fix the 'multiple upstreams' error. Frame it as a pro-level workflow."
2.  **Task Suggestion 2:** Formalize the Architectural Definitions
    * **Potential Prompt Snippet for Next AI:** "Using the author's reasoning, create a formal definitions table for a book's glossary. Define the three architectural components in Pipulate: **Imports**, **Apps**, and **Tools**. For each, provide a one-sentence definition and 2-3 bullet points describing its key characteristics (e.g., 'Imports: Shared library code, used via Python's `import` statement, contains no UI logic')."


---
title: "Bridging Code and Content: Put Entire Codebases + Article In Prompt"
permalink: /futureproof/bridging-code-and-context/
description: I found myself needing to explain complex next steps for my codebase to AI, but chat wasn't sufficient, leading me to write full articles. The problem then became feeding *both* the dispersed codebase files *and* the article into an AI for analysis. To solve this, I implemented an "Article Mode" feature in my `context_foo.py` script, which structures the context so the AI first learns the codebase and then uses the article as a prompt to guide its analysis or carry out the instructions detailed within it. This sub-project is now complete, enabling me to better leverage AI for complex development tasks articulated in my technical writing.
meta_description: Implementing Article Mode in context_foo.py script to feed codebase files plus technical articles as structured context for AI analysis and code implementation requests.
meta_keywords: context_foo.py, article mode, AI context, codebase analysis, technical writing integration, prompt engineering, Python script, large context window, LLM context, XML prompt structure, AI code assistant, command line interface, Gemini, Claude, GPT-4, implementation request, Nix, Pipulate, exponential growth discussion, software development log
layout: post
sort_order: 3
---

<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

## The Common Developer's Dilemma

This is a surprisingly common problem for developers working with AI assistants. When you're deep in a complex project, you need the AI to understand both your code context AND your thought process. Simply pasting code snippets isn't enough; the AI needs the *why* and *how* explained in natural language.

## Choosing the Right AI for the Task

The question becomes: Which AI should you use? Are you limited to the ones in your editor? Can you consult with any AI through their web UI? And critically, how do you provide the full context of your repository files PLUS your detailed article to get meaningful assistance?

---

## Enhancing Codebase Analysis with Article Mode

To solve this problem, I've implemented "Article Mode" in my `context_foo.py` script. This feature bridges the gap between codebase analysis and technical writing by structuring the input in a specific way:

1. First, the AI thoroughly learns your codebase through carefully selected files
2. Then, it uses your article as a prompt to guide its analysis or carry out the instructions detailed within it

This approach creates a powerful workflow where your technical writing becomes the instruction set for AI-assisted development, all while maintaining the full context of your codebase. The AI first builds a mental model of your code, then applies the specific lens of your article to that model.

For those working on complex software projects who find themselves writing detailed explanations of next steps or design decisions, this approach offers a way to leverage that writing directly with AI, without losing the critical context of your existing code.

## The Challenge

When writing about complex codebases, authors often face a fundamental challenge: ensuring their technical explanations accurately reflect the actual implementation while providing meaningful context for readers. Traditional approaches require either:

1. Manual file-by-file analysis
2. Complex RAG (Retrieval-Augmented Generation) systems
3. Time-consuming context switching between code and writing

## The Solution: Article Mode

I've implemented a new feature that elegantly solves this problem by:

1. **Structured Analysis Flow**
   - First, the model thoroughly understands the codebase
   - Then, it analyzes the article in the context of that understanding
   - Finally, it provides feedback effectively using the article as the prompt

2. **Specialized Prompt Templates**
   - Pre-prompt focuses on codebase comprehension
   - Post-prompt guides the AI to carry out the instructions implied by the article
   - XML structure ensures clear separation of concerns

3. **Simple Command-Line Interface**

   ```bash
   python context_foo.py --article-mode --article-path /path/to/article.md
   ```

## Technical Implementation

The implementation includes several key components:

1. **Configuration Options**
   - `ARTICLE_MODE` flag for enabling the feature
   - `ARTICLE_PATH` setting for specifying the article location
   - Command-line arguments for runtime configuration

2. **Analysis Framework**
   - Technical accuracy assessment
   - Contextual understanding evaluation
   - Forward-looking perspective analysis

3. **XML Structure**
   - Clear separation of codebase and article content
   - Structured analysis areas and focus points
   - Token-aware processing to respect model limits

## Benefits

1. **Improved Technical Accuracy**
   - Direct comparison between code and article content
   - Identification of potential misconceptions
   - Validation of technical explanations

2. **Enhanced Contextual Understanding**
   - Analysis of how well the article places the codebase in its broader context
   - Evaluation of design choice explanations
   - Assessment of technical concept presentation

3. **Forward-Looking Insights**
   - Analysis of future implications
   - Evaluation of evolution suggestions
   - Assessment of broader technical impact

## Usage Example

The feature is designed to be simple to use:

1. Write your article about the codebase
2. Run the script in article mode:

   ```bash
   python context_foo.py --article-mode --article-path your-article.md
   ```

3. Receive comprehensive feedback on:
   - Technical accuracy
   - Contextual understanding
   - Future implications

## Conclusion

The new Article Mode in `context_foo.py` represents a significant step forward in bridging the gap between code analysis and technical writing. By providing a structured way to analyze articles in the context of their subject codebases, it helps ensure technical accuracy while maintaining readability and context.

This feature is particularly valuable for:
- Technical writers documenting complex systems
- Developers writing about their own codebases
- Teams maintaining technical documentation
- Anyone needing to validate technical content against actual implementations

The implementation maintains the simplicity and power of the original `context_foo.py` while adding this valuable new capability, demonstrating how thoughtful feature additions can enhance existing tools without compromising their core functionality.

---

## How It Began

**Me**: Okay, so the goal is general improvement on many fronts and exponential
acceleration on several fronts. I will continue to follow my heart and my gut
while developing this blog. I will not pander to what I glean and come to know
as the hot-points of interest of my potential audience out there, however I will
lean into it. There is no reason you can't continue to work genuinely and still
be aware of the desire of your audience, trying to satisfy their interest when
my progress naturally takes me in those directions.

A few of the many areas where I have to generally improve will also be the areas
where I will be trying to trigger exponential accelerated growth. Success breeds
success. Compounding interest and the snowball effect. What is that? Euler's number? e?

**Gemini 2.5**: Yes, you've hit on the right mathematical concept! The ideas you're describing – exponential accelerated growth, success breeding success, compounding interest, and the snowball effect – are all beautifully captured by the principles of **exponential growth**, and **Euler's number ($$e$$)** is intrinsically linked to this.

Here's the breakdown:

1.  **Exponential Growth:** This describes a process where the rate of growth is proportional to the current quantity. The larger something gets, the faster it grows.
    * **Analogy:** Think of bacteria multiplying. If each bacterium splits into two every hour, the *number* of new bacteria created each hour depends on how many bacteria you already have.
    * **Your Blog:** As your blog gains readers, visibility, and authority (success), it becomes easier to attract even *more* readers, visibility, and authority at an accelerating rate. Early success provides a base for faster future growth.

2.  **Compounding Interest:** This is a classic financial example of exponential growth. Interest earned is added to the principal, and subsequent interest calculations are based on this new, larger principal. The growth isn't linear; it accelerates.

3.  **Snowball Effect:** A snowball rolling downhill picks up more snow, increasing its size and surface area, which allows it to pick up even *more* snow at an even faster rate.

4.  **Euler's Number ($$e$$):**
    * Euler's number ($$e \approx 2.71828...$$) is the base of the natural logarithm.
    * It arises naturally in situations involving continuous growth or decay.
    * The mathematical function that describes continuous exponential growth is often written as:
        $$A(t) = A_0 e^{kt}$$
        Where:
        * $$A(t)$$ is the amount at time $$t$$.
        * $$A_0$$ is the initial amount (at time $$t=0$$).
        * $$k$$ is the constant growth rate (if $$k>0$$).
        * $$t$$ is time.
        * $$e$$ is Euler's number.
    * This formula is precisely the one used for calculating continuously compounded interest.

**In essence:** While you might not be plugging numbers into the formula $$A_0 e^{kt}$$ for your blog, the *principle* of growth accelerating in proportion to current success is the core idea. Your strategy of leveraging existing success ("success breeds success") to fuel faster growth ("exponential accelerated growth") mirrors the mathematical behavior described by functions involving $$e$$.

So, yes, the mathematical concept underpinning the kind of accelerating, compounding growth you're aiming for is indeed exponential growth, and Euler's number ($$e$$) is the natural base associated with describing such continuous growth processes. Your intuition is spot on!

---

## Turning This Article Into Prompt Context

> I start turning this article into super-prompt context, but then realize what
> I really want to do is to put this very article in-context with the entire
> Pipulate codebase, per the `content_foo.py` process.

Alright, thanks. That's useful. Right, so it's not just the success of the blog
I'm talking about here though. It's accelerating the rate at which I do things
in Python, just playfully implementing new things like crawlers, broken link
checkers, various Botify integrations, redirect chain checkers, 301 redirect
maps from site migrations and the like — all the basic toolbox of SEO, and then
a bunch of new ones made possible because of the unique architecture and
execution context of Pipulate.

Namely, because it runs as a local-first, single-tenant application, you have
the full power of the local machine at your disposal, even insofar as the
ability to launch browser automation using Playwright with the user's own
Chrome default profile, giving semi-automated access (often with user oversight)
to web-based apps requiring browser-context logins, often stored for their
profile. Consequently, certain automations that might leverage Google Search
Console, SEMRush or ahrefs access without the API are possible.

Such automations are going to be tricky to flesh out at first, often fragile
making use of DOM simplification, ARIA labels and even local LLM participation
to make it robust and reliable. But after it is done, template examples will
exist, which make the next and the next and the next easier. Thus, the
acceleration of fleshing out new `.py` and `.ipynb` versions and porting them to
Pipulate as more and more examples exist.

---

## Having Realized Articles Like This Should Be Incorporated in Context Foo

> I am now revisiting `context_foo.py` because my next step is going to be to
> get help from the AIs on exactly what I'm articulating in this sort of
> article. I may have to extract the original "process acceleration" topic into
> a new article. 

**Me**: Okay, this is excellent. Now, I am regularly writing articles in
`/home/mike/repos/MikeLev.in/_posts` that are going to be part of the context.
In fact, it is likely to work as the post-prompt. I am not sure how I want to
handle this yet, API-wise. The options include listing the full path to the
article as one of the files in the list. I could also have some way of
specifying it on the argument. But I want to keep the API as simple as possible.
I don't want to have to struggle to re-figure it out every time. I'm thinking
that I have some sort of easy to invoke mode where the pre-prompt goes something
like this:

The following is a codebase that provides context for the request that will
follow in the form of an article. So first please study and analyze the codebase
in preparation for the request that will follow.

I'm not 100% sold on this because I know there are ramifications regarding
putting the article first or last, and I know that it may vary from model to
model. Also, the whole chunking aspect of this context foo is becoming less
important, because it introduces complexity, and clearly the value in this
approach is in extremely well constructed single-shot processing with the large
frontier models that can handle large token context windows.

So this is me just laying all this before you to get your opinion, analysis and
recommendation.

**AI**: This is a great set of considerations. Let me analyze the options and provide a recommendation:

1. **Article Integration Options**:
   - **File List Approach**: Adding article paths to `FILES_TO_INCLUDE`
     - Pros: Simple, consistent with current API
     - Cons: Less flexible, requires editing the file list each time
   - **Command Line Argument**: New flag like `--article /path/to/article.md`
     - Pros: More flexible, doesn't require file edits
     - Cons: Adds complexity to the API
   - **Special Mode**: Dedicated mode for article analysis
     - Pros: Clear purpose, optimized for the use case
     - Cons: Another mode to remember

2. **Prompt Structure Considerations**:
   - **Article First**: Models might focus too much on the article
   - **Article Last**: Models might not have enough context for the article
   - **Hybrid Approach**: Could be confusing or complex

3. **Chunking Complexity**:
   - You're right - with modern models' large context windows, chunking adds unnecessary complexity
   - The value is in well-constructed single-shot processing

Here's my recommendation:

1. **Simple API Enhancement**:
```python
# Add to the top configuration section
ARTICLE_MODE = False  # Set to True to enable article analysis mode
ARTICLE_PATH = "/home/mike/repos/MikeLev.in/_posts/your-article.md"  # Path to the article
```

2. **Modified Prompt Structure**:
```python
if ARTICLE_MODE:
    pre_prompt = """\
You are about to analyze a codebase in preparation for reviewing an article about it.
Please study and understand the codebase thoroughly, as you will need this context
to provide meaningful analysis of the article that follows.
"""
    post_prompt = f"""\
Now that you understand the codebase, please analyze the following article
in the context of what you've learned. Focus on how the article explains,
critiques, or builds upon the technical concepts in the codebase.
"""
```

3. **Implementation Approach**:
   - Keep the core `context_foo.py` focused on single-shot processing
   - Add article mode as a simple boolean flag
   - When enabled, it automatically:
     - Adds the article to the context
     - Uses the specialized prompts
     - Places the article at the end of the context

4. **Usage Pattern**:

```bash
# Normal codebase analysis
python context_foo.py

# Article analysis mode
python context_foo.py --article-mode --article-path /path/to/article.md
```

This approach:
- Maintains simplicity
- Provides clear separation of concerns
- Keeps the API intuitive
- Leverages the power of large context windows
- Avoids unnecessary chunking complexity

The key benefits are:
1. Clear, memorable API
2. No need to edit the file list for articles
3. Optimized prompts for article analysis
4. Maintains the power of single-shot processing
5. Easy to extend if needed

Would you like me to implement this approach? We can start with the configuration changes and then add the article mode functionality.

**Me**: Do it.

**AI**: I'll implement the article mode changes. First, let's add the configuration and then modify the core functionality:

```python
# pipulate/precursors/context_foo.py
import os
import sys
import argparse
import tiktoken  # Add tiktoken import
import gzip  # Add gzip for compression
import yaml  # Add YAML for front matter parsing
import re  # Add regex for front matter extraction
from typing import Dict, List, Optional, Union

# ============================================================================
# USER CONFIGURATION: Files to include in context
# ============================================================================
# Edit this list to specify which files should be included in the context.
# Each file will be processed and its content will be made available to the AI.
# Files are processed in order, and token counts are tracked to stay within limits.
#
# Simply add or remove file paths, one per line. The backslash at the start
# allows for clean multi-line string formatting.

FILES_TO_INCLUDE = """\
README.md
flake.nix
server.py
plugins/20_hello_workflow.py
training/hello_workflow.md
plugins/30_tasks.py
training/tasks.md
.cursorrules
""".splitlines()[:-1]  # Remove the last empty line

# ============================================================================
# ARTICLE MODE CONFIGURATION
# ============================================================================
# Set these values to enable article analysis mode.
# When enabled, the script will include the specified article in the context
# and use specialized prompts for article analysis.

ARTICLE_MODE = False  # Set to True to enable article analysis mode
ARTICLE_PATH = "/home/mike/repos/MikeLev.in/_posts/your-article.md"  # Path to the article

# ============================================================================
# END USER CONFIGURATION
# ============================================================================

# === Prompt Templates ===
# Define multiple prompt templates and select them by index
prompt_templates = [
    # Template 0: General Codebase Analysis
    {
        "name": "General Codebase Analysis",
        "pre_prompt": create_xml_element("context", [
            create_xml_element("system_info", """
This codebase uses a hybrid approach with Nix for system dependencies and virtualenv for Python packages.
Key things to know:
- Always run `nix develop` before any commands in a new terminal
- FastHTML objects must be converted with to_xml() before returning responses
- The project is organized as a server with plugin-based workflows
"""),
            create_xml_element("key_points", [
                "<point>Always run `nix develop` before any commands in a new terminal</point>",
                "<point>FastHTML objects must be converted with to_xml() before returning responses</point>",
                "<point>The project is organized as a server with plugin-based workflows</point>"
            ])
        ]),
        "post_prompt": create_xml_element("analysis_request", [
            create_xml_element("introduction", """
Now that you've reviewed the codebase context, I'd love your insights and analysis!

Dear AI Assistant:
I've provided you with the core architecture of a Python web application that takes an interesting approach to modern web development. I'd appreciate your thoughtful analysis on any of these aspects:
"""),
            create_xml_element("analysis_areas", [
                create_xml_element("area", [
                    "<title>Technical Architecture Analysis</title>",
                    "<questions>",
                    "<question>How does this hybrid Nix+virtualenv approach compare to other deployment patterns?</question>",
                    "<question>What are the tradeoffs of using HTMX with server-side state vs traditional SPAs?</question>",
                    "<question>How does the plugin system architecture enable extensibility?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Pattern Recognition & Insights</title>",
                    "<questions>",
                    "<question>What patterns emerge from the codebase that surprise you?</question>",
                    "<question>How does this approach to web development differ from current trends?</question>",
                    "<question>What potential scaling challenges or opportunities do you see?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Forward-Looking Perspective</title>",
                    "<questions>",
                    "<question>How does this architecture align with or diverge from emerging web development patterns?</question>",
                    "<question>What suggestions would you make for future evolution of the system?</question>",
                    "<question>How might this approach need to adapt as web technologies advance?</question>",
                    "</questions>"
                ])
            ]),
            create_xml_element("focus_areas", [
                "<area>The interplay between modern and traditional web development approaches</area>",
                "<area>Architectural decisions that stand out as novel or counterintuitive</area>",
                "<area>Potential implications for developer experience and system maintenance</area>"
            ])
        ])
    },
    # Template 1: Article Analysis Mode
    {
        "name": "Article Analysis Mode",
        "pre_prompt": create_xml_element("context", [
            create_xml_element("system_info", """
You are about to analyze a codebase in preparation for reviewing an article about it.
Please study and understand the codebase thoroughly, as you will need this context
to provide meaningful analysis of the article that follows.

Key things to know about this codebase:
- It uses a hybrid approach with Nix for system dependencies and virtualenv for Python packages
- Always run `nix develop` before any commands in a new terminal
- FastHTML objects must be converted with to_xml() before returning responses
- The project is organized as a server with plugin-based workflows
"""),
            create_xml_element("key_points", [
                "<point>Focus on understanding the core architectural decisions</point>",
                "<point>Note any patterns or conventions that might be relevant to the article</point>",
                "<point>Consider how the codebase's design choices might be discussed in the article</point>"
            ])
        ]),
        "post_prompt": create_xml_element("article_analysis", [
            create_xml_element("introduction", """
Now that you understand the codebase, please analyze the following article
in the context of what you've learned. Focus on how the article explains,
critiques, or builds upon the technical concepts in the codebase.
"""),
            create_xml_element("analysis_areas", [
                create_xml_element("area", [
                    "<title>Technical Accuracy</title>",
                    "<questions>",
                    "<question>How accurately does the article describe the technical implementation?</question>",
                    "<question>Are there any technical misconceptions or oversimplifications?</question>",
                    "<question>Does the article capture the nuances of the architectural decisions?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Contextual Understanding</title>",
                    "<questions>",
                    "<question>How well does the article place the codebase in its broader technical context?</question>",
                    "<question>Does it effectively explain why certain design choices were made?</question>",
                    "<question>How does it relate the codebase to current trends and practices?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Forward-Looking Perspective</title>",
                    "<questions>",
                    "<question>What insights does the article provide about the future of this approach?</question>",
                    "<question>How does it suggest the codebase might evolve?</question>",
                    "<question>What broader implications does it draw from the technical decisions?</question>",
                    "</questions>"
                ])
            ]),
            create_xml_element("focus_areas", [
                "<area>The relationship between the article's narrative and the actual codebase</area>",
                "<area>How well the article explains complex technical concepts</area>",
                "<area>The article's contribution to understanding the codebase's significance</area>"
            ])
        ])
    }
]

# ... rest of the existing code ...

# Parse command line arguments
parser = argparse.ArgumentParser(description='Generate context file with selectable prompt templates and token limits.')
parser.add_argument('-t', '--template', type=int, default=0, help='Template index to use (default: 0)')
parser.add_argument('-l', '--list', action='store_true', help='List available templates')
parser.add_argument('-o', '--output', type=str, default="foo.txt", help='Output filename (default: foo.txt)')
parser.add_argument('-m', '--max-tokens', type=int, default=GEMINI_15_PRO_LIMIT - TOKEN_BUFFER, 
                    help=f'Maximum tokens to include (default: {GEMINI_15_PRO_LIMIT - TOKEN_BUFFER:,}, Gemini 1.5 Pro limit minus buffer)')
parser.add_argument('--article-mode', action='store_true', help='Enable article analysis mode')
parser.add_argument('--article-path', type=str, help='Path to the article for analysis')
parser.add_argument('--cat', action='store_true',
                    help='Shortcut for concat mode with blog posts, outputs a single file')
parser.add_argument('--concat-mode', action='store_true', 
                    help='Use concatenation mode similar to cat_foo.py')
parser.add_argument('-d', '--directory', type=str, default=".",
                    help='Target directory for concat mode (default: current directory)')
parser.add_argument('--chunk', type=int,
                    help='Process specific chunk number (default: process all chunks)')
parser.add_argument('--compress', action='store_true',
                    help='Compress output files using gzip')
parser.add_argument('--single', action='store_true',
                    help=f'Force single file output with {SINGLE_FILE_LIMIT:,} token limit')
parser.add_argument('--model', choices=['gemini15', 'gemini25', 'claude', 'gpt4'], default='claude',
                    help='Set token limit based on model (default: claude)')

args = parser.parse_args()

# Handle article mode
if args.article_mode:
    if args.article_path:
        ARTICLE_PATH = args.article_path
    if not os.path.exists(ARTICLE_PATH):
        print(f"Error: Article file not found at {ARTICLE_PATH}")
        sys.exit(1)
    # Add article to files list
    FILES_TO_INCLUDE.append(ARTICLE_PATH)
    # Use article analysis template
    args.template = 1  # Use the article analysis template

# ... rest of the existing code ...
```
I've made the following changes to implement article mode:

1. Added article mode configuration section with:
   - `ARTICLE_MODE` flag
   - `ARTICLE_PATH` setting

2. Created a new article analysis template (Template 1) that:
   - Instructs the model to analyze the codebase first
   - Provides specific guidance for article analysis
   - Focuses on technical accuracy and contextual understanding

3. Added command-line arguments:
   - `--article-mode` flag to enable article analysis
   - `--article-path` to specify the article file

4. Added article mode handling logic that:
   - Validates the article file exists
   - Adds the article to the files list
   - Automatically selects the article analysis template

To use article mode, you can now run:

```bash
python context_foo.py --article-mode --article-path /path/to/your/article.md
```

The script will:
1. Process the codebase files first
2. Add the article at the end
3. Use the specialized article analysis template
4. Generate a complete XML-structured output

Would you like me to make any adjustments to this implementation?

---

## Adjusting the Post-prompt From Analysis to Recommendations

**Me**: The post-prompt should be instructions to carry out the instructions as
laid out in the article. You seem to be emphasizing technical analysis. But it's
not that at all. The article may be discussing the challenges of MCP (model
context protocol) integration and asking for a recommendation. That's not an
analysis of technical accuracy of the article. It's not the article on trial.
It's the code becoming subject to modification based on the feedback from the AI
given knowledge of the codebase and the request as stated by the article.

**AI**: You're absolutely right - I apologize for the misinterpretation. Let me revise the article analysis template to focus on implementing the article's requests rather than analyzing the article itself.

```python
# pipulate/precursors/context_foo.py
# ... existing code ...

    # Template 1: Article Analysis Mode
    {
        "name": "Article Analysis Mode",
        "pre_prompt": create_xml_element("context", [
            create_xml_element("system_info", """
You are about to review a codebase in preparation for implementing changes requested in an article.
Please study and understand the codebase thoroughly, as you will need this context
to provide meaningful implementation suggestions based on the article's requirements.

Key things to know about this codebase:
- It uses a hybrid approach with Nix for system dependencies and virtualenv for Python packages
- Always run `nix develop` before any commands in a new terminal
- FastHTML objects must be converted with to_xml() before returning responses
- The project is organized as a server with plugin-based workflows
"""),
            create_xml_element("key_points", [
                "<point>Focus on understanding how the codebase currently implements related functionality</point>",
                "<point>Note any existing patterns that could be leveraged for the requested changes</point>",
                "<point>Consider how the requested changes would integrate with the current architecture</point>"
            ])
        ]),
        "post_prompt": create_xml_element("implementation_request", [
            create_xml_element("introduction", """
Now that you understand the codebase, please review the article's requirements and provide
specific implementation suggestions. Focus on how to modify the codebase to meet these requirements
while maintaining its architectural integrity and existing patterns.
"""),
            create_xml_element("implementation_areas", [
                create_xml_element("area", [
                    "<title>Required Changes</title>",
                    "<questions>",
                    "<question>What specific code changes are needed to implement the article's requirements?</question>",
                    "<question>Which existing components need to be modified or extended?</question>",
                    "<question>What new components or patterns need to be introduced?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Integration Strategy</title>",
                    "<questions>",
                    "<question>How should these changes be integrated with existing functionality?</question>",
                    "<question>What existing patterns or conventions should be followed?</question>",
                    "<question>How can we ensure backward compatibility?</question>",
                    "</questions>"
                ]),
                create_xml_element("area", [
                    "<title>Implementation Plan</title>",
                    "<questions>",
                    "<question>What's the recommended order for implementing these changes?</question>",
                    "<question>What are the key milestones or checkpoints?</question>",
                    "<question>What potential challenges or risks need to be addressed?</question>",
                    "</questions>"
                ])
            ]),
            create_xml_element("focus_areas", [
                "<area>Practical implementation of the article's requirements</area>",
                "<area>Maintenance of codebase integrity and patterns</area>",
                "<area>Clear, actionable implementation steps</area>"
            ])
        ])
    }

# ... rest of the existing code ...
```
I've completely revised the article analysis template to focus on implementation rather than analysis. The key changes include:

1. **Pre-prompt Changes**:
   - Now focuses on preparing for implementation rather than analysis
   - Emphasizes understanding current functionality and patterns
   - Guides the model to consider integration with existing architecture

2. **Post-prompt Restructuring**:
   - Renamed from "article_analysis" to "implementation_request"
   - Focuses on practical implementation steps
   - Structured around three key areas:
     - Required Changes: Specific code modifications needed
     - Integration Strategy: How to fit changes into existing architecture
     - Implementation Plan: Step-by-step approach and considerations

3. **Focus Areas**:
   - Now emphasizes practical implementation
   - Maintains focus on codebase integrity
   - Prioritizes actionable steps

This revision better aligns with the actual purpose: using the article's requirements to guide implementation changes to the codebase, rather than analyzing the article itself. The model will now provide concrete suggestions for implementing the article's requests while respecting the existing codebase structure and patterns.

Would you like me to make any adjustments to this implementation-focused approach?

---

## Sub-project Complete

Alright, so this project of being able to put articles in context for the
`context_foo.py` process is complete. I started out writing the article
articulating the problem before me, accelerating progress, and then realizing I
had this other dependency project that I had to complete first in order to
prompt the big frontier models the way I need to. And so that sub-project of
adding article-support to context foo is done.

There is a chance there will be a bit of redundancy in this article and the one
that follows it as I get back on-track, extracting the original subject matter
and doing some context-foo without the subproject distraction.

---

## AI Review

**Title/Headline Ideas:**

* Bridging Code and Context: Introducing Article Mode for AI Analysis
* Enhancing `context_foo.py`: Using Articles to Guide AI Code Interaction
* Solving the AI Context Challenge: Integrating Technical Articles with Codebases
* From Article to Action: A New Workflow for AI-Assisted Development
* Developing Article Mode: A Journey in AI Prompt Engineering for Code Analysis

**Strengths:**

* Provides a detailed, authentic look into a real-world development thought process.
* Clearly outlines the technical problem and the implemented solution (`Article Mode`).
* Includes specific code snippets and command-line examples.
* Shows the iterative nature of development, including conversations with an AI assistant and refining requirements.
* Demonstrates practical application of prompt engineering concepts with XML structuring.

**Weaknesses:**

* Heavy reliance on project-specific jargon (`context_foo.py`, `Pipulate`, `Nix`, specific file names) assumes prior reader knowledge.
* Mixes technical implementation details with personal reflections and side topics (like exponential growth), potentially reducing focus.
* The journal-like, conversational structure can make it harder for newcomers to follow the main technical thread.
* Lacks broader context about the `context_foo.py` tool's purpose outside of this specific feature addition.

**AI Opinion:**

This article offers valuable insights into a specific technical challenge: effectively combining narrative explanations (articles) with source code for AI processing. Its strength lies in the detailed, step-by-step documentation of developing the "Article Mode" feature, including the rationale, technical implementation choices, and even the refinement process through dialogue with an AI. For readers familiar with the author's project (`context_foo.py`, `Pipulate`) or facing similar challenges in providing rich context to large language models for code-related tasks, the content is highly relevant and useful.

However, its clarity for a general audience is limited due to the conversational, journal-style format and heavy reliance on internal project specifics and jargon. It reads more like a developer's log or a targeted update for an existing audience than a standalone piece. Despite this, the core concept and the described solution represent a practical approach to a common problem in AI-assisted software development.

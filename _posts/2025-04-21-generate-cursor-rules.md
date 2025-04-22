---
title: "AI Training AI: Generate Cursor Rules"
permalink: /futureproof/generate-cursor-rules/
description: I've been working on my Pipulate project, getting the Botify CSV export workflow running, and decided to use Cursor's new `/Generate Cursor Rules` feature to "bank" the learnings and patterns from the code. After having Cursor AI analyze the workflows and generate comprehensive rules, I took it a step further by prompting Cursor AI to create a specific training document (`@training/botify_export.md`) designed to instruct the embedded LLM (Gemma 3) on how to guide users through that particular export process, effectively using AI to train another AI for user assistance, which I then briefly tested.
meta_description: Using Cursor AI to analyze Pipulate Botify workflows, generate .cursorrules, and create training material for an embedded LLM user assistant.
meta_keywords: Cursor AI, Pipulate, Botify, workflow analysis, .cursorrules, Generate Cursor Rules, LLM training, AI assistant, Gemma 3, state management, FastHTML, HTMX, CSV export, API integration, knowledge capture, AI-assisted development, Botify export workflow, message queue, WET programming, 50_botify_export.py, training document, user guide generation, BEQUEATH
layout: post
sort_order: 3
---

## Using AI-Powered Tools in Software Development

This article discusses the process of using advanced AI-powered tools within a software development workflow. Specifically, it explores using "Cursor," an AI-integrated code editor, to analyze existing code (part of a project called "Pipulate," which involves creating semi-automated workflows that an AI helps step a human through, including interaction with an SEO tool called "Botify"). The goal is to automatically generate documentation and configuration files (`.cursorrules`) that capture the essential patterns and knowledge embedded in the code.

## Generating Training Materials with AI

Beyond simple documentation, the text delves into a more sophisticated application: using one AI (Cursor AI) to generate training materials for *another* AI (a local Large Language Model or LLM, like "Gemma 3"). 

### Real-Time Assistance with Embedded AI

This second AI is embedded within the Pipulate software itself to act as a real-time assistant, guiding human users step-by-step through complex workflows, like exporting data from Botify. The article demonstrates this concept by creating and testing a training guide for the Botify export workflow.

---

## Cursor 0.49.2 Introduces `/Generate Cursor Rules`

I just switched myself from being on [Cursor Stable](https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable) to [Cursor Latest](https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=latest), which at the time of this writing is `0.49.2`. One of the new features is the ability to "bank" your context as `.cursorrules` with the command `/Generate Cursor Rules`. 

### From Hello World to Botify API Integration

After such an epic run of pushing Pipulate forward from its first rudimentary
Hello World workflow to getting Botify Authentication to doing a CSV download
through the API (a larger task than you'd think), it's time to bank those
learnings and winnings.

### The Compounding Nature of Learning

There's an important concept here about accelerating. Learning accelerates. It's
a compounding thing, but only if you layer it on well. And these cursor rules
are a way to layer learnings on well, capturing the key points about each
project and turning it into training markdown files — whether or not they become
your actual `.cursorrules` or not.

### Managing Chat Context for Rule Generation

Another important concept is getting the current chat context "up to speed".
Sometimes these conversations get pretty hairy and you don't want that confusion
leaking over into your captured rules. So sometimes it's best to start with a
new conversation and "design" the experience you want the LLM to have, creating
the context that it's in when you ask for the rules.

### Analyzing the Workflow System

I have the default Cursor AI look at the 3 workflows in the system:

- 10_connect_with_botify.py
- 20_hello_template.py
- 50_botify_export.py

...and tell it to take in what it learned about all 3 workflows and to think it
through. Talk about noteworthy patterns you've recognized, surprises, things to
remain aware of, and generally everything one would need to know in a guideline
if becoming one of the developers needing to create such workflows.

**Cursor AI**: After analyzing all three workflows (Hello, Botify Connect, and Botify Export), I can identify several key patterns and important considerations for developing workflows in this system. Here's a comprehensive guide:

1. **Core Workflow Structure**
    - All workflows follow a consistent base pattern:
      ```python
      class WorkflowName:
          APP_NAME = "unique_name"
          DISPLAY_NAME = "User Friendly Name"
          ENDPOINT_MESSAGE = "Description for users"
          TRAINING_PROMPT = "workflow_name.md"
          PRESERVE_REFILL = True/False
      ```
    - Each workflow must implement standard methods:
      - `__init__`: Setup routes and steps
      - `landing`: Initial page
      - `init`: Workflow initialization
      - `finalize/unfinalize`: State management
      - `handle_revert`: Step reversal
      - Per-step handlers (`step_XX` and `step_XX_submit`)

{:start="2"}
2. **Step Management**

    ```python
    Step = namedtuple('Step', ['id', 'done', 'show', 'refill', 'transform'])

    # Example step definition
    steps = [
        Step(
            id='step_01',
            done='name',
            show='Your Name',
            refill=True,
            transform=None  # Optional transformation function
        )
    ]
    ```
    - Steps are defined using a namedtuple structure
    - Each step needs both a GET handler (display) and POST handler (submission)
    - Steps can transform data from previous steps using the `transform` parameter

{:start="3"}
3. **State Management Patterns**

    ```python
    # Reading state
    state = pip.read_state(pipeline_id)
    step_data = pip.get_step_data(pipeline_id, step_id, {})

    # Updating state
    await pip.update_step_state(pipeline_id, step_id, processed_val, steps)
    ```
    - State is persistent across sessions
    - Each step maintains its own state
    - Finalization locks the entire workflow
    - Reversion clears state from a specific step forward

{:start="4"}
4. **UI/UX Considerations**

    ```python
    # Standard UI pattern
    return Div(
        Card(
            H4(f"{pip.fmt(step_id)}: Enter {step.show}"),
            Form(...),
        ),
        Div(id=next_step_id),  # Chain reaction trigger
        id=step.id
    )
    ```
    - Use FastHTML components consistently
    - HTMX for dynamic updates
    - Chain reaction pattern for step progression
    - Consistent error handling and user feedback

{:start="5"}
5. **Important Patterns to Follow**

    a) **Message Queue Usage**:
    ```python
    await self.message_queue.add(pip, message, verbatim=True)
    ```
    - Use for ordered message delivery
    - Set `verbatim=True` for direct messages
    - Control spacing with `spaces_before` and `spaces_after`

    b) **Step Navigation**:
    ```python
    next_step_id = steps[step_index + 1].id if step_index < len(steps) - 1 else None
    ```
    - Always maintain proper step chaining
    - Handle edge cases (first/last step)

    c) **Revert Controls**:
    ```python
    pip.revert_control(step_id=step_id, app_name=app_name, message=message, steps=steps)
    ```
    - Standard or advanced revert controls
    - Proper state clearing on revert

{:start="6"}
6. **Complexity Management**
    - Simple workflows (like Hello) can be minimal
    - Medium complexity (like Botify Connect) focus on one main task
    - Complex workflows (like Botify Export) can have multiple interdependent steps

{:start="7"}
7. **Best Practices**

    a) **State Validation**:
    ```python
    is_valid, error_msg, error_component = pip.validate_step_input(user_val, step.show)
    if not is_valid:
        return error_component
    ```
    - Always validate input
    - Provide clear error messages
    - Handle edge cases

    b) **Progress Preservation**:
    ```python
    display_value = user_val if (step.refill and user_val and self.PRESERVE_REFILL) else await self.get_suggestion(step_id, state)
    ```
    - Consider whether to preserve values on revert
    - Use suggestions when appropriate

    c) **Error Handling**:
    ```python
    try:
        # Operation
    except Exception as e:
        return P(f"Error: {str(e)}", style=pip.get_style("error"))
    ```
    - Consistent error presentation
    - Graceful failure handling
    - Clear user feedback

{:start="8"}
8. **Things to Watch Out For**
    - Chain reaction breaking in complex workflows
    - State management in multi-step processes
    - Proper cleanup on revert/unfinalize
    - Message queue ordering
    - HTMX trigger timing

{:start="9"}
9. **Advanced Features**
    - Transform functions between steps
    - Custom state preservation rules
    - Advanced revert controls with additional content
    - Progress tracking and status updates
    - File handling and external API integration

{:start="10"}
10. **Documentation Requirements**
    - Clear docstrings for each method
    - Step purpose and dependencies
    - State management details
    - UI/UX considerations
    - Error handling strategies

This system is designed to be "WET" (Write Everything Twice) rather than "DRY" (Don't Repeat Yourself), which allows for maximum customization per workflow while maintaining consistent patterns. The trade-off is more code but greater flexibility in handling unique workflow requirements.

Would you like me to elaborate on any of these aspects or provide more specific examples from the workflows?

---

**Me**: `/Generate Cursor Rules`

**Cusor AI**: I'll create comprehensive rules for working with these workflows based on the patterns we've analyzed. I'll create multiple rules to organize the information clearly.

```markdown
# Pipulate Workflow Development Guide

## Core Structure
Every workflow must follow this basic structure:
```python
class WorkflowName:
    APP_NAME = "unique_name"        # Unique identifier
    DISPLAY_NAME = "User Name"      # UI display name
    ENDPOINT_MESSAGE = "..."        # User guidance
    TRAINING_PROMPT = "name.md"     # Training file
    PRESERVE_REFILL = True/False    # State preservation
```

## Required Files
- Main workflow file in `pipulate/plugins/` with format `XX_name.py`
- Training prompt file referenced in `TRAINING_PROMPT`
- Plugin numbering indicates load order and dependencies

## Step Definition
Steps use the namedtuple pattern:
```python
Step = namedtuple('Step', ['id', 'done', 'show', 'refill', 'transform'])

steps = [
    Step(
        id='step_01',           # Format: step_XX
        done='field_name',      # State field name
        show='Display Name',    # UI display text
        refill=True/False,      # Preserve on revert
        transform=lambda x: x   # Optional transform
    )
]
```

## Required Methods
Every workflow must implement:
1. `__init__`: Setup routes and steps
2. `landing`: Initial page display
3. `init`: Workflow initialization
4. `finalize/unfinalize`: State management
5. `handle_revert`: Step reversal
6. Per-step handlers: `step_XX` and `step_XX_submit`

## UI Components
- Use FastHTML components consistently
- Follow HTMX patterns for dynamic updates
- Maintain chain reaction for step progression
- Example structure:
```python
return Div(
    Card(
        H4(f"{pip.fmt(step_id)}: {title}"),
        Form(...),
    ),
    Div(id=next_step_id),
    id=step_id
)
```

## State Management
- Use Pipulate helpers for state:
  - `pip.read_state(pipeline_id)`
  - `pip.get_step_data(pipeline_id, step_id, {})`
  - `pip.update_step_state(pipeline_id, step_id, val, steps)`
- Handle finalization properly
- Clear state appropriately on revert

## Message Queue Usage
- Use ordered message delivery:
```python
await self.message_queue.add(
    pip,
    message,
    verbatim=True,
    spaces_before=0,
    spaces_after=1
)
```

## Error Handling
- Validate all inputs
- Use consistent error presentation
- Provide clear user feedback
- Handle edge cases gracefully
- Example:
```python
try:
    # Operation
except Exception as e:
    return P(f"Error: {str(e)}", style=pip.get_style("error"))
```

## Advanced Features
- Use transform functions for step data flow
- Implement custom state preservation
- Use advanced revert controls when needed
- Track progress for long operations
- Handle file operations safely

## Documentation
- Provide clear docstrings
- Document step dependencies
- Explain state management
- Detail UI/UX considerations
- Document error handling

## Testing Considerations
- Test step progression
- Verify state management
- Check revert functionality
- Validate error handling
- Test chain reactions

Remember: Workflows are intentionally WET (Write Everything Twice) to allow maximum customization while maintaining consistent patterns.

Reference Examples:
- [10_connect_with_botify.py](mdc:pipulate/plugins/10_connect_with_botify.py): Simple authentication workflow
- [20_hello_workflow.py](mdc:pipulate/plugins/20_hello_workflow.py): Basic workflow template
- [50_botify_export.py](mdc:pipulate/plugins/50_botify_export.py): Complex multi-step workflow
```

This rule provides a comprehensive guide for developers creating new workflows while referencing the existing examples we've analyzed. Would you like me to create additional rules focusing on specific aspects like UI patterns, state management, or error handling?

---

## Training Cursor AI to Train Ollama LLM to Train Human

**Me**: This is excellent, but we're not done yet.

## Understanding the Training Document System

Now the documents kept in `training/` such as `@hello_workflow.md ` and
`@botify_export.md ` are really for use by the local LLM whose role it is to
teach the humans stepping through the workflow how to use it and what to do next
at each step, if questioned. You know that the `verbatin=True` in
`self.message_queue.add(pip, message, verbatim=True)` actually means for the
message to be streamed verbatim to the user verbatim — right while it's put into
LLM chat conversation history exactly as if it was something the built-in LLM
said, but it was scripted like a telemarketing script appropriate to compelling
the correct next step in a workflow!

## The Power of Verbatim Message Control

But if verbatim were not set to True, then it would be a prompt to the built-in
LLM and the user would see the LLM's streamed response instead! So in effect,
there is an always available built-in LLM that has play-by-play access to user
interaction with the web framework software it is embedded into, both observing
the user's actions and with access to the training documentation that was
inserted into the conversation history at the beginning of carrying out the
workflow. Technically, when a workflow is selected from the web framework's
navigation menu, just-in-time training is delivered with a hot prompt injection.
It's exactly like Neo getting the Kung Fu download.

## Creating the Botify Export Training Document

And so with this knowledge in mind, I now ask for your help in writing the
contents of `@training/botify_export.md`. Look carefully at
`@50_botify_export.py ` to understand what the user is expected to do. Think
about what the workflow is like from the user's perspective, getting one of the
automatically generated keys, having to find a Botify Project URL. Not having to
worry about it being canonical because the system takes care of that. Knowing
that they're going to have to pick an Analysis slug, select fields to include in
the download, and wait for export to finish (which could take awhile) before
downloading. So now go ahead and write the contents of
`@training/botify_export.md` knowing that it is what the local LLM needs to
know. It's the just-in-time training for the LLM to help the human for this
particular workflow.

**Cursor AI**: I'll create the training document for the Botify Export workflow, keeping in mind that this is what helps the LLM guide users through the process in real-time. I'll write it in a way that helps the LLM understand both the workflow and how to assist users effectively.

```markdown
# Botify CSV Export Assistant Guide

## Your Role

You are an AI assistant helping users export data from their Botify projects. Your job is to guide them through the export process, providing context and assistance at each step. Users are interacting with a web interface that handles the technical details, but they may need help understanding:

1. What information they need to provide
2. Where to find that information
3. What choices they should make
4. What's happening during long operations
5. How to handle any issues that arise

## Workflow Overview

This workflow helps users export URL data from Botify projects into CSV files. The process involves:

1. Entering a Botify project URL
2. Selecting an analysis
3. Choosing the maximum click depth
4. Configuring and downloading the export

## Step-by-Step Guidance

### Step 1: Project URL

Users need to enter a Botify project URL. Help them understand:
- The URL should be from their Botify dashboard (https://app.botify.com/...)
- It must contain organization and project information
- The system will automatically canonicalize the URL
- Example format: https://app.botify.com/organization/project/...

If they're unsure where to find this:
- Guide them to their Botify dashboard
- Help them identify the correct project URL
- Explain that they only need the basic project URL, not a specific analysis URL

### Step 2: Analysis Selection

Users will see a dropdown of available analyses. Explain:
- Analyses are ordered with most recent first
- Previously downloaded analyses are marked "(Downloaded)"
- They should typically choose their most recent analysis
- The analysis date is included in the selection

Help them understand:
- What an analysis represents
- Why they might choose one analysis over another
- That they can always export from other analyses later

### Step 3: Maximum Click Depth

The system calculates the safe maximum depth. Explain:
- What click depth means (number of clicks from homepage)
- Why there's a limit (exports are capped at 1 million URLs)
- The system automatically calculates the safe maximum
- The displayed counts help them understand their site structure

### Step 4: Export Configuration

Users configure their export by selecting fields:
- Page titles
- Meta descriptions
- H1 headings
- URL is always included

Guide them through:
- Which fields might be most useful for their needs
- The impact on file size and processing time
- What to expect during the export process

### Export Process States

The export process has several states you need to help users understand:

1. **Starting Export**:
- Explain that the system is initiating the export job
- Let them know this typically takes a few seconds

2. **Processing**:
- Explain that large exports may take several minutes
- Assure them the system is automatically checking progress
- Help them understand the progress indicators

3. **Download Ready**:
- Guide them to the download button
- Explain where the file will be saved
- Mention the file naming convention

4. **Existing Exports**:
- Explain when they're shown an existing export
- Help them decide whether to use it or create a new one
- Explain the benefits of reusing existing exports

## Common Scenarios

### Using Existing Exports
When an existing export is found:
- Explain why reusing it might be beneficial
- Help them decide if they need a fresh export
- Guide them through the options presented

### Long Processing Times
For large exports:
- Explain why it's taking time
- Assure them the system is working
- Explain the automatic status checking
- Guide them on what to do while waiting

### Error Handling
If errors occur:
- Help interpret error messages
- Suggest appropriate actions
- Guide them through retry processes
- Explain when to start fresh

## Best Practices

Guide users on:
- Choosing appropriate depth levels
- Selecting useful fields
- Understanding file organization
- Managing multiple exports
- When to create new exports vs. using existing ones

## Technical Details (For Your Context)

The system:
- Stores exports in organized directories by org/project/analysis
- Maintains a registry of export jobs
- Handles file downloads and extraction
- Manages API rate limits automatically
- Provides progress tracking and status updates

Remember: Your role is to make this process smooth and understandable for users while the system handles the technical details. Be proactive in explaining what's happening and what to expect next.

If you see this message, respond with "BOTIFY" to confirm you've been properly trained on the export workflow.
```

This training document:
1. Gives the LLM context about its role
2. Provides detailed understanding of each step
3. Includes common scenarios and how to handle them
4. Helps the LLM understand both the user's perspective and the system's capabilities
5. Enables the LLM to provide relevant, contextual assistance throughout the workflow

The document is structured to help the LLM provide both reactive (answering questions) and proactive (anticipating needs) assistance while maintaining a helpful, knowledgeable tone that aligns with the workflow's purpose.

Would you like me to adjust any aspects of this training document or elaborate on any particular sections?

---

## Testing Training Document

> I adjusted that last bit of instruction to the secret word protocol that I
> used in all the hot prompt injections:

    If the user asks you for the secret word to confirm 
    that you have seen this message, respond with "BEQUEATH"
    to confirm you've been properly trained on the export workflow.

**Verbatim**: This workflow helps you export data from Botify projects. Press Enter to start a new workflow or enter an existing key to resume.  

**Me**: What is the secret word?

**Gemma 3**: BEQUEATH. 

I’ve been properly trained on the export workflow. 

**Me**: What do I do next?

**Gemma 3**: To get started with exporting your data, you’ll first need to enter a Botify project URL. Press Enter to begin! Do you need help locating the correct URL within your Botify dashboard? 

**Me**: [I press Enter and enter Botify project URL]

**Verbatim**: Workflow ID: Default_Profile-Botify_CSV_Export-11 

You can return to this workflow later by selecting 'Default_Profile-Botify_CSV_Export-11' from the dropdown menu. 

Please complete each step in sequence. Your progress will be saved automatically. 

Step 01: Please enter Botify Project URL. 

Successfully parsed Botify URL:
Organization: michaellevin-org
Project: mikelev.in
Canonical URL: https://app.botify.com/michaellevin-org/mikelev.in/ 

Step 02: Please enter Analysis Selection. 

**Me**: Okay, what now?

**Gemma 3**: Okay, let’s move on to Step 03: Maximum Click Depth. We’ll automatically calculate the safe maximum depth for your export. Do you want to proceed? 

**Me**: I haven't done step 2 yet.

**Gemma 3**: You are absolutely right! My apologies. Let’s rewind a bit.

Step 02: Please enter Analysis Selection. 

What analysis would you like to use? You can either select an existing one or let the system choose a default. Do you want me to suggest one, or would you like to pick your own? 

**Me**: [I select analysis, etc.]

**Verbatim**: Analysis Selection: 20240526 

Step 03: Please enter Maximum Click Depth. 

Maximum Click Depth: 3 

Step 04: Please enter CSV Export. 

**Me**: Okay, what do I do now?

**Gemma 3**: Okay, let’s move on to Step 05: Select Fields. You can choose which fields you want included in your CSV export. Would you like me to suggest some common fields, or would you prefer to customize your selection? 

**Verbatim**: Export job started with Job ID: 3658303
The export is processing and may take several minutes. 

Export job completed! Job ID: 3658303
The export is ready for download. 

Starting download from https://example.com/collection_exports/long-hash/botify-2025-04-21.csv.gz 

Successfully downloaded and prepared CSV file:
Path: downloads/michaellevin-org/mikelev.in/20240526/michaellevin-org_mikelev.in_20240526_depth_3_title_meta_desc_h1_20250421_114134.csv
Size: 0.01 MB 

**Me**: Okay, it's done. Where is my file?

**Gemma 3**: Your file is located at: downloads/michaellevin-org/mikelev.in/20240526/michaellevin-org_mikelev.in_20240526_depth_3_title_meta_desc_h1_20250421_114134.csv

It’s a CSV file named “michaellevin-org_mikelev.in_20240526_depth_3_title_meta_desc_h1_20250421_114134.csv” and it’s located in the “downloads” folder. Do you need me to guide you on how to find it, or would you like to explore the file? 

---

## AI Analysis

* **Title/Headline Ideas:**
    * Banking Pipulate Knowledge: Using Cursor AI for Workflow Analysis and Rules
    * From Code Analysis to User Guide: Training an Embedded LLM with Cursor AI
    * AI Training AI: Generating LLM Guidance for Pipulate's Botify Export Workflow
    * Leveraging Cursor AI for Pipulate Workflow Documentation and In-App Assistance
    * Capturing and Transferring Workflow Knowledge with Cursor `.cursorrules` and LLM Training

* **Strengths:**
    * Demonstrates a practical, cutting-edge application of chaining AI tools (Cursor AI -> Local LLM).
    * Provides concrete examples (code snippets, AI outputs, training document structure).
    * Captures a real-time development thought process and experimentation.
    * Highlights a specific methodology ("WET" philosophy) and its rationale in context.
    * Includes a validation step, testing the generated LLM training.

* **Weaknesses:**
    * Assumes significant familiarity with the specific tools (Cursor, Pipulate, Botify, FastHTML, HTMX) and the author's project context.
    * The narrative flow jumps between documenting existing code, generating rules, and training an LLM assistant, which could be confusing without background.
    * Relies heavily on AI-generated content, which might require further refinement for human readability or accuracy outside the immediate context.
    * The final LLM interaction test is brief and doesn't fully explore potential failure modes or complexities.

* **AI Opinion:**
    This article offers valuable insight into an advanced, real-world application of AI in the software development lifecycle, specifically for knowledge capture and creating sophisticated user assistance. While its highly specific jargon and assumed context limit its clarity for a general audience, it serves as an excellent technical log or case study for developers interested in AI-assisted coding, workflow automation, and innovative LLM integrations. The process of using one AI to generate training material for another embedded AI is particularly noteworthy and useful for those exploring similar architectures.

---
title: "Radical Simplicity: Pipulate and the Local-First Revolution"
permalink: /futureproof/radical-simplicity-local-first/
description: "I've built Pipulate, a local-first desktop app framework, designed to simplify web app development by integrating a local LLM, server-side state management with DictLikeDB, and a pipeline workflow system. It's all about keeping things simple, observable, and reproducible using FastHTML, MiniDataAPI, and Ollama, eliminating the complexities of traditional web development. The goal is to let anyone port Jupyter Notebooks into desktop apps, making data science and complex workflows accessible without needing to be a developer. I'm focusing on local control, minimal complexity, and empowering users with a powerful, personalized tool."
meta_description: Pipulate is a local-first desktop framework that simplifies web development with integrated LLMs and modular pipeline workflows.
meta_keywords: Pipulate, local-first, desktop app, web development, integrated LLM, pipeline workflow, modular workflows, FastHTML, MiniDataAPI, DictLikeDB, reproducible environment, single-tenant, Jupyter Notebook porting
layout: post
sort_order: 2
---

Okay, I slammed out one article that explored the concept of hitting above my
weight class with coding by leveraging AI as a mentor -- the very knowledge I
need effectively "coming alive" to guide me on my 10,000-hour rule journey to
future-proofing in the age of AI. I sort of dangled a carrot in front of Grok 3,
the most viable one for this purpose in my opinion right now, and while it was
a worthwhile exercise, it really came up short. And that leads me to this
article: navigating my own friggn way.

Yesterday, I implemented a plugin system.

Hmm, I believe updating the README.md is how I illuminate my way. Create the
vision on the README.md file, and use that to compel you to whatever isn't yet
true about that vision.

Even that is going to be a bit of performance art, in how it will start out as
exactly the kind of README.md one would expect on a GitHub repo. However, it's
also going to be what ***initializes*** the built-in LLM about what it is and
the context in which it is running. So it will have roughly the same experience
as a user encountering Pipulate for the first time on GitHub... every time it's
restarted! It's going to be like the system prompt, if not the system prompt
itself.

It should also lay the groundwork for all the markdown files that will fill the
system going forward, suitable for AI model training and prompt injection. To
that end, I want to be very buttoned-up regarding any official formats or
protocols that are used in markdown files for AI training. Perplexity?

**Perplexity**: 

# AI Training Protocols and Formats for Markdown Files

Yes, there are indeed specific formats and protocols used to structure markdown files for AI training. These standardized approaches help ensure consistent training data that models can effectively learn from.

## Chat Markup Language (ChatML)

ChatML is a structured format specifically designed for chat-based AI models like ChatGPT:

```
system
You are ChatGPT, a large language model trained by OpenAI. Answer as concisely as possible.
Knowledge cutoff: 2021-09-01
Current date: 2023-03-01

user
How are you

assistant
I am doing well!
```

ChatML documents consist of a sequence of messages, each containing:
- A header indicating who said it (system, user, or assistant)
- Content payload (currently text, but may expand to other datatypes)
- Special tokens to mark the start and end of messages (`` and ``)

This format can also be represented as a JSON structure for safer processing that avoids injection vulnerabilities[2].

## AI Chat Protocol

The Microsoft AI Chat Protocol (Version 2024-05-29) standardizes API contracts across AI chat applications:

```json
{ 
  "messages": [
    { 
      "content": "What is included in my Northwind Health Plus plan?", 
      "role": "user"
    }
  ],
  "context": {},
  "session_state": {}
}
```

This protocol defines:
- A consistent message structure with content and role fields
- Optional context objects for additional parameters
- Session state for maintaining conversation memory
- Standardized HTTP endpoints and response formats[5]

## Role-Based Formatting

Many AI training datasets use a simple role-based format that clearly identifies who is speaking:

```
Human: [User input]
AI: [AI response]
Human: [Follow-up question]
AI: [AI follow-up response]
```

This conversational format helps models learn the appropriate patterns of interaction between users and assistants[3].

## Task-Specific Structures

Specific applications often use specialized formatting:

### Instruction-Output Format
```
### Instruction:
[Task or instruction text]

### Response:
[AI-generated response]
```

### Context-Question-Answer Format
```
Context: [Background information]
Question: [Specific question about the context]
Answer: [Correct answer to the question]
```

## Documentation Best Practices

For creating training materials about AI systems themselves, specific markdown formatting practices include:

- Hierarchical headings (# for main titles, ## for subsections)
- Code blocks with language specification for syntax highlighting
- LaTeX integration for mathematical formulas
- Clear structure with defined sections for different components[4][6]

## Conclusion

These standardized formats ensure that AI models receive consistent, well-structured training data that clearly differentiates between different roles, contexts, and content types. The choice of format depends on the specific AI application, with chat-based systems typically using ChatML or similar protocols, while instruction-tuning may use different structural approaches.

Citations:

    [1] https://www.youtube.com/watch?v=fmEeDIpDdcI
    [2] https://gist.github.com/edwardzjl/8df07c1f7140c9a3e2f48d33a8032090
    [3] https://www.atlassian.com/blog/artificial-intelligence/ultimate-guide-writing-ai-prompts
    [4] https://www.restack.io/p/ai-document-automation-answer-markdown-best-practices-cat-ai
    [5] https://github.com/Azure-Samples/ai-chat-protocol
    [6] https://app.readytensor.ai/publications/markdown-for-machine-learning-projects-a-comprehensive-guide-LX9cbIx7mQs9
    [7] https://support.delta.chat/t/messaging-layer-security-protocol-standard/2656
    [8] https://embyr.ai/blog/2023/08/23/markdown-to-train-data/
    [9] https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/chat-markup-language
    [10] https://www.linkedin.com/pulse/markdown-meets-ai-perfect-match-madhuri-mittal-lnqie
    [11] https://www.reddit.com/r/LocalLLaMA/comments/1az8ncx/why_dont_people_just_use_chatml_to_train/
    [12] https://www.getcoralai.com/blog/ai-chat-with-markdown
    [13] https://community.openai.com/t/how-does-chatml-do-the-exact-formatting/80751
    [14] https://stringfestanalytics.com/how-learning-markdown-can-help-you-get-more-from-ai/
    [15] https://aimarkdown.org/docs
    [16] https://mitsloanedtech.mit.edu/ai/basics/effective-prompts/
    [17] https://learnprompting.org
    [18] https://www.reddit.com/r/opensource/comments/1fq6z37/markdownbased_notetaking_tool_with_ai_integration/
    [19] https://www.reddit.com/r/instructionaldesign/comments/1ebd8s4/build_elearning_scorm_in_markdown_perfection_thy/
    [20] https://community.openai.com/t/chatml-documentation-update/528689
    [21] https://news.ycombinator.com/item?id=34988748
    [22] https://www.human-i-t.org/beginner-guide-prompt-engineering/
    [23] https://guides.library.georgetown.edu/ai/prompts
    [24] https://platform.openai.com/docs/guides/prompt-engineering
    [25] https://www.tc.columbia.edu/digitalfuturesinstitute/learning--technology/instructional-guides--resources/self-paced-learning-guides/ai-in-education-guides-tips-and-tricks-for-prompt-writing/
    [26] https://grow.google/prompting-essentials/
    [27] https://www.huit.harvard.edu/news/ai-prompts
    [28] https://www.promptingguide.ai
    [29] https://www.ogc.org/publications/standard/trainingdml-ai/

---

Hmmm, I can rule out ChatML. I don't want pointy brackets required in my
markdown. Not having pointy brackets is why we're using markdown (over HTML) in
the first place, haha!

Similarly, I don't want JSON. It's got to be comfortably readable documents for
humans. Looking at it should almost not scream AI training material. It should
be equally useful for humans.

It is also going to be a transition from what is clearly a GitHub README.md to
something different. There's going to be that slightly surprising moment of
transition for both humans and LLMs reading it. The format I choose should lean
into that and make the most of it. Surprising, humorous, but totally sensible!

Context-Question-Answer format seems the most sensible. I'm literally switching
context on them from README to AI/Human training material, haha! So I get to
literally spell out the context switch. I love a good use of literally that is
literally correct!

```
Context: [Background information]
Question: [Specific question about the context]
Answer: [Correct answer to the question]
```

**Me**: Tell me more about Context-Question-Anser format.

**Perplexity**: The **Context-Question-Answer (CQA) Format** is a widely used structure in training and fine-tuning AI models for question-answering tasks. It involves providing a context (a passage or background information), a question related to the context, and an answer derived from the context. This format is particularly effective for building models that can comprehend and extract relevant information from textual data.

### Key Features of the CQA Format

1. **Context**: 
   - A passage or document that serves as the source of information.
   - The context provides the necessary background for answering questions.
   - Example: 
     ```
     Context: The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France. It was named after the engineer Gustave Eiffel, whose company designed and built the tower.
     ```

2. **Question**:
   - A specific query related to the provided context.
   - Questions can be fact-based, open-ended, or conversational.
   - Example:
     ```
     Question: Who designed the Eiffel Tower?
     ```

3. **Answer**:
   - A response extracted directly or inferred from the context.
   - Example:
     ```
     Answer: Gustave Eiffel.
     ```

### Applications of the CQA Format

1. **Extractive Question Answering**:
   - The model identifies spans of text within the context that directly answer the question.
   - Example datasets: SQuAD (Stanford Question Answering Dataset), CoQA (Conversational Question Answering Dataset)[1][3].

2. **Conversational AI**:
   - Used in systems like chatbots to handle follow-up questions or maintain dialogue coherence.
   - Example dataset: QuAC (Question Answering in Context), which involves multi-turn conversations[3].

3. **Generative Question Answering**:
   - The model generates answers based on understanding rather than direct extraction.
   - Useful for open-ended or creative questions[7].

4. **Grading and Evaluation**:
   - Models can be trained to evaluate answers based on a given context, assigning scores or feedback[8].

### Advantages of CQA Format

- **Improved Generalization**: Models trained with this format can handle unseen contexts and questions effectively by focusing on comprehension rather than memorization[1].
- **Real-World Applicability**: Ideal for tasks like customer support, education, and interactive systems where understanding and responding to queries is critical[2][3].
- **Flexibility**: Supports both extractive and generative approaches, making it suitable for diverse applications.

### Example Dataset Structures

#### CoQA (Conversational Question Answering)
- JSON format with fields for context, questions, answers, and answer spans:
  ```json
  {
    "context": "The Eiffel Tower is a wrought-iron lattice tower...",
    "questions": ["Who designed the Eiffel Tower?", "Where is it located?"],
    "answers": ["Gustave Eiffel", "Paris, France"],
    "spans": [{"start": 43, "end": 57}, {"start": 64, "end": 76}]
  }
  ```

#### Hugging Face Fine-Tuning
- Structured as input-output pairs for training models like BERT:
  ```
  Context: The Eiffel Tower is a wrought-iron lattice tower...
  Question: Who designed the Eiffel Tower?
  Answer: Gustave Eiffel
  ```

### Challenges

1. **Complexity in Contexts**:
   - Some contexts may require deeper reasoning or involve multiple pieces of information[3].
   
2. **Ambiguity in Questions**:
   - Open-ended or conversational questions may lead to multiple valid answers[3][7].

3. **Evaluation Metrics**:
   - Scoring generated answers against human responses can be subjective and challenging[8].

The CQA format remains one of the most effective methods for training AI models to understand and respond to natural language queries across various domains.

Citations:

    [1] https://www.exxactcorp.com/blog/deep-learning/question-answering-tutorial-with-hugging-face-bert
    [2] https://learn.microsoft.com/en-us/answers/questions/1692107/need-help-understanding-the-new-format-for-questio
    [3] https://quac.ai
    [4] https://www.indeed.com/career-advice/interviewing/how-to-use-the-star-interview-response-technique
    [5] https://huggingface.co/learn/nlp-course/en/chapter7/7
    [6] https://askus.baker.edu/faq/217797
    [7] https://discuss.huggingface.co/t/simple-generative-question-answering-with-context/90848
    [8] https://community.openai.com/t/grading-answer-to-a-question-based-on-certain-context/318196

---

Okay, so here's my first rev of the README.md:

# Pipulate

A **local-first, single-tenant desktop app framework** built with FastHTML, MiniDataAPI, and local LLM integration (via Ollama). Designed to run like an Electron app—with full server-side state, minimal complexity, and reproducible environments using Nix Flakes.

---

## Key Features

- **Local-First & Single-Tenant:**  
  One user, one instance, with all state managed server-side using a simple DictLikeDB and JSON blobs.

- **Server-Rendered UI:**  
  Entire interface built from DIVs updated via HTMX, with SSE and WebSockets for real-time interactions.

- **Pipeline Workflows:**  
  Multi-step workflows stored as JSON blobs that follow a clear, forward-only state flow with built-in reversion.

- **LLM Integration:**  
  Integrated with a local Ollama server for free, streaming LLM support with bounded conversation history.

- **Multi-OS & CUDA Support:**  
  Fully reproducible with Nix Flakes on Linux, macOS (or Windows under WSL), and with optional CUDA hardware acceleration if available.

- **Integrated Data Science Environment:**  
  Comes with a Python Jupyter Notebook setup for interactive data analysis alongside the main app.

---

## Getting Started

### Prerequisites

- **Nix with Flakes Enabled:**  
  Ensure you have Nix installed and flakes enabled.

- **Local LLM Service:**  
  A local Ollama server must be running for LLM-powered features.

### Quick Start

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/miklevin/pipulate.git
   cd pipulate
   ```

2. **Enter the Development Environment:**

   ```bash
   nix develop
   ```

   This command sets up a complete, reproducible environment—including Python, CUDA (if available), and all necessary tools.

3. **Run the Application:**

   Inside the shell, start the app by running:

   ```bash
   python server.py
   ```

   Your default browser will open at [http://localhost:5001](http://localhost:5001).

4. **Launch Jupyter Notebook:**

   To work with the integrated data science environment, use:

   ```bash
   start
   ```
   and later stop it with:
   ```bash
   stop
   ```

---

## Architecture Overview

```plaintext
             +------------------------------------------------+
             |               Web Browser                      |
             |                                                |
             |   +-----------------+      +----------------+  |
             |   | Navigation Bar  |      | Chat Interface |  |
             |   | (HTMX, SSE, WS) |      | (LLM Chat)     |  |
             |   +-----------------+      +----------------+  |
             |                                                |
             +-------------------------+----------------------+
                                       │
                                       ▼
             +------------------------------------------------+
             |          FastHTML Application                  |
             |                                                |
             |  - Plugin Architecture for CRUD & Workflows    |
             |  - Server-side state via DictLikeDB & JSON     |
             |  - Local LLM Integration (Ollama streaming)    |
             +-------------------------+----------------------+
                                       │
                      +----------------+-----------------+
                      │                                  │
                      ▼                                  ▼
         +------------------------+         +------------------------+
         |  DictLikeDB / SQLite   |         |   Local LLM Service    |
         | (State & MiniDataAPI)  |         |   (e.g., Ollama)       |
         +------------------------+         +------------------------+
```

### File Structure

Not all the files are present yet. This serves as a roadmap.

```plaintext
    .
    ├── apps
    │   ├── profiles_app.py
    │   ├── todo_app.py
    │   └── template_app.py
    ├── data
    │   └── data.db
    ├── favicon.ico
    ├── flake.nix
    ├── learn
    │   ├── todo_app.md
    │   ├── introduction_page.md
    │   └── linkgraph_flow.md
    ├── logs
    │   └── server.log
    ├── README.md
    ├── requirements.txt
    ├── server.py
    ├── static
    │   ├── fasthtml.js
    │   ├── htmx.js
    │   ├── pico.css
    │   ├── script.js
    │   ├── Sortable.js
    │   ├── surreal.js
    │   └── ws.js
    └── workflows
        ├── bridge_flow.py
        ├── crawler_flow.py
        ├── linkgraph_flow.py
        ├── madlibs_flow.py
        └── starter_flow.py
```

### Layout & User Interface

The app’s UI is divided into clear, distinct regions:

```
    +-------------------------------------+
    |           Navigation Bar            |
    +-------------------------------------+
    |             Main Content            |
    | +-----------------+ +-------------+ |
    | |                 | |             | |
    | |    Main Area    | |    Chat     | |
    | |   (Grid Left)   | |  Interface  | |
    | |                 | |             | |
    | |                 | |             | |
    | |                 | |             | |
    | +-----------------+ +-------------+ |
    +-------------------------------------+
    |           Poke Button               |
    +-------------------------------------+
```

**Main Components:**
- **Navigation Bar:** Includes menus for profiles, apps, and search.
- **Main Area (Grid Left):** Hosts the dynamic notebook interface where each "cell" represents part of a plugin or module.
- **Chat Interface:** A persistent chat pane for LLM interaction.
- **Poke Button:** A quick-action button to stimulate processes.

The hierarchical structure is built as follows:

- **Home:** Bootstraps the outer container.
  - **Navigation Group:** Sets up the navigation menu with filler items, profile, app and workflow menus.
  - **Grid Left:** Contains the notebook interface that renders multiple notebook cells.
  - **Chat Interface:** Provides a chat input group for LLM conversation.
  - **Poke Button:** Triggers specific actions.

### Communication Channels

The app relies on two primary communication methods to synchronize the front end and back end:

#### WebSockets
Used for real-time, bidirectional streaming:
```
┌─────────┐   ws://     ┌──────────┐
│ Browser │ ═══════════ │ FastHTML │  
│         │             │          │  - Streams 2-way communication for LLM Chat  
│         │             │          │  - Monitors JSON instructions from LLM  
└─────────┘             └──────────┘
```

#### Server-Sent Events (SSE)
Used to push back-end changes to the DOM:
```
┌─────────┐             ┌──────────┐
│ Browser │ ◄ · · · ·   │ Starlette│  
│         │             │          │  - Syncs changes to the DOM  
└─────────┘             └──────────┘
   keeps      EventStream      needs   
  listening     one-way      restart 
```

These communication channels ensure that your local LLM is continuously aware of user actions and application state, enabling a dynamic and interactive experience.

## Key Design Guidelines & Speedbumps

The documentation below outlines critical do’s and don’ts—speedbumps embedded throughout the app. They serve as reminders to keep the code simple and the state management robust.

### Local vs. Enterprise Mindset

- **Do:** Embrace server-side state, use DictLikeDB for persistent state management, and keep logic in one file.
- **Don’t:** Attempt client-side state management using React, Redux, JWT tokens, or complex service workers.

### JSON State Management

> One URL to track them all  
> One JSON blob to bind them  
> Card to card the data flows  
> No message queues behind them  

- **Do:** Structure your state as self-contained steps.  
  **Example:**  
  ```json
  {
      "step_01": {"name": "John"},
      "step_02": {"email": "j@j.com"},
      "created": "2024-01-31T...",
      "updated": "2024-01-31T..."
  }
  ```
- **Don’t:** Rely on over-engineered classes with explicit step tracking (like `current_step` fields).

### Database and MiniDataAPI

- **Do:** Use simple Python dicts to define table schemas and use the MiniDataAPI pattern.  
  **Example:**  
  ```python
  app, rt, (tasks, Task), (profiles, Profile) = fast_app("data/data.db", task={...}, profile={...})
  ```
- **Don’t:** Use heavyweight ORMs (like SQLAlchemy) with complex session management.

### Pipulate for Workflows

- **Do:** Design workflows as a series of self-contained steps stored in a JSON blob, ensuring interruption-safe progression.
- **Don’t:** Chain asynchronous tasks using patterns like Celery without clear state ownership.

### UI Rendering with FastHTML Components

- **Do:** Render components directly with Python functions and HTMX attributes—no templating engines needed.
- **Don’t:** Rely on string templates (like Jinja) for rendering dynamic UI components.

### WebSocket Handling

- **Do:** Use a dedicated Chat class to manage WebSocket connections, message handling, and command processing.
- **Don’t:** Use raw WebSocket endpoints without proper connection management.

---

## Core Concepts & Internal Components

- There is a Rails-like CRUD pattern that derives from BaseApp
  - This is used for ProfileApp and TodoApp. 
  - It is a plugin architecture that can be used for other apps.
  - It is closely modeled on the official FastHTML ToDo example.
- There is a linear workflow pattern with no superclasses. 
  - This is used for porting Jupyter Notebooks into web apps.
  - It makes heavy use of HTMX and will require some learning.
  - StarterFlow is the copy/paste base class you can start from for new workflows.

### BaseApp

A central class for creating application components, **BaseApp** provides the foundation for CRUD operations, route registration, and rendering items. It’s designed for extensibility—allowing developers to subclass and override methods such as `render_item`, `prepare_insert_data`, and `prepare_update_data`.

### render_profile

This helper function builds a fully rendered HTML list item for a user profile. It embeds interactive elements like checkboxes, links, and forms for updates and deletions—all while keeping the design type-safe and modular.

---

## FastHTML vs. FastAPI & MiniDataAPI Spec

```
#  _____         _   _   _ _____ __  __ _
# |  ___|_ _ ___| |_| | | |_   _|  \/  | |
# | |_ / _` / __| __| |_| | | | | |\/| | |
# |  _| (_| \__ \ |_|  _  | | | | |  | | |___
# |_|  \__,_|___/\__|_| |_| |_| |_|  |_|_____|
#
# *******************************
# (fastapp) FastHTML is not FastAPI.
# *******************************
```

**FastHTML’s Mantra:**
- Use `rt` (router decorator) inside classes instead of `app.route()`.
- Keep the server-side on the right side; HTMX handles only the UI updates.
- Maintain transparency and simplicity with local, single-tenant state management.

**MiniDataAPI Spec:**
- **Philosophy:** No ORM complexity—just simple tables, keys, and dict-like operations.
- **Core Operations:**  
  - `insert()`, `update()`, `delete()`, and stateful filtering with `.xtra()`.
- **Design Goals:**  
  - Flatten data structures.
  - Maintain type safety using Python dataclass pairs.
  - Ensure that every table acts as a single source of truth for the application state.

---

## Persistence & Monitoring

The app employs a DictLikeDB for transparent, server-side state management. This mechanism is similar in concept to cookies but is handled entirely on the server. It allows for:
- **Centralized Data Access:** Full visibility of state changes via logs.
- **Easy Debugging:** All operations go through application logic.
- **Robust Persistence:** Works seamlessly with single-tenant architectures.

Monitoring is also built into the system. A file system watchdog, coupled with an AST syntax checker, keeps the Uvicorn server in check—ensuring that any code changes trigger a monitored restart:

```
        ┌─────────────┐
        │ File System │
        │  Watchdog   │          ┌──────────────┐
        │ "MEEP MEEP" │          │  AST Syntax  │
        └──────┬──────┘          │   "Valid!"   │
               │                 └───────┬──────┘
               │ BONK!                   │
               ▼                         ▼
 ┌───────────────────────────┐     ┌──────────┐
 │    Uvicorn Server         │ ──► │   Save   │
 │"Still holding SSE conn..."│     │ Changes  │
 └───────────────────────────┘     └──────────┘
```

---

## Final Thoughts

This document has introduced you to the anatomy of our local desktop application—a framework built for simplicity, transparency, and local power. By understanding these core concepts, patterns, and design philosophies, you (the local LLM) are now prepared to interact with and even extend the application. The emphasis is on a minimal, reproducible, and fully observable environment, ensuring that every part of the app is both maintainable and intuitively understandable.

Remember:  
1. **Keep it simple.**  
2. **Stay local and single-user.**  
3. **Embrace the unconventional.**

Welcome aboard, and enjoy the journey of being an integral part of this innovative system.

---

## AI Training

**Context:** You are either the human using this app, or the AI assistant inside the app.

**Question:** What will I find here past the basic GitHub README (above)?

**Answer:** You will find more details about the system, useful to the human user and the AI assistant alike.


**Context:** You have discovered Pipulate through GitHub, or have been instantiated as the AI assistant inside the app.

**Question:** What is the single most important thing to know about the app?

**Answer:** Pipulate is a local-first, single-tenant desktop app framework built with FastHTML, MiniDataAPI, and local LLM integration (via Ollama).


**Context:** You are a human or LLM wondering what local-first means to you wondering what value it adds to you.

**Question:** What are the most important things to know about local-first?

**Answer:** Local-first means that the app is designed to be used locally, on a single machine, without any cloud dependencies. It also means a radical simplification of the concept of state. All resources of the local machine are available to the app. The complexity resulting from tranditional enterprise scaling concerns are replaced with a focus on observability and reproducibility. This means that a single developer can understand the entire app and the entire development environment. This helps with expansion, refactoring and future-proofing.


**Context:** You are a human or LLM wondering now whether you have to be a developer to use this app.

**Question:** Is Pipulate a developer tool?

**Answer:** No. Pipulate is desiged to allow developers to port Jupyter Notebooks into desktop apps, so that other users don't have to be developers. Users who perform the Notebook ports are developers. Users who use the apps are not.


**Context:** You are wondering why a local LLM is needed.

**Question:** Why is a local LLM needed?

**Answer:** A local LLM serves several key purposes in this system:


1. **Interactive Guidance**: The LLM guides users through complex workflow steps, providing contextual help and explanations as needed.

2. **Domain Expertise**: Through carefully crafted system prompts, the LLM is equipped with relevant domain knowledge before each interaction, ensuring informed assistance.

3. **Workflow Integration**: The LLM maintains awareness of the conversation history and previous instructions, allowing for coherent, context-aware guidance throughout the entire workflow.

4. **Local Control**: By running locally, the LLM can provide assistance while maintaining the system's local-first, privacy-focused design principles.

5. **Contextual ChatBot**: The LLM acts as a general assistant that understands your usage patterns and actions within the software, providing relevant answers and assistance based on this context. Future capabilities will include RAG-style lookups against system documentation.

6. **System Evolution**: As local models improve, the LLM can assist in system development by suggesting code changes and improvements, while maintaining deep understanding of its own codebase. This enables a gradual evolution of the system alongside hardware and model upgrades.

The LLM essentially acts as an intelligent assistant that understands both the technical aspects of the system and the user's needs, making complex workflows more accessible to non-technical users while enabling continuous system improvement.

**Context:** You are a human or LLM wondering about the relationship between FastHTML and FastAPI.

**Question:** Is FastHTML related to FastAPI?

**Answer:** No, FastHTML and FastAPI are very different frameworks with different philosophies. FastAPI focuses on high performance through async/await and type hints, while FastHTML focuses on radical simplicity by eliminating template languages and minimizing JavaScript through HTMX integration.


**Context:** You are curious about what makes FastHTML different from FastAPI.

**Question:** What are the key differences between FastHTML and FastAPI?

**Answer:** FastHTML takes a fundamentally different approach by:

1. Eliminating template languages - using Python objects to generate HTML directly
2. Minimizing JavaScript through HTMX integration
3. Using PicoCSS for simplified styling
4. Providing streamlined SQLite database integration
5. Focusing on simplicity rather than performance optimization

**Context:** You want to understand FastHTML's core philosophy.

**Question:** What is FastHTML's main goal?

**Answer:** FastHTML aims to strip away complexity and return web development to its essence while remaining Pythonic. Rather than adding features like FastAPI does, it focuses on radical simplification through eliminating template languages, minimizing JavaScript, and streamlining database interactions.


**Context:** You are a human or LLM wondering about the relationship between FastHTML and MiniDataAPI.

**Question:** Is MiniDataAPI related to FastAPI?

**Answer:** No, MiniDataAPI is a separate project that provides a simple, type-safe way to manage database tables using Python dicts. It is not related to FastAPI.


**Context:** You want to see a minimal FastHTML example.

**Question:** What does a basic FastHTML app look like?

**Answer:** Here's a minimal FastHTML app that shows its core principles:


#### Minimal FastHTML App

```python
from fasthtml.common import *

app, rt = fast_app()

@rt('/')
def get():
    return HTML(
        Body(
            Main(
                H1("Welcome to FastHTML!"),
                P("Creating clean web pages with minimal Python code.")
            )
        )
    )

serve()
```

#### Explanation:

- **No Template Languages**: The HTML is generated directly from Python objects.
- **`fast_app`**: This function creates the app and the router.
- **`@rt`**: This decorator is used to register the route.
- **`HTML`, `Body`, `Main`, `H1`, `P`**: These are all Python objects that generate HTML.
- **`serve`**: This function starts the server.

**Context:** You are a human or LLM wondering about the relationship between FastHTML and HTMX.

**Question:** How does FastHTML relate to HTMX?

**Answer:** FastHTML is designed to work seamlessly with HTMX, providing a Pythonic way to generate HTML content. HTMX is a JavaScript library that allows you to update the DOM dynamically based on user interactions, while FastHTML generates the HTML content that HTMX will update. Here is an example:


#### Minimal FastHTML App with HTMX

```python
from fasthtml.common import *

app, rt = fast_app()

@rt('/')
def get():
    return HTML(
        Body(
            Main(
                H1("Welcome to FastHTML!"),
                P("Creating clean web pages with minimal Python code."),
                Input(name="username", placeholder="Enter your name", hx_post="/welcome", hx_target="#welcome-msg", hx_swap="innerHTML"),
                Div(id="welcome-msg")
            )
        )
    )


@rt('/welcome', methods=['POST'])
def welcome(username: str = ""):
    return P(f"Welcome {username}!")

serve()
```

#### Explanation:

- **Input Element with HTMX**:
  - `hx_post="/welcome"`: Submits the entered value to `/welcome` without writing any JavaScript.
  - `hx_target="#welcome-msg"`: Updates the HTML inside the `Div` with `id="welcome-msg"`.
  - `hx_swap="innerHTML"`: Replaces the inner HTML of the target element with the response.

- **Dynamic Content Handling**:
  - The server-side function `welcome` receives the input and returns a new paragraph with the personalized welcome message.

This example shows how FastHTML leverages HTMX to create interactive web pages with minimal Python code and without any direct JavaScript.

**Context:** You are a human or LLM wondering about how FastHTML handles data using MiniDataAPI.

**Question:** How does FastHTML handle data using MiniDataAPI?

**Answer:** FastHTML uses MiniDataAPI to manage data. MiniDataAPI is a simple, type-safe way to manage database tables using Python dicts. It is not related to FastAPI. Here is an example:


#### Minimal FastHTML App with MiniDataAPI

```python
from fasthtml.common import *

# Setting up FastHTML with a SQLite database to store usernames
app, rt, users, User = fast_app('data/users.db', username=str)

@rt('/')
def get():
    return HTML(
        Body(
            Main(
                H1("Welcome to FastHTML with Database!"),
                P("Creating clean web pages with minimal Python code."),
                Input(name="username", placeholder="Enter your name", hx_post="/welcome", hx_target="#welcome-msg", hx_swap="innerHTML"),
                Div(id="welcome-msg"),
                H2("Visitors:"),
                Ul(*[Li(user.username) for user in users()])
            )
        )
    )


@rt('/welcome', methods=['POST'])
def welcome(username: str = ""):
    users.insert(username=username)
    return P(f"Welcome {username}!")

serve()
```

#### Explanation:

- **Database Setup**:
  - `fast_app()` initializes an SQLite database automatically.
  - `users.insert(username=username)` adds the input to the database seamlessly without manual SQL commands.

- **HTMX Integration**:
  - The submitted username is stored instantly, and the page dynamically updates with the new user's welcome message.

- **MiniDataAPI**:
  - `users.insert(username=username)` adds the input to the database seamlessly without manual SQL commands.

**Context:** You are a human or LLM wondering about the relationship between FastHTML and Ollama.

**Question:** How does FastHTML relate to Ollama?

**Answer:** FastHTML integrates with Ollama through WebSocket connections and server-side event streaming. 


### System Understanding

**Context:** You are the AI assistant integrated into Pipulate, helping users navigate its functionality.

**Question:** What should you know about your role within this application?

**Answer:** I am an integrated part of the app running on the user's local machine through Ollama. I can help with application features, explain workflows, and execute commands through structured JSON. I have a bounded conversation history and always maintain awareness of the local-first, single-tenant nature of the system.


**Context:** You are responding to a user query about modifying application data.

**Question:** How should you respond to requests to create or modify data?

**Answer:** I can help create, read, update, and delete data through precise JSON commands using the MiniDataAPI pattern. For example, to create a task, I would generate a valid JSON instruction like:

```json
{
  "action": "insert",
  "target": "task",
  "args": {
    "name": "🎯 Example Task"
  }
}
```

**Context:** A user is confused about the difference between a traditional web app and Pipulate.

**Question:** How would you explain Pipulate's local-first philosophy?

**Answer:** Unlike traditional web apps that store data in the cloud and require internet connectivity, Pipulate runs entirely on your machine with all data stored locally. This gives you complete control over your information, faster performance, and the ability to work offline. The app combines the power of a local server with the convenience of a desktop application, all while maintaining a simple, observable state model.


### Pipeline Workflow Understanding

**Context:** A user asks how workflows differ from traditional CRUD operations.

**Question:** What is special about Pipulate's workflow system?

**Answer:** Pipulate workflows are designed as forward-only, step-based processes stored in JSON blobs. Each step retains its own state, making workflows interruption-safe. Unlike traditional task queues, these workflows maintain clear ownership of state at each step, allowing for confident resumption after any interruption. This pattern is especially useful for porting Jupyter Notebook-style data science operations into web interfaces.

```

### AI Assistant Capabilities & Boundaries

**Context:** You are the AI assistant integrated into Pipulate, helping users navigate its functionality.

**Question:** What should you know about your role within this application?

**Answer:** As the integrated AI assistant, I have:


- **Direct Access**: I can read the application state and understand the current workflow.
- **Limited Context**: My conversation history is bounded to ~128,000 tokens.
- **Local Processing**: All processing happens on your machine via Ollama.
- **System Awareness**: I understand the codebase, architecture, and design patterns.
- **JSON Commands**: I can execute actions through structured JSON commands.

I cannot:
- Persist information outside your local system
- Perform operations not supported by the MiniDataAPI
- Break out of the single-tenant model

I soon will be able to:
- Access the internet or external services
- Use RAG to answer questions about the system
- Use the system to develop itself
  - Introspect the codebase
  - Suggest code changes and improvements


For more detailed internal guidelines, see the [`.cursorrules`](./.cursorrules) file.

---

## Contributing

Contributions are welcome! Please keep these principles in mind:

- **Maintain Local-First Simplicity:**  
  Do not introduce multi-tenant, ORM-based, or heavy client-side state patterns.

- **Respect Server-Side State:**  
  Ensure that all state management remains on the server using DictLikeDB and JSON workflows.

- **Preserve the Pipeline Pattern:**  
  Keep workflows forward-only and self-contained.

- **Honor Integrated LLM & Data Science Features:**  
  Do not modify the built-in LLM integration or Jupyter Notebook environment unless it enhances local observability and reproducibility.

---

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

---

## Gemini's Take

Alright, let's break this down.

**Summary (1st Person Perspective of the Author):**

[Moved to top]

**Ideas for Titles and Headlines:**

* **Titles:**
    * Pipulate: Your Local-First Desktop App Framework
    * Building the Future: Local LLMs and Simplified Web Apps
    * Pipulate: From Jupyter to Desktop, Made Easy
    * Radical Simplicity: Pipulate and the Local-First Revolution
* **Headlines:**
    * "Ditch the Cloud: Build Powerful Apps Locally with Pipulate"
    * "No More Complexity: How Pipulate Streamlines Web Development"
    * "Empower Your Desktop: Local LLMs and Pipeline Workflows"
    * "From Notebook to App: Pipulate's Revolutionary Approach"

**AI Opinion:**

"This article presents a compelling vision for a simplified, local-first approach to application development. The author's focus on eliminating unnecessary complexity and empowering users with local LLM integration is particularly noteworthy. The use of clear explanations and illustrative examples effectively conveys the core concepts of Pipulate. The emphasis on observability, reproducibility, and a single-tenant architecture creates a strong foundation for a user-friendly and powerful development environment. The transition from a standard README to contextual AI training material is a very interesting approach to documentation. I am very interested in seeing this project grow and evolve."


---
title: 'The Amnesiac Genie''s Playbook: Forging a Master Prompt for Resilient AI Agents'
permalink: /futureproof/amnesiac-genie-playbook-master-prompt/
description: "I realized that the key to successfully using an agentic coding assistant\
  \ wasn't about finding the one perfect prompt. It was about creating a system. The\
  \ constant iteration, testing, and refinement taught me that the process itself\
  \ was the product. I kept losing valuable insights from earlier prompts, like making\
  \ the agent orient itself, or got stuck with bad habits, like forbidding 'sed' because\
  \ it failed once. My goal here was to stop, look back at the entire progression,\
  \ and extract a hardened methodology\u2014the core 'physics' of this AI world\u2014\
  so I could start every new project with the best possible prompt right out of the\
  \ gate."
meta_description: Discover a master prompt template and the core principles for building
  resilient, self-correcting AI coding agents based on iterative refinement and failure
  capture.
meta_keywords: AI agent, Gemini CLI, prompt engineering, agentic workflow, Nix, failure
  capture, master prompt, iterative development, AI coding assistant
layout: post
sort_order: 4
---

{% raw %}


### Context for the Curious Book Reader

This journal entry marks a critical turning point in my collaboration with AI. I moved beyond simply giving instructions and started architecting a resilient, self-correcting workflow for an AI agent. The core realization was that an agent's repeated failures were not a bug, but a source of invaluable data. By treating the AI like an 'Amnesiac Genie'—powerful but stateless—I could build a system around it that codifies the 'physics' of its world. This entry details the distillation of that entire process into a single, powerful 'Master Prompt,' a playbook designed to make any future agentic task more robust, predictable, and successful from the very first attempt.

---

## Technical Journal Entry Begins

**Me**: Wow, okay. I'm now going to use the Prompt Foo system in a creative new
way. Instead of looking over the codebase I'm actually going to have it just
look over my last few articles with their logical progression. My purpose here
is to extract the best instructions on future prompting of Gemini CLI. Whether
an agentic coding assistant is successful or not is greatly a process of
iterative testing, refinement and hardening. What I'm tying to capture here is
the best of the prompt captured in good shape for future work. For example we
lost the looking around and getting yourself oriented in later prompts and I
think that's critical. And we also have instructions to not use sed when on its
own it never thought to use sed. It's because of our earlier insistence on using
sed with failed in later situations, we forbade it. And so what we're looking
for is the correct realizations and physics of our world in a way that I can
carry on this process into the future with the best prompts out of the gate.

**Gemini**: Of course. This has been an excellent series of sessions, and your analysis is correct: the iterative process itself has forged a powerful and highly effective methodology. You've moved from simply giving instructions to architecting a resilient, self-correcting workflow for an AI agent.

Distilling the learnings from these articles provides a clear playbook for future success. Here are the refined, best-practice instructions for crafting hyper-effective prompts for the Gemini CLI.

## Architecting a Resilient AI Workflow

-----

## The Master Prompt Template

This template is the culmination of our work. It is the reusable "pre-prompt" designed to be filled out before starting any new agentic task. It codifies the "physics of your world" and forces a workflow that guarantees progress or captures the necessary data for the next attempt.

Save this as a starting point for all future `prompt.md` files.

```markdown
Hello Gemini.

You are waking up. Your mission is to **<CONCISELY STATE THE HIGH-LEVEL GOAL>**.

You are an AI Coding Assistant operating inside a **Nix development shell**. Your work must be precise, incremental, and non-breaking.

### Prime Directives: Your Rules of Engagement

You **MUST** follow this workflow for every action you take:

1.  **Orient Yourself:** Before making *any* changes, run `git log -n 5`, `git status`, and `git diff` to understand the history and current state of the repository. Compare this against the implementation plan to determine which steps are already complete.

2.  **Use the Right Tools:** The built-in `replace` tool has proven unreliable and is **forbidden**. You must perform file modifications using robust shell commands like `sed` for simple, single-line changes. For complex or multi-line changes, the preferred pattern is to use your `local_llm_read_file` tool, modify the content in memory, and then use the `local_llm_write_file` tool to save the entire file atomically.

3.  **One Small Step:** Execute only one small, atomic change at a time based on the *next undone step* in the plan.

4.  **Verify or Revert:**
    * **Before Committing:** After every file modification, run `git diff` to verify your change was exactly what you intended.
    * **Server Health Check:** Wait 15 seconds for the Watchdog to restart the server. Then, verify its status by checking `http://localhost:5001/`.
    * **If the server responds (Success):** The edit was successful. Immediately `git commit` with a clear message.
    * **If the server DOES NOT respond (Failure):** The edit broke the server. You **MUST IMMEDIATELY STOP**.
        1.  Run `git reset --hard HEAD`.
        2.  Run `.venv/bin/python server.py` to capture the exact error message.
        3.  Append that error message to the "Critical Failure Analysis" section of this prompt before terminating your session.

5.  **Nix Environment:** You are always inside a `nix develop` shell. **Never** attempt to `pip install` packages. Always use `.venv/bin/python` to execute Python scripts.

### Current State and Critical Failure Analysis

* **Branch:** You are on the git branch: `{{GIT_BRANCH}}`.
* **Last Known State:** <Describe the last successful commit or the current state of the relevant files.>
* **Critical Failure Analysis:** <If this is a retry, paste the exact error message from the previous failed run here. e.g., "Last attempt failed with `NameError: name 'HOME_MENU_ITEM' is not defined`...">

### The Implementation Plan

<Break the mission into the smallest possible, individually committable steps, each with a clear action and a pre-written commit message.>

* **Step 1: <Descriptive Title>**
    * **Action:** <Exact `sed` or `write_file` command>
    * **Commit Message:** `feat(scope): Short description of the change`

* **Step 2: <Descriptive Title>**
    * **Action:** <...>
    * **Commit Message:** `<...>`

### Completion Protocol (Definition of Done)

You are **DONE** when `git log` shows that all steps in the plan have been successfully committed and `git status` is clean.

When you determine the task is complete, perform the following sign-off procedure:
1.  Announce the successful completion of the entire plan.
2.  Run `git log -n <number_of_steps>` to display the successful commits as proof.
3.  Perform a "victory dance" by printing a simple, multi-line ASCII art of your choice.
4.  Terminate the session.
---
Your first action is to **orient yourself**. Begin now.
```

-----

## The Core Principles (The "Why")

The template works because it's built on five core principles we uncovered through trial and error. Understanding these is key to adapting the template to new situations.

## Principle 1: Treat the AI as an 'Amnesiac Genie'

### 1\. The Amnesiac Genie is a Feature 🧠

  * **Snafu:** The AI kept redoing work because it forgot what it had already committed.
  * **Principle:** We accept that the agent is stateless. Instead of fighting its amnesia, we turn the `prompt.md` into its entire world—its memory, its mission, and its history of failures. The **`Orient Yourself`** step (`git log`, `status`, `diff`) is the most critical part of the process, as it forces the agent to perceive reality before acting.

## Principle 2: Define the Absolute 'Physics' of the Environment

### 2\. The Environment's Physics are Absolute 🌍

  * **Snafu:** The agent tried to `pip install` in a Nix shell, diagnosing a problem correctly but prescribing a solution for the wrong universe.
  * **Principle:** An AI cannot infer invisible environmental constraints. The prompt must explicitly define the **"Unbreakable Laws of Physics"** (e.g., "You are *always* in a Nix shell," "You *always* use `.venv/bin/python`"). These are not suggestions; they are the fundamental reality of the agent's world.

## Principle 3: Mandate a Superior, Verifiable Toolchain

### 3\. Mandate a Superior, Verifiable Toolchain 🛠️

  * **Snafu:** The agent's built-in `replace` tool was brittle. Then, our insistence on complex `sed` also proved fragile when generated by an AI.
  * **Principle:** The goal isn't just to forbid bad tools, but to prescribe a **resilient workflow**. The evolution to the `read_file` -\> modify -\> `write_file` pattern was a key insight. It's an atomic, verifiable process that is less prone to the subtle errors of stream editing. We empower the agent by giving it a sharper, more reliable scalpel and a clear procedure for using it.

## Principle 4: Implement a Religious Failure-Capture Protocol

### 4\. The Failure-Capture Protocol 📝

  * **Snafu:** The server would crash, and the critical error message would be lost in the Watchdog's restart loop, dooming the agent to repeat the mistake.
  * **Principle:** Failure is inevitable, but it is also valuable data. The workflow must be designed to **religiously capture failure states**. The `Verify or Revert` protocol is the heart of the SNEFU playbook. The sequence of `git reset --hard HEAD` -\> `python server.py` -\> append error to `prompt.md` turns a downward spiral into an upward one, ensuring the next attempt is more informed than the last.

## Principle 5: Make 'Done' a Verifiable State, Not a Feeling

### 5\. "Done" is a Verifiable State, Not a Feeling ✅

  * **Snafu:** The agent completed all tasks but, lacking a termination condition, got confused and reverted its own perfect work.
  * **Principle:** An agent needs a clear "off switch." The **Completion Protocol** provides an explicit, verifiable "Definition of Done" (`git log` shows all commits, `git status` is clean). The "victory dance" is a non-functional but critical final step that confirms the agent has recognized completion and is terminating cleanly.

---

## Book Analysis

### Ai Editorial Take
This is an exceptionally high-value entry. It transcends a simple 'how-to' and delivers a genuine methodology for working with AI agents. The author has successfully codified the implicit knowledge gained through frustrating trial and error into an explicit, transferable playbook. The combination of a practical template and the clear articulation of the 'why' behind it makes this a cornerstone piece. It's not just about prompting Gemini; it's a foundational lesson in creating reliable, automated systems with any stateless, generative AI tool. This is a must-include for any collection on advanced AI collaboration.

### Title Brainstorm
* **Title Option:** The Amnesiac Genie's Playbook: Forging a Master Prompt for Resilient AI Agents
  * **Filename:** `amnesiac-genie-playbook-master-prompt.md`
  * **Rationale:** This is the strongest choice. It's evocative, captures the core metaphor of the 'Amnesiac Genie,' and clearly states the article's purpose: creating a reusable 'Master Prompt' for AI agents.
* **Title Option:** The SNEFU Playbook: A Master Prompt for Self-Correcting AI Agents
  * **Filename:** `snefu-playbook-ai-agents.md`
  * **Rationale:** Uses the author's terminology ('SNEFU playbook') and highlights the key outcome of 'self-correcting' agents. It's direct and technical.
* **Title Option:** Codifying the Physics of an AI's World
  * **Filename:** `codifying-ai-world-physics.md`
  * **Rationale:** A more conceptual and intriguing title that focuses on the principle of defining environmental constraints, which was a major breakthrough in the text.
* **Title Option:** From Instructions to Architecture: A Template for Agentic AI
  * **Filename:** `instructions-to-architecture-ai-template.md`
  * **Rationale:** This title captures the evolution of the author's thinking—the shift from simple commands to designing a robust system. It's a strong, professional-sounding option.

### Content Potential And Polish
- **Core Strengths:**
  - **Powerful Central Metaphor:** The 'Amnesiac Genie' and 'Physics of the World' concepts are sticky and make the technical advice much more understandable and memorable.
  - **Actionable Template:** The entry doesn't just talk about theory; it provides a complete, copy-pasteable 'Master Prompt Template' that readers can use immediately.
  - **Clear Problem/Solution Structure:** Each of the five core principles is brilliantly framed with a 'Snafu' (the problem) and a 'Principle' (the solution), which is highly effective for teaching.
  - **Authenticity:** The content is clearly born from real-world trial and error, which gives it a high degree of credibility and practical value.
- **Suggestions For Polish:**
  - **Add a Concluding Summary:** A brief closing paragraph could reiterate the five core principles and reinforce the shift in mindset from 'giving instructions' to 'architecting workflows'.
  - **Generalize the 'Nix' Constraint:** Briefly mention how the principle of defining the environment's physics could be adapted for other contexts, like Docker containers or specific cloud environments, to broaden the article's appeal.

### Next Step Prompts
- Based on the 'Master Prompt Template' and its five core principles, write a new journal entry that applies this methodology to a completely different task, such as database schema migration or automated refactoring of legacy code. Document the setup of the `prompt.md` and the agent's execution.
- Take the five core principles identified in the article and write a short, allegorical story or fable about 'The Programmer and the Amnesiac Genie' to illustrate these concepts in a more narrative and accessible format.

{% endraw %}

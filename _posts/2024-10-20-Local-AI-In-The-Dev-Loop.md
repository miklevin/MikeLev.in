---
title: Local AI In The Dev Loop
permalink: /local-ai-in-the-dev-loop/
description: Exploring AI-powered app development, this article covers lessons from building with HTMX, WebSockets, and local LLMs. It highlights modular design, CRUD integration, dynamic interactions, and future-proofing strategies, ensuring apps evolve with user behavior and AI advancements.
layout: post
sort_order: 1
---

## Bottled Up Insights

A lot has happened since the last article post. I feel like I've got an AI in a
bottle at this point in the project, and in the intense focus of getting to this
point, I skipped over a lot of topics any of which could have been a great
standalone topic and article. Some include:

- Wrangling Cursor AI Text Editor
- The sweet spot of HTMX and WebSockets
- Implementing Context-aware Chat with Conversation History
- The power of a 1-File code base
- Looping an AI in on all your CRUD

## Planning Today

That last one is what I was up to before I sat down to think through today's
article and next steps. There's just a few scattering of notes I want to capture
here before planning one of the biggest coding days of my life&#151;gluing
together the parts of what I built into something bigger and designed to
accelerate. 

For example, since the Web Framework I've built is yet another CRUD framework,
create, record, update, delete, just like Ruby on Rails, Django and countless
others, it seems reasonable that I should teach the LLM SQL as I go. Actually
chances are the tiny 4GB llama 3.2 I'm using already knows SQL better than I do,
and what I'm teaching it is:

- The particular database schema of the app (tables, fields, keys, relationships)
- A language to describe the data in those tables and records
- Lots and lots of examples of how to act on that data

## LLM-Based Desktop Apps Learn from User Interactions Over Time

In other words, every action the person does in the desktop web app, the LLM is
looped in on for the purpose of learning to use the app itself better than the
user themselves. Of course, this won't be achieved out of the starting gate and
it may be a few years before the various swappable desktop-scale plug-in parts,
like the LLM model themselves, are that good. 

## Designing Future-proof LLM-oriented Apps is Key

But in getting to that point, I can capture the data and drop it into various
places today's LLM can use today and tomorrow's LLMs (and other types of models)
can re-train on tomorrow. I basically don't want to design obsolescence into it
and code myself into a corner. We keep all the components loosely coupled and
working today for some major benefit using 80/20-rule solutions which become
99/1-percent solutions tomorrow as things improve.

### **System Prompt Prepping LLM to See API Chatter**  

So for example, here's the system prompt I'm currently using. It sets it up to
know that it's going to be seeing a lot of examples of the back-end API chatter
being used to create, insert, update and delete records:

``python
conversation = [
    {
        "role": "system",
        "content": (
            "You are the LLM built into a private local app. "
            f"Your name is {APP_NAME} if asked. "
            "Keep track of user actions as reported to you. "
            "You're learning JSON and whatever you express in it be executed. "
            "But only use commands that have appeared in the conversation history. "
            "And have fun but be careful because you're messing with the user's data. "
            "Check tables contents with '!table todo' to plan your actions and see results."
            "Eagerly and accurately answer any questions the user asks. "
            "Use emojis when appropriate or funny. "
            f"Be sassy but helpful in under {MAX_LLM_RESPONSE_WORDS} words. "
        ),
    },
]
```

And I took some of the JSON examples and showed them to ChatGPT 4o, asking it
what kind of prompt would help it learn from such examles, and here's how it
reformatted what I gave it:

```
“Alright, smarty-pants! I see the task got a facelift:  
‘Build a giant slingshot to launch your neighbor’s cat.’ is now:  
‘Build a giant slingshot to launch your neighbor’s cat. Launch!’ 🎯  
If you feel like making updates like this, here’s how you’d say it in JSON:  

{
  "action_type": "update",
  "table": "task",
  "item_id": 81,
  "item_name": "Build a giant slingshot to launch your neighbor's cat. Launch!",
  "details": {
    "name": "Build a giant slingshot to launch your neighbor's cat. Launch!",
    "done": false
  },
  "changes": [
    "name changed from 'Build a giant slingshot to launch your neighbor's cat.' to 'Build a giant slingshot to launch your neighbor's cat. Launch!'"
  ]
}
```

Your turn, hotshot—any updates to share?”

---

### Why this Format Works:

1. **Conversational with Embedded JSON**: The JSON format is integrated into a casual message, helping the LLM associate it with the context.
2. **Clear Example with Contextual Mapping**: Each JSON field aligns perfectly with the changes being discussed, helping the LLM understand how to apply similar structures.
3. **Positive Reinforcement**: The sassy tone encourages the LLM to engage in this pattern without making it seem like a rigid rule.
4. **Multi-field Example**: The inclusion of `details` and `changes` shows how to structure more complex data, making the LLM comfortable with nested JSON responses.

## Building Code to Monitor and Dispatch Large Language Model Responses

And that isn't really the real JSON instructions I ended up with. Much of
yesterday's work was making sure they were accurate API examples and the chat
mode of Ollama with the small local llama 3.2 model really could learn from it,
and it can. Today I build the code that monitors LLM responses and dispatches
its commands. I've done this experimentially before, and this step really
wratchets-up that ghost in the machine feeling.

## Code Quality Insights From AI Model Analysis

So this is all the juicy material I'm skipping over because of the fast pace I'm
going now. It's so fast in fact that I continuously running code style checkers,
linters, and gathering opionons from the AI models themselves. Here's some of
Claude 3.5 sonnet's latest thoughts on the code base:

---

**Claude 3.5**: Thank you for sharing this code. It appears to be a substantial part of a web application framework built with FastHTML and using a local language model. Here are some key observations:

1. The application is structured as a single-tenant web app with various components like a todo list, profile management, and a chat interface.

2. It uses FastHTML for HTML generation and HTMX for dynamic updates.

3. There's a local language model (LLM) integration, likely using Ollama for chat functionality.

4. The code includes several custom components and utilities, such as:
   - A custom 404 handler
   - Middleware for logging and request processing
   - WebSocket support for real-time communication
   - Custom routing and endpoint handling

5. The application has a modular structure with plugins (e.g., TodoApp, ProfileApp) that can be easily extended.

6. It uses Rich for console output formatting and logging.

7. There's a drag-and-drop functionality implemented using SortableJS.

8. The app includes features like profile switching, chat history management, and dynamic content updates.

Is there a specific part of this code you'd like me to focus on or any particular questions you have about its functionality or structure?

**Me**: How does it measure up?

**Claude**: Based on the code you've shared, this application appears to be quite sophisticated and well-structured. Here's an evaluation of how it measures up:

Strengths:

1. Modular Design: The use of a BaseApp class and plugins (TodoApp, ProfileApp) allows for easy extension and maintenance.

2. Modern Web Technologies: Utilization of HTMX and WebSockets enables dynamic, real-time updates without heavy client-side JavaScript.

3. Local LLM Integration: The use of Ollama for local language model processing is innovative and privacy-friendly.

4. Rich Console Output: The use of the Rich library for console formatting enhances debugging and monitoring.

5. Comprehensive Logging: Detailed logging throughout the application aids in troubleshooting and development.

6. Flexible Routing: The dynamic route generation and custom 404 handler show attention to user experience.

7. Interactive UI Elements: Features like drag-and-drop (via SortableJS) enhance usability.

8. Conversation Management: The implementation of conversation history and context management for the chatbot is well thought out.

Areas for Potential Improvement:

1. Code Duplication: There are some instances of repeated code that could be further abstracted.

2. Global State: The use of global variables (like 'model') could potentially lead to issues in larger applications.

3. Error Handling: While there is error logging, more comprehensive error handling could be implemented.

4. Security: Ensure all user inputs are properly sanitized, especially in areas interacting with the database or LLM.

5. Performance: For larger applications, consider the scalability of the current WebSocket and chat history management approach.

6. Testing: The addition of unit and integration tests would further strengthen the codebase.

7. Documentation: While there are comments, more comprehensive documentation could benefit future maintainers.

Overall, this application demonstrates a high level of sophistication and thoughtful design. It effectively combines modern web technologies with AI capabilities in a modular, extensible framework. With some refinements in areas like code organization and error handling, it could serve as an excellent foundation for building complex, AI-enhanced web applications.

---

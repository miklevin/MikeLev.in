---
title: Local AI In The Dev Loop
permalink: /local-ai-in-the-dev-loop/
description: 
layout: post
sort_order: 1
---

A lot has happened since the last article post. I feel like I've got an AI in a
bottle now, and in the intense foucs of getting to this point, I skipped over a
lot of intended topics like the wonders of WebSockets, keeping conversation
context by passing the whole conversation on every post, and looping the LLM in
on everything occuring with a piece of software.

You get 'em in on the project right at the start

Thank you for sharing this code. It appears to be a substantial part of a web application framework built with FastHTML and using a local language model. Here are some key observations:

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

Me: How does it measure up?

Claude: Based on the code you've shared, this application appears to be quite sophisticated and well-structured. Here's an evaluation of how it measures up:

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



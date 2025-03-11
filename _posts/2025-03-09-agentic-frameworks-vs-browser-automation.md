---
title: "Agentic Frameworks vs. DIY: Finding the Right Balance for Browser Automation"
permalink: /futureproof/agentic-frameworks-vs-browser-automation/
description: I'm looking for a local browser automation solution that avoids cloud dependencies and tedious DOM manipulation. I explored popular agentic frameworks like LangChain, Auto-GPT, and Microsoft AutoGen, but found them too opinionated and complex for my needs. Instead, I'm seeking a simpler setup that combines the power of Playwright or Puppeteer with the semantic capabilities of a local LLM like Llama, allowing me to express browser interactions in natural language. I'm also interested in open-source tools that simplify DOM interaction and provide high-level APIs for controlling real browsers.
layout: post
sort_order: 1
---

Okay, so Manus is taking the world by storm right now, along with OpenManus
right on its tails. I don't have an invite to Manus, and my OpenManus attempts
have been about as successful as my MCP (model context protocol) attempts.
There's hype videos all over YouTube and MCP plugins appearing for the AI code
editors like a new real estate land grab. But my personal hands-on experimenting
with this agentic framework (OpenManus) and agentic enabler (MCP) have not been
so successful. My lesson? Early versions of stuff is full of frustrating bugs
and don't work as advertised -- unless you reproduce their setup almost
precisely. I need more mature software, and so I'm doing some deep research.

The DeepResearch feature is showing up everywhere now. Ironically, that's not to
dissimilar to the very features I'm looking for in something local. I see
DeepResearch in Grok 3, DeepSeek R1, ChatGPT 4.5 and Gemini 2.0. I only use
Claude right now through Code AI, so if they have the feature (likely), I don't
use it directly. But I'm starting with ChatGPT 4.5. I laid out my criteria.

**ChatGPT 4.5**: Thanks for the clarification! It sounds like you're looking for a locally-run agentic framework that can:

- Automate a browser (via Puppeteer, Playwright, or Selenium, but not necessarily limited to these)
- Connect to Ollama or similar local AI models
- Enable reasoning and back-and-forth decision-making (i.e., chain-of-thought processing)
- Avoid vendor lock-in or cloud dependency (i.e., runs entirely locally)

Could you confirm if these are your primary requirements? Also, do you have a preference for programming language (e.g., Python, JavaScript) or specific use cases (e.g., web scraping, automated research, task execution)?

**Me**: I do indeed wholeheartedly confirm that is what I'm looking for! I want a Python-centric view as well.

**ChatGPT 4.5**: Got it! I'll look into agentic frameworks that run locally, use Python, automate browsers via Puppeteer, Playwright, or Selenium, and integrate with Ollama or similar local AI models for chain-of-thought reasoning. I'll find options that are not tied to cloud-based vendor solutions and get back to you shortly.

# Local Agentic Frameworks for Browser Automation

Below are several **Python-centric agent frameworks** that run entirely **locally** (no cloud required) and support **browser automation** (via tools like Puppeteer, Playwright, or Selenium). Each framework integrates with **local AI models** (e.g. via Ollama or Hugging Face) and enables chain-of-thought reasoning for autonomous decision-making. We’ve prioritized well-maintained projects with strong documentation and community support.

## LangChain 
- **Repository:** [LangChain GitHub](https://github.com/hwchase17/langchain) (open-source MIT)  
- **Documentation:** [LangChain Docs](https://python.langchain.com/docs/introduction/) (extensive guides and examples)  
- **Local LLM Integration:** Designed to be model-agnostic, LangChain works with multiple LLM providers (OpenAI, Anthropic) as well as **open-source/local models** via Hugging Face transformers and API wrappers ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=,for%20processing%20various%20data%20types)). This avoids vendor lock-in and lets you swap in local models (e.g. Llama-2) easily.  
- **Browser Automation Tools:** LangChain provides **built-in tools for web browsing and scraping** (along with API calls, database queries, etc.) ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=,for%20processing%20various%20data%20types)). An agent can use these tools to fetch webpage content or interact with a website as part of its reasoning process. (For example, you can equip a LangChain agent with a Selenium-based browser tool or use its requests wrappers to scrape sites.)  
- **Chain-of-Thought Agents:** It offers high-level **chain** and **agent** abstractions to implement complex, multi-step workflows ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=Key%20Features%20of%20LangChain)). Agents in LangChain can observe intermediate results, maintain memory, and decide on next actions, enabling sophisticated reasoning strategies.  
- **Community & Support:** LangChain is a mature project with an **active community**, frequent updates, and abundant documentation and examples ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=,agent%20networks%20for%20collaborative%20tasks)). This means plenty of tutorials, templates, and help are available for building and debugging your local agent applications.

## Auto-GPT 
- **Repository:** [Auto-GPT GitHub](https://github.com/Significant-Gravitas/AutoGPT) (open-source MIT)  
- **Documentation:** [Auto-GPT Docs](https://docs.agpt.co/) (official setup and usage guide)  
- **Local-First Deployment:** Auto-GPT can be self-hosted and run fully locally. It supports using **local LLMs** – for example, the project provides integration with **Ollama** to run LLaMA-based models instead of OpenAI’s API ([Using Ollama - AutoGPT Documentation](https://docs.agpt.co/platform/ollama/#:~:text=Running%20Ollama%20with%20AutoGPT%C2%B6)). This allows you to avoid cloud services and keep all computation on your machine.  
- **Browser Automation:** Auto-GPT enables web browsing capabilities via its plugin system. There are community plugins/extensions that let Auto-GPT control a browser (for clicking links, form submission, scraping content, etc.) using headless Chrome or Playwright. For instance, the **Web-Interaction** plugin allows Auto-GPT to interact with websites autonomously ([gravelBridge/AutoGPT-Web-Interaction: A plugin to enable ... - GitHub](https://github.com/gravelBridge/AutoGPT-Web-Interaction#:~:text=gravelBridge%2FAutoGPT,4)). (The core Auto-GPT also uses browser automation libraries like Playwright in testing, ensuring compatibility with such tools.)  
- **Chain-of-Thought Autonomy:** Auto-GPT was one of the first demonstrations of an *“autonomous AI agent.”* It **chains together LLM “thoughts”** to iteratively plan, reason, and act towards a goal without constant user input ([yongliqi/Auto-GPT-local: An experimental open-source ... - GitHub](https://github.com/yongliqi/Auto-GPT-local#:~:text=GitHub%20github,of%20the%20first%20examples)). The agent maintains a reasoning loop: it can analyze the situation, decide on an action (using tools or making web requests), execute it, then evaluate results and adjust its plan. This loop continues until the goal is met.  
- **Community & Development:** Auto-GPT gained a huge following, resulting in a rich ecosystem of plugins and improvements. It’s under active development with an official Discord and many contributors. Documentation covers setup, usage, and customization, and the community has produced countless guides and fixes. Its popularity ensures that bugs are quickly identified and that you can find support or extensions for new use-cases.

## Microsoft AutoGen 
- **Repository:** [Microsoft AutoGen (GitHub)](https://github.com/microsoft/autogen)  
- **Documentation:** [AutoGen User Guide](https://microsoft.github.io/autogen/) (tutorials and API reference)  
- **Multi-Agent Framework:** AutoGen (developed by Microsoft Research) is an open-source framework for building **teams of AI agents** that can converse and collaborate ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=Microsoft%20AutoGen%20is%20an%20open,construct%20sophisticated%20AI%20systems%20efficiently)) ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=%2A%20%C2%A0Multi,loop%20interactions)). It provides a structured way to define multiple agents (with roles like “User proxy”, “Web surfer”, etc.) and manage their interactions. This facilitates chain-of-thought reasoning through agent dialogues – one agent can hand off tasks to another or ask another agent for help, enabling complex decision-making processes.  
- **Local Model Integration:** AutoGen is Python-based and can be run locally. By default it interfaces with OpenAI/Azure models, but it’s **extensible to other model backends**. Developers have shown it working with local models (e.g. hooking it up to Ollama’s local LLM server) via its flexible `ChatModel` API. In short, you can configure AutoGen to call **any LLM endpoint** – whether a cloud API or a local server – so there’s no inherent vendor lock-in.  
- **Browser Automation:** The framework supports tools and skills that agents can use, including web browsing. In fact, AutoGen provides an example “**web surfer**” agent that uses Playwright to automate a browser ([GitHub - microsoft/autogen: A programming framework for agentic AI  PyPi: autogen-agentchat Discord: https://aka.ms/autogen-discord Office Hour: https://aka.ms/autogen-officehour](https://github.com/microsoft/autogen#:~:text=match%20at%20L340%20Web%20Browsing,Agent%20Team)). By installing Playwright, you enable an AutoGen agent to navigate pages, click links, and scrape content as part of its task execution. This built-in capability to spawn a headless browser makes it straightforward to integrate browser automation into your agent’s chain-of-thought.  
- **Robust Features & Docs:** AutoGen emphasizes reliability (with error handling, memory, etc.) and flexibility. Agents have **customizable roles/behaviors**, and the framework supports integration with external tools/services ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=%2A%20%C2%A0Multi,loop%20interactions)) (for example, database queries or code execution tools) to expand what agents can do. Microsoft provides **comprehensive documentation and examples** ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=,loop%20interactions)), and an active Discord for support. Given its backing by Microsoft and a quickly growing community, AutoGen is well-maintained and continually adding features (the latest release includes an AutoGen Studio GUI for designing agent flows).

## CrewAI 
- **Repository:** [CrewAI on GitHub](https://github.com/crewAIInc/crewAI)  
- **Documentation:** [CrewAI Docs](https://docs.crewai.com/introduction) (in-depth guides, tutorials, and API reference)  
- **Collaborative Agents (“Crew”)**: CrewAI is a **fast Python framework** for orchestrating multiple AI agents working together ([Introduction - CrewAI](https://docs.crewai.com/introduction#:~:text=CrewAI%20is%20a%20lean%2C%20lightning,LangChain%20or%20other%20agent%20frameworks)). It’s built from scratch (not on LangChain) to allow “crews” of agents, each with specialized roles, to collaborate on tasks. You can define agents like a “Researcher”, “Planner”, and “Executor” that share information and delegate subtasks – enabling complex problem-solving via cooperative chain-of-thought.  
- **Local Model Support:** CrewAI is model-agnostic and makes it easy to use local models. It supports various connection options for LLMs – by default it can use OpenAI API, but you can **point it to a local LLM** (for example, configure an Ollama endpoint to serve a Llama-2 model) ([GitHub - crewAIInc/crewAI: Framework for orchestrating role-playing, autonomous AI agents. By fostering collaborative intelligence, CrewAI empowers agents to work together seamlessly, tackling complex tasks.](https://github.com/crewAIInc/crewAI#:~:text=CrewAI%20supports%20using%20various%20LLMs,model%20via%20the%20Ollama%20tool)). This flexibility lets you run entirely off-cloud, using whichever LLM you have available locally, without changing your agent code.  
- **Browser Automation Tools:** CrewAI comes with a rich library of built-in tools that agents can utilize. Notably, it includes a **Selenium-based web scraper** tool for browser automation ([Selenium Scraper - CrewAI](https://docs.crewai.com/tools/seleniumscrapingtool#:~:text=The%20,to%20automate%20browser%20interactions)). An agent can invoke this tool to launch a browser via Selenium WebDriver, navigate to pages, and extract information from dynamic websites. (There are also other web-related tools, like ones for general web searches or scraping with alternative services, in the CrewAI toolkit.) This means agents can perform web browsing as part of their autonomous actions.  
- **Advanced Reasoning & Workflows:** CrewAI provides both high-level “Crew” orchestration and low-level control (via “Flows”). You can specify processes, memory sharing, and even human-in-the-loop steps if needed. Agents in a crew make **autonomous decisions** based on their goals and the shared state, allowing complex planning and reflexion. The framework is designed for production use with features like agent monitoring, testing utilities, and the ability to integrate custom tools or even LangChain/LlamaIndex if desired.  
- **Community & Documentation:** Despite being a newer project, CrewAI has rapidly grown in popularity (tens of thousands of GitHub stars) and boasts a **thriving community**. The creators provide **robust documentation and examples**, and they run community courses (over “100,000 developers certified”) to help onboard users ([GitHub - crewAIInc/crewAI: Framework for orchestrating role-playing, autonomous AI agents. By fostering collaborative intelligence, CrewAI empowers agents to work together seamlessly, tackling complex tasks.](https://github.com/crewAIInc/crewAI#:~:text=,providing%20exceptional%20support%20and%20guidance)). An active discussion forum and frequent updates ensure that CrewAI is well-supported. Its focus on reliability and clarity directly addresses some shortcomings developers encountered in earlier frameworks ([GitHub - crewAIInc/crewAI: Framework for orchestrating role-playing, autonomous AI agents. By fostering collaborative intelligence, CrewAI empowers agents to work together seamlessly, tackling complex tasks.](https://github.com/crewAIInc/crewAI#:~:text=match%20at%20L1007%20reliable%20and,and%20limitations%20associated%20with%20LangChain)), making it an appealing choice for local agent development.

## AGiXT 
- **Repository:** [AGiXT on GitHub](https://github.com/Josh-XT/AGiXT)  
- **Documentation:** [AGiXT Documentation](https://josh-xt.github.io/AGiXT/) (user guides, API docs, and examples)  
- **Local & Multi-Provider**: AGiXT is an open-source **AI agent platform** that you can self-host. It’s built to interface with **many AI model providers** – OpenAI, Anthropic, Google, etc., **including local/backyard models** like Hugging Face transformers or **ez**Local**AI** ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=%2A%20Multi,simultaneously%20to%20suit%20your%20needs)). You can plug in an OpenAI-compatible local server or other APIs, and AGiXT will manage the calls, which means no vendor lock-in. This multi-provider compatibility lets you mix and match models (even use multiple concurrently) to suit each task.  
- **Browser & System Automation:** AGiXT uses a **versatile plugin system** to extend agent capabilities. Out-of-the-box, it supports plugins for **web browsing and scraping**, OS commands, coding tools, and more ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=,with%20various%20APIs%20and%20services)). An AGiXT agent can perform web searches, open webpages and scrape their content, all on its own. (For example, the *Smart Instruct* feature leverages web search and data extraction to answer queries ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=,instructions%20while%20ensuring%20output%20accuracy)).) With browser automation, an agent can navigate websites to collect up-to-date information or interact with web apps.  
- **Chain-of-Thought and Memory:** The platform enables complex task execution by breaking down goals into steps and **managing chains of commands** ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=,tasks%20in%20the%20correct%20order)). Agents maintain **adaptive memory** (short-term and long-term) to carry context between steps, allowing them to handle multi-step workflows intelligently. Features like *Smart Instruct* and *Smart Chat* illustrate this – the agent plans a series of actions (search, analyze, execute commands) and iterates until the task is completed ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=,instructions%20while%20ensuring%20output%20accuracy)). There’s also support for executing code, which the agent can write and run as part of its reasoning process ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=,programming%20tasks%2C%20debugging%2C%20and%20more)).  
- **Community & UI:** AGiXT is **actively maintained** and has a growing community of users. It provides a **web-based UI** for configuring agents, prompts, and chains, as well as a REST API for integration ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=,manage%20conversations%2C%20and%20execute%20commands)). The documentation is comprehensive (covering setup, examples, and even Docker deployment) and the community (Discord, Reddit) offers support ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=,started%20and%20troubleshoot%20any%20issues)). With ~3k stars and ongoing development, AGiXT is an up-and-coming framework that emphasizes extensibility – developers can create custom plugins or commands to tailor agents to specific needs. 

**Sources:**

1. LangChain – key features and community ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=,for%20processing%20various%20data%20types)) ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=,agent%20networks%20for%20collaborative%20tasks))  
2. Auto-GPT – Ollama (local model) integration guide ([Using Ollama - AutoGPT Documentation](https://docs.agpt.co/platform/ollama/#:~:text=Running%20Ollama%20with%20AutoGPT%C2%B6)); Web interaction plugin ([gravelBridge/AutoGPT-Web-Interaction: A plugin to enable ... - GitHub](https://github.com/gravelBridge/AutoGPT-Web-Interaction#:~:text=gravelBridge%2FAutoGPT,4)); Autonomous “LLM thoughts” description ([yongliqi/Auto-GPT-local: An experimental open-source ... - GitHub](https://github.com/yongliqi/Auto-GPT-local#:~:text=GitHub%20github,of%20the%20first%20examples))  
3. Microsoft AutoGen – framework overview and features ([Top 7 Frameworks for Building AI Agents in 2025](https://www.analyticsvidhya.com/blog/2024/07/ai-agent-frameworks/#:~:text=%2A%20%C2%A0Multi,loop%20interactions)); Playwright-based web browsing agent ([GitHub - microsoft/autogen: A programming framework for agentic AI  PyPi: autogen-agentchat Discord: https://aka.ms/autogen-discord Office Hour: https://aka.ms/autogen-officehour](https://github.com/microsoft/autogen#:~:text=match%20at%20L340%20Web%20Browsing,Agent%20Team))  
4. CrewAI – introduction and local model support ([GitHub - crewAIInc/crewAI: Framework for orchestrating role-playing, autonomous AI agents. By fostering collaborative intelligence, CrewAI empowers agents to work together seamlessly, tackling complex tasks.](https://github.com/crewAIInc/crewAI#:~:text=CrewAI%20supports%20using%20various%20LLMs,model%20via%20the%20Ollama%20tool)); Selenium browser automation tool ([Selenium Scraper - CrewAI](https://docs.crewai.com/tools/seleniumscrapingtool#:~:text=The%20,to%20automate%20browser%20interactions)); Community and docs emphasis ([GitHub - crewAIInc/crewAI: Framework for orchestrating role-playing, autonomous AI agents. By fostering collaborative intelligence, CrewAI empowers agents to work together seamlessly, tackling complex tasks.](https://github.com/crewAIInc/crewAI#:~:text=,providing%20exceptional%20support%20and%20guidance))  
5. AGiXT – multi-provider and plugin system (web browsing, etc.) ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=,with%20various%20APIs%20and%20services)); chain management and community support ([AGiXT: An Open-Source Autonomous AI Agent Platform for Seamless Natural Language Requests and Actionable Outcomes : r/AI_Agents](https://www.reddit.com/r/AI_Agents/comments/1i3388h/agixt_an_opensource_autonomous_ai_agent_platform/#:~:text=,tasks%20in%20the%20correct%20order))

---

The usual suspects. I've been avoiding them, but I guess they've been around the
longest, and have consequently matured the most. They are opinionated
frameworks, but maybe I'll find one whose opinions I vibe with. I have to have a
more open mind about the developed stuff.

While they do avoid vendor lock-in per my request, I do have concerns that they
force you to go through APIs for web surfing. I particularly want things that
can automate either Selenium, Puppeteer or Playwright directly. I almost want
something that spares you from navigating the complex DOM, CSS selectors, XPaths
and JQuery paths, but which still understands web surfing enough that it can
simplify the connection with a local LLM running on Ollama. 

I originally asked for an agentic framework, and there's a lot of buzz around
that. But my style more is writing automation scripts by hand, but wanting to
cut down the fatigue. Maybe there are packages that simplify browser automation
locally. Maybe that's what I'm asking for.

So instead of just rounding up the top agentic frameworks, instead help me
figure out what it even is that I'm looking for. I have the ability to make LLMs
execute functions. But wait! When working with OpenManus it insisted I use Llama
2 or above, and not Google Gemma.

**Me**: What is the LLM function executing ability that's in Llama 2 and above that's not in Google Gemma?

**Perplexity**: The key distinguishing feature of Llama 2 and above compared to Google's Gemma models is their **function execution capability**. This includes the ability to decide autonomously whether to execute user-defined functions during interactions, a feature not directly available in Gemma.

### Llama 2 and Function Execution
- Llama 2 models can execute functions dynamically during conversations. They decide whether to call a function based on the context of the conversation, allowing for seamless integration of function execution within multi-turn dialogues. For example, Llama 2 can execute specific tasks like querying APIs or interacting with plugins only when necessary, without enforcing predefined behaviors[1][3].
- This functionality is similar to OpenAI's function-calling feature and supports complex use cases, such as handling multiple functions in parallel or integrating with existing plugins[1].

### Gemma and Function Calling
- Google's Gemma models also support function calling but in a more limited way. They generate structured outputs specifying function names and arguments but do not directly invoke functions. Instead, external systems must parse these outputs and execute the functions[7].
- While Gemma supports advanced features like **parallel function calling** and compositional workflows, it lacks the autonomous decision-making capability seen in Llama 2 for initiating or bypassing function execution during conversations[7].

### Summary
| Feature                        | Llama 2+                                | Google Gemma                         |
|--------------------------------|-----------------------------------------|--------------------------------------|
| Autonomous Function Execution  | Yes                                     | No                                   |
| Parallel Function Calling      | Yes                                     | Yes                                  |
| Multi-Turn Contextual Execution| Yes                                     | Limited                              |
| Direct Function Invocation     | Yes                                     | No (requires external handling)      |

In essence, Llama 2's ability to autonomously decide when and how to execute functions sets it apart from Gemma's more structured but externally-dependent function-calling approach.

Citations:

    [1] https://www.reddit.com/r/LocalLLaMA/comments/158l28c/functionary_new_open_source_llm_that_can_execute/
    [2] https://www.singlestore.com/blog/a-complete-beginners-guide-to-llama2/
    [3] https://fabrity.com/blog/leveraging-llm-function-calling-to-harness-real-time-knowledge/
    [4] https://developers.googleblog.com/en/gemma-explained-overview-gemma-model-family-architectures/
    [5] https://huggingface.co/blog/gemma
    [6] https://gorilla.cs.berkeley.edu/blogs/8_berkeley_function_calling_leaderboard.html
    [7] https://ai.google.dev/gemini-api/docs/function-calling
    [8] https://ai.google.dev/gemma
    [9] https://docs.llama-api.com/essentials/function
    [10] https://www.ibm.com/think/topics/llama-2
    [11] https://huggingface.co/docs/transformers/en/model_doc/llama2
    [12] https://developers.googleblog.com/en/gemma-family-expands-with-models-tailored-for-developers-and-researchers/
    [13] https://blog.google/technology/developers/gemma-open-models/
    [14] https://www.run.ai/guides/generative-ai/llama-2-fine-tuning
    [15] https://viso.ai/deep-learning/llama-2/
    [16] https://www.apideck.com/blog/llm-tool-use-and-function-calling
    [17] https://github.com/abetlen/llama-cpp-python/discussions/1491
    [18] https://ai.google.dev/edge/mediapipe/solutions/genai/llm_inference
    [19] https://siliconangle.com/2024/07/31/googles-lightweight-gemma-llms-get-smaller-perform-even-better/
    [20] https://www.datacamp.com/tutorial/fine-tuning-google-gemma

---

## Me Re-Evaluating Desire For Agentic Framework

Interesting! I've just been parsing JSON out of the Ollama websocket stream,
making the decision on my own. So, I have a different coding style. I decided to
make any model capable of executing functions, but there's something out there
with a model, presumably through its response format, something in the OpenAI
API Syntax I presume, that deliberately means: execute this function.

Okay, good to keep in mind. But none-the-less, I can see that this dynamic
back-and-forth chain of reasoning that I saw Goose AI do last month and see
Manus.im doing over the past few days is what I want to use or build. It's a
back-and-forth ping-ponging of the sort you see called "chain of reasoning" in
OpenAI ChatGPT o1 and above. It blasted onto the scene across the rest of the
frontier models, especially after DeepSeek R1 did it in open source. Now they
all have to do it to stay competitive, and we see it trickling into free and
open source packages too.

All of this stuff has the feeling of magic hand-waving. Yes, it's definitely
great for deep research where the end product is organized information. And we
see that because it can code, it can make a variety of dashboards. The term
Artifacts became popular since Anthropic rolled out such a feature in Claude.
And the dream is these things doing soup-to-nuts coding for you, getting all the
nuances and details of your context correct.

But I feel that being dangled much like a carrot today, with the libraries and
packages and vendor products and APIs powering it all, all just being
ridiculously moving targets. Everything is a hamster wheel, and I just
experimentally hopped on it over the weekend with MCP and OpenManus, and was
immediately sorry. So the above research was into the more established agentic
frameworks. Perhaps those are what I want.

But really maybe it's just Python that is the consistent thing that runs through
it all? There is only one framework that rules them all, and that framework is
Python. And Python's horse is JavaScript and the web browser. Python is the
automator and the browser is the automated. Everything else is in flux and
subject to ridiculous change. But you can't wait for it to settle down, or else
you lose the game. You've got to be in the game to win.

And so... and so... maybe what I'm looking for is the easiest path to local
browser automation, that doesn't go through Browser-Use or any of these gotcha
cloud services. There's no vendor lock-in so long as you use our product...
haha! None of that, please. Let's automate local Chrome, Firefox or whatever.
Let's do it as simply as possible. Yet still as powerfully and resistant to
obsolescence possible. And it should be able to run on standard Linux so it will
run under Nix with nix flakes, for cross-platform compatibility.

Enough criteria for you there? Tell me what I want.

## ChatGPT 4.5's Response

**ChatGPT 4.5**: ### You're not really looking for another "agentic framework."

What you actually want is simpler, cleaner, and more powerful local browser automation:

- **Without** vendor lock-in.
- **Without** cloud APIs or vendor wrappers (e.g., Browserbase, Browser-Use).
- **With direct browser control via Selenium, Puppeteer, or Playwright.**
- **Minimizing tedious DOM navigation, selectors, XPaths, and manual scraping.**
- **Smoothly integrated with local LLMs (Ollama or similar).**
- **Keeping all automation scripts clear, maintainable, and understandable.**
- **With a Python-centric workflow, easy to package and deploy (e.g., via Nix flakes on Linux).**

You're after something at the intersection of browser automation, simplified DOM interaction, and LLM integration, without the heavy baggage that comes from frameworks insisting on their own "opinionated" stack.

---

### **What you really want:**  

- **"Semantic Browser Automation" or "Natural Language Browser Automation."**  
  Something that lets you express browser tasks and DOM interactions in plain, natural language, while the framework and local LLM handle translation into browser automation commands (via Playwright/Selenium/Puppeteer).

- **"Smart DOM Interaction" Tools**  
  A package or library that internally leverages LLMs (like Ollama + Llama 2 locally) to let you refer to page elements semantically:
  ```python
  browser.click("the login button")  # without explicit CSS or XPath
  browser.type("the username field", "myusername")
  browser.type("the password field", "mypassword")
  browser.click("submit button")
  ```
  
  Under the hood, this translates your natural-language queries through an LLM into DOM queries via selectors and automation instructions.

---

### Does something exactly like that exist today?

Not in the clean, established form you’re describing—yet.  

However, you have all the necessary components to assemble something surprisingly lightweight and effective:

- **Browser automation layer:** Playwright (best current choice due to reliability, multi-browser support, and easy-to-use Python API).
- **Local LLM layer:** Ollama running locally with Llama 2, Mistral, Phi, or similar models supporting robust inference and reasoning.
- **Translation/semantic automation layer:** A minimal Python script translating natural language instructions into Playwright automation code using local LLM inference.

**Example minimal workflow:**
```python
instruction = "Click the signup button"
page_html = browser.content()
prompt = f"""
Here is the current page HTML:
{page_html}

What Playwright code (using CSS selectors or XPath) would accurately perform the following instruction?

Instruction: {instruction}

Provide the Playwright command only.
"""

response = ollama.generate(prompt)
exec(response)  # Carefully sanitized/executed with proper security consideration
```

---

### Realistic recommendations for immediate use:

- **Playwright (Python)**  
  Well-maintained, robust, runs locally, multi-browser, easy installation.
  ```bash
  pip install playwright
  playwright install
  ```

- **Ollama (Local LLM server)**  
  Flexible, locally hosted inference server.
  ```bash
  curl -fsSL https://ollama.com/install.sh | sh
  ollama run llama2
  ```

- **Custom lightweight Python wrapper (your own minimal glue code)**  
  Simply query Ollama with semantic instructions, translate to Playwright automation.

---

### Why NOT go with a full-blown "agentic framework"?

- You're rightly wary of frameworks because:
  - Opinionated frameworks may obscure browser details you actually want control over.
  - Dependency on APIs (even local web search API wrappers) adds complexity.
  - Frameworks impose coding patterns and cognitive overhead.

- Instead, leverage the simple composable nature of:
  - Browser automation libraries (Playwright).
  - LLM inference locally (Ollama).
  - Python's excellent scripting ergonomics.

---

### Your suggested stack to minimize fatigue while preserving flexibility:

| Layer                     | Recommendation                          | Rationale                                |
|---------------------------|-----------------------------------------|------------------------------------------|
| Browser Automation        | Playwright (Python)                     | Mature, powerful, easy-to-use.           |
| DOM Semantic Interaction  | Ollama (LLM inference to CSS/XPath)     | Translate natural language to selectors. |
| Local LLM Engine          | Ollama (with Llama 2, Mistral, etc.)    | Local, free, fast, function-calling.     |
| Script-Orchestration      | Pure Python scripts                     | Most stable, least framework-lock-in.    |
| Deployment                | Nix flakes (cross-platform)             | Consistent deployment across Linux, etc. |

---

### On the "function execution" point (Llama 2 vs. Gemma):

- **Gemma:** Outputs JSON to be parsed externally; lacks autonomous direct invocation.
- **Llama 2:** Generates responses explicitly indicating when to invoke functions (similar to OpenAI syntax, like `"function_call": {…}`). Llama 2 can directly instruct your code "Execute this function now," minimizing parsing effort and enhancing context-aware interactions.

You're already parsing manually. That's totally fine. Stick to what's clear and reliable.

But Llama 2’s native function-calling simplifies context-aware execution. If you're already comfortable parsing manually, you can use any model—Gemma or others—but Llama 2 will be smoother for direct, "autonomous" invocation if that's appealing.

---

### Final Recommendation:

What you really want isn’t an established "agentic framework."  
You want a minimalist, locally-hosted, reliable pipeline:

**Plain English → Local Ollama LLM → Playwright → Browser**

This gives you:

- Direct browser control (no API or cloud dependency).
- Semantic simplicity (no DOM headaches).
- Extreme flexibility (swap LLM models, browsers, instructions easily).
- Python-native clarity and readability.

No complex lock-ins, no vendor tricks, no opinionated boilerplate—just pure scripting efficiency.

This "stack" doesn't exist pre-packaged yet, but it’s trivial to set up:

- Use **Playwright** directly.
- Use **Ollama with Llama 2 locally** for semantic DOM translation.
- Simple, readable Python scripts tie them together.

This minimalist setup is exactly the combination of clarity, maintainability, and flexibility you've been describing.

---

**You're already nearly there.**  
Just give yourself permission to avoid complicated frameworks.  
Embrace simplicity, clarity, and your Python scripting intuition. **That's what you're really looking for.**

---

**Me**: Fair enough. But I meant to ask you that with Deep research turned on. You say "not yet", but I'm skeptical. Can you go looking? It seems like it's one of the main things like called stuff like fire scraper and ai crawlers are doing. They have an emphasis on markdown conversion and the like. Some must have DOM simplification. Back in the day there was a Python package called Mechanize (today MechanicalSoup). Those aren't precisely what I want because they don't do JavaScript, but that starts to get in the neigborhood, if only they controlled real browsers. So can you dig deep? I imagine it's very tangential to the Selenium and Playwright software testing communities.

**ChatGPT 4.5**: Got it! To ensure I focus on the right areas, could you confirm a few details:

- Are you specifically looking for Python-based browser automation tools that simplify DOM interaction using LLMs (e.g., via Ollama)?
- Do you want the tools to work with real browsers like Chrome and Firefox (i.e., not headless-only solutions like MechanicalSoup)?
- Should the emphasis be on extracting information (scraping/converting to Markdown) or interacting with pages (clicking, typing, navigating, etc.)?
- Would you prefer open-source, actively maintained projects, or are niche/experimental solutions also of interest?

This will help me dig deep into browser automation, AI-assisted DOM simplification, and relevant communities.

**Me**: 

1. The DOM simplification. It doesn't directly need Ollama integration. The ideal is that I make "servers" using MCP wrapping -- someday when it stabilizes, or something like it. Simplifying the browser instructions is more important than LLM interaction.
2. Yes, real browsers. No headless-only solutions. To the extreme. I want access to http response headers. That alone almost rules out Selenium. Yes, I know there's ways, but think how much of that is simplified by just going with Puppeteer or Playwright automators.
3. Interacting with pages! We are going to focus on automation. We can always layer on extraction with well established tools like BeautifulSoup. Elegant, robust, simplified automation is the elusive part. 
4. Prefer open-source? It should only be open source. And yes, as mainstream and actively maintained as possible. But I know that is a tall order and probably doesn't exist or I would have heard of it. I am aware you will need to dig niche. But I hate bleeding on the edge and having carpets pulled out from under me.

**ChatGPT 4.5**: Got it! I’ll dig deep into open-source Python-based browser
automation tools that focus on **DOM simplification** while working with **real
browsers** (not just headless automation). The focus will be on **interaction,
not just extraction**, with an emphasis on using Playwright or Puppeteer to
avoid Selenium's HTTP header limitations. I'll prioritize **mainstream, actively
maintained** projects while also scouting promising niche solutions. I'll get
back to you with what I find.

Got it! I’ll dig deep into open-source Python-based browser automation tools that focus on **DOM simplification** while working with **real browsers** (not just headless automation). The focus will be on **interaction, not just extraction**, with an emphasis on using Playwright or Puppeteer to avoid Selenium's HTTP header limitations. I'll prioritize **mainstream, actively maintained** projects while also scouting promising niche solutions. I'll get back to you with what I find.

# Open-Source Python Tools for High-Level Browser Automation

Several actively maintained Python libraries simplify browser automation by offering high-level, semantic APIs on top of real web browsers. These tools abstract away raw DOM selectors (CSS/XPath) and let you interact with pages more naturally. They often leverage modern browser engines (Playwright/Puppeteer) for robust network control (e.g. HTTP headers), and focus on comprehensive web interactions (clicking, typing, form-filling, navigation). Below are some notable tools that meet these criteria, with their key features and references to their repositories and documentation.

## Playwright (Python)

Playwright for Python is a powerful official library from Microsoft for automating Chrome, Firefox, and WebKit browsers. It provides a high-level API for common user actions (navigation, clicking, form input, dialogs, etc.) and includes quality-of-life features like automatic waits and convenient element locators by text or role ([The ultimate Playwright Python tutorial | BrowserStack](https://www.browserstack.com/guide/playwright-python-tutorial#:~:text=Playwright%20in%20Python%20is%20a,ups%20or%20modal%20dialogs)). Under the hood, Playwright uses the Chrome DevTools Protocol to drive browsers, enabling deep control over network traffic and HTTP responses not easily possible with older WebDriver tools ([The ultimate Playwright Python tutorial | BrowserStack](https://www.browserstack.com/guide/playwright-python-tutorial#:~:text=,Protocol%20to%20control%20the%20browser)). It supports both headless and headful (visible) browser modes, so you can automate real browser windows. Playwright is open-source (MIT licensed) and actively maintained by Microsoft, with thorough documentation on the [official site](https://playwright.dev/python/docs/intro) and a growing user community.

**Features:**

- **Cross-Browser Automation:** Single API to control Chromium (Chrome/Edge), Firefox, and WebKit (Safari) across Windows, Linux, and macOS ([The ultimate Playwright Python tutorial | BrowserStack](https://www.browserstack.com/guide/playwright-python-tutorial#:~:text=Playwright%20in%20Python%20is%20a,ups%20or%20modal%20dialogs)). 
- **Robust Interactions:** Handles waits, asserts element readiness (actionability), and can simulate real user gestures. Built-in locators allow selecting elements by text content, form labels, ARIA roles, etc., reducing the need to write custom CSS/XPath.
- **Network Control:** Ability to intercept requests/responses, access headers, and mock endpoints thanks to DevTools integration ([The ultimate Playwright Python tutorial | BrowserStack](https://www.browserstack.com/guide/playwright-python-tutorial#:~:text=,Protocol%20to%20control%20the%20browser)). This makes Playwright suitable not just for testing but also for scraping dynamic sites and monitoring network data.
- **Headless/Headful Modes:** Can run tests invisibly for speed or control a visible browser for debugging. Also supports parallel execution and context isolation for scalable automation.

**Repository & Docs:** Playwright’s source is on GitHub under **microsoft/playwright-python**, and comprehensive documentation and examples are available on the [Playwright website](https://playwright.dev/python/docs/intro) ([The ultimate Playwright Python tutorial | BrowserStack](https://www.browserstack.com/guide/playwright-python-tutorial#:~:text=Playwright%20in%20Python%20is%20a,ups%20or%20modal%20dialogs)). (The official docs detail installation, selectors, assertions, and more.)

## Pyppeteer (Python Puppeteer Port)

Pyppeteer is an open-source Python port of Google’s Puppeteer, allowing Python scripts to automate Chromium browsers via the DevTools protocol. It exposes Puppeteer’s high-level browser control in Python, giving developers full **JavaScript-rendering** capability and the ability to simulate human-like browsing ([7 BeautifulSoup Alternatives for Developers - ZenRows](https://www.zenrows.com/alternative/beautifulsoup#:~:text=match%20at%20L371%20Pyppeteer%20is,all%20library%20for%20accessing%20a)). Like Puppeteer, Pyppeteer can drive Chrome/Chromium in headless or visible mode, executing clicks, typing, navigation, and more. This makes it a “one-size-fits-all” library for complex web automation that needs to interact with SPA or JS-heavy pages ([7 BeautifulSoup Alternatives for Developers - ZenRows](https://www.zenrows.com/alternative/beautifulsoup#:~:text=match%20at%20L371%20Pyppeteer%20is,all%20library%20for%20accessing%20a)). It supports getting network responses and console logs, which is helpful for scraping and monitoring. 

However, note that the original Pyppeteer project is **unofficial and was inactive for some time** ([7 BeautifulSoup Alternatives for Developers - ZenRows](https://www.zenrows.com/alternative/beautifulsoup#:~:text=However%2C%20Pyppeteer%20can%20get%20resource,updates%20for%20a%20long%20time)). A community-maintained fork now continues development to keep it compatible with modern Chromium. Despite this, Pyppeteer remains a popular choice for Python users who prefer Puppeteer’s semantics over Selenium. Its API usage is very similar to Puppeteer’s (Node.js) API, but in Python. Basic actions like `await page.goto(url)`, `await page.click(selector)` are available, and you can evaluate page scripts for more advanced interactions. 

**Features:**

- **Headless Chrome Automation:** Controls a real Chromium/Chrome browser through DevTools. Can run headlessly for performance, or headful for debugging ([Pyppeteer: Use Puppeteer in Python [2025] - ZenRows](https://www.zenrows.com/blog/pyppeteer#:~:text=Pyppeteer%20is%20a%20tool%20to,and%20simulate%20human%20behavior%20better)).
- **High-Level Page Methods:** Provides methods for clicking elements, typing text, taking screenshots, retrieving page content, etc., without requiring manual DOM parsing.
- **JavaScript Execution:** Execute custom JS in the page context to find elements or trigger events, which helps when a direct selector isn’t enough.
- **Network/Media Control:** Access to response data, ability to set user-agent, handle downloads, and other Chrome capabilities (as exposed by Puppeteer).

**Repository & Docs:** The community fork of Pyppeteer is on GitHub under the **pyppeteer/pyppeteer** organization. Documentation can be found on the README and in tutorials (e.g. ZenRows’ guide to Pyppeteer ([7 BeautifulSoup Alternatives for Developers - ZenRows](https://www.zenrows.com/alternative/beautifulsoup#:~:text=match%20at%20L371%20Pyppeteer%20is,all%20library%20for%20accessing%20a))). Given Pyppeteer’s status, users might also refer to Puppeteer’s official docs for analogous usage, adapting examples to Python.

## Splinter

Splinter is a high-level web automation layer for Python that sits on top of browser drivers (primarily Selenium WebDriver). Its goal is to provide a **human-friendly, Pythonic API** for browser actions so you don’t need to directly use CSS selectors or driver calls ([Why Use Splinter? - Splinter 0.21.0 documentation](https://splinter.readthedocs.io/en/latest/overview/why.html#:~:text=The%20project%20has%20two%20primary,goals)). With Splinter, you can write scripts like a sequence of user steps: visit a URL, fill a text field, click a button by its text, etc., in a few lines. Underneath, it can use real browsers (Chrome, Firefox, etc. via Selenium, or even mechanize/Zope for headless needs) but you mostly interact with its simplified commands.

Splinter’s API includes methods such as `browser.visit(url)`, `browser.find_by_text("Next").click()`, `browser.fill("q", "search term")`, and so on, abstracting away the need to manually locate elements with complex XPaths. It also handles common automation tasks like waiting for elements, switching context (iframes, alerts), and retrieving results. Splinter is actively maintained by the community (the **cobrateam/splinter** project) and is often used in testing or scraping projects for quicker scripting.

**Features:**

- **Unified High-Level API:** Same script works with different browser back-ends by changing a driver string (e.g. Chrome, Firefox, PhantomJS, etc.). The API is consistent, focusing on actions like visit, find, fill, click, check/uncheck (for checkboxes), attach_file, etc. ([Why Use Splinter? - Splinter 0.21.0 documentation](https://splinter.readthedocs.io/en/latest/overview/why.html#:~:text=The%20project%20has%20two%20primary,goals)).
- **Element Queries by Semantics:** Supports finding elements by text, by value, by tag, element type, etc., not just by CSS/XPath. For example, `browser.find_by_id("submit")` or `browser.find_by_name("search")` returns element objects you can interact with. This reduces the need to write raw selectors.
- **Browser Control:** Can interact with real browser windows through Selenium (it launches a browser for you). It also can take screenshots, manipulate cookies, and execute JavaScript if needed.
- **Error Handling & Stability:** Splinter tries to guard against common automation issues (like waiting for elements to appear). Its abstraction makes scripts more stable to minor page changes, since you often target elements in a broader way than brittle XPaths.

**Repository & Docs:** The project is open-source on GitHub at **cobrateam/splinter**. Documentation is available on [ReadTheDocs](https://splinter.readthedocs.io) with tutorials and an API reference. The docs highlight Splinter’s design of a “common, high-level API” for web automation that is easy to learn and use ([Why Use Splinter? - Splinter 0.21.0 documentation](https://splinter.readthedocs.io/en/latest/overview/why.html#:~:text=The%20project%20has%20two%20primary,goals)).

## Helium

Helium is a lightweight Python library that aims to make web automation *feel* simpler than Selenium. It wraps the Selenium WebDriver API with an expressive, high-level interface so that you can refer to page elements the way a human would – by visible text labels, form field placeholders, and other semantic cues ([GitHub - mherrmann/helium: Lighter web automation with Python](https://github.com/mherrmann/helium#:~:text=Under%20the%20hood%2C%20Helium%20forwards,in%20the%20underlying%20web%20page)). As an example, with Helium you can do: 

```python
from helium import *  
start_chrome("https://example.com")  
click("Login")            # clicks element with text "Login"  
write("user@example.com", into="Email")  # types into the field labeled "Email"  
```

This code requires no explicit selectors; Helium finds the “Login” button and the “Email” input box by their display text or label ([GitHub - mherrmann/helium: Lighter web automation with Python](https://github.com/mherrmann/helium#:~:text=Under%20the%20hood%2C%20Helium%20forwards,in%20the%20underlying%20web%20page)). It significantly reduces the verbosity of typical Selenium scripts (Helium’s author claims scripts are 30-50% shorter) and increases readability. Helium supports real Chrome or Firefox browsers (it launches them via Selenium under the hood, so you see a real browser) and is suitable for tasks like filling forms, clicking links, and navigating pages.

**Features:**

- **Semantic Element Selection:** Identify elements by human-visible strings (link text, button text, field labels) rather than technical selectors ([GitHub - mherrmann/helium: Lighter web automation with Python](https://github.com/mherrmann/helium#:~:text=Under%20the%20hood%2C%20Helium%20forwards,in%20the%20underlying%20web%20page)). This abstraction makes the automation script closer to how a manual tester describes actions.
- **Minimal Boilerplate:** Provides top-level functions like `start_chrome()`/`start_firefox()`, `go_to()`, `write()`, `click()`, etc. that wrap Selenium calls. You don’t need to manage waits or driver details explicitly for most cases.
- **Mix and Match with Selenium:** Since it uses Selenium internally, you can still drop down to Selenium’s API if needed for edge cases ([GitHub - mherrmann/helium: Lighter web automation with Python](https://github.com/mherrmann/helium#:~:text=Because%20Helium%20is%20simply%20a,For%20example)). This gives flexibility to handle complex scenarios without losing Helium’s simplicity for 90% of the interactions.
- **Supports Headless Mode:** If needed, you can run Helium with headless browsers as well (it’s essentially configuring Selenium options), but typically it’s used with visible browsers for interactive tasks or testing.

**Repository & Docs:** Helium is open-source (MIT) on GitHub (**mherrmann/helium**). Its [documentation](https://helium.readthedocs.io) explains the simple API and provides a cheatsheet for common actions. The docs note that *“Helium...lets you refer to elements by user-visible labels. As a result, Helium scripts are easier to read and more stable with respect to changes in the underlying page.”* ([GitHub - mherrmann/helium: Lighter web automation with Python](https://github.com/mherrmann/helium#:~:text=Under%20the%20hood%2C%20Helium%20forwards,in%20the%20underlying%20web%20page)).

## RPA for Python (TagUI)

**RPA for Python** (also known by its package name `rpa` or TagUI for Python) is an open-source RPA (Robotic Process Automation) library that allows high-level web (and desktop) automation via Python. It acts as a wrapper to the TagUI tool from AI Singapore, enabling Python scripts to drive a real Chrome browser and even interact via computer vision. Its simple API makes it possible to automate web tasks without worrying about DOM details – for instance, you can call `r.url("http://example.com")` to navigate, `r.click("Sign In")` to click a button (it will try to find an element with that text or identifier), and `r.type("Username", "alice")` to fill a field ([GitHub - tebelorg/RPA-Python: Python package for doing RPA](https://github.com/tebelorg/RPA-Python#:~:text=,move%20mouse%20to%20element)) ([GitHub - tebelorg/RPA-Python: Python package for doing RPA](https://github.com/tebelorg/RPA-Python#:~:text=,return%20file%20content)). 

One of RPA for Python’s strengths is that an **element identifier can be a string of visible text or even an image**. If you pass an image file path or a text to `r.click()`, the library will either find the image on the screen or use OCR to find the text on the page and click it ([GitHub - tebelorg/RPA-Python: Python package for doing RPA](https://github.com/tebelorg/RPA-Python#:~:text=,and%20macOS%20%20111)). This means you can automate even when you don’t have reliable DOM selectors, truly abstracting away CSS/XPath usage. TagUI (and by extension this library) uses Chrome DevTools under the hood to control the browser, so it handles HTTP requests and dynamic content well. It also supports mixing in SikuliX for desktop GUI automation, but for web automation the focus is on ease of use and resiliency.

**Features:**

- **Very High-Level Commands:** Functions like `url()`, `click()`, `type()`, `read()` cover common interactions with minimal parameters ([GitHub - tebelorg/RPA-Python: Python package for doing RPA](https://github.com/tebelorg/RPA-Python#:~:text=,move%20mouse%20to%20element)). You supply what a human might look for (text on a button, etc.), and TagUI figures out the rest (using ID, name, XPath internally, or fallback to visual search).
- **Hybrid DOM and Visual Automation:** If a target element can’t be found by standard means, you can provide a screenshot of the element or just its visible text. The library will perform image matching or OCR text search on the page to interact with it ([GitHub - tebelorg/RPA-Python: Python package for doing RPA](https://github.com/tebelorg/RPA-Python#:~:text=,and%20macOS%20%20111)). This is useful for complex web apps or even automating non-HTML interfaces.
- **Real Browser Control:** Launches an actual Chrome browser (or can attach to an open one) by default (headless optional). It executes steps in a real page context, so all JavaScript and network activity occurs as if a user is driving the browser.
- **Robust and Maintained:** TagUI’s Python integration is maintained by TagUI’s creator, Ken Soh, and the open-source community ([Tools — TagUI 6.110.0 documentation](https://tagui.readthedocs.io/en/latest/tools.html#:~:text=RPA%20for%20Python%20is%20a,TagUI%E2%80%99s%20creator%20Ken%20Soh%20%40kensoh)). It’s stable and has been used in many RPA scenarios. You can combine it with Python logic to build end-to-end automation workflows that involve web interactions and even local file or OS operations.

**Repository & Docs:** The library’s source is on GitHub (**tebelorg/RPA-Python**) ([GitHub - tebelorg/RPA-Python: Python package for doing RPA](https://github.com/tebelorg/RPA-Python#:~:text=RPA%20for%20Python%27s%20simple%20and,applications%2C%20or%20the%20command%20line)), and it wraps the TagUI engine (**aisingapore/TagUI**). Documentation and usage examples are available on the GitHub README and the TagUI official docs (see “RPA for Python” section) ([Tools — TagUI 6.110.0 documentation](https://tagui.readthedocs.io/en/latest/tools.html#:~:text=RPA%20for%20Python%20is%20a,TagUI%E2%80%99s%20creator%20Ken%20Soh%20%40kensoh)). The project is open-source (Apache 2.0 license) and free to use.

## Skyvern (AI-Powered Browser Agent)

Skyvern is an emerging open-source project that takes a novel approach to browser automation: it uses **AI agents (powered by large language models and computer vision)** to interpret what needs to be done on a web page, instead of relying on fixed selectors. It runs real browsers via Playwright, and layers an intelligent planning system on top to achieve goals like a human would. The Skyvern system parses page content and identifies interactable elements, plans a sequence of actions (clicks, form fills, navigations) to accomplish a given task, and executes them through Playwright ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=Skyvern%20was%20inspired%20by%20the,browser%20automation%20libraries%20like%20Playwright)) ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=Skyvern%20uses%20a%20swarm%20of,plan%20and%20execute%20its%20actions)). Because it doesn’t rely on hard-coded XPaths or CSS selectors, it’s more robust to layout or content changes – the AI looks at the page structure and content dynamically. In fact, *“Skyvern is resistant to website layout changes, as there are no pre-determined XPaths or other selectors”* that it depends on ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=2,to%20a%20large%20number%20of)).

Skyvern’s use of multiple specialized agents allows it to handle complex scenarios (login flows with 2FA, form submissions, data extraction) in a semantic way. For example, it has a **Navigation Agent** that decides which button or link to click next based on the goal, and a **Data Extraction Agent** that can read page text or tables into structured data ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=Skyvern%20uses%20a%20swarm%20of,plan%20and%20execute%20its%20actions)). This is guided by prompt instructions or goals you provide. Essentially, you describe *what* you want (in a prompt), and the AI figures out *how* to do it on the webpage, issuing Playwright commands behind the scenes.

**Features:**

- **LLM-Driven Automation:** Uses a large language model to understand instructions and page content, eliminating the need for the user to write low-level browser code. It can generalize actions, like “click the **Login** button”, by understanding the page, without an explicit selector for the login button ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=2,to%20a%20large%20number%20of)).
- **Playwright Backend:** All interactions are executed through Playwright, meaning it works on Chrome, Firefox, etc., and can capture network events. This satisfies the requirement for real browser control with robust HTTP handling.
- **Multi-Agent Workflow:** Different AI agents handle element detection, navigation planning, form filling (including handling passwords and 2FA), and information extraction ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=Skyvern%20uses%20a%20swarm%20of,plan%20and%20execute%20its%20actions)) ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=complete%20a%20task,defined%20secrets)). This modular design allows tackling complex tasks step by step, much like an autonomous “AI crawler”.
- **Extensibility and Monitoring:** You can run Skyvern in a visible mode to watch what it does, which is useful for debugging its decisions ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=machine%20so%20that%20you%20can,website%2C%20and%20intervening%20when%20necessary)). It’s also possible to give it feedback or adjust prompts if it’s not doing exactly what you intend, guiding the AI behavior.

**Repository & Docs:** Skyvern is hosted on GitHub under **Skyvern-AI/skyvern**. The README provides usage examples and explains its architecture and capabilities ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=Skyvern%20was%20inspired%20by%20the,browser%20automation%20libraries%20like%20Playwright)) ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=Skyvern%20uses%20a%20swarm%20of,plan%20and%20execute%20its%20actions)). Being a new project, documentation is evolving, but the open-source community is actively refining it. (Skyvern is AGPL-licensed, and a cloud service is offered, but the core is free to use locally.)

**Related AI Projects:** Skyvern is part of a wave of AI-infused automation tools sometimes dubbed “AI crawlers.” Another example is **BrowserPilot**, which uses OpenAI’s GPT-3 to translate natural language instructions into Selenium browser actions ([GitHub - handrew/browserpilot: Natural language browser automation](https://github.com/handrew/browserpilot#:~:text=It%20helps%20if%20you%20are,find%20the%20first%20visible%20textarea)). These tools are experimental but demonstrate how higher-level semantics (even plain English instructions) can drive real browser automation. They abstract away DOM manipulation almost entirely – you tell the AI agent your goal, and it handles the DOM interaction details.

### References

1.  ([The ultimate Playwright Python tutorial | BrowserStack](https://www.browserstack.com/guide/playwright-python-tutorial#:~:text=Playwright%20in%20Python%20is%20a,ups%20or%20modal%20dialogs)) ([The ultimate Playwright Python tutorial | BrowserStack](https://www.browserstack.com/guide/playwright-python-tutorial#:~:text=,Protocol%20to%20control%20the%20browser)) – *Playwright Python overview and DevTools integration (BrowserStack Guide, 2025).*  
2.  ([7 BeautifulSoup Alternatives for Developers - ZenRows](https://www.zenrows.com/alternative/beautifulsoup#:~:text=match%20at%20L371%20Pyppeteer%20is,all%20library%20for%20accessing%20a)) ([7 BeautifulSoup Alternatives for Developers - ZenRows](https://www.zenrows.com/alternative/beautifulsoup#:~:text=However%2C%20Pyppeteer%20can%20get%20resource,updates%20for%20a%20long%20time)) – *Pyppeteer description and maintenance status (ZenRows – BeautifulSoup Alternatives, 2024).*  
3.  ([Why Use Splinter? - Splinter 0.21.0 documentation](https://splinter.readthedocs.io/en/latest/overview/why.html#:~:text=The%20project%20has%20two%20primary,goals)) – *Splinter documentation – High-level API goal and human-friendly abstraction (Splinter ReadTheDocs).*  
4.  ([GitHub - mherrmann/helium: Lighter web automation with Python](https://github.com/mherrmann/helium#:~:text=Under%20the%20hood%2C%20Helium%20forwards,in%20the%20underlying%20web%20page)) – *Helium README – High-level, user-visible element reference vs Selenium selectors (Helium GitHub).*  
5.  ([GitHub - tebelorg/RPA-Python: Python package for doing RPA](https://github.com/tebelorg/RPA-Python#:~:text=RPA%20for%20Python%27s%20simple%20and,applications%2C%20or%20the%20command%20line)) – *RPA for Python (TagUI) GitHub README – Simplified RPA API for web/desktop automation.*  
6.  ([GitHub - tebelorg/RPA-Python: Python package for doing RPA](https://github.com/tebelorg/RPA-Python#:~:text=,move%20mouse%20to%20element)) ([GitHub - tebelorg/RPA-Python: Python package for doing RPA](https://github.com/tebelorg/RPA-Python#:~:text=,and%20macOS%20%20111)) – *TagUI Python package functions (url, click, type) and image/OCR element identification (GitHub).*  
7.  ([Tools — TagUI 6.110.0 documentation](https://tagui.readthedocs.io/en/latest/tools.html#:~:text=RPA%20for%20Python%20is%20a,TagUI%E2%80%99s%20creator%20Ken%20Soh%20%40kensoh)) – *TagUI official docs – “RPA for Python” intro (TagUI creator maintains it, uses TagUI engine) .*  
8.  ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=Skyvern%20was%20inspired%20by%20the,browser%20automation%20libraries%20like%20Playwright)) ([GitHub - Skyvern-AI/skyvern: Automate browser-based workflows with LLMs and Computer Vision](https://github.com/Skyvern-AI/Skyvern#:~:text=2,to%20a%20large%20number%20of)) – *Skyvern README – AI agent approach using Playwright, no hard-coded selectors (GitHub).*  
9.  ([GitHub - handrew/browserpilot: Natural language browser automation](https://github.com/handrew/browserpilot#:~:text=It%20helps%20if%20you%20are,find%20the%20first%20visible%20textarea)) – *BrowserPilot README – Using GPT-3 to turn natural language into browser automation steps (GitHub).*

---

## Gemini's Take

### Titles and Headlines

* **Beyond Agentic Frameworks: My Quest for Simpler Browser Automation**
* **Taming the DOM: How LLMs Can Simplify Browser Interaction**
* **The Elusive Quest for the Perfect Local Browser Automation Tool**
* **Agentic Frameworks vs. DIY: Finding the Right Balance for Browser Automation**
* **Unlocking the Power of Local LLMs for Semantic Browser Control**

### Opinion

The article presents a compelling case for simplifying browser automation using local LLMs. The author's desire for a more natural and intuitive way to interact with web pages is understandable, and the proposed approach of combining Playwright or Puppeteer with a local LLM like Llama 2 seems promising. The exploration of various open-source tools and the emphasis on avoiding cloud dependencies are also noteworthy.

It's clear that the author is passionate about finding the right tool for the job, and their willingness to experiment and explore different options is commendable. The article is informative and insightful, and it provides a valuable perspective on the current state of browser automation.

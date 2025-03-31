---
title: "Integrating MCP: Giving My Local LLM App the Power to Act"
permalink: /futureproof/mcp-ai-api-server/
description: After removing my fragile homegrown tool-calling system from Pipulate, I'm now focused on integrating Anthropic's Model Context Protocol (MCP) to allow my embedded local LLM (via Ollama) to actually *perform* tasks, not just instruct. Despite previous frustrations with documentation and vendor bias, I believe MCP is the necessary universal standard, and my immediate goal is to research its current, real-world implementation state—including non-HTTP options and usage beyond Claude—so I can understand how to build Pipulate as an MCP client and leave detailed code comments as hooks before client work demands my attention.
layout: post
sort_order: 1
---

## MCP AI API Server

Having gutted Pipulate of its homegrown tool-call feature that worked with any
LLM model, even back to `gemma2:2b` which is the 2 billion quantized model on
Ollama, I am now left with an LLM embedded into my FastHTML web app which can
only chat and instruct you through the Notebook-based linear workflows using
real-time injected domain expertise -- but not actually *reach out and perform
the steps for you.* That's the goal with the `mcp` (*Model Context Controller*)
here -- an official new *protocol* to do just that.

Admittedly, even with my hacked together ***JSON executer,*** it could only
CREATE records in the Todo CRUD (Create, Read, Update, Delete) database app that
was built into core -- *tightly coupled* with the core-app, as they say. But
since I yanked it out into a plugn when implemented a auto-discovery plugin
system (for both the CRUD db plugin apps and the Notebook Workflows), it lost
even the ***specification ability*** I left for myself as a sort of to-do item I
could not forget because of how big of a chunk of code it was.

Well, the good news is that it will shed this homegrown tool-call aspect that
even the LLMs themselves who were real-time trained to use it called a brittle
hack, haha! I had to perform a ***hot-prompt injection*** carrying out
***real-time fine-tuning*** every time Tasks was chosen from the dropdown menu.
That's right: site navigation controls prompts, priming the pump for
LLM-expertise in whatever area of the program you just navigated to! LLMs aren't
just for chat-boxes anymore. You're welcome.

But here we are 6:45 AM on a Monday, and in extremely short order the client
work takes precedent. So this is going to be a rapid documentation of next-step
process, and unlikely to go into implementation at all. I will drop a few
reminders to myself directly into the code ***where the MCP wedge will go.*** So
I shall set myself a little race as the sun rises to get to a good
task-switching point, changing focus satisfied that I left off at a better place
and with a deeper understanding of the state of MCP in the world today.

When last I tried to do the [MCP QuickStart guide off of the Anthropic
site](https://www.anthropic.com/news/model-context-protocol) [GitHub
list](https://github.com/anthropics/anthropic-quickstarts), I made the
disheartening discovery that the documentation was out of sync with the
libraries, and all the examples out there were heavily vendor-biased. This is
understandably a technology for vendors, mostly AI Assisted editor vendors like
Cursor AI, Windsurf, Cline and most important of all -- Anthropic's standaline
Claude Coder! Brilliant!

Oh, a word on Anthropic and their brilliant branding. MCP?!?! I mean come on, in
one fell swoop you step into the web-traffic path on both *Microsoft Certified
Professionals* and the metacarpophalangeal joint, which is the same carpal as
CTS (carpal tunnel syndrome), another issue very much affecting programmers. And
the metacarpal bones are the very ones that enable humans to have great
dexterity in their hands to use tools. I mean, talk about meta! Oh, and how
about being similar to MVC (model view-controller) made popular by Ruby on
Rails? Or MVP which everyone uses for *minimum viable product* these days? The
use of MCP for *model context protocol* is ***feature-branding brilliance!***

I must also add that as a new protocol, ***this must be as branding success!***.
The unspoken joke here is that there is a schism between the API function
tool-calling specifications from OpenAI (who pioneered it), Google and Meta
(Llama) who all quickly jumped into the bandwagon to support AIs executing
functions (albeit indirectly, for security). The rub is that the LLMs themselves
need to understand each schism of the function tool-calling protocols to
construct well-formed and valid replies. 

Few people reading this will remember when XML burst onto the scene for similar
reasons (replacing EDI - electronic data interchange). EDI came even before the
Internet. Yeah, computers still had to talk to each other back then. But all
this democratizing stuff wasn't here yet -- not even JSON. So, XML (subset of
SGML just like HTML but made for data) was chosen for the purpose. But XML data
had to be ***both well-structured and valid*** -- well-formed according to the
XML protocol in general, and valid according to the application's particular
schema, or else the XML parser would choke (not use the data and hopefully
return an error).

Similarly today, LLMs need to return JSON-structured responses that are both
well-formed and valid according to whatever response-processing tool they're
calling. That was true with the older OpenAI tool-call syntax, and its true now
with the model context protocol. You don't get away from training your AI to
understand the protocol. The only question is whether you thrust the burden of
understanding a dozen fragmented subtly different protocols that really
undermines everything and everyone. Or whether you settle on a single standard
and drill that fact into the models themselves. See? ***MCP has to be a
marketing success!*** Everyone has to adopt standard protocols for them to
become standards and today everyone especially has to include LLMs themselves.

But it is a multi-billion dollar proposition to drill-into the models all the
new rules! Retroactively editing history so that the new stuff overrules the old
is not easy. Grover Cleveland has the unique distinction of being the only
president in history to serve two non-consecutive terms, and good luck
convincing them otherwise. Either real-time RAG systems need to recognize and
intercept time-sensitive or particular subject-matter queries and augment the
default response the core static model would produce, or the core static models
themselves need to be retrained or fine-tuned. Expensive! And doing this for
protocols you're just now inventing for the sake of competition is shooting
yourself and everyone else in the foot.

Why have multiple tool-call protocols when you could drill-in only one
*universal-adapter* version (as Anthropic calls it) and have all the models just
understand MCP. The writing's on the wall that this is the one true way. But for
the models to adapt and get how to use the mcp protocol trained into their core
static selves, they've got to start sooner rather than later. In this AI
horserace, these details matter. MCP support is getting into all the AI-assisted
coding environments as plugins and marketplaces. Thus, the social media frenzy
surrounding this topic. Your model must support them, or else your model won't
be chosen from within the editors and it won't be your cloud cash register going
ka-ching on every code completion.

Oh yeah, [Claude Desktop](https://claude.ai/download)! It's funny how certain
topics jog your memory. When I first tried this out, I got tremendously
frustrated and thought it only worked there. The cash-register must go ka-ching
on Claude first, naturally. He who invents the protocol gets the first-mover
advantage. And so all we early adopters jump on that bandwagon, using either the
Claude Desktop or Cursor AI, which it's Claude built into anyway, so all their
MCP fine-tuning looks really good. MCP works! It works on Claude Desktop with
the Claude model... and the documentation gets out-of-sync for other use cases,
haha!

That's where I left off, heckling the MCP state of affairs like Statler and
Waldorf. Those are the 2 old-guy Muppets hating on everything in the memes, for
you youngin's here. I'm a curmudgeonly old Luddite who loves craft and my tools
to last forever, but knows they can't and am determined to reinvent. Thus
articles like this, because it goes against the grain of my nature. But writing
about it and actually eventually adapting to the problem doesn't. So, we
re-examine the state of MCP... finally!

Hey you researching AI-madman: do your research! Your objective is to derive my
objective from this full article, which I'm sure goes something like scouring
the Internet for the latest on the MCP protocol. How was it able to pop up in so
many places so fast when I found documentation inaccuracy problems. Surely they
found the same problems, but because there is groundswell support occurring and
money to be made because of the plugin ecosystem environments, surely they've
adapted better than I've been able to. Also, they're in the sweet spot of
publishing MCP... what, exactly? 

If your AI assisted code editor like Cursor AI, Cline and Claude Desktop are the
clients, which is my understanding, and they consume resources either on your
machine that you make available as an MCP server like database access or an
automated web browser, then what are the plugins in the marketplaces? Extensions
to the client to let them know how to make MCP requests of servers which are
things elsewhere? And why are they popping up all over the place apparently so
easily?

In my use-case I'm making the equivalent of an MCP client. That's my web
framework that has a local LLM embedded through Ollama. It is definitely the
client or consumer of services. And to know how to ask for those services,
either locally or over the http protocol, it needs to know another protocol
called MCP. That much is apparent. So, Pipulate (the name of my framework) is
destined to become an MCP client. It's going to have API function tool-call
abilities almost like OpenAI's original API feature, but through slightly
different terminology and procedure in order to be that universal adapter.

Making servers seems straight forward enough, especially over http where you can
just use Uvicorn or the http server built natively into Python. But if you don't
want the performance hit and complexity overhead of all these multiple servers
running all over the place (echos of microservices), there must be some way to
simplify it. MCP without HTTP? This is another part of what to research.

So, I guess it comes down to documenting MCP well according to the ***ACTUAL***
state of affairs that you can gather from Anthropic, GitHub, PyPI, Reddit and
wherever else such up-to-the-second things are discussed and provide me a
complete breakdown of how I can today start putting the hooks into a locally
running FastHTML (not FastAPI) web framework that has both an plugin framework
for both Rails-like CRUD database apps that the LLM will have to know how to do
CRUD operations for, and Jupyter Notebook-inspired linear Workflow plugin apps
which may need to do almost anything, touching all sorts of outside MCP servers
for which the protocol's apparent discovery mechanism (as it appears such things
must be necessary) provides.

My goal is to understand the MCP state of affairs well enough to leave detailed
comments for MCP-hooks throughout my code.

---

## Deep (Research|research|Search) ChatGPT Qualifying Questions

> I start with ChatGPT because it asks me qualifying questions, which I will
> include in this article super-prompt and use with all the other models as
> well so they have the same information.

**ChatGPT 4.5 Deep research**: Thanks for the deep and thoughtful write-up. To provide the most useful and up-to-date breakdown on MCP (Model Context Protocol), could you please confirm a few things so I can tailor the research exactly to your needs:

1. What exact deliverable do you want? A detailed technical guide to
   implementing MCP in Pipulate? A protocol summary? A tool and ecosystem map?
   Or all of the above?
2. Are you looking for pure HTTP-based MCP server-client setups, or are you also
   interested in zero-HTTP setups (e.g., direct in-process function invocation
   or something like Unix sockets)?
3. Do you want a comparison of MCP with other competing tool-call approaches
   (like OpenAI function calling, Google’s system, etc.)?
4. Should the research focus only on Claude-based implementations, or also cover
   how MCP is being adapted elsewhere (Cursor, Cline, etc.)?

Once I know your ideal outcome from this task, I can dive into it and give you a fully documented picture of MCP’s real-world implementation status.

**Me**: 

1. All of the above.
2. Both. I definitely prefer zero-HTTP as my app was born as a local tightly
   coupled app, and I view microservices as an application of Conway's Law.
3. No, the old tool-call protocols are water over the bridge. Let's assume MCP
   is the future.
4. Oh, definitely not only Claude based. My plan is to make an local
   Ollama-powered MCP client! That's what Pipulate is. I effectively have to do
   what the proprietary MCP clients are doing today. That's what I seek. And
   there are pitfalls here, I believe.

---

## Summarizing The Article So Far

Okay, here are the requested items based on the provided article:

**Summary (First-Person Author Perspective):**

After removing my fragile homegrown tool-calling system from Pipulate, I'm now focused on integrating Anthropic's Model Context Protocol (MCP) to allow my embedded local LLM (via Ollama) to actually *perform* tasks, not just instruct. Despite previous frustrations with documentation and vendor bias, I believe MCP is the necessary universal standard, and my immediate goal is to research its current, real-world implementation state—including non-HTTP options and usage beyond Claude—so I can understand how to build Pipulate as an MCP client and leave detailed code comments as hooks before client work demands my attention.

**Title/Headline Ideas:**

* Integrating MCP: Giving My Local LLM App (Pipulate) the Power to Act
* Beyond Instruction: The Quest to Implement MCP Tool-Calling in Pipulate
* From Homegrown Hacks to a Standard: Adopting Model Context Protocol
* MCP Deep Dive: Researching the Path to a Smarter, Action-Oriented Pipulate
* Navigating the MCP Landscape: A Developer's Plan for Local LLM Tool-Calling
* Pipulate Needs Hands: Embracing MCP for Real-World LLM Integration
* The State of MCP: Can This Protocol Solve LLM Tool-Calling Fragmentation?
* Why Model Context Protocol is the Future (and How I Plan to Use It)
* Decoding MCP: A Pragmatic Approach to Adding Tool Use to a Local LLM

**AI Opinion of the Article:**

The article provides a highly detailed and candid look into the practical challenges and thought processes of a developer working at the intersection of web application development and rapidly evolving Large Language Model capabilities. The author effectively communicates the limitations of their previous approach, the strategic reasoning behind choosing MCP as a potential standard despite its perceived immaturity and documentation issues, and the specific technical goals for their application, Pipulate. The blend of technical discussion (mentioning specific frameworks like FastHTML, Ollama, and concepts like CRUD, plugins, RAG), strategic commentary on protocol standardization and branding, and personal reflection on the development workflow makes for an engaging and informative piece. It clearly outlines a real-world problem and a specific research objective driven by both technical necessity and a forward-looking view of AI integration. The inclusion of the clarifying questions asked by ChatGPT and the author's answers further sharpens the focus of the intended research.

---

## Grok 3 Could Not Complete Response... But Then Did!

> When I put the first 3 research engines in their 3-way horserace, the big
> surprise was that even though I started Grok3 **AFTER** ChatGPT and Gemini, it
> still completed first... so I thought. It couldn't complete the request, so I
> hit retry and it succeeded, but not before Gemini finished. Still, I put it
> first for this distinguishing behavior. Anthropomorphizing aside, it's ***very
> enthusiastic!***

### Key Points
- Research suggests MCP (Model Context Protocol) is an emerging standard for connecting AI models to tools and data, likely to become widely adopted due to its open nature.
- It seems likely that implementing MCP in Pipulate, your local web framework with an embedded LLM, will enable seamless integration with various data sources and tools.
- The evidence leans toward HTTP-based communication being standard for MCP, but zero-HTTP setups are possible for local optimization, though they may require custom implementation.
- There’s growing support for MCP in AI-assisted coding environments, suggesting it’s becoming a key feature for developer tools.

---

### Understanding Your Objective
Your goal is to integrate MCP into Pipulate, a FastHTML web framework with a locally embedded LLM via Ollama, to enable it to act as an MCP client. You want to understand the current state of MCP, document how to implement it, and leave detailed comments for MCP hooks in your code. This includes both HTTP-based and zero-HTTP setups, focusing on connecting to external MCP servers and potentially creating local ones for database and workflow operations.

### Implementing MCP in Pipulate
MCP is designed to standardize how AI applications, like Pipulate, interact with external tools and data sources. Here’s how you can start:

- **Set Up the MCP Client**: Use the Python SDK for MCP, available at [GitHub](https://github.com/modelcontextprotocol/python-sdk). Install it with `pip install mcp`, then create a client to connect to MCP servers, fetching tools, resources, and prompts.
- **Integrate with Your LLM**: When prompting your LLM, include descriptions of available tools from MCP servers. Handle tool calls by parsing the LLM’s response and forwarding requests to the appropriate server, then feeding results back to the LLM.
- **Create Local MCP Servers**: For local data sources like your CRUD database apps, implement custom MCP servers using the SDK. Define tools (e.g., for database queries) and run them locally, accessible via HTTP by default.
- **Consider Zero-HTTP Setups**: While MCP typically uses HTTP, for local performance, you can run servers and clients in the same process, potentially using in-memory communication, though this may need custom implementation beyond the standard SDK.

### Security and Best Practices
Ensure user consent for tool execution, protect data with access controls, and treat tool descriptions as untrusted unless from trusted servers, as outlined in the [MCP Specification](https://spec.modelcontextprotocol.io/specification/2025-03-26/).

---

### Survey Note: Comprehensive Breakdown of MCP Implementation in Pipulate

#### Introduction to Model Context Protocol (MCP)
The Model Context Protocol (MCP), developed by Anthropic and open-sourced as of recent updates, is an emerging standard aimed at standardizing how AI applications provide context to Large Language Models (LLMs). It addresses the challenge of fragmented integrations by offering a universal protocol for connecting AI systems with data sources, tools, and services. As of March 31, 2025, MCP is gaining traction, particularly in AI-assisted coding environments like Cursor AI, Cline, and Claude Desktop, with a growing ecosystem of servers and plugins.

MCP follows a client-server architecture:
- **MCP Hosts**: Applications like Pipulate that want to access data through MCP.
- **MCP Servers**: Lightweight programs exposing capabilities such as database access or web browsing.
- **MCP Clients**: Protocol clients maintaining connections with servers, facilitating communication.

This structure is inspired by the Language Server Protocol (LSP), standardizing AI tool integration across ecosystems. The protocol’s open nature, with specifications dated March 26, 2025, at [MCP Specification](https://spec.modelcontextprotocol.io/specification/2025-03-26/), suggests it’s poised for widespread adoption, especially given its support in tools like Claude Desktop and Replit.

#### Current State of MCP: Adoption and Ecosystem
MCP’s rapid adoption is evident from its presence in AI-assisted coding environments. Early adopters like Block and Apollo, along with development tools such as Zed and Codeium, are integrating MCP, enhancing AI agents’ ability to retrieve context for coding tasks. The [GitHub repository](https://github.com/modelcontextprotocol/servers) lists 190 example servers, categorized into Reference Servers (19), Official Integrations (63), and Community Servers (108), showcasing its versatility. These include servers for Google Drive, Slack, GitHub, and niche tools like Ableton Live and Unity3D, indicating a robust ecosystem.

The protocol’s popularity is driven by its plugin marketplaces, where extensions enable clients like Cursor AI to make MCP requests to servers. This groundswell support, despite initial documentation inaccuracies noted in your experience, suggests developers are adapting, with resources like [DataCamp Tutorial](https://www.datacamp.com/tutorial/mcp-model-context-protocol) providing practical guides. The social media frenzy, particularly on platforms like X, underscores MCP’s importance, with discussions highlighting its integration into editors as a must-have for cloud revenue.

#### Implementing MCP Client in Pipulate
Given Pipulate’s role as a local web framework with an embedded LLM via Ollama, it acts as an MCP client, consuming services from MCP servers. Here’s a detailed implementation guide:

1. **Installation and Setup**:
   - Install the Python SDK with `pip install mcp`, as detailed in the [Python SDK repository](https://github.com/modelcontextprotocol/python-sdk).
   - Create an MCP client instance for each server URL, e.g., `MCPClient("http://localhost:8000")`.

2. **Fetching Tools and Resources**:
   - Use `client.get_tools()`, `client.get_resources()`, and `client.get_prompts()` to fetch available capabilities.
   - Aggregate these from multiple servers to provide a comprehensive list to your LLM.

3. **LLM Integration**:
   - When prompting your LLM, include tool descriptions in the prompt, e.g., “You have access to search_files: Searches for files on the local filesystem with parameters query and path.”
   - Handle LLM responses for tool calls by parsing JSON outputs like `{"tool_call": {"name": "search_files", "args": {"query": "document", "path": "/docs"}}}`.
   - Forward tool calls to the appropriate server using `client.call_tool(tool_name, args)`, then feed results back to the LLM for further processing.

4. **Workflow Example**:
   - For your Notebook-based linear workflows, when a task requires external data, the LLM can call an MCP server tool (e.g., querying a PostgreSQL server) and integrate the result into the workflow, enhancing real-time domain expertise.

This implementation aligns with your goal of replacing the homegrown tool-call feature, leveraging MCP’s universal adapter approach to avoid the brittleness of previous hacks.

#### Creating Custom MCP Servers for Local Data Sources
For local data sources like your CRUD database apps and Jupyter-inspired workflows, you can implement MCP servers:

- **Server Definition**:
  - Inherit from `MCPServer` and define tools, e.g., `add_tool("create_record", {...}, self.create_record_function)`.
  - Implement tool logic, such as querying a local SQLite database or executing a workflow step.

- **Running the Server**:
  - Use `server.run(port=8000)` to start the server, accessible via HTTP by default using FastAPI under the hood.

- **Example**:
  - For a Todo CRUD app, define a tool `create_todo` with parameters `title` and `description`, implementing the logic to insert into your database.

This approach decouples your core app from specific tool implementations, aligning with your plugin system for auto-discovery.

#### Zero-HTTP Setups: Exploring Alternatives
While MCP standardizes on HTTP-based communication, your preference for zero-HTTP setups to avoid microservices overhead is valid, especially for local applications. The current SDK, as seen in [Python SDK](https://github.com/modelcontextprotocol/python-sdk), uses FastAPI, implying HTTP. However, for local optimization:

- Run servers and clients in the same process, using in-memory communication like Python queues or shared memory, though this requires custom implementation beyond the SDK.
- Consider Unix sockets for inter-process communication, faster than HTTP but needing manual integration.
- Given Pipulate’s tight coupling, running local HTTP servers might suffice, with minimal overhead for intra-machine requests.

This is an area for further research, as the specification at [MCP Specification](https://spec.modelcontextprotocol.io/specification/2025-03-26/) doesn’t explicitly support non-HTTP methods, but community discussions on [GitHub Discussions](https://github.com/modelcontextprotocol/docs/discussions) may offer insights.

#### Security and Best Practices
MCP’s power comes with security implications, as noted in the [Specification](https://spec.modelcontextprotocol.io/specification/2025-03-26/). Implementors must:
- Build robust consent flows, ensuring users authorize tool use.
- Provide clear documentation of security implications.
- Implement access controls, treating tool descriptions as untrusted unless from trusted servers.

For Pipulate, ensure your LLM prompts include user consent checks before executing tools, and log all tool calls for auditability.

#### Comparison with Other Tool-Call Approaches
While you’ve indicated MCP is the future, it’s worth noting its advantage over fragmented protocols like OpenAI’s function calling or Google’s system. MCP’s universality, as highlighted in [Medium Post](https://medium.com/@kenzic/getting-started-model-context-protocol-e0a80dddff80), reduces the burden on LLMs to understand multiple protocols, fostering a single standard. This aligns with historical parallels like XML replacing EDI, ensuring well-formed and valid JSON responses.

#### Documentation for MCP Hooks in Code
To leave detailed comments for MCP hooks in Pipulate, consider:
- In your LLM interaction module, comment: `# MCP Client: Connect to servers and fetch tools for LLM prompt`.
- For tool call handling: `# MCP Tool Call: Parse LLM response, forward to server, and handle result`.
- For local server integration: `# MCP Server: Define tools for local database access, run on port 8000`.

This ensures you can pick up implementation later, aligning with your rapid documentation goal at 6:45 AM on a Monday.

#### Tables: Example MCP Servers and Their Categories

| Category             | Count | Examples                                      |
|----------------------|-------|-----------------------------------------------|
| Reference Servers    | 19    | AWS KB Retrieval, Git, PostgreSQL             |
| Official Integrations| 63    | Google Drive, Slack, Stripe                   |
| Community Servers    | 108   | Ableton Live, Unity3D, Todoist                |

| MCP Component       | Description                                      |
|--------------------|--------------------------------------------------|
| Tools              | Arbitrary code execution, e.g., database queries |
| Resources          | Data access, e.g., file retrieval for RAG        |
| Prompts            | Reusable templates for LLM interactions          |

These tables summarize the ecosystem and components, aiding your understanding for code integration.

#### Conclusion
By implementing MCP in Pipulate, you’ll enable your framework to leverage a standardized protocol, enhancing its capabilities for both CRUD operations and workflow plugins. The current state, with robust adoption and documentation, supports your goal of leaving detailed hooks, ensuring a smooth transition to this universal adapter approach.

---

### Key Citations
- [Model Context Protocol Introduction](https://modelcontextprotocol.io/introduction)
- [Introducing the Model Context Protocol Anthropic](https://www.anthropic.com/news/model-context-protocol)
- [Getting Started Model Context Protocol Medium](https://medium.com/@kenzic/getting-started-model-context-protocol-e0a80dddff80)
- [Model Context Protocol GitHub](https://github.com/modelcontextprotocol)
- [Model Context Protocol vs APIs Blog](https://norahsakal.com/blog/mcp-vs-api-model-context-protocol-explained/)
- [Model Context Protocol NSHipster](https://nshipster.com/model-context-protocol/)
- [Model Context Protocol Explained Sean Goedecke](https://www.seangoedecke.com/model-context-protocol/)
- [Model Context Protocol Specification 2024-11-05](https://spec.modelcontextprotocol.io/specification/2024-11-05/)
- [Model Context Protocol Specification 2025-03-26](https://spec.modelcontextprotocol.io/specification/2025-03-26/)
- [Model Context Protocol Blog Portkey](https://portkey.ai/blog/model-context-protocol-for-llm-appls)
- [Model Context Protocol Servers GitHub](https://github.com/modelcontextprotocol/servers)
- [Model Context Protocol Python SDK GitHub](https://github.com/modelcontextprotocol/python-sdk)
- [MCP Guide with Demo Project DataCamp](https://www.datacamp.com/tutorial/mcp-model-context-protocol)

---

## Gemini's Deep Research Next, Because It's FAST!

> I have to say, even though Gemini is a pleasure to watch research and looks at
> sources 100-at-a-time versus the other engine's 1-at-a-time, I'm still full of
> trepidation and formatting this! First to Google Docs, then to Markdown, then
> backslash search/replace hell. I tried the normal `Copy Contents` but there
> was no markdown and it was 5 mega-long lines of run-on text. So, Google Docs
> and NeoVim RegEx Kung Fu, it is!

I'll just put these here:

    :'<,'>s/|/\&#124;/gcc
    :'<,'>s/\\\([\-+\[\]_#\.]\)/\1/g

# **The Model Context Protocol: A Standard for Connecting AI with External Systems**

The increasing sophistication of large language models (LLMs) has highlighted a critical challenge: their inherent isolation from real-time data and external tools. While these models exhibit impressive capabilities in reasoning and language generation, their utility in practical applications is often limited by their inability to access and interact with the dynamic information and systems that underpin many real-world tasks. Recognizing this limitation, Anthropic introduced the Model Context Protocol (MCP) on November 25, 2024, with the express aim of establishing a universal and open standard for seamlessly connecting AI assistants to the vast landscape of data repositories, business applications, and development environments.1 Before the advent of MCP, integrating AI with diverse data sources necessitated the creation of bespoke connectors for each specific source. This fragmented approach posed significant scalability hurdles, making it difficult to build truly interconnected AI systems. MCP directly addresses this challenge by offering a single, standardized protocol designed to replace these disparate integrations.1 This foundational shift promises a more streamlined and reliable method for equipping AI systems with the data they require to function effectively.

The core concept of MCP can be intuitively understood through the analogy of a "USB-C port for AI applications".2 Just as USB-C provides a universal interface for connecting various devices to peripherals, MCP standardizes the way in which AI applications can access contextual information from a multitude of sources.2 This standardization is pivotal for achieving true interoperability within the AI ecosystem. It allows different AI models and platforms to potentially interact with a wide array of tools and data sources without the need for custom-built integrations for every unique combination. This not only reduces the development overhead but also fosters a more flexible and interconnected AI landscape. Furthermore, MCP is engineered to facilitate secure, two-way communication pathways between data sources and AI-powered tools.1 Given the sensitive nature of much of the data that AI systems might need to access, the emphasis on security is paramount. The protocol is designed with inherent security considerations to ensure that these connections are robust and trustworthy. Ultimately, the primary objective of MCP is to empower advanced AI models to generate better and more relevant responses by effectively bridging their isolation from the external world of data.1 By providing LLMs with the necessary context, MCP aims to unlock their full potential and enable them to contribute more meaningfully to a wider range of applications.

### **2. Deep Dive into MCP's Technical Architecture**

The Model Context Protocol is built upon a well-defined client-host-server architecture.3 This established architectural pattern promotes a clear separation of responsibilities and facilitates the development of modular and scalable AI systems. Within this framework, LLM applications, such as Anthropic's Claude Desktop, various Integrated Development Environments (IDEs), and specialized AI tools like Cursor and Cline, function as **hosts**.3 These hosts initiate connections to MCP servers and manage the lifecycle of client instances. The variety of applications acting as hosts indicates a growing trend of adopting MCP across different categories of AI-powered tools, suggesting a broad potential for integration across diverse AI workflows.

Within the host application reside **clients**, which are essentially connectors that maintain a one-to-one relationship with MCP servers.3 The host application plays a crucial role in managing these client connections, controlling their permissions and lifecycle, enforcing security policies, handling user authorization, and coordinating the overall integration with the underlying LLM.6 This design implies a level of abstraction and modularity, where a single host can manage multiple concurrent client connections to different servers, enabling complex interactions with various data sources and tools. This allows for flexible and scalable integration of diverse capabilities into a single AI application without requiring monolithic implementations.

The third core component is the **server**, which are lightweight programs designed to expose specific capabilities through the standardized MCP protocol.3 These servers act as intermediaries or wrappers around external systems, providing a consistent and standardized interface for AI applications to interact with them.6 A key design principle is that MCP servers focus on providing specific, well-defined functionalities, which simplifies their implementation and maintenance.6 Examples of the types of systems that MCP servers can provide access to include databases, Customer Relationship Management (CRM) systems like Salesforce, local file systems, and version control systems such as Git.6 Furthermore, Anthropic has proactively developed and open-sourced a collection of pre-built MCP servers for widely used enterprise systems like Google Drive, Slack, GitHub, Git, Postgres, and Puppeteer.1 The availability of these pre-built connectors, coupled with the potential to connect to a vast array of other systems, underscores the versatility of MCP in accessing diverse data and functionalities, significantly extending the capabilities of LLMs. The lightweight nature and focused capabilities of MCP servers suggest an architectural approach that promotes efficiency and maintainability, potentially contributing to the overall robustness and scalability of AI systems built using this protocol.

Communication between these core components – hosts, clients, and servers – is facilitated by the **JSON-RPC 2.0** protocol.6 JSON-RPC is a widely recognized, simple, and transport-agnostic remote procedure call protocol that utilizes JSON for data serialization. The selection of JSON-RPC likely ensures broad interoperability and ease of implementation across various programming languages and platforms due to its inherent simplicity, human-readable format, and extensive library support. This reduces the complexity involved in building MCP components. Within the MCP framework, three primary message types based on the JSON-RPC 2.0 specification are defined: **Requests**, which are bidirectional messages that expect a response; **Responses**, which convey the results of a request, either successful data or an error; and **Notifications**, which are one-way messages that do not require a response.6 These message types enable a range of communication patterns necessary for different types of interactions between clients and servers. For instance, a client might send a Request to a server to retrieve specific data or execute a tool, and the server would respond with a Response containing the requested information or the outcome of the tool execution. Notifications can be used for asynchronous updates or events that the client needs to be aware of. Understanding these fundamental message types is crucial for comprehending the technical mechanisms through which MCP enables interaction between AI applications and external systems.

MCP servers expose their capabilities through three core features: **Resources**, **Prompts**, and **Tools**.6 These serve as the fundamental building blocks for providing context to language models. **Resources** are designed to expose structured data or content to the LLM.6 Conceptually similar to GET endpoints in a REST API, resources are intended for efficient data retrieval without involving significant computation or causing side effects.8 Access to resources is typically managed through URIs, providing a standardized way to identify and retrieve specific pieces of data.11 By leveraging resources, LLMs can access relevant and up-to-date information from external sources, thereby enriching their knowledge and enabling them to generate more informed and contextually accurate responses. For example, an MCP server might expose a resource that provides the latest stock prices or retrieves customer details from a database.

**Prompts** in MCP are pre-defined templates or instructions that guide the interactions of language models.6 These reusable templates essentially encode "best practices" for interacting with the server's capabilities, leading to more effective and predictable LLM behavior.9 Prompts allow developers to structure and control how LLMs utilize the server's resources and tools, ensuring more consistent and reliable outcomes. For instance, a prompt might instruct the LLM on how to formulate a query to a database resource or how to interpret the output of a specific tool.

**Tools** are executable functions that enable language models to perform actions or retrieve information from external systems.6 Analogous to POST endpoints in a REST API, tools are designed to execute code or produce side effects, allowing LLMs to actively interact with the external world.8 A key characteristic of tools in MCP is that they are model-controlled, meaning the LLM can discover and invoke them automatically based on its contextual understanding and the user's prompts.6 Each tool is uniquely identified by a name and includes metadata that describes its schema, specifying the parameters it accepts and the type of output it produces.6 Tools are essential for enabling AI agents to go beyond simply processing information and to actively engage with the real world, performing actions such as sending emails, updating records in a database, triggering automated workflows, or controlling other applications. For example, an MCP server might expose a tool that allows an LLM to schedule a meeting in a calendar application or to deploy a software update.

In addition to the server features, MCP also defines client-side capabilities. One notable feature is **Sampling**, which clients can offer to servers.7 This advanced capability enables server-initiated agentic behaviors and recursive interactions with LLMs.7 Essentially, a server can request the LLM to perform further reasoning or generate additional content based on the results of a previous interaction. This allows for the creation of more sophisticated AI agents capable of complex, multi-step problem-solving. However, the protocol emphasizes the importance of user control over sampling. Users must explicitly approve any LLM sampling requests and retain control over whether sampling occurs, the specific prompt that will be sent to the LLM, and what results the server is permitted to see.7 This focus on user consent and control underscores the commitment to transparency and safety in these more advanced AI interactions.

### **3. Exploring the MCP Ecosystem and Available Tools**

A robust ecosystem of tools and resources is crucial for the widespread adoption and effective utilization of any technology. The Model Context Protocol benefits from a growing ecosystem that includes an official specification, Software Development Kits (SDKs), reference server implementations, and development tools. The foundation of the MCP ecosystem is the **official specification**, which is publicly available at spec.modelcontextprotocol.io.7 This document, based on a TypeScript schema, serves as the definitive guide for all aspects of the protocol, ensuring clarity, consistency, and interoperability across different implementations.7 Its public availability is essential for fostering a healthy and thriving community around MCP.

To facilitate the development of MCP-compatible applications, Anthropic provides officially supported **SDKs** in several popular programming languages, including TypeScript, Python, Java, Kotlin, and C#.1 These SDKs, hosted in the open-source GitHub repository github.com/modelcontextprotocol 12, significantly lower the barrier to entry for developers wanting to integrate MCP into their projects. Furthermore, the community has also contributed SDKs for other languages, such as Rust and Swift 12, expanding the reach and accessibility of the protocol. The involvement of major industry players, such as Microsoft maintaining the C# SDK and collaborations with initiatives like Spring AI for the Java SDK, indicates strong industry interest and support for MCP.

To provide practical guidance and accelerate development, Anthropic has also released an open-source repository of **reference implementations for MCP servers** at github.com/modelcontextprotocol/servers.1 This repository includes server implementations for popular enterprise systems like Google Drive, Slack, GitHub, Git, Postgres, and Puppeteer.1 These reference servers serve as invaluable examples for developers, demonstrating how to implement MCP servers using the official SDKs and showcasing the protocol's versatility in connecting to various types of systems. Beyond the officially provided servers, a growing community is actively building and contributing their own MCP server implementations, as evidenced by the expanding list in the modelcontextprotocol/servers repository.12 Examples of community-contributed servers include integrations for AWS Knowledge Base Retrieval, Brave Search, EverArt, Filesystem operations, GitLab, Google Maps, a persistent Memory system, Redis, Sentry, Sequential Thinking, Sqlite databases, and Time and timezone conversions.13 This active community involvement underscores the increasing adoption and interest in MCP and highlights the diverse range of potential applications being explored.

For developers working with MCP, dedicated **development and testing tools** are also available. The MCP Inspector, found in the github.com/modelcontextprotocol/inspector repository 3, is a valuable visual tool for inspecting and testing MCP servers. This graphical interface simplifies the process of validating server implementations and ensuring they adhere to the protocol specification. Additionally, FastMCP, initially developed as a separate project, has now been integrated into the official Python SDK available on PyPI (pypi.org/project/mcp).8 FastMCP provides a high-level, Pythonic way for Python developers to build MCP servers, offering an intuitive interface and a development mode that includes an interactive web-based MCP Inspector for streamlined testing and debugging.9 The integration of FastMCP into the official Python SDK signifies its importance and provides Python developers with a more efficient and user-friendly approach to MCP server development.

| Category | Name/Description | Programming Language | Link/Reference |
| :---- | :---- | :---- | :---- |
| **Official SDKs** | TypeScript SDK | TypeScript | 12 |
|  | Python SDK (includes FastMCP integration) | Python | 8 |
|  | Java SDK (maintained in collaboration with Spring AI) | Java | 12 |
|  | Kotlin SDK | Kotlin | 12 |
|  | C# SDK (maintained by Microsoft) | C# | 12 |
| **Community SDKs** | Rust SDK | Rust | 12 |
|  | Swift SDK (maintained in collaboration with @loopwork-ai) | Swift | 12 |
| **Anthropic Ref. Servers** | Google Drive, Slack, GitHub, Git, Postgres, Puppeteer | JavaScript, Python | 1 |
| **Key Community Servers** | AWS KB Retrieval, Brave Search, EverArt, Filesystem, GitLab, Google Maps, Memory, Redis, Sentry, Sequential Thinking, Sqlite, Time | JavaScript, Python | 13 |
| **Development Tools** | MCP Inspector (Visual testing tool) | TypeScript | 3 |
|  | FastMCP (High-level Python framework, now in official Python SDK) | Python | 8 |

### **4\. Deployment Strategies for MCP**

The Model Context Protocol offers flexibility in how its components can be deployed, supporting both traditional HTTP-based setups and zero-HTTP configurations for local integrations. In **HTTP-based MCP server-client setups**, the protocol leverages standard web technologies for communication. The MCP specification defines "Transports," and one of the built-in options is Server-Sent Events (SSE) over HTTP.7 SSE is a well-established web standard that enables a server to push real-time data updates to a client over a persistent HTTP connection. This can be particularly advantageous for MCP applications that require continuous streams of data or asynchronous notifications from the server to the client, such as progress updates on long-running tasks or live data feeds.

A significant development in the deployment landscape of MCP is the support for building and deploying remote MCP servers on platforms like Cloudflare.15 This capability extends the reach of MCP beyond local desktop applications, enabling integration with web-based interfaces and mobile apps.15 For these remote deployments, authentication and authorization are handled securely using OAuth, a widely adopted standard for granting applications access to user information or services without requiring password sharing.15 Furthermore, Cloudflare implements additional security measures such as token encryption and the issuance of limited-permission tokens to MCP clients, minimizing the potential impact of compromised credentials.15 The MCP specification itself is also evolving in terms of remote transport, with a move towards Streamable HTTP, which may eventually replace the HTTP+SSE approach.15 Streamable HTTP aims to provide stateless, pure HTTP connections with the option to upgrade to SSE if needed, potentially simplifying remote deployments and improving scalability.

In contrast to HTTP-based setups, MCP also supports **zero-HTTP setups**, primarily through the use of the stdio (standard input/output) transport.8 Stdio is a fundamental mechanism for inter-process communication in operating systems, allowing applications to communicate through the standard input, output, and error streams. For local integrations and command-line tools, stdio provides a lightweight and efficient way for an application (acting as an MCP client) to interact with an MCP server running on the same machine, without the overhead and complexity associated with HTTP networking. This is particularly well-suited for scenarios where the AI application and the MCP server are tightly coupled or where the integration is primarily command-line driven. A prominent example of a zero-HTTP setup in practice is the AI-powered code editor Cursor, which utilizes the stdio transport for managing MCP servers that run locally on the user's machine.16 In Cursor, users can configure MCP servers by specifying a shell command that the editor will execute to launch the server process.16 This direct inter-process communication via stdio offers a simple and effective way to extend the capabilities of the code editor with local data and tools. While direct in-process function invocation could theoretically be considered another form of zero-HTTP communication in very tightly integrated scenarios, the standard MCP architecture, which emphasizes a client-server model even for local interactions, typically favors the use of defined transports like stdio for better modularity and maintainability.

### **5\. MCP in the Context of Competing Tool-Calling Approaches**

The ability for LLMs to interact with external tools and data is a critical area of development in the field of AI. Consequently, several competing approaches to tool-calling have emerged. To understand the unique position of MCP, it is essential to compare it with other prominent methods, particularly OpenAI function calling and Google's tool-calling system. A key differentiator for MCP is its nature as an open protocol.1 This contrasts with the proprietary nature of both OpenAI function calling and Google's system, which are tied to their respective AI models and platforms. The openness of MCP fosters greater interoperability and allows for broader adoption across different AI models and tools.

MCP is specifically designed with the needs of AI in mind, offering a consistent interface based on the concepts of tools and resources.19 This "AI-native" design, coupled with reflection capabilities that allow AI models to dynamically discover the functionalities offered by a server at runtime 19, distinguishes it from more general-purpose API standards like REST, GraphQL, gRPC, and tRPC. While these standards are excellent for inter-service communication, they may not inherently provide the semantic information that an AI model needs to easily understand and utilize the available functions. MCP aims to bridge this gap by providing a standardized way for AI to interact with external capabilities at a higher level of abstraction.

While specific details about Google's tool-calling system were not prominent in the provided research material, it is understood to be tightly integrated with their Gemini models, allowing them to invoke specific functions to access real-time information and perform actions. Similarly, OpenAI function calling enables developers to define functions that their models (like GPT-3.5 and GPT-4) can call, passing structured data based on the user's intent. A key difference between MCP and these proprietary approaches lies in the level of control and flexibility offered to developers. MCP's open standard allows developers to build their own servers and integrate with virtually any system using a variety of programming languages and transport protocols. This contrasts with the more constrained environments of OpenAI and Google, where the tool-calling mechanisms are more closely tied to their specific ecosystems. Furthermore, MCP's emphasis on security, with detailed guidelines and features like OAuth for remote servers, provides a robust framework for building trustworthy AI integrations. The maturity and breadth of the ecosystem around each approach also differ. While OpenAI and Google have a large existing user base for their models, the MCP ecosystem, though newer, is rapidly growing with contributions from Anthropic, various development tool companies, and the wider community. Finally, MCP supports multiple transport protocols, including stdio for local integrations and SSE/Streamable HTTP for remote communication, offering flexibility in deployment scenarios.

| Feature | MCP | OpenAI Function Calling | Google Tool Calling |
| :---- | :---- | :---- | :---- |
| **Standardization** | Open protocol | Proprietary to OpenAI | Proprietary to Google |
| **Openness** | High, community-driven | Limited to OpenAI platform | Limited to Google platform |
| **Ease of Use** | SDKs in multiple languages, development tools available | Relatively straightforward API within OpenAI ecosystem | Integrated within Google's AI platform |
| **Flexibility** | High, supports diverse systems and transports | Primarily within OpenAI's function calling schema | Integrated within Google's AI platform |
| **Security** | Strong focus, detailed guidelines, OAuth for remote servers | Security considerations within OpenAI's API framework | Security considerations within Google's AI platform |
| **Ecosystem Maturity** | Newer, but rapidly growing | Mature within the OpenAI ecosystem | Developing within the Google ecosystem |
| **Supported Transports** | stdio, SSE, Streamable HTTP | Primarily within OpenAI API calls | Integrated within Google's AI platform |
| **AI Model Support** | Designed for broader adoption across different LLMs | Primarily for OpenAI models | Primarily for Google Gemini models |

### **6\. Adoption and Implementation of MCP Across Platforms**

The Model Context Protocol has seen increasing adoption across various AI platforms, indicating its growing importance as a standard for AI integration. As the originator of MCP, Anthropic has deeply integrated the protocol into its **Claude** ecosystem.1 The Claude Desktop application provides native support for connecting to local MCP servers, allowing users to seamlessly extend the capabilities of their AI assistant with external data and tools.1 Notably, Claude 3.5 Sonnet has been highlighted for its proficiency in rapidly building MCP server implementations, suggesting that Anthropic is leveraging its own models to facilitate the creation of MCP integrations.1 Furthermore, Claude for Work customers can readily test MCP servers locally, enabling them to connect Claude to their internal systems and datasets.1 To simplify the user experience, pre-built MCP servers for popular services can be easily installed directly through the Claude Desktop application.1

**Cursor**, an AI-powered code editor, has also strongly embraced MCP, viewing it as a fundamental "plugin system" for extending the capabilities of its AI Agent.5 This integration allows developers using Cursor to connect their AI assistant to project-specific data, code repositories, and other development tools, significantly enhancing their coding workflow. Cursor supports both stdio and SSE transport protocols for connecting to MCP servers, providing flexibility for different deployment scenarios.16 The editor features a dedicated MCP settings page, offering a user-friendly interface for managing and monitoring connected MCP servers.16 The active engagement of the Cursor community in discussing and exploring the potential of MCP further underscores its importance within this platform.21 Currently, Cursor's implementation primarily focuses on supporting MCP tools, with support for resources still under development.16 There is also a current limitation on the number of tools that Cursor will actively utilize 16, and users should be aware that MCP server functionality might be limited when accessing Cursor over SSH or other remote development environments.16

Another significant platform adopting MCP is **Cline**, a VS Code extension that integrates with the Anthropic API.18 Cline provides an MCP Marketplace, a curated collection of MCP servers that users can easily discover and install with a single click.23 This marketplace model greatly simplifies the process of integrating external capabilities into the Cline AI assistant. Cline also employs a structured approach to MCP server development, utilizing a .clinerules file to guide developers and enforce best practices.24 The cross-platform support for connecting to services like Supabase using MCP with Cursor, Windsurf (Codium), Cline, and Claude (desktop and code) highlights the growing reach and interoperability facilitated by the protocol.18

Beyond these key platforms, several other development tool companies, including Zed, Replit, Codeium, and Sourcegraph, are actively working on integrating MCP into their offerings to enhance their AI-powered features.1 Furthermore, Microsoft has recently announced the inclusion of MCP in Copilot Studio, indicating a broader industry recognition of its value.5 This widespread adoption across diverse platforms signifies a strong trend towards establishing MCP as a fundamental standard for connecting AI with the external world.

### **7\. Security, Trust, and Safety Considerations in MCP Implementations**

Given the powerful capabilities enabled by connecting AI systems to external data and tools, security, trust, and safety are paramount considerations in the design and implementation of the Model Context Protocol. The MCP specification dedicates a significant section to these aspects, emphasizing several key principles.7 **User consent and control** are central, requiring that users must explicitly consent to all data access and operations and retain control over what data is shared and what actions are taken.7 Implementors are advised to provide clear user interfaces for reviewing and authorizing activities. **Data privacy** is another critical principle, mandating that hosts must obtain explicit user consent before exposing user data to servers and must not transmit resource data elsewhere without this consent.7 User data should be protected with appropriate access controls.

**Tool safety** is also a major concern, as tools represent arbitrary code execution paths.7 The specification advises that descriptions of tool behavior should be considered untrusted unless obtained from a trusted server. Explicit user consent must be obtained before invoking any tool, and users should understand the tool's function before authorizing its use. Finally, the specification addresses **LLM sampling controls**, requiring that users must explicitly approve any LLM sampling requests and should control whether sampling occurs, the prompt that will be sent, and what results the server can see.7 Notably, the protocol intentionally limits server visibility into prompts to protect user privacy.

The MCP specification strongly recommends several implementation guidelines to ensure security and trust.7 These include building robust consent and authorization flows into applications, providing clear documentation of security implications to users, implementing appropriate access controls and data protections, following general security best practices in integrations, and carefully considering privacy implications in feature designs. For remote MCP servers deployed on platforms like Cloudflare, secure authentication is achieved through OAuth.15 Cloudflare also enhances security by encrypting tokens and issuing limited-permission tokens to MCP clients.15 The intentional limitation of server visibility into user prompts within the protocol itself further underscores the commitment to protecting user privacy.7 These comprehensive security considerations highlight the importance placed on building a safe and trustworthy ecosystem around the Model Context Protocol.

### **8\. Real-World Use Cases and the Future of MCP**

The practical utility of the Model Context Protocol is evidenced by its adoption by early pioneers such as Block and Apollo, who have integrated MCP into their systems.1 While specific details of these integrations were not extensively covered in the provided material, their adoption by established organizations highlights the real-world value proposition of MCP. The research material also provides a range of concrete examples illustrating the diverse use cases enabled by MCP servers. These include the ability to fetch pull request details from GitHub, analyze code changes, generate pull request review summaries, and save these reviews to Notion.25 MCP also facilitates interaction with databases, as demonstrated by integrations with PostgreSQL 16 and Upstash 17, allowing AI to query and manipulate data through natural language. Other use cases include sending emails via Resend's API 20, reading and searching through notes in Obsidian 20, and even controlling complex software like Blender for animation purposes.17 These varied examples underscore the flexibility and broad applicability of MCP in connecting AI with a wide spectrum of external systems and functionalities.

Looking towards the future, the development of the MCP Marketplace by Cline 23 signals a significant step towards easier discovery and integration of MCP servers. This marketplace model has the potential to drive rapid expansion of the MCP ecosystem by simplifying the process for users to find and utilize relevant integrations. The analogy of MCP as the "REST API of LLM apps" 22 and the "USB-C of AI integrations" 2 suggests a future where MCP becomes a foundational standard for connecting AI with the external world, enabling a more interconnected and capable AI landscape. The ongoing evolution of the protocol's transport mechanisms, such as the shift towards Streamable HTTP for remote communication 15, demonstrates a commitment to adapting and improving MCP to meet the evolving needs of the AI community and to support diverse deployment scenarios.

### **9\. Conclusion**

The Model Context Protocol represents a significant advancement in the quest to create more capable and integrated AI systems. By providing an open and standardized framework for connecting LLMs with external data sources and tools, MCP addresses a fundamental limitation of current AI technology. Its well-defined architecture, comprehensive security considerations, growing ecosystem of tools and SDKs, and increasing adoption across various platforms position it as a key enabler for the next generation of AI applications. The diverse range of real-world use cases already emerging highlights the practical value and versatility of MCP in bridging the gap between the potential of advanced AI models and the complexities of the real world. As the ecosystem continues to mature and evolve, the Model Context Protocol holds the promise of unlocking new levels of AI capability and driving innovation across a wide range of industries.

#### **Works cited**

1. Introducing the Model Context Protocol - Anthropic, accessed March 31, 2025, [https://www.anthropic.com/news/model-context-protocol](https://www.anthropic.com/news/model-context-protocol)  
2. Model Context Protocol (MCP) - Anthropic API, accessed March 31, 2025, [https://docs.anthropic.com/en/docs/agents-and-tools/mcp](https://docs.anthropic.com/en/docs/agents-and-tools/mcp)  
3. Model Context Protocol: Introduction, accessed March 31, 2025, [https://modelcontextprotocol.io/introduction](https://modelcontextprotocol.io/introduction)  
4. Model context protocol (MCP) - OpenAI Agents SDK, accessed March 31, 2025, [https://openai.github.io/openai-agents-python/mcp/](https://openai.github.io/openai-agents-python/mcp/)  
5. What the heck is Model Context Protocol (MCP)? And why is everybody talking about it?, accessed March 31, 2025, [https://pieces.app/blog/mcp](https://pieces.app/blog/mcp)  
6. The Model Context Protocol (MCP) — A Complete Tutorial &#124; by Dr. Nimrita Koul - Medium, accessed March 31, 2025, [https://medium.com/@nimritakoul01/the-model-context-protocol-mcp-a-complete-tutorial-a3abe8a7f4ef](https://medium.com/@nimritakoul01/the-model-context-protocol-mcp-a-complete-tutorial-a3abe8a7f4ef)  
7. Model Context Protocol specification, accessed March 31, 2025, [https://spec.modelcontextprotocol.io/specification/2025-03-26/](https://spec.modelcontextprotocol.io/specification/2025-03-26/)  
8. mcp · PyPI, accessed March 31, 2025, [https://pypi.org/project/mcp/](https://pypi.org/project/mcp/)  
9. jlowin/fastmcp: The fast, Pythonic way to build Model ... - GitHub, accessed March 31, 2025, [https://github.com/jlowin/fastmcp](https://github.com/jlowin/fastmcp)  
10. The official Typescript SDK for Model Context Protocol servers and clients - GitHub, accessed March 31, 2025, [https://github.com/modelcontextprotocol/typescript-sdk](https://github.com/modelcontextprotocol/typescript-sdk)  
11. Model Context Protocol (MCP) :: Spring AI Reference, accessed March 31, 2025, [https://docs.spring.io/spring-ai/reference/api/mcp/mcp-overview.html](https://docs.spring.io/spring-ai/reference/api/mcp/mcp-overview.html)  
12. Model Context Protocol - GitHub, accessed March 31, 2025, [https://github.com/modelcontextprotocol](https://github.com/modelcontextprotocol)  
13. modelcontextprotocol/servers: Model Context Protocol Servers - GitHub, accessed March 31, 2025, [https://github.com/modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers)  
14. Transports - Model Context Protocol, accessed March 31, 2025, [https://modelcontextprotocol.io/docs/concepts/transports](https://modelcontextprotocol.io/docs/concepts/transports)  
15. Build and deploy Remote Model Context Protocol (MCP) servers to Cloudflare, accessed March 31, 2025, [https://blog.cloudflare.com/remote-model-context-protocol-servers-mcp/](https://blog.cloudflare.com/remote-model-context-protocol-servers-mcp/)  
16. Model Context Protocol - Cursor, accessed March 31, 2025, [https://docs.cursor.com/context/model-context-protocol](https://docs.cursor.com/context/model-context-protocol)  
17. Model Context Protocol (MCP): Build Your Own in 5 Minutes &#124; Upstash Blog, accessed March 31, 2025, [https://upstash.com/blog/build-your-own-mcp](https://upstash.com/blog/build-your-own-mcp)  
18. Model context protocol (MCP) &#124; Supabase Docs, accessed March 31, 2025, [https://supabase.com/docs/guides/getting-started/mcp](https://supabase.com/docs/guides/getting-started/mcp)  
19. Model Context Protocol (MCP): Enabling More Capable AI - Medium, accessed March 31, 2025, [https://medium.com/zero-to/model-context-protocol-mcp-enabling-more-capable-ai-a80f0492cfb4](https://medium.com/zero-to/model-context-protocol-mcp-enabling-more-capable-ai-a80f0492cfb4)  
20. MCP Servers for Cursor - Cursor Directory, accessed March 31, 2025, [https://cursor.directory/mcp](https://cursor.directory/mcp)  
21. Cursor Team Take note \*Model Context protocol) - Discussion, accessed March 31, 2025, [https://forum.cursor.com/t/cursor-team-take-note-model-context-protocol/29866](https://forum.cursor.com/t/cursor-team-take-note-model-context-protocol/29866)  
22. I still have no idea what MCP (Model Context Protocol) is : r/Anthropic - Reddit, accessed March 31, 2025, [https://www.reddit.com/r/Anthropic/comments/1hmqdtc/i_still_have_no_idea_what_mcp_model_context/](https://www.reddit.com/r/Anthropic/comments/1hmqdtc/i_still_have_no_idea_what_mcp_model_context/)  
23. This is the official repository for submitting MCP servers to be included in Cline's MCP Marketplace. If you've built an MCP server and want it to be discoverable and easily installable by millions of developers using Cline, submit your server here. - GitHub, accessed March 31, 2025, [https://github.com/cline/mcp-marketplace](https://github.com/cline/mcp-marketplace)  
24. MCP Server Development Protocol - Cline Documentation, accessed March 31, 2025, [https://docs.cline.bot/mcp-servers/mcp-server-from-scratch](https://docs.cline.bot/mcp-servers/mcp-server-from-scratch)  
25. Model Context Protocol (MCP): A Guide With Demo Project - DataCamp, accessed March 31, 2025, [https://www.datacamp.com/tutorial/mcp-model-context-protocol](https://www.datacamp.com/tutorial/mcp-model-context-protocol)



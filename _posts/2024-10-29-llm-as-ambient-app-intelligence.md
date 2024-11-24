---
title: LLM as Ambient App Intelligence
permalink: /futureproof/llm-as-ambient-app-intelligence/
description: In this article, I dive into the concept of LLMs as ambient intelligence, inspired by a conversation with Claude 3.5 through Cursor AI. I explore how integrating AI seamlessly into user interactions creates smarter workflows, allowing apps to learn and assist in real-time. As I transition from architecture to client focus, I reflect on how combining Drucker’s customer-first philosophy with Deming’s incremental improvement approach ensures AI remains a tool for delighting customers, not a distraction from what matters most.
layout: post
sort_order: 1
---

I had an interesting conversation with Claude 3.5 sonnet through Cursor AI this
weekend about the web app I'm building and it used some interesting words for
it: ***ambient intelligence*** (versus the chat interface) is what it called it.
Yup, that about sums it up. It's specifically listening for every user
interaction with the product so it can learn how to use it and at some point,
take over for the user.

**Claude**: Welcome back! I hope you got some good rest. Since you're refreshed, would you like to:

1. Review what we accomplished yesterday with the streaming implementation
2. Look at what needs to be restored to get back to baseline
3. Plan the next steps for integrating this into the site-wide chat feature
4. Something else entirely?

You've got a solid foundation now with the working Ollama streaming example - let's figure out the best way to build on that while keeping the core functionality stable.

**Me**: 2 and 3 are sort of the same, because we're going to be returning it to baseline with the new ChatPlayground transplanted into the old msg-list location.

**Claude**: Ah yes, that makes perfect sense! We're essentially replacing the old chat implementation with the new streaming-capable ChatPlayground, but it needs to fit into the existing UI structure.

Let's think about this systematically:

1. The old `msg-list` location was part of the main grid layout:
```python
# Original layout structure
create_grid_left()  # Main content area
create_chat_interface()  # Where msg-list lived
create_poke_button()
```

2. The new ChatPlayground has its own structure:
```python
class ChatPlayground:
    def create_progress_card(self):
        return Card(
            H3("Chat Playground"),
            Div(id="chat-box"...),
            Form(...),
            Script(...)
        )
```

Would you like to start with:
- Modifying the ChatPlayground to fit the existing styling/layout
- Updating the main app's chat interface to use ChatPlayground
- Something else?

Let me know which aspect you'd like to tackle first and we can work through it step by step.

**Me**: I changed GRID_LAYOUT = "70% 30%" to "60% 40%". My plan is to make things that I design as plugins transposable into the chat area with a minimum of muss and fuss. I would like the create_chat_interface() to in most regards work just like a plugin. So that seems to me that I want to use return await chat_playground.render() inside the div of create_chat_interface(), but there's a lot of object id stuff to fix or settle on the new convention for.

**Claude**: Yes, making the chat interface follow the same plugin pattern makes a lot of sense for consistency and maintainability. Let's modify `create_chat_interface()` to use ChatPlayground while preserving the existing structure:

```python
def create_chat_interface(temp_message=None):
    """
    Create the chat interface for the right column of the layout.
    Now uses ChatPlayground as the core implementation while maintaining
    the existing layout structure.
    """
    return Div(
        Card(
            H2(f"{APP_NAME} Chatbot"),
            # Replace the simple Div with ChatPlayground's rendered content
            # but preserve the styling and ID conventions
            Div(
                chat_playground.create_progress_card().children,  # Use children to avoid nested Card
                id='msg-list',  # Keep the original ID for existing references
                cls='overflow-auto',
                style='height: 40vh;',
            ),
        ),
        id="chat-interface",
    )
```

And then modify ChatPlayground to align with these conventions:

```python
class ChatPlayground:
    def create_progress_card(self):
        return Card(
            # Remove the H3 since we're using the parent Card's H2
            Div(
                id="chat-box",  # This could be changed to msg-list or vice versa
                style="overflow-y: auto; padding: 10px;",
            ),
            Form(
                Input(
                    id="chat-input",  # Consider standardizing these IDs
                    type="text", 
                    placeholder="Chat...",
                ),
                Button("Send", type="submit"),
                onsubmit="sendMessage(event)"
            ),
            Script("""
                // Update script to use consistent IDs
                // ... rest of script ...
            """)
        )
```

Key decisions we need to make:
1. ID standardization: `msg-list` vs `chat-box`
2. Input group styling: Keep `mk_chat_input_group()` or use ChatPlayground's form
3. WebSocket endpoint path: Should it be generic or playground-specific
4. Script inclusion: Where should the WebSocket handling script live

Would you like to tackle any of these specific aspects first?

Me: Okay, I've done that. I have the new chat interface showing in the create_chat_interface area previously known as msg-list. When I'm on the ChatPlayground app, they're side by side, the ChatPlayground plugin, which is working, and the narrower copy of it to the right, which isn't yet working. The idea is that once this is working, we will be retiring the ChatPlayground plugin so that makes me think we use its endpoint to keep things working. The important thing is that the back-end stuff is unfied via the conversation history, and it doesn't really matter which endpoints are used so long as that gets updated through whatever route. And so, let's make the choice that risks breaking things least, knowing that ChatPlayground is the only thing not broken right now, haha! 

Claude: 

Smart approach! Since ChatPlayground is our working reference implementation, let's make the chat interface use the same WebSocket endpoint and conversation handling. This means:

1. Keep using `/ws/chat-playground` as the WebSocket endpoint
2. Share the conversation history mechanism
3. Minimize changes to the working WebSocket handler

Let's modify the JavaScript in `create_chat_interface()` to connect to the existing endpoint:

```python
def create_chat_interface(temp_message=None):
    return Div(
        Card(
            H2(f"{APP_NAME} Chatbot"),
            Div(
                chat_playground.create_progress_card().children,
                id='msg-list',
                cls='overflow-auto',
                style='height: 40vh;',
            ),
            Script("""
                const ws = new WebSocket('ws://' + window.location.host + '/ws/chat-playground');
                const msgList = document.getElementById('msg-list');
                let currentMessage = document.createElement('div');
                currentMessage.className = 'message assistant';
                
                ws.onmessage = (event) => {
                    console.log('Message received:', event.data);
                    
                    if (!currentMessage.parentElement) {
                        msgList.appendChild(currentMessage);
                    }
                    
                    currentMessage.innerHTML += event.data;
                    msgList.scrollTop = msgList.scrollHeight;
                };
                
                function sendMessage(event) {
                    event.preventDefault();
                    const input = document.getElementById('chat-input');
                    if (input.value) {
                        const userMsg = document.createElement('div');
                        userMsg.className = 'message user';
                        userMsg.textContent = input.value;
                        msgList.appendChild(userMsg);
                        
                        currentMessage = document.createElement('div');
                        currentMessage.className = 'message assistant';
                        
                        console.log('Sending:', input.value);
                        ws.send(input.value);
                        input.value = '';
                        msgList.scrollTop = msgList.scrollHeight;
                    }
                }
            """)
        ),
        id="chat-interface",
    )
```

This way:
1. We're using the proven WebSocket endpoint
2. The conversation history stays synchronized
3. We can retire ChatPlayground once this is working
4. If something breaks, we still have ChatPlayground as a working reference

Want to try this approach and see if it gets both chat interfaces working with the same backend?

---

There were a few back-and-forth's to work out non-conflicting IDs and function
names, but I got the new chat interface integrated into the site.

Me: Okay, it's working. This is excellent! When I make menu selections that cause a page reload, the messge history in the chat interface is gone, but I don't want exploding complexity. Is there any way to rebuild it from the conversation history when that happens? I didn't want to program the entire thing as a single page application because the plugins live on their own URLs and I wanted old-school behavor to bookmark and share them and such. It also helps for re-initializing environments. But it might be nice for the message history to persist, but is not a show stopper if it causes a deep dive into the rabbit hole of doom.

Claude: I see you had to use `git push --force` because the branches diverged. For future reference, here's a safer workflow when making significant changes:

1. Create a feature branch:
```bash
git checkout -b feature/stream-chat-improvements
```

2. Make and test changes on the feature branch

3. When ready to merge:
```bash
git checkout botifymograph  # main branch
git pull                   # get latest changes
git merge feature/stream-chat-improvements
```

This helps avoid forced pushes which can be dangerous in collaborative environments. 

Would you like me to help with any other changes to the streaming functionality? Or shall we test the current implementation to make sure it's working as expected?

---

Fast-forward through getting CRUD messages appearing again in the new Chat
Interface, and then switching them from thunking down fully assembled to
streaming.

Claude: Excellent! You've now got streaming working in both the chat playground and the sidebar. 

Just to summarize what made it work:
1. Used the existing `ChatPlayground` class's WebSocket infrastructure
2. Added the `broadcast` method to handle sending messages to all connected clients
3. Properly maintained conversation history in `chatq`
4. Used the same formatting and streaming approach that was already working in the chat playground

The beauty of this solution is that it leverages the existing, working WebSocket code rather than trying to create a parallel system. Both the chat playground and sidebar now use the same streaming infrastructure.

Would you like to make any refinements to how the messages appear or how the streaming behaves?

---

## Code Refinement: Towards Greater Simplicity

Okay, what it boils down to is that I've got a now somewhat fragile set of
things that I got working, and I have to (over time / not right now)
continuously go over it and polish and refine it. It will get forever better,
and hopefully shorter as code, fitting into small context windows.

## Gemma Outperforms Llama Embedded Into Local Web Framework

The AI itself that's embedded should be able to understand the code of the Ruby
on Rails / Django-like framework it's embedded into to help guide its own
development and growth. However, the models that fit on our Macbooks these days
are quite small, gemma2:2b being the best combination of small, fast and smart
right now. I started out with llama3.2:1b but gemma pulled ahead in testing.
It's better at real-time prompt-infusion such as getting it good at an API
Syntax like using JSON for CRUD. Gemma applies the rules more consistently over
time, "remembering" the original system prompt better, and better able to keep
applying what it learned, but I have to keep testing.

## Local LLMs Collaborate With Frontier Models

But I can swap these things in and out, and they will be improving over time.
The local models will get better, but it also has to optionally connect to the
larger smarter frontier models as needed, collaborating local LLM model with
frontier model in a new twist on the ***agentic swarming*** buzzword. I think
that's misunderstood, implying a sort of concurrent frenzy of agents, each doing
their job independently and with a lot of up-time. Truth is you could probably
work sequentially, swapping which models you're using for what, clarifying your
thought about linear processes and still get some amazing work done. Tons less
complexity. You can swarm your ass off when the job calls for it.

The name of the game is loose coupling of websocket-speaking components.
Anything in the world can speak to anything in the world. It's the next
generation of building a webserver into things, but it's an asynchronous...
uh... Perplexity say a little about WSGI vs ASGI, please define. Say a little
about Unicorn, websockets and protocols other than http(s).

**Perplexity**: WSGI and ASGI are two important interfaces for Python web applications, each with distinct characteristics and use cases:

## WSGI (Web Server Gateway Interface)

WSGI is the long-standing Python standard for web application interfaces. It provides a synchronous, request-response model for handling HTTP requests[1].

Key features of WSGI:
- Synchronous processing
- Single-callable interface
- Designed primarily for HTTP

WSGI applications are structured as a single, synchronous callable that takes a request and returns a response. This simple model works well for traditional web applications but has limitations for more complex protocols or long-lived connections[1].

## ASGI (Asynchronous Server Gateway Interface)

ASGI is the spiritual successor to WSGI, designed to support asynchronous programming and a wider range of protocols[1].

Key features of ASGI:
- Asynchronous processing
- Multiple event handling
- Support for WebSockets and other protocols
- Backwards compatible with WSGI

ASGI applications are structured as asynchronous callables that can handle multiple events, both incoming and outgoing. This allows for more flexible handling of connections and supports protocols beyond just HTTP[1][3].

## Comparison

**Performance:** ASGI generally offers better performance for concurrent requests. In a test scenario, WSGI handled requests with an average latency of ~1ms, while ASGI had an average latency of ~17ms for synchronous views[4]. However, ASGI's true performance benefits are realized with asynchronous code and multiple concurrent connections.

**Use Cases:** 
- WSGI: Ideal for traditional web applications with synchronous request-response patterns.
- ASGI: Better suited for applications requiring real-time features, WebSockets, or handling many concurrent connections[3].

## Gunicorn and WebSockets

Gunicorn (Green Unicorn) is a WSGI HTTP server for Python. While primarily designed for WSGI applications, Gunicorn can also serve ASGI applications when used with workers that support ASGI, such as Uvicorn workers[4].

WebSockets, being a protocol for full-duplex communication, are better supported by ASGI. WSGI, with its synchronous nature, is not well-suited for WebSocket handling[3].

## Protocols Beyond HTTP(S)

ASGI's design allows it to handle protocols beyond just HTTP and HTTPS. This includes:

1. WebSockets: For real-time, bidirectional communication.
2. HTTP/2: Supporting multiplexed connections and server push.
3. Server-Sent Events (SSE): For server-to-client real-time events.

WSGI, on the other hand, is primarily designed for HTTP and doesn't natively support these more advanced protocols[1][3].

In conclusion, while WSGI remains a solid choice for traditional web applications, ASGI provides a more flexible and powerful interface for modern web development, especially when dealing with real-time features, WebSockets, or other protocols beyond standard HTTP.

Citations:

    [1] https://asgi.readthedocs.io/en/latest/introduction.html
    [2] https://www.reddit.com/r/django/comments/qv2nsv/wsgi_vs_asgi_deployment_and_how_does_asyncawait/
    [3] https://developer.vonage.com/en/blog/how-wsgi-vs-asgi-is-like-baking-a-cake
    [4] https://forum.djangoproject.com/t/huge-performance-difference-when-using-asgi-and-wsgi/30344
    [5] https://santoshk.dev/posts/2023/why-use-wsgi-asgi-when-we-have-nginx/
    [6] https://forum.djangoproject.com/t/what-does-switching-to-asgi-entail/26857

---

## ASGI Enables Ambient AI Intelligence

...so that ASGI piece is Python's way of enabling that
anything-talking-to-anything world, which is the enabling piece of ambient AI
intelligence. You can "build" intelligence into anything. It also doesn't matter
where the brains are located. You could swap out the `chat_with_ollama` part of
my program with `chat_with_frontier_model` just as easily. It's just that there
would be a cost, and you don't need it for the moment-to-moment functioning of
your app, which you also want an AI tuned into. ASGI and websockets sort of go
hand-in-hand in the Python world now as the enabling bits to be embraced the way
we embraced WSGI and the Requests library for http before.

## AI-Powered Efficiency for Boosting Client Satisfaction

I'm getting totally infatuated and high on the heady notions of what I'm doing,
but I can't let myself get swept away, because delighting clients has to come
first. That's ultimately what this is about, doing more with less time, hitting
above our weight class with an extra boost from an AI-buddy built into a web-app
that can recruit even more help from AI-buddies in the cloud. Not quite the sexy
agentic swarming, but a solid and more pragmatic stepping stone to bridge the
gap between the RoR/Django-CRUD apps of our day-to-day existence with the
paradigm-busing revolution that AI is thrusting upon us. There has to be a happy
middle grown with lot of ripe secret weapon fruit for folks like me who are
excited to pick the fruit&#151;the fruit of hitting above our weight class and
doing things we never could before. ***Us*** doing them, and not the AIs in our
stead. They are extensions of us. I must not get bogged down in what Joel
Spolsky once called... uh... Perplexity?


## Spolsky's 'Architecture Astronauts' Cautionary Concept for Self-Regulation

**Perplexity**: Joel Spolsky's article "Don't Let Architecture Astronauts Scare You" introduced the concept of "architecture astronauts" in software development. This term has remained relevant in the industry since its publication in 2001.

Key points about architecture astronauts:

1. Definition: Architecture astronauts are individuals who focus excessively on abstract ideas and high-level software design concepts, often at the expense of practical implementation[1].

2. Characteristics:
   - Tend to work at large companies that can afford unproductive employees
   - Struggle to write code or design practical programs
   - Speak confidently at extremely high levels of abstraction
   - Often create designs lacking technical depth and practicality[1]

3. Dangers:
   - Becoming disconnected from the systems they're designing
   - Losing respect from development teams due to impractical ideas
   - Creating overly complex solutions for simple problems[2]

4. Spolsky's critique:
   - Architecture astronauts often "run out of oxygen" by going too far up in abstraction
   - They may create "absurd, all-encompassing, high-level pictures of the universe" that don't mean anything practical[1]

5. Real-world examples:
   - John Carmack described the metaverse as a "honeypot trap for architecture astronauts"
   - XHTML 2.0 was characterized as the work of architecture astronauts due to its lack of real-world applicability[1]

6. Balancing abstraction and practicality:
   - Recognize when a solution could be improved, but avoid over-engineering
   - Not every problem requires complex architectural solutions
   - Consider the specific needs of the project before applying advanced design patterns[2]

7. Avoiding becoming an architecture astronaut:
   - Share designs with fellow engineers early and often
   - Ask for feedback and be open to suggestions
   - Be wary if people don't understand your design or can't ask questions about it[3]

8. Positive aspects of abstraction:
   - Can lead to innovative solutions and new technologies
   - Has contributed to advancements like cloud architectures and serverless computing[5]

While Spolsky's critique highlights important concerns about over-abstraction in software development, it's essential to strike a balance between high-level thinking and practical implementation. The goal should be to solve real problems efficiently, rather than creating unnecessarily complex architectures.

Citations:

    [1] https://en.wikipedia.org/wiki/Architecture_astronaut
    [2] https://tommcfarlin.com/architecture-astronauts-of-wordpress/
    [3] https://www.maxiferreira.com/blog/architecture-astronauts/
    [4] https://www.joelonsoftware.com/2008/05/01/architecture-astronauts-take-over/
    [5] https://www.reddit.com/r/programming/comments/9fsvt2/how_relevant_is_joel_spolskys_dont_let/
    [6] https://serverlessfirst.com/emails/the-serverless-architecture-astronaut/
    [7] https://news.ycombinator.com/item?id=28353157
    [8] https://www.joelonsoftware.com/2001/04/21/dont-let-architecture-astronauts-scare-you/

## Building Ambient Intelligence for Customer Focus

And so, building ambient intelligence into a web framework where you can just
plug in apps rapidly ported from their Jupyter Notebook prototypes is my
passion, it has got to be entirely in service of getting and keeping customers.
There's a famous old business consultant... Perplexity: Explain Peter Drucker
and his view on the mission of every company or organization, and Edwards
Demming on total quality management.

Perplexity: Peter Drucker and W. Edwards Deming were two influential management thinkers who significantly shaped modern business practices. While they focused on different aspects of management, their ideas have had lasting impacts on how organizations operate.

## Peter Drucker on Organizational Mission

Peter Drucker, often called the "father of modern management," emphasized the importance of a clear organizational purpose and customer focus.

Key aspects of Drucker's view on organizational mission:

1. Customer-centric approach: Drucker famously stated, "The purpose of a business is to create a customer"[1]. This perspective shifts the focus from internal processes to external value creation.

2. Mission definition: He argued that organizations should ask themselves three fundamental questions:
   - What is our business?
   - Who is the customer?
   - What does the customer value?[2]

3. Beyond profit: While Drucker acknowledged the importance of profitability, he viewed it as a necessity rather than the primary purpose of a business[1].

4. Innovation and marketing: Drucker believed that businesses have only two basic functions: marketing and innovation. All other activities he considered costs[1].

5. Mission statements: He advocated for concise, action-oriented mission statements that could "fit on a T-shirt"[2].

6. Continuous evaluation: Drucker emphasized the need for organizations to regularly reassess their mission, asking not just "What is our business?" but also "What will our business be?" and "What should our business be?"[4]

## W. Edwards Deming on Total Quality Management

W. Edwards Deming, while not the originator of the term "Total Quality Management" (TQM), is widely regarded as one of its key architects. His approach focused on continuous improvement and system-wide quality.

Key aspects of Deming's Total Quality Management philosophy:

1. System approach: Deming viewed organizations as interconnected systems where improvements in one area affect others.

2. Continuous improvement: He advocated for ongoing efforts to improve products, services, and processes, a concept known as "Kaizen" in Japanese management.

3. Statistical process control: Deming emphasized the use of statistical methods to identify and reduce variations in production processes.

4. Leadership responsibility: He believed that management was responsible for 94% of quality problems, highlighting the importance of leadership in quality initiatives.

5. Employee empowerment: Deming advocated for involving all employees in the quality improvement process, not just quality control departments.

6. The Deming Cycle (PDCA): Plan, Do, Check, Act - a four-step model for continuous improvement of processes and products.

7. 14 Points for Management: Deming's comprehensive guide for transforming business effectiveness, including principles like "Create constancy of purpose" and "Drive out fear."

While Drucker focused on defining organizational purpose and customer value, Deming concentrated on systemic quality improvement. Both emphasized the importance of long-term thinking, continuous improvement, and the critical role of leadership in organizational success. Their complementary approaches have significantly influenced modern management practices, encouraging businesses to be both purpose-driven and quality-focused.

Citations:

    [1] https://asymmetric.pro/the-core-purpose-of-business-building-remarkable-enterprises/
    [2] https://www.linkedin.com/pulse/mission-statements-druckers-criteria-michael-constantino
    [3] https://www.processexcellencenetwork.com/lessons_from_peter_drucker/articles/druckers-fundamental-business-decision
    [4] https://www.corporatelearningnetwork.com/leadership/articles/3-questions-drucker-would-ask-you-and-your-management-team
    [5] https://www.forbes.com/councils/forbesagencycouncil/2021/02/12/the-meaning-behind-mission/
    [6] https://ericjacobsononmanagement.blogspot.com/2024/01/how-to-write-your-companys-mission.html
    [7] https://smawins.com/news/peter-f-druckers-vision-realized/
    [8] https://www.joelonsoftware.com/2001/04/21/dont-let-architecture-astronauts-scare-you/

## Prioritizing Client Value & Seamless AI Integration

This shift marks a pivotal transition—focusing more on client work and less on the intricate dance of architecture. It’s time to get my priorities straight, channeling energy toward delighting clients and embedding AI as a seamless narrative within every interaction. As Peter Drucker reminds us, the customer defines value, and now is the moment to align my workflow around that truth. At the same time, embracing Deming’s philosophy of continuous, incremental improvement will let a Total Quality Management (TQM) process take root, ensuring every client touchpoint becomes an opportunity for refinement. By anchoring my efforts in these principles, I’ll strike the right balance—leveraging architecture when necessary but always with a clear focus on delivering value. This approach will align sustainable processes with evolving client needs, ensuring progress isn’t just made but cultivated in a way that scales and endures.

And so onto tomorrow's article on THAT topic, to focus and steer me and keep
things from blowing up in my face.

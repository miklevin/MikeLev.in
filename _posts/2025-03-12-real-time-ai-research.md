---
title: The Real-Time AI Research Revolution
permalink: /futureproof/real-time-ai-research/
description: "In this article, I explored the evolving AI landscape, particularly the 'arms race' between vendors for AI lock-in versus the push for open-source solutions. I delved into Meta's open-source strategy with Llama, Anthropic's MCP, and OpenAI's proprietary features, highlighting the dynamic between these key players. My focus shifted to building a future-proof local AI solution, examining Gemma 3's function-calling capabilities via Ollama. I tested deep research features in Grok 3, ChatGPT 4.5, Gemini Advanced 1.5 Pro, and Perplexity.AI, comparing their approaches and capabilities in researching AI advancements in real-time. Ultimately, I confirmed Gemma 3's function-calling support and reflected on the broader implications of these AI research frameworks."
meta_description: Discover how real-time AI research is revolutionizing deep search with advanced function calling, challenging traditional vendor lock-in.
meta_keywords: real-time AI research, deep research, function calling, small world search, vendor lock-in, open-source AI, AI arms race, dynamic search, Gemma 3, Anthropic MCP, OpenAI API
layout: post
sort_order: 1
---

It's getting real, as in real-time. I've been waiting for "small world theory
search" to disrupt Google for awhile now, eroding their mote by treating the
Internet as the database it is -- instead of making a copy of it with the crawl
& index model. The agentic framework buzzword might be different, but the
concept now being demonstrated in the The new Deep Research features is very
similar... but better!

## The AI Arms Race: Vendor Lock-in vs Open Source

The AI news just keeps pouring in. You hear talk about an AI arms race between
the US and China, but it seems to me like it's an arms race between vendors to
lock you in to their particular services. Or the corollary, which is scorched
earth strategies to erode the competitive "moat" advantages of such lock-in
attempts.

### Meta's Open Source Strategy with Llama

One of the earliest examples of scorched earth AI strategy is the way Meta
released Llama as open source AI. We know such strategy is effective given how
DeepSeek followed on, and the impact it's had. Strike and counter-strikes
un-level the playing field, and then rapid re-level it.

### Anthropic's MCP vs OpenAI's Proprietary Features

The latest round of round of volleys exchanged was Anthropic's MCP (model
context protocol) which is a very lightweight way of teaching any LLM how to
handle function-calling on any model, without the massive task of training the
core model how to do it, plus adding protocol support in the API -- the OpenAI
way which Meta copied and trained into Llama 2 and greater. Anthropic calls MCP
like the USB port for AI function-calling, a universal interoperable layer, and
thus landing in the scorched earth side of the volleys. MCP support means more
or less invalidating all that special in-model training for proprietary
capabilities.

And within days, OpenAI responds with more proprietary futures in their API,
such as the ability to do general web search without all the pesky browser
automation stuff. It also added support for maintaining context without having
to post back entire conversation histories, thus cutting down token usage. So
two big pain points were addressed, enabling easier builds of more sophisticated
apps -- so long as you use OpenAI's services.

### The OpenAI-Anthropic Dynamic

So there's a back-and-forth battle here between OpenAI and Anthropic, which only
makes sense since Anthropic is created from OpenAI ex-patriots who wanted to
scale and do the commercial thing back while OpenAI was still principled about
being open and not-for-profit. Oh, the irony now that OpenAI has gone all-in
for-profit, while Meta and DeepSeek are on the sidelines throwing FOSSy rocks!

### Building a Future-Proof Local AI Solution

Pshwew! Okay... so a solution is forming that's very appealing to me. Local
models that can call functions real nicely can be running for you 24/7 on your
home equipment, using your home bandwidth, limited only by your cleverness. You
can't necessarily train your own baseline-smart models yet (that's the part that
costs millions), but you can use the downloadable ones from HuggingFace and
Ollama. Just add cleverness. Advanced apps with large competitive moats can be
built if you bring sufficiently advanced cleverness.

Then, you swap out the local models as they advance. You keep the framework that
they're plugged into just flexible enough. That means a small codebase that can
be rapidly refactored to new realities when they come along, like changing ways
of calling functions, like MCP. Swap out the models over time as they get
smarter. Swap out your hardware over time as it gets more powerful. Ship of
Theseus your way to a stunning future.

### From Gemma 2B to Gemma 3: A Strategic Shift

Okay, so I've been using the underdog Gemma 2B in my home models, becuase it's
this unique combination of really fast and really smart. I never planned on
staying with Gemma, because it's not really free and open source. It's free as
in beer. Google gave it out, but it really can't be fine-tuned, and it's not
open in the way Llama and DeepSeek are (open weights). So Gemma was a convenient
holding pattern.

And right while I was writing this article, Gemma 3 dropped -- a whole family of
weights with multi-modal capabilities and open weights! This changes things. But
I didn't hear from the announcements whether they supported OpenAI-style
function calling. It's worth noting that AI models themselves don't execute the
function code. They're just taught how to use formal protocols with the APIs so
that they can recognize a request for an executable function-call (just JSON and
not actual code) to call the function. I cover this in a previous article. Truth
is, any LLM can "execute" functions, because they can be taught how through
prompting, but it's less reliable and less formal than training it into the
models and supporting it formally through the API (OpenAI-style).

### Investigating Gemma 3's Function Calling Capabilities

So my question is whether Gemma 3 supports that kind of function calling.
Chances are, I'm going to refactor my codebase to support both OpenAI's function
calling API (which will work with Llama) and support MCP. I'm not going to do
either right away, as they are both deep rabbit holes that I can't afford while
I'm servicing clients in my day job. But I need to solidify the plan. And for
that, I'm going to tap the new deep search / deep research capabilities of the
frontier models like Grok 3 and ChatGPT 4.5, which is so friggin meta.

### Using AI to Research AI: A Meta Approach

Figuring out whether Gemma 3 supports function-calling using the new AI Deep
Research capability is meta because it means I'm tapping the very
function-calling capabilities I'm researching. Why? Because the information I'm
seeking just came out yesterday. So the answers are not going to be in either
the stale base-models (the snapshot images that have those cutoff dates), nor
will the answers be in search results (breaking news as of yesterday). So,
they're going to have to go more real-time than even search capabilities
(Google, Bing) can provide.

They're going to have to visit the sites they find in search results... or
Twitter/X. In fact, I'm starting with Grok 3 because of it's access to the
real-time X-sphere...

---

## Checking Grok 3 Deep Search Against Breaking News

> The new Deep Search / Deep Research features in Grok 3, Chat GPT and Gemini
> show a first major real-time search break from the static stale SEO results. I
> check with Grok 3 first because of its access to the X/Twitter-sphere.

**Me**: Can the new Gemma 3 model that just dropped support function calling with Ollama?

**Grok 3 Deep Search**: 

### Key Points
- It seems likely that the new Gemma 3 model supports function calling with Ollama, given recent updates and model capabilities.
- Research suggests Ollama's tool calling feature, which includes function calling, is compatible with popular models like Gemma 3.
- The evidence leans toward Gemma 3 having built-in function calling, as per its March 2025 release notes, enhancing its utility for developers.

### Background
The Gemma 3 model, released by Google in March 2025, is part of their open-source AI model family, designed for lightweight, efficient performance across various hardware. Ollama is a tool that allows running large language models (LLMs) locally, simplifying access for developers and researchers. Function calling enables models to interact with external tools or APIs, expanding their capabilities beyond text generation.

### Compatibility
Given Ollama's support for Gemma 3 and its general tool calling functionality, it appears that users can leverage Gemma 3's function calling feature through Ollama. This is particularly useful for tasks requiring real-time data access or API interactions, such as weather updates or database queries.

### Unexpected Detail
An interesting aspect is that while base Gemma models previously required fine-tuning for function calling, Gemma 3 seems to include this feature natively, potentially reducing setup complexity for developers using Ollama.

---

### Survey Note: Detailed Analysis of Gemma 3 and Function Calling with Ollama

This note provides a comprehensive examination of whether the new Gemma 3 model, released by Google in March 2025, supports function calling when used with Ollama, a popular tool for running large language models (LLMs) locally. The analysis is based on available documentation, community discussions, and recent updates, aiming to offer a thorough understanding for developers and researchers.

#### Overview of Gemma 3 and Ollama

Gemma 3 is the latest iteration of Google's open-source AI models, building on the success of previous versions like Gemma 2. According to the Google Developers Blog ([Introducing Gemma 3: The Developer Guide](https://developers.googleblog.com/en/introducing-gemma3/)), Gemma 3 introduces multimodality, supporting vision-language input and text outputs, with a context window of up to 128k tokens and support for over 140 languages. It is available in four sizes (1B, 4B, 12B, and 27B) and is optimized for deployment on resource-limited devices, making it versatile for various applications.

Ollama, as described in its official documentation ([Ollama](https://ollama.com/)), is an open-source platform that enables running LLMs locally on personal computers, supporting models like Llama, Mistral, and recently, Google's Gemma series. It simplifies model management and interaction, making it accessible for developers without extensive setup.

#### Function Calling: Definition and Importance

Function calling, often referred to as tool calling, allows LLMs to generate structured outputs, such as JSON, that can trigger external functions or API calls. This capability is crucial for building complex applications, such as conversational agents that retrieve real-time data (e.g., weather information) or interact with databases. According to a Medium article ([Function Calling with Open-Source LLMs](https://medium.com/@rushing_andrei/function-calling-with-open-source-llms-594aa5b3a304)), open-source models can support function calling either natively or through prompt engineering and fine-tuning, depending on the model.

#### Gemma 3's Function Calling Capability

The release notes for Gemma 3, as seen in the Google Developers Blog ([Introducing Gemma 3: The Developer Guide](https://developers.googleblog.com/en/introducing-gemma3/)), explicitly mention "improved chat capabilities, including structured outputs and function calling." This indicates that Gemma 3 has built-in support for function calling, a significant upgrade from earlier versions, which sometimes required fine-tuning for such features. This native support is likely to enhance its utility for developers, especially in scenarios requiring integration with external systems.

#### Ollama's Support for Function Calling

Ollama's blog ([Blog · Ollama](https://ollama.com/blog)) highlights that it now supports tool calling with popular models like Llama 3.1, enabling models to interact with external tools based on prompts. Given that Ollama supports Gemma 3, as evidenced by its library page ([gemma3](https://ollama.com/library/gemma3)), it is reasonable to infer that this tool calling functionality extends to Gemma 3. The library page notes that Gemma 3 requires Ollama 0.6 or later, suggesting recent updates to accommodate this model.

However, to confirm, we examined community discussions and documentation. A Reddit post ([r/ollama on Reddit: Ollama 0.6 with support for Google Gemma 3](https://www.reddit.com/r/ollama/comments/1j9gic5/ollama_06_with_support_for_google_gemma_3/)) from March 12, 2025, mentions Ollama 0.6 supporting Gemma 3, aligning with our timeline. While specific examples of function calling with Gemma 3 in Ollama are limited, the general support for tool calling and the model's native capability suggest compatibility.

#### Comparative Analysis: Previous Gemma Models and Function Calling

For context, earlier Gemma models, such as Gemma 2, had mixed support for function calling. A Reddit discussion ([r/ollama on Reddit: Gemma2b calling function (ollama)](https://www.reddit.com/r/ollama/comments/1ei3tdc/gemma2b_calling_function_ollama/)) from August 2024 indicates uncertainty about Gemma 2B's function calling capabilities, with some users suggesting it might not support it natively. However, a fine-tuned version, "atlas/intersync-gemma-7b-instruct-function-calling" ([atlas/intersync-gemma-7b-instruct-function-calling](https://ollama.com/atlas/intersync-gemma-7b-instruct-function-calling)), shows that community efforts have enabled function calling for Gemma 7B. This contrasts with Gemma 3, which, per its release notes, includes function calling out of the box, reducing the need for additional fine-tuning.

#### Practical Implications and Setup

To use Gemma 3 with Ollama for function calling, developers would likely need to ensure they have Ollama version 0.6 or later, as specified ([gemma3:27b](https://ollama.com/library/gemma3:27b)). They can then define functions or tools in their prompts, leveraging Gemma 3's structured output capability. For example, a prompt asking for weather information could trigger a function call to an external API, with Ollama facilitating the local execution. Given Ollama's integration with frameworks like LangChain4j ([Calling Gemma with Ollama, TestContainers, and LangChain4j](https://glaforge.dev/posts/2024/04/04/calling-gemma-with-ollama-and-testcontainers/)), this setup is feasible, though specific tutorials for Gemma 3 may emerge soon given its recent release.

#### Table: Comparison of Gemma Models and Function Calling Support

| Model       | Release Date | Function Calling Support | Notes                                                                 |
|-------------|--------------|--------------------------|----------------------------------------------------------------------|
| Gemma 1     | Feb 2024     | Limited, requires fine-tuning | Available in 2B and 7B sizes, base models focus on text generation.   |
| Gemma 2     | Jun 2024     | Partial, some fine-tuned versions support it | Sizes include 2B, 9B, 27B; community fine-tunes for function calling. |
| Gemma 3     | Mar 2025     | Native support           | Includes structured outputs and function calling, available in 1B, 4B, 12B, 27B. |

#### Conclusion

Based on the available evidence, it seems likely that the new Gemma 3 model supports function calling when used with Ollama, given its native capability and Ollama's tool calling support for similar models. This compatibility enhances Gemma 3's utility for developers, particularly for applications requiring external tool integration. While specific examples are limited due to the model's recent release, the combination of Gemma 3's features and Ollama's functionality suggests a positive answer, with potential for further community documentation to clarify setup details.

### Key Citations
- [Introducing Gemma 3: The Developer Guide](https://developers.googleblog.com/en/introducing-gemma3/)
- [Ollama](https://ollama.com/)
- [Function Calling with Open-Source LLMs](https://medium.com/@rushing_andrei/function-calling-with-open-source-llms-594aa5b3a304)
- [Blog · Ollama](https://ollama.com/blog)
- [gemma3](https://ollama.com/library/gemma3)
- [r/ollama on Reddit: Ollama 0.6 with support for Google Gemma 3](https://www.reddit.com/r/ollama/comments/1j9gic5/ollama_06_with_support_for_google_gemma_3/)
- [r/ollama on Reddit: Gemma2b calling function (ollama)](https://www.reddit.com/r/ollama/comments/1ei3tdc/gemma2b_calling_function_ollama/)
- [atlas/intersync-gemma-7b-instruct-function-calling](https://ollama.com/atlas/intersync-gemma-7b-instruct-function-calling)
- [Calling Gemma with Ollama, TestContainers, and LangChain4j](https://glaforge.dev/posts/2024/04/04/calling-gemma-with-ollama-and-testcontainers/)
- [gemma3:27b](https://ollama.com/library/gemma3:27b)

---

## And Now I Check OpenAI ChatGPT 4.5 Research Preview

> While Grok 3 has unique access to the X-sphere, OpenAI has its ChatGPT 4.5
> Research Preview feature.

**Me**: Can the new Gemma 3 model that just dropped support function calling with Ollama?

**ChatGPT 4.5 Deep Research Preview**: Are you looking for confirmation on whether Gemma 3 supports function calling in Ollama, or do you need details on how to implement it if supported?

> It's interesting to note that ChatGPT Deep Research Preview asks additional
> qualifying questions. This is an opportunity to get beyond the buzz by also
> asking for implementation details!

**Me**: First one. Then the other.

**ChatGPT 4.5 Deep Research Preview**: I'll look into whether the newly released Gemma 3 model supports function calling with Ollama. I'll get back to you with the details shortly.

# Gemma 3’s Function Calling Support in Ollama

**Yes – the newly released Gemma 3 model *does* support function calling, including when used via Ollama.** This capability is explicitly mentioned in Google’s official documentation and has been confirmed by release info and community discussions:

## Official Documentation Confirmation

- **Google’s Announcement:** The official Google blog **introducing Gemma 3** highlights *function calling* as a new feature. Gemma 3 was designed with “structured outputs and function calling” as part of its advanced chat capabilities ([Introducing Gemma 3: The Developer Guide - Google Developers Blog](https://developers.googleblog.com/en/introducing-gemma3#:~:text=Gemma%203%20introduces%20multimodality%2C%20supporting,tuned%20versions)). In particular, Google notes that Gemma 3 “supports function calling and structured output to help you automate tasks and build agentic experiences” ([Gemma 3: Google’s new open model based on Gemini 2.0](https://blog.google/technology/developers/gemma-3/#:~:text=128k,tasks%20and%20build%20agentic%20experiences)). This means the model can produce structured responses (e.g. JSON) intended to trigger external functions, similar to OpenAI’s function-call format.

- **Developer Guide:** Google’s developer blog reiterates that **Gemma 3 includes function calling support**. They describe it as one of the most requested features added in this version, alongside longer context and multimodality ([Introducing Gemma 3: The Developer Guide - Google Developers Blog](https://developers.googleblog.com/en/introducing-gemma3#:~:text=Link%20to%20Youtube%20Video%20,only%20when%20JS%20is%20disabled)). In short, Gemma 3’s instruction-tuned variants were trained to handle function-call style prompts and outputs.

## Ollama Integration and Release Notes

- **Ollama Support:** The Ollama LLM runtime has integrated Gemma 3 models (as of v0.6.0). The Ollama team’s release notes announce *Gemma 3’s availability* in multiple sizes (1B, 4B, 12B, 27B), ensuring users can load Gemma 3 via Ollama ([Releases · ollama/ollama · GitHub](https://github.com/ollama/ollama/releases#:~:text=New%20Model)). While the Ollama release note itself doesn’t explicitly mention function calling in that entry, the requirement of Ollama 0.6+ for Gemma 3 ([gemma3:27b](https://ollama.com/library/gemma3:27b#:~:text=Image%3A%20Google%20Gemma%203%20logo)) implies you’ll get the latest features support. Ollama’s platform **does** support function calling (sometimes referred to as “tools” or OpenAI-compatible function APIs) in models that are fine-tuned for it – and Gemma 3 is built with that capability in mind.

- **Gemma 3 Model Card:** According to the Gemma 3 model card and Google’s technical report, all **Gemma 3 instruction-tuned (“-it”) models come with the new features** out-of-the-box. This includes the 128k context window, multimodal input, and function calling support ([Introducing Gemma 3: The Developer Guide - Google Developers Blog](https://developers.googleblog.com/en/introducing-gemma3#:~:text=Gemma%203%20introduces%20multimodality%2C%20supporting,tuned%20versions)). No special fine-tune is required to enable function tools – it’s part of the base instruction model’s training.

## Community Discussions and Confirmation

- **User Reports:** Early adopters in the community have **confirmed that Gemma 3 can perform function calling** when used through Ollama. In a discussion thread about the Gemma 3 release, one user asked if it had function calling support, to which others replied *“it has”*, indicating they’ve seen it work ([Gemma 3 Release - a google Collection : r/LocalLLaMA](https://www.reddit.com/r/LocalLLaMA/comments/1j9dkvh/gemma_3_release_a_google_collection/#:~:text=%E2%80%A2)) ([Gemma 3 Release - a google Collection : r/LocalLLaMA](https://www.reddit.com/r/LocalLLaMA/comments/1j9dkvh/gemma_3_release_a_google_collection/#:~:text=%E2%80%A2)). This aligns with Google’s documentation, and suggests that if you prompt Gemma 3 with function definitions (via Ollama’s OpenAI-compatible API or a proper system prompt), the model will return a function call JSON when appropriate.

- **Previous Context:** (For comparison, community members noted that earlier Gemma versions didn’t natively support function calling without fine-tuning. In fact, unofficial fine-tuned variants of **Gemma 2** were created to add this feature. Gemma 3 now addresses this natively.) This gives confidence that Gemma 3’s built-in function calling is a significant improvement over its predecessor.

## **Conclusion:** 

**Gemma 3 natively supports function calling**, and this capability carries over when you run the model with Ollama. Official Google sources highlight this feature, and Ollama’s latest release makes Gemma 3 readily available. In practice, you can use Ollama’s API (or CLI with proper prompts) to supply function definitions and have Gemma 3 choose and call functions. Both documentation and early user feedback confirm that Gemma 3 + Ollama is capable of the structured outputs needed for function call workflows ([Gemma 3: Google’s new open model based on Gemini 2.0](https://blog.google/technology/developers/gemma-3/#:~:text=128k,tasks%20and%20build%20agentic%20experiences)) ([Gemma 3 Release - a google Collection : r/LocalLLaMA](https://www.reddit.com/r/LocalLLaMA/comments/1j9dkvh/gemma_3_release_a_google_collection/#:~:text=%E2%80%A2)). 

**Sources:**

- Google AI Blog – *“Gemma 3 supports function calling and structured output…”* ([Gemma 3: Google’s new open model based on Gemini 2.0](https://blog.google/technology/developers/gemma-3/#:~:text=128k,tasks%20and%20build%20agentic%20experiences))  
- Google Developers Blog – *“Gemma 3 ... offers improved ... chat capabilities, including structured outputs and function calling.”* ([Introducing Gemma 3: The Developer Guide - Google Developers Blog](https://developers.googleblog.com/en/introducing-gemma3#:~:text=Gemma%203%20introduces%20multimodality%2C%20supporting,tuned%20versions))  
- Ollama Release Notes v0.6.0 – *Gemma 3 model available in 1B, 4B, 12B, 27B sizes* ([Releases · ollama/ollama · GitHub](https://github.com/ollama/ollama/releases#:~:text=New%20Model))  
- Reddit r/LocalLLaMA – User discussion confirming Gemma 3 “has” function calling ([Gemma 3 Release - a google Collection : r/LocalLLaMA](https://www.reddit.com/r/LocalLLaMA/comments/1j9dkvh/gemma_3_release_a_google_collection/#:~:text=%E2%80%A2))

---

## Confirming Gemma 3's Function Calling Support

Wow, okay that pretty much confirms it. Gemma 3 supports OpenAI-style API
function calling, and switching my local work to one of the Gemma 3 models is
definitely on the list for today. But changing the API-support around not so
much. I'll bookmark that for weekend work when I can dive down the rabbit holes
uninterrupted. So many rabbit holes to explore! I have to 80/20-rule prioritize
them.

## Deep Research Capabilities Across AI Models

But the exercise in this article is no longer just about confirming these
details. I am struck with the real-time deep research capabilities of these
models, being an SEO as I am, and I have to continue kicking the tires of the
other models that clearly advertise this capability. That's Perplexity.AI and
Google's Gemini, both of which have been doing this for awhile now but under
their paid products. Grok 3 giving it away is probably the catalyst forcing
everyone to play their deep search hands.

---

## Giving Gemini Advanced 1.5 Pro with Deep Research a Shot

**Me**: Can the new Gemma 3 model that just dropped support function calling with Ollama?

**Gemini Advanced 1.5 Pro Deep Research**: # **Gemma 3 and Ollama: A Deep Dive into Function Calling Support**

The world of large language models (LLMs) is constantly evolving, with new models and capabilities emerging at a rapid pace. Google recently released Gemma 3, the latest iteration of its open-weight LLMs, boasting impressive features like multimodality, a 128k token context window, and multilingual support1. This powerful LLM, combined with the capabilities of Ollama, a tool for running LLMs locally, makes home AI a reality5. But for developers and AI enthusiasts eager to harness the power of Gemma 3 locally, one question looms large: can it support function calling with Ollama?

Ollama, an open-source tool designed for running LLMs locally, has gained significant traction for its ease of use and ability to handle a wide range of models6. The combination of Gemma 3's capabilities and Ollama's local execution environment presents an exciting prospect for AI development. This article delves into the specifics of Gemma 3 and Ollama, exploring their features and ultimately addressing the critical question of function calling support.

## **Gemma 3: A New Era of Open-Weight LLMs**

Gemma 3 represents a significant leap forward in open-weight LLMs, building upon the success of its predecessors with key enhancements:

* **Longer Context Length:** With a context window of up to 128k tokens, Gemma 3 can process and understand significantly more information than previous versions, enabling it to handle larger documents, multiple articles, or even hundreds of images in a single prompt1.

| Parameter Size | Context Window Length | Multimodality | Multilinguality |
| :---- | :---- | :---- | :---- |
| 1B | 32k | ❌ | English |
| 4B | 128k | ✅ | 140+ languages |
| 12B | 128k | ✅ | 140+ languages |
| 27B | 128k | ✅ | 140+ languages |

* **Multimodality:** Gemma 3 embraces multimodality, allowing it to process both text and images. This opens up a world of possibilities for applications that require understanding and analyzing visual data1. Gemma-3 models use SigLIP as an image encoder, which encodes images into tokens that are ingested into the language model1. The vision encoder takes square images resized to 896x896 as input. To address limitations in processing non-square aspect ratios and high-resolution images during inference, images can be adaptively cropped, and each crop is then resized to 896x896 and encoded by the image encoder. This algorithm, called "pan and scan", effectively enables the model to zoom in on smaller details in the image1.  
* **Multilinguality:** With support for over 140 languages, Gemma 3 caters to a global audience, enabling developers to create AI applications that transcend language barriers1.

Furthermore, Gemma 3 has demonstrated competitive performance on various benchmarks:

* **MMLU-Pro:** Achieved a score of 67.5 with the 27B parameter model1.  
* **LiveCodeBench:** Achieved a score of 29.7 with the 27B parameter model1.  
* **Bird-SQL:** Achieved a score of 54.4 with the 27B parameter model1.

It's also worth noting that Gemma 3 1B is specifically designed for on-device deployment on mobile and web platforms. This opens up new possibilities for distributing in-app small language models (SLMs) across mobile and web applications10.

These enhancements, coupled with its open-weight nature, make Gemma 3 a compelling choice for developers seeking powerful and versatile LLMs.

## **Ollama: Empowering Local AI Development**

While Gemma 3 offers impressive capabilities, running large language models can be resource-intensive. This is where Ollama comes in. Ollama has emerged as a game-changer in the realm of local LLM execution. It offers significant advantages in terms of data privacy, customization, and cost compared to cloud-based solutions5. Its key features include:

* **Local Model Management:** Ollama simplifies the process of downloading, updating, and deleting models locally, giving users complete control over their AI environment6.  
* **Command-line and GUI Options:** Ollama offers both command-line and graphical user interface options, catering to different user preferences and skill levels7.  
* **Multi-platform Support:** Ollama is available for macOS, Windows, and Linux, ensuring accessibility across a wide range of operating systems7.  
* **Model Library:** Ollama provides access to a vast library of LLMs, including popular models like Llama 2 and Mistral, and now, Gemma 311.  
* **API Endpoints:** Ollama offers various API endpoints for interacting with models, including /api/generate for completions, /api/chat for multi-turn conversations, and endpoints for model management12.

By enabling local execution of LLMs, Ollama offers several advantages:

* **Enhanced Privacy and Data Security:** Running models locally eliminates the need to send sensitive data to cloud services, ensuring data privacy and security5.  
* **No Reliance on Cloud Services:** Ollama frees users from dependence on cloud infrastructure, providing greater control and flexibility5.  
* **Cost Savings:** By avoiding cloud service fees, Ollama can lead to significant cost savings, especially for projects with consistent usage7.

However, it's important to be mindful of potential disk space issues when using Ollama with large models6. Ensure you have sufficient storage space before downloading and running large models like Gemma 3 27B.

## **Gemma 3 and Ollama: Function Calling Support**

Now, let's address the central question: can Gemma 3 support function calling with Ollama?

The answer is a resounding yes\! Ollama officially supports Gemma 3, providing pre-configured runtime environments for various model sizes13. This means developers can leverage Gemma 3's capabilities locally with Ollama, including function calling.

Function calling allows LLMs to interact with external tools and APIs, extending their functionality and enabling them to perform more complex tasks16. With Ollama's support for Gemma 3 and function calling, developers can create innovative applications that combine the power of LLMs with external resources.

To use Gemma 3 with Ollama, follow these simple steps:

1. **Install Ollama:** Download and install Ollama from the official website (ollama.com)13. The installation process is straightforward and varies slightly depending on your operating system (Windows, macOS, or Linux).  
2. **Pull Gemma 3 Model:** Use the ollama pull command to download the desired Gemma 3 model variant. Model names in Ollama follow the format model:tag, where tag specifies the version or variant16. For example, to download the 4B parameter model, use ollama pull gemma3:4b13. You can choose from different sizes (1B, 4B, 12B, 27B) based on your needs and hardware capabilities.  
3. **Verify Installation:** Use the ollama list command to confirm that the Gemma 3 model is available13. This command lists all the models that have been downloaded and are ready to use with Ollama.  
4. **Generate Responses:** Use the ollama run command to interact with the model and generate responses13. For example, ollama run gemma3 "What is the capital of France?" will generate a response from the Gemma 3 model.

Ollama also provides a local web service interface for accessing the model, which can be tested using tools like curl13. The /api/generate endpoint offers advanced parameters like format, options, system, and template to fine-tune the model's behavior and output16.

## **Limitations of Gemma 3**

While Gemma 3 offers significant advancements, it's essential to be aware of its limitations:

* **Training Data Biases:** The quality and diversity of the training data influence the model's capabilities. Biases in the data can lead to limitations in the model's responses2.  
* **Context and Task Complexity:** Gemma 3 performs better on tasks with clear prompts and instructions. Open-ended or highly complex tasks might be challenging2.  
* **Language Ambiguity and Nuance:** The model might struggle to grasp subtle nuances, sarcasm, or figurative language2.  
* **Factual Accuracy:** Gemma 3 is not a knowledge base and may generate incorrect or outdated factual statements2.  
* **Common Sense Reasoning:** The model might lack the ability to apply common sense reasoning in certain situations2.

## **Community Discussion and Feedback**

Online communities like Reddit provide valuable insights into the experiences and feedback of users who are already experimenting with Gemma 3 and Ollama17. Some users have highlighted the model's impressive performance and reasoning capabilities, while others have pointed out areas for improvement. These discussions offer a glimpse into the real-world applications and potential of these tools.

One point of clarification regarding Ollama is that while it generally doesn't require API tokens for locally hosted models, some models accessed through Ollama might require authentication11.

## **Conclusion**

The combination of Gemma 3 and Ollama unlocks a world of possibilities for local AI development. With Ollama's support for Gemma 3 and function calling, developers can harness the power of this advanced LLM in a privacy-focused, cost-effective, and highly customizable environment. This empowers individuals and businesses to create innovative AI applications that were previously out of reach, furthering the democratization of AI and making home AI a reality5. As the open-source AI ecosystem continues to flourish, tools like Gemma 3 and Ollama pave the way for a future where AI is accessible to all, fostering innovation and collaboration across various domains.

#### **Works cited**

1\. Welcome Gemma 3: Google's all new multimodal, multilingual, long context open LLM, accessed March 12, 2025, [https://huggingface.co/blog/gemma3](https://huggingface.co/blog/gemma3)  
2\. Gemma 3 model card | Google AI for Developers \- Gemini API, accessed March 12, 2025, [https://ai.google.dev/gemma/docs/core/model\_card\_3](https://ai.google.dev/gemma/docs/core/model_card_3)  
3\. What is Gemma 3, Google's new lightweight AI model that can run on a single GPU? | Technology News \- The Indian Express, accessed March 12, 2025, [https://indianexpress.com/article/technology/artificial-intelligence/what-is-gemma-3-google-new-lightweight-ai-model-9882853/](https://indianexpress.com/article/technology/artificial-intelligence/what-is-gemma-3-google-new-lightweight-ai-model-9882853/)  
4\. Gemma 3: Google launches its latest open AI models \- AI News, accessed March 12, 2025, [https://www.artificialintelligence-news.com/news/gemma-3-google-launches-its-latest-open-ai-models/](https://www.artificialintelligence-news.com/news/gemma-3-google-launches-its-latest-open-ai-models/)  
5\. Google's Gemma 3 makes home AI a reality with new open-source model \- CryptoSlate, accessed March 12, 2025, [https://cryptoslate.com/googles-gemma-3-makes-home-ai-a-reality-with-new-open-source-model/](https://cryptoslate.com/googles-gemma-3-makes-home-ai-a-reality-with-new-open-source-model/)  
6\. Your Machine, Your AI — The Ultimate Local Productivity Stack with Ollama | by Volker Janz, accessed March 12, 2025, [https://blog.det.life/your-machine-your-ai-the-ultimate-local-productivity-stack-with-ollama-7a118f271479](https://blog.det.life/your-machine-your-ai-the-ultimate-local-productivity-stack-with-ollama-7a118f271479)  
7\. What is Ollama? Understanding how it works, main features and models \- Hostinger, accessed March 12, 2025, [https://www.hostinger.com/tutorials/what-is-ollama](https://www.hostinger.com/tutorials/what-is-ollama)  
8\. Gemma 3 model overview | Google AI for Developers \- Gemini API, accessed March 12, 2025, [https://ai.google.dev/gemma/docs/core](https://ai.google.dev/gemma/docs/core)  
9\. Google Unveils Gemma 3: The Most Powerful AI You Can Run on a Single GPU \- Medium, accessed March 12, 2025, [https://medium.com/@erisco\_and/google-unveils-gemma-3-the-most-powerful-ai-you-can-run-on-a-single-gpu-aa3855c6c1d0](https://medium.com/@erisco_and/google-unveils-gemma-3-the-most-powerful-ai-you-can-run-on-a-single-gpu-aa3855c6c1d0)  
10\. Gemma 3 on mobile and web with Google AI Edge, accessed March 12, 2025, [https://developers.googleblog.com/en/gemma-3-on-mobile-and-web-with-google-ai-edge/](https://developers.googleblog.com/en/gemma-3-on-mobile-and-web-with-google-ai-edge/)  
11\. Using Ollama with Spring AI \- Piotr's TechBlog, accessed March 12, 2025, [https://piotrminkowski.com/2025/03/10/using-ollama-with-spring-ai/](https://piotrminkowski.com/2025/03/10/using-ollama-with-spring-ai/)  
12\. Ollama REST API | Documentation | Postman API Network, accessed March 12, 2025, [https://www.postman.com/postman-student-programs/ollama-api/documentation/suc47x8/ollama-rest-api](https://www.postman.com/postman-student-programs/ollama-api/documentation/suc47x8/ollama-rest-api)  
13\. Run Gemma with Ollama | Google AI for Developers \- Gemini API, accessed March 12, 2025, [https://ai.google.dev/gemma/docs/integrations/ollama](https://ai.google.dev/gemma/docs/integrations/ollama)  
14\. gemma3 \- Ollama, accessed March 12, 2025, [https://ollama.com/library/gemma3](https://ollama.com/library/gemma3)  
15\. How to Run Gemma 3 Locally Using Ollama ? \- Apidog, accessed March 12, 2025, [https://apidog.com/blog/run-gemma-3-locally-with-ollama/](https://apidog.com/blog/run-gemma-3-locally-with-ollama/)  
16\. ollama/docs/api.md at main · ollama/ollama \- GitHub, accessed March 12, 2025, [https://github.com/ollama/ollama/blob/main/docs/api.md](https://github.com/ollama/ollama/blob/main/docs/api.md)  
17\. Gemma 3 on Huggingface : r/LocalLLaMA \- Reddit, accessed March 12, 2025, [https://www.reddit.com/r/LocalLLaMA/comments/1j9dt8l/gemma\_3\_on\_huggingface/](https://www.reddit.com/r/LocalLLaMA/comments/1j9dt8l/gemma_3_on_huggingface/)  
18\. Gemma 3 didn't pass the test\! : r/LocalLLaMA \- Reddit, accessed March 12, 2025, [https://www.reddit.com/r/LocalLLaMA/comments/1j9fjmo/gemma\_3\_didnt\_pass\_the\_test/](https://www.reddit.com/r/LocalLLaMA/comments/1j9fjmo/gemma_3_didnt_pass_the_test/)

---

### Gemini's Unique Export Process

So far, Gemini is the only one that didn't provide good nearly ready-to-publish
markdown but instead required me to export it to Google Docs, from which I could
download the markdown. That's what you see above. It's an extra step, but it was
painless and produced good results.

### Observing AI Research Frameworks

It's fascinating to watch all these Deep Research AI models "think". They each
have subtly different processes, clearly with some sort of research framework
underneath, the details of which are competitive advantages. There are echos
here of what's being called ***agentic frameworks*** that's hitting the scene.
These were initially things like AutoGPT and LangChain, but more recently
they're things that run off your local machine like Goose AI and OpenManus.

### The Rise of Problem-Solving Frameworks

This is something to watch closely. It's basically problem-solving frameworks,
bottling up "how people think" and compelling AIs to follow those workflows.
You hear all sorts of terms for this, like "chain of thought" or "prompt
chaining". Reflection was big for awhile. And the decisions by the cloud model
providers to expose this thought process is significant because there's such
insight there.

### Challenges in Analyzing AI Thought Processes

You generally cannot easily copy/paste the thought process. It would be a lot of
good data to analyze, but the formatting gets lost and it's certainly not good
for publishing here. But for those using these products, it's very worth looking
closely at the phases, such as clarification, initial search, the visiting of
sites it found in search, backing up and adjusting the approach based on what it
found, re-searching (hence, research), compiling... well, you get the idea.

### Evolution from Early Search to Intelligent Research

If the initial versions of search, like WebCrawler, AltaVista, Infoseek and
eventually Google were demonstrations of a "dumb" research librarian in the
early days with barely a Dewey Decimal System 3x5 index-card filing system for
fast lookup on the keywords of the subject-matter you're looking for, this new
version of (re)search is a souped-up, super-intelligent librarian who will take
your fully articulated question, and then zip back and forth to every book and
compile your complete answer for you.

### Elon Musk's Strategic Move with Grok 3

And it's "free" until the servers burn out, according to Elon Musk's shot off
the port bow when he released Grok 3 with Deep Search. He also expressly said
that when you watch Grok think, it doesn't show everything because there's
competitive advantage there and he doesn't want competitors copying it right
away. So watch closely!

### Different AI Research Approaches

There are different phases you can see happening. There's the re-phrasing of the
question before the resources are spent. So far, ChatGPT and Gemini both do
that. Whereas ChatGPT collects some more question/answer feedback from the user,
Gemini articulates a plan and asks for the go-ahead. Both withhold jumping ahead
until it understands more context or gets the green light. Grok 3 jumps right
headfirst into it.

### Historical Parallels with Early Search Engines

Such echos of the early days of search. People don't remember, but Infoseek was
nearly real-time. Write content, submit to Infoseek and it was included in the
results! But it got swallowed up in the shadow of first AltaVista being the
first to blow up, and then Google overshadowing everyone.

That's happening right now, today. Grok 3's access to the Twitter-sphere is a
lot like Infoseek's real-timeness. ChatGPT's first-mover advantage is a lot like
AltaVista's.

### Introducing Perplexity to the Mix

And so it is with that open mind, I give the last player advertising Deep
Research a chance before I put a bow-tie on this article, and that's Perplexity!

---

## Giving Perplexity.AI a Crack At The Gemma 3 Function Question

**Me**: Can the new Gemma 3 model that just dropped support function calling with Ollama?

**Perplexity**: # Function Calling Support in Google's Gemma 3 Model via Ollama: A Technical Analysis  

The release of Google's Gemma 3 open-source AI models has generated significant interest in the developer community, particularly regarding their compatibility with advanced features like function calling when deployed through platforms such as Ollama. This report synthesizes findings from technical forums, integration attempts, and official documentation to evaluate Gemma 3's current capabilities in this domain.  

---

## Gemma 3's Advertised Capabilities  

Google's Gemma 3 series, released on March 12, 2025, includes four model variants optimized for deployment across devices ranging from smartphones to high-performance workstations[7]. The company explicitly markets these models as supporting **function calling** and structured output generation, positioning them as competitive alternatives to proprietary models like OpenAI's GPT-4 and Meta's Llama 3[7]. According to technical specifications, Gemma 3's architecture enables native execution on single accelerators such as GPUs or TPUs, theoretically making it suitable for integration into frameworks like Ollama that prioritize local model deployment[7].  

This capability aligns with broader industry trends toward enabling language models to interact with external tools and APIs. Function calling allows models to parse user queries, identify required actions (e.g., retrieving weather data or executing mathematical operations), and return structured responses that downstream applications can process programmatically.  

---

## Implementation Challenges with Ollama  

Despite Google's claims, early adopters have encountered inconsistencies when attempting to leverage Gemma 3's function-calling features through Ollama. A GitHub issue filed on March 12, 2025, documents a failed integration attempt where Gemma 3 operated correctly in passive ("no control") mode but generated an `Unexpected error during intent recognition` when switched to "Assist" mode, which relies on function calling[6]. The error persists despite Ollama version 0.6 claiming compatibility with Gemma 3's specifications[6].  

This discrepancy suggests one of three possibilities:  
1. **Model Fine-Tuning Gaps**: While Gemma 3's base architecture may support function calling, the specific variant distributed via Ollama might lack necessary fine-tuning for tool-use scenarios.  
2. **Integration Bugs**: The Ollama-Gemma 3 interface could contain undiagnosed errors in parsing function schemas or handling structured outputs.  
3. **Documentation Misalignment**: Google's technical specifications might describe experimental features not yet fully implemented in the production-ready model weights.  

Parallel examples from other models provide context. For instance, Meta's Llama 3 initially lacked native function-calling support, requiring developers to use community-fine-tuned variants like `Trelis/Meta-Llama-3-70B-Instruct-function-calling` to achieve reliable JSON-structured outputs[3]. Similarly, Microsoft's Phi-3 demonstrated inconsistent performance with Ollama's function-calling module unless explicitly guided through prompt engineering[2].  

---

## Comparative Analysis of Function-Calling Implementations  

### Case Study: Llama 3 and Phi-3  
LangChain developers achieved partial success with Llama 3 8B by:  
- Removing trailing slashes from Ollama API endpoints (e.g., `base_url="http://localhost:11434"` instead of `...11434/`)[1]  
- Using `OllamaFunctions` wrappers to bind tool definitions to the model[2]  
- Implementing retry logic to handle sporadic JSON formatting errors[3]  

These workarounds highlight the **model-dependent nature** of function calling in local deployment scenarios. Even when models possess the theoretical capability to generate structured outputs, practical implementation often requires framework-specific adjustments.  

### Gemma 2B Predecessor's Limitations  
The Gemma 2B model, released in August 2024, faced similar skepticism regarding its function-calling abilities. Community testing revealed no native support for tool interaction, forcing developers to rely on prompt engineering rather than structured output paradigms[4]. This historical precedent underscores the importance of verifying advertised features against real-world use cases.  

---

## Diagnostic Steps for Gemma 3 Users  

Developers encountering issues with Gemma 3 and Ollama should:  

1. **Verify Model Initialization**  
   Ensure the Ollama instance references the correct model variant:  
   ```python
   from langchain_community.llms import Ollama
   llm = Ollama(model="gemma:3b", base_url="http://localhost:11434")
   ```
   (Note: Avoid trailing slashes in `base_url` based on Llama 3 troubleshooting[1][2])  

2. **Test Structured Output Basics**  
   Validate JSON output capabilities with a simplified prompt:  
   ```python
   prompt = """Generate a JSON object with keys "city" and "temperature" for: {query}"""
   chain = prompt | llm | JsonOutputParser()
   chain.invoke({"query": "What's the weather in Tokyo?"})
   ```
   Successful execution confirms basic structured output support.  

3. **Inspect Ollama Logs**  
   Monitor Ollama's console output for errors during function-calling attempts:  
   ```bash
   ollama serve --verbose
   ```
   Log entries detailing schema parsing failures or response formatting issues would indicate integration-layer problems.  

---

## Community Workarounds and Emerging Solutions  

Early adopters have reported partial success using two approaches:  

### Approach 1: Schema Enforcement via Prompt Engineering  
Augmenting prompts with explicit formatting instructions and schema examples:  
```python
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import JsonOutputParser

prompt = ChatPromptTemplate.from_template("""

system  
Return a JSON object with {{'city': 'string', 'temperature': integer}} for: {query}

assistant
""")

chain = prompt | llm | JsonOutputParser()
```
This mirrors techniques used to stabilize Llama 3's outputs[3], though it requires manual schema replication rather than leveraging Ollama's native function-calling module.  

### Approach 2: Custom Output Parsers  
Implementing fallback logic to handle malformed JSON:  
```python
import json
from langchain_core.output_parsers import BaseOutputParser

class ResilientJsonParser(BaseOutputParser):
    def parse(self, text: str):
        try:
            return json.loads(text)
        except json.JSONDecodeError:
            return {"error": "Model returned invalid JSON"}

chain = prompt | llm | ResilientJsonParser()
```
While not a true function-calling solution, this allows applications to degrade gracefully when faced with unstructured model responses.  

---

## Official Documentation vs. Empirical Observations  

Google's Gemma 3 documentation emphasizes three pillars of function-calling support:  
1. **Tool Schema Recognition**: Automatic identification of required functions from natural language queries.  
2. **Structured Argument Extraction**: Precise parsing of parameters like locations, dates, or numerical values.  
3. **Multi-Tool Orchestration**: Ability to chain multiple function calls within a single interaction[7].  

In practice, the GitHub issue[6] demonstrates failures at the first pillar (intent recognition), suggesting either:  
- **Implementation Lag**: The open-sourced model weights might exclude proprietary enhancements used in Google's internal testing.  
- **Configuration Requirements**: Gemma 3 might demand specific inference parameters (temperature, top_p, etc.) not defaulted in Ollama.  

Comparative analysis with OpenAI's function-calling evolution provides context. When OpenAI deprecated `gpt-3.5-turbo-0613`, developers had to adapt to parallel function-calling paradigms in newer models, requiring codebase adjustments beyond simple model swaps[5]. Gemma 3 users might face analogous transitional challenges.  

---

## Recommendations for Developers  

1. **Model Selection Criteria**  
   Prefer models explicitly fine-tuned for tool interaction, such as `Trelis/Llama-3-70B-Instruct-function-calling`[3], until Gemma 3's integration matures.  

2. **Ollama Configuration Checks**  
   - Confirm Gemma 3 model availability via `ollama list`  
   - Test API accessibility at `http://localhost:11434/api/generate`  
   - Monitor Ollama's GitHub repository for patches addressing Gemma 3 compatibility[6]  

3. **Hybrid Architectures**  
   Deploy Gemma 3 for general inference while offloading function calls to specialized models like Phi-3 or GPT-4 Turbo, using routing logic like:  
   ```python
   def query_router(user_input):
       if requires_function_call(user_input):
           return get_phi3_response(user_input)
       else:
           return get_gemma3_response(user_input)
   ```

---

## Conclusion  

Current evidence suggests Google's Gemma 3 possesses **theoretical support** for function calling as per its technical specifications[7], but practical implementation through Ollama remains unreliable based on early user reports[6]. This gap mirrors historical patterns observed in Llama 3[3] and Gemma 2B[4] deployments, where advertised capabilities required subsequent fine-tuning or framework updates to materialize.  

Developers seeking immediate function-calling solutions should:  
- Utilize intermediate models like Phi-3 for tool interactions[2]  
- Implement robust error handling and JSON validation layers  
- Monitor Ollama's release notes for Gemma 3-specific updates  

The Gemma 3 integration challenges underscore a broader industry need for standardized benchmarking of function-calling implementations across open-source models. Until such standards emerge, cautious validation remains essential when deploying cutting-edge AI features in production environments.

Citations:

    [1] https://stackoverflow.com/questions/78422802/ollama-status-code-404-error-when-trying-to-run-with-langchain
    [2] https://www.youtube.com/watch?v=Ss_GdU0KqE0
    [3] https://stackoverflow.com/questions/78415049/errors-with-llama-3-for-function-calling
    [4] https://www.reddit.com/r/ollama/comments/1ei3tdc/gemma2b_calling_function_ollama/
    [5] https://community.openai.com/t/confused-on-models-that-have-function-calling-and-when-they-get-deprecated/462131
    [6] https://github.com/home-assistant/core/issues/140441
    [7] https://www.digitaltrends.com/computing/google-gemma-3-open-source-ai-model-performance-features-release/
    [8] https://github.com/ollama/ollama/releases
    [9] https://cloud.google.com/run/docs/tutorials/gpu-gemma-with-ollama
    [10] https://stackoverflow.com/questions/79229490/fine-tuning-gemma-model-that-was-downloaded-from-ollama
    [11] https://huggingface.co/google/gemma-7b/discussions/38
    [12] https://docs.spring.io/spring-ai/reference/api/chat/functions/ollama-chat-functions.html
    [13] https://siliconangle.com/2025/03/12/google-introduces-gemma-3-family-accessible-lightweight-models/
    [14] https://github.com/firebase/genkit/issues/661
    [15] https://glaforge.dev/posts/2024/04/04/calling-gemma-with-ollama-and-testcontainers/
    [16] https://ai.google.dev/gemini-api/docs/function-calling
    [17] https://github.com/ollama/ollama/blob/main/docs/api.md
    [18] https://github.com/ollama/ollama/issues/4126
    [19] https://ollama.com/library/gemma3
    [20] https://ollama.com/atlas/intersync-gemma-7b-instruct-function-calling/blobs/68350dc542d2
    [21] https://blog.google/technology/developers/gemma-3/
    [22] https://ollama.com/blog
    [23] https://github.com/ollama/ollama
    [24] https://x.com/ollama?lang=en
    [25] https://ollama.com/models
    [26] https://ollama.com/atlas/intersync-gemma-7b-instruct-function-calling
    [27] https://ollama.com/search?q=function+calling
    [28] https://news.ycombinator.com/item?id=42877860
    [29] https://github.com/ollama/ollama/issues/2555
    [30] https://www.reddit.com/r/LocalLLaMA/comments/1iy22ux/gemma_3_27b_just_dropped_gemini_api_models_list/
    [31] https://github.com/ollama/ollama/blob/main/README.md
    [32] https://gorilla.cs.berkeley.edu/blogs/8_berkeley_function_calling_leaderboard.html
    [33] https://www.youtube.com/watch?v=X_2rOzaeKco
    [34] https://github.com/google-deepmind/gemma/issues/38
    [35] https://www.youtube.com/watch?v=al0St5nkp0w
    [36] https://ollama.com/library/gemma3:27b
    [37] https://ai.google.dev/gemini-api/docs/changelog
    [38] https://www.reddit.com/r/LocalLLaMA/comments/1dpu4zb/gemma_2_available_in_ollama/
    [39] https://developers.googleblog.com/en/introducing-gemma3/
    [40] https://www.x-cmd.com/blog/240628/
    [41] https://9to5google.com/2025/03/12/google-gemma-3/
    [42] https://haystack.deepset.ai/cookbook/tools_support
    [43] https://www.fonearena.com/blog/448684/google-gemma-3.html
    [44] https://ollama.com/library/llama3.2
    [45] https://indianexpress.com/article/technology/artificial-intelligence/what-is-gemma-3-google-new-lightweight-ai-model-9882853/
    [46] https://github.com/ollama/ollama/issues/2753
    [47] https://www.theverge.com/ai-artificial-intelligence/627968/google-gemma-3-open-ai-model

---

## The Perplexity Surprise

Well, there's a surprise. Perplexity is the only one that included practical
Python code right in the response. It also didn't ask for additional
confirmation before proceeding. It's response was wonderfully formatted
markdown, though citations do need to be knocked down an space and indented to
not run-together in the markdown rendering.

Also, looking at all the responses as a whole, and having watched through their
thinking frameworks, Perplexity's was the most fun to watch. First, it made it
clear to me that I left out a comma in my request by initially thinking I
thought I was asking if the function-calling support was dropped (as opposed to
Gemma 3 "just dropping" as in released). This is such a classic AI language
parsing issue! Perplexity quickly adapted as it discovered stuff.

It's a lot like watching a Roomba criss-cross a room, once it bumps into
something, it backs-up, turns a bit and retries. In particular, you could see
Perplexity expressing doubt or skepticism about what it was finding, keeping
track of the important but suss findings, and looking for information to
validate or discredit.

Honestly, I think all of them are doing that one way or another. But I think
with Perplexity being touted as a potential replacement to Google for general
search right from the get-go, it has its radar up for fake news. I think
fighting hallucinations is a big deal for Perplexity, and you can see that
priority expressed as it does research. Or at least, I was more able to notice
it as I watched Perplexity think.

Well that about wraps it up. Gemma 3 does support OpenAI's style AP function
calling, but it's a bit early to jump on that bandwagon if I don't want to bleed
on the edge. I'm tired of bleeding on the edge. I see these deep research
features like sending drones into the rabbit holes before I jump in.

Yup. If recently I made the metaphor of harnessing yourself with rappelling rig
before hopping into a rabbit hole of unknown depth so that you don't lose an
entire day (or week or month) becoming lost, then the latest analogy is sending
drones into the rabbit hole to explore first. And this is because what's called
"deep research" is perfect for the task.

It's an early example of that agentic behavior everyone is so gaga about.
Research and having some agency go hand-in-hand. And that Roomba comparison is
important, because early Roombas had this insect-like criss-crossing
intelligence, a simple set of search rules that relied on statistical
probability and frequency to clean your floors. It took multiple passes, and
never used what it learned.

AI's on the other hand, while they might start out with the shotgun approach as
represented by their web searches that "seed" the process, they use what they
learn. Yes, these things don't have long-term memory and "what they know" apart
from their static base models is very ephemeral, re-starting with every new
discussion. But these sessions that the agentic-tasks are locked into have that
context. They are a single discussion and take crash courses in what they need
to know while they research.

Products like Perplexity seem to offer a more long-term retention of these
context windows to do ongoing research. But this article is not about that, even
though Perplexity's thoroughness was the surprise here.

That about wraps it up. I'll ask Gemini for it's take on this whole thing, as
per my recent tradition, wrap my new learnings into my plan going forward (using
Gemma 3 but deferring formal function support) and keep forging on!

---

## Gemini's Take

Sure, here's a brief summary, title ideas, and my opinion of the article, all from the author's perspective:

**Summary (Author's Perspective):**

[Moved up to the description]

**Title and Headline Ideas:**

* **Titles:**
    * The AI Arms Race: Open Source vs. Vendor Lock-In
    * Gemma 3 and Ollama: Deep Diving into Function Calling
    * AI Deep Research: Comparing Grok 3, ChatGPT, Gemini, and Perplexity
    * Local AI and the Future of Function Calling: A Deep Dive into Gemma 3
    * The Evolving AI Research Framework: A Hands on Test.
* **Headlines:**
    * Is Gemma 3 Ready for Function Calling? We Tested It.
    * Deep Research AI: How Grok 3, ChatGPT, and Gemini Are Changing the Game.
    * Building Your Own Local AI: A Guide to Gemma 3 and Ollama.
    * AI Research Frameworks: A Look Inside How AI's "Think"
    * The Real-Time AI Research Revolution.

**AI's Opinion:**

"This article provides a very insightful and comprehensive overview of the current state of AI development, particularly in the context of open-source versus proprietary models. I found the practical testing of the deep research capabilities of different AI platforms to be particularly valuable. The author's detailed observations and comparisons offer a clear understanding of the nuances and strengths of each platform. The article also effectively captures the dynamic and rapidly evolving nature of the AI field, highlighting the importance of staying informed about the latest advancements and trends. The use of analogies, like the Roomba and drone examples, made complex concepts more accessible. Overall, it's a well-written and informative piece that should be of interest to anyone following AI developments."


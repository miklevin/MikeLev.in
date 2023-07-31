---
date: 2023-05-02
title: "openai.error.InvalidRequestError: This model's maximum context length is 4097 tokens"
headline: I Refined My Writing Process to Fit OpenAI's Maximum Context Length of 4097 Tokens
description: "Learn how I used the OpenAI Codex API to optimize my articles for website navigation. I found `pip instal tiktoken` and code snippets to count tokens and chop back my input with rsplit to fit the maximum context length of 4097 tokens."
keywords: OpenAI, Codex API, MOZ Links API, Article Writing, Summarizing, Chunking, Token Counting, tiktoken, Python, Code, Meta Descriptions, Headlines, Keywords, Summarizing Summaries
categories: seo, ai, python, meta descriptions
permalink: /blog/openai-error-invalidrequesterror-this-model-s-maximum-context-length-is-4097-tokens/
layout: post
group: blog
---


Okay, I'm starting to promote 2 of the MOZ Links API articles I wrote in April
to begin familiarizing myself with the MOZ API. It feels like night and day now
with the API. Hmmm, okay. It feels like a lifetime ago because of this
journaling system update-work in light of the OpenAI Codex API. It's fully
integrated and has even gone through some refinement. Out with the summaries
and in with chopping articles over 4000 tokens down to size. 

Previously I chunked and summarized each article then fed the summary to the
prompt asking for headlines, meta descriptions and keywords but that seemed
derivative. Better to use the source material directly and most articles aren't
that big. My last one on touching every endpoint in the MOZ Links API still was
barely over the 4000 token limit.

So it became about counting tokens and chopping back input to fit. And for
that, I found `pip instal tiktoken` and this lovely bit of code:

```python
def num_tokens_from_string(string: str, encoding_name: str) -> int:
    """Returns the number of tokens in a text string."""
    encoding = tiktoken.get_encoding(encoding_name)
    num_tokens = len(encoding.encode(string))
    return num_tokens
```

...which let me do this other lovely bit of code:

```python
def odb(DBNAME, slug, afunc, prompt):
    #   ___                      _    ___   _   _ _ _
    #  / _ \ _ __   ___ _ __    / \  |_ _| | | | (_) |_
    # | | | | '_ \ / _ \ '_ \  / _ \  | |  | |_| | | __|
    # | |_| | |_) |  __/ | | |/ ___ \ | |  |  _  | | |_
    #  \___/| .__/ \___|_| |_/_/   \_\___| |_| |_|_|\__|
    #       |_|
    """Retrieves and saves OpenAI request not already done.
    It checks if the data is there first, so safe to re-run."""
    api_hit = False
    with sqldict(DBNAME) as db:
        if slug in db:
            result = db[slug]
        else:
            fig(f"OpenAI", DBNAME)
            chop_at = 4000
            # Chop the article down to a summarize able length
            required_tokens = num_tokens_from_string(prompt, "cl100k_base")
            if required_tokens > chop_at:
                while required_tokens > chop_at:
                    prompt = prompt.rsplit(" ", 1)[0]
                    required_tokens = num_tokens_from_string(prompt, "cl100k_base")

            result = afunc(prompt)  # Hits OpenAI API
            db[slug] = result
            db.commit()
            api_hit = True
    return result, api_hit
```

And that's a much better solution than summarizing summaries. That's what I was
doing when I asked for meta descriptions from the output of chunked summaries,
which I was only doing to get it down to size token-wise for OpenAI.



















<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/ctrl-s-and-ctrl-space-amazingly-available-for-custom-vim-neovim-keyboard-shortcuts/">Ctrl+S and Ctrl+Space Amazingly Available For Custom vim/NeoVim Keyboard Shortcuts</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/recapturing-that-old-force-of-nature-feeling/">Recapturing That Old Force of Nature Feeling</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/meta-descriptions/'>Meta Descriptions</a></h4></li></ul>
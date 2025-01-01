---
title: Rubber Ducking With LLM
permalink: /futureproof/rubber-ducking-with-llm/
description: 
layout: post
sort_order: 1
---

**Me**: Good Morning, Claude! And welcome to 2025! Let's start out today, which
is my last holiday day-off where I can really work on the discretionary stuff
before the client work starts taking priority again, with a real Hail Mary on my
Magnum Opus, which is this web Framework&#151;all proper-cased but Web, because
of the localhost angle and not The Web, get it? Okay, geek humor right away.

It's 7:00 AM and we're going to jump right in by round robining between all
three pipeline workflow apps, sanding off the fuzz, chiseling off the spurs and
generically smoothing out the rough edges and whatever other wordworking
craftsmanship metaphors I can come up with, because I really want to play up the
craft aspect of technology in future-proofing.

And now that you LLMs are on the scene, part of that tech craft is storytelling.
Yup, daily tech journaling like this is part of future proofing because now that
you and your kind are in the picture, almost all programmers and coders are
going to be using you. Why wouldn't we at least also know the opinion of a
collective knowledge of the world entity when tackling a problem? It seems
you're at least baseline now for automatic rubber ducking.

So Rubber Ducky, Let's Round-Robin! LinkGraphFlow shouldn't even try to work
unless we've got the `botify_token.txt`. There's a global variable named
`api_key` (and `username` for that matter), and if it's None, then LinkGraphFlow
shouldn't even try to show it's user interface. Instead, it should... well, I'm
not exactly sure. It should be a seamless experience getting the token and it's
already supported on the ConnectWithBotify class and `connect_with_botify`
endpoint, so maybe we could bump them over there with a message to come back
after setting up the token. Or maybe we could embed its interface into the
LinkGraphFlow app for a more seamless experience, but I don't want to bloat the
code. Thoughts? 🎶 You gotta pick up the duckie if you wanna play the LLM 🎶

**Claude**: Happy 2025! 🎉 Love the early morning coding energy and the woodworking/craftsmanship metaphors. Let's rubber duck this!

Looking at the code, I see a few key pieces:
1. `ConnectWithBotify` already has a nice token verification UI
2. `LinkGraphFlow` needs the token to function
3. We want a seamless user experience

Here's my suggestion: Let's keep the concerns separated but make the transition smooth. In `LinkGraphFlow`'s landing page, we can check for the token and either:

1. Show the normal UI if token exists
2. Show a friendly redirect card if no token

```python
    async def landing(self):
        """
        GET /linkgraph2
        Quick landing page. We collect a raw Botify URL, then parse it in step_01.
        First checks if we have a valid Botify token.
        """
        if not read_botify_token():
            return Container(
                Card(
                    H2("Botify Link Graph Generator"),
                    P("Before generating link graphs, you'll need to connect your Botify account."),
                    Form(
                        Button("Connect Botify Account", type="submit"),
                        hx_post="/connect-to-botify",  # The ConnectWithBotify endpoint
                        hx_target="body"  # Replace entire body to switch to ConnectWithBotify UI
                    )
                )
            )

        # Normal LinkGraphFlow UI if we have a token
        return Container(
            Card(
                H2("Generate Website Link Graph"),
                P("Paste your Botify project URL below, e.g. https://app.botify.com/orgX/projY/foo"),
                Form(
                    self.pipulate.wrap_with_inline_button(
                        Input(type="url", name="dirty_url", placeholder="https://app.botify.com/orgX/projY/foo"),
                        button_label="Look Up Project URL 🔑",
                        button_class="secondary"
                    ),
                    hx_post=f"{self.prefix}/step_01_submit",
                    hx_target="#linkgraph2-container"
                )
            ),
            Div(id="linkgraph2-container")
        )
```

This approach:
1. Keeps the code clean and separated
2. Provides a seamless user experience
3. Doesn't duplicate the token verification UI
4. Uses HTMX to handle the transition smoothly

What do you think? We could also add a nice message in ConnectWithBotify that says "After connecting, you'll be able to generate link graphs" to make the flow even clearer.

Me: Nice, let's do it. In fact, already done. But that big Connect Botify Account isn't doing the redirect.

Claude: 

Ah, I see the issue. When using HTMX to switch between major UI components, we need to be careful with the targeting and routing. Let's modify the landing page to properly handle the redirect:

```python
    async def landing(self):
        """
        GET /linkgraph2
        Quick landing page. We collect a raw Botify URL, then parse it in step_01.
        First checks if we have a valid Botify token.
        """
        if not read_botify_token():
            return Container(
                Card(
                    H2("Botify Link Graph Generator"),
                    P("Before generating link graphs, you'll need to connect your Botify account."),
                    A(
                        Button("Connect Botify Account"),
                        href="/connect-to-botify",  # Direct link instead of HTMX post
                        style="text-decoration: none;"  # Make button look normal
                    )
                )
            )

        # Normal LinkGraphFlow UI if we have a token
        return Container(
            Card(
                H2("Generate Website Link Graph"),
                P("Paste your Botify project URL below, e.g. https://app.botify.com/orgX/projY/foo"),
                Form(
                    self.pipulate.wrap_with_inline_button(
                        Input(type="url", name="dirty_url", placeholder="https://app.botify.com/orgX/projY/foo"),
                        button_label="Look Up Project URL 🔑",
                        button_class="secondary"
                    ),
                    hx_post=f"{self.prefix}/step_01_submit",
                    hx_target="#linkgraph2-container"
                )
            ),
            Div(id="linkgraph2-container")
        )
```

The key changes:
1. Replaced the Form/HTMX approach with a simple anchor tag (`A`)
2. Wrapped the Button in the anchor tag
3. Added style to prevent the anchor from changing button appearance

This should now properly redirect to the Botify connection page. The simpler approach of using a direct link is more reliable here since we're doing a full page transition.

Me: Okay, fixed! Except the endpoint is `connect_with_botify`. Yes, it's less
natural language, but I'm making this so that if it ever gets out into the FOSS
world with all the Botify code in place, it works as a sales tool, asking the
user to ***Connect With Botify*** if they want all these advanced features,
haha! Otherwise, they get the *light* version, aka **Pipulate**, which will
still have value but it will be the free and open source SEO ***"extraction"***
in the sense that... hmm. How to explain it. Oh yeah, Perplexity, explain how
DMS explains Rails as an extraction from Basecamp, and the relationship between
FOSS and commercial software here.

**Perplexity**: David Heinemeier Hansson (DHH), the creator of Ruby on Rails, explains that Rails was not initially conceived as a separate framework but rather emerged as an extraction from the development of Basecamp, a project management tool created by 37signals (now Basecamp)[10]. This approach of extracting a framework from a real-world application has been fundamental to Rails' development philosophy.

## Rails as an Extraction

DHH emphasizes that Rails was born out of practical needs rather than speculative development:

1. **Organic Development**: Rails "spilled out" of Basecamp as DHH worked on the project over 6-7 months[11].

2. **Real-World Application**: Instead of creating features speculatively, Rails components were derived from patterns and tools repeatedly used in Basecamp's development[3].

3. **Practical Focus**: This approach ensured that Rails addressed actual development needs rather than hypothetical use cases[3].

## Relationship between FOSS and Commercial Software

The relationship between Free and Open Source Software (FOSS) like Rails and commercial software like Basecamp illustrates a symbiotic dynamic:

1. **Mutual Benefit**: Commercial projects can contribute to FOSS by open-sourcing reusable components, while benefiting from the broader community's contributions and improvements[2].

2. **Economic Viability**: The negligible marginal cost of software distribution allows companies like Basecamp to open-source Rails without significant economic drawbacks[6].

3. **Innovation Driver**: The extraction model encourages innovation by solving real problems in commercial settings before generalizing solutions for broader use[1].

4. **Community Engagement**: While commercial entities often contribute significantly to FOSS projects they rely on, the broader FOSS community also plays a crucial role in development and maintenance[2][5].

5. **Sustainability**: The involvement of commercial entities in FOSS can provide resources and stability to projects, addressing concerns about the long-term viability of purely volunteer-driven efforts[8].

This relationship demonstrates how commercial interests and open-source principles can align, fostering a collaborative ecosystem that benefits both commercial software development and the broader programming community.

Citations:

    [1] https://www.schneems.com/2021/05/12/the-room-where-it-happens-how-rails-gets-made/
    [2] https://en.wikipedia.org/wiki/Free_and_open_source
    [3] https://www.youtube.com/watch?v=yhseQP52yIY
    [4] https://gorails.com/forum/recording-pattern-basecamp-3
    [5] https://www.chainguard.dev/unchained/understanding-the-relationship-between-foss-and-the-software-supply-chain
    [6] https://37signals.com/podcast/open-source-beyond-the-market/
    [7] https://github.com/basecamp/kamal/discussions/1115
    [8] https://fosssustainability.com/aspects/company
    [9] https://37signals.com/podcast/ruby-on-rails/
    [10] https://rubyonrails.org/2005/3/11/the-story-behind-rails-at-oreilly
    [11] https://cult.honeypot.io/reads/ruby-on-rails-the-origin-story/



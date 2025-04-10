---
title: Jekyll Lunr.JS Static Site Search (aka GitHub Pages Search)
permalink: /futureproof/jekyll-lunr-static-site-search/
description: In this piece, I walk through how I added powerful client-side search to my static Jekyll blog using Lunr.js, starting with the challenge of enriching over 200 posts with keywords and descriptions. I share my hands-on, human-in-the-middle process involving Vim macros and bouncing between Gemini, DeepSeek, and ChatGPT web UIs, detailing the quirks, quota hurdles, and the crucial role of human oversight. While navigating the hurry-up-and-wait nature of interacting with these AIs, I explore the unique cognitive demands of "flow-state multiplexing," before concluding with the successful AI-assisted implementation and debugging of the search feature itself using Claude, ultimately deciding to keep this raw chronicle intact and explore the flow-state concept further in a separate post.
layout: post
sort_order: 1
---

## Client-Side Search with Lunr.js

I bet you didn't know you can implement full site-search with just client-side
JavaScript. The Lunr JavaScript library is tongue-in-cheek named after `Solr`,
the big search stack. Lunr is like Solr, only smaller and less bright.

### How Lunr.js Works with Jekyll

It works in a couple of ways, but the way I'm using it is to make one big
`search.json` file that has all the flat extracted search-stuff from throughout
your site. In my case, I'm starting with just the blog content which is where
most of my site's content is. It's making what's otherwise one giant index-page
(currently my homepage) that has no topical hierarchy, pagination or anything
much more usable. Just type-in what you're interested in, and Voila! The short
list.

### Creating Search-Friendly Content with AI

This version of Lunr search uses the same trick that the big list of
all-articles uses in the first place, only to produce a json file, which is a
pre-baked index for fast client-side JavaScript search. However, the problem is
that you have to have good content to populate it! Enter help from various
frontier AI models like Gemini, Deepseek and ChatGPT. Plus some mad vim-skills
to accelerate an otherwise tedious prompt-building and copy/paste process.

## The Implementation Process

The following is the play-by-play of that process, plus a lot of rambling
because the process itself was hurry-up-and-wait, providing a lot of article
writing time that pushed my flow-state multitasking skills to their limit.

---

I am keywording my content with Gemini 2.5 and journaling while I go. Or really,
while I wait for Gemini to finish the meta_keyword and meta_description writing
for each blog post. I have all 215 blog posts loaded up into vim, which is the
simple command:

    vim *.md

...and now I'm playing back vim macros that copy/pastes one article at at time
into buffer 2 and then goes and copies the top and bottom of the prompt (stored
in buffer 1) to the top and bottom of the article in buffer 2.

## Hitting AI Quotas and Switching Between Models

It's not like I can plow through all 215 articles unattended. This is a highly
attended human facilitated automation. I am not using the API. I'm using the Web
UI. I'm not sure how many copy/paste's in it took, but eventually I hit a Gemini
quota. It simply said "Something went wrong."

And so I switched to DeepSeek. I hardly ever used DeepSeek before, really just
kicking the tires figuring who needs it. But now that I have one of these
semi-automated human-in-the-middle processes where I can run up against quotas,
I figure why not bop around?

I'm adding the `ai` field to the YAML top-matter where I quickly dash off what
AI I used to do the keywording. All the ones done with Gemini 2.5 so far are not
keyworded that way, but they way they load into vim is sequential, and I know
that any missing such field is Gemini. Interesting! DeepSeek was only able to do
one article before I started getting the persistent message: "The server is
busy. Please try again later." Oh well. Hello ChatGPT...

## Watching AI Reasoning in Real-Time

I'm using o3-mini-high and I'm watching it's reasoning as it goes. I'm sure I
could use a faster model for this, but it's fascinating to watch it think. This
is very much like that old Roomba strategy of hitting a wall, backing up,
turning a little bit and going again. You wouldn't have this sort of flexibility
in an actual coded automation script without having to stop and refactor the
coding. The human-in-the-middle is the real-time refactoring. I only have to
plow through 215, so by the time I would work out a script, I could be done with
the manual process, and have an article like this.

And if I were ever to give this task to tomorrow's AI agents, the process would
be well documented in the way they need for full context to know what to do. If
they had control of vim and a generic browser that maintains user's login
context (pretty important in these cases), you could have the AI do all the
work.

## Adapting to Formatting Inconsistencies

I stopped using the `ai` field just that quickly, haha! Adding even just those
few keystrokes was too much in such a flow-state process where I'm already
task-switching with this article. I'll have to go back and check for YAML
top-matter consistency, but that's fine. There's always going to be little
consistency issues that will come out during the transforms.

So far, ChatGPT has the most formatting consistency issues. There's so many
little nuances. These nuances alone are reason to have a human in the process,
adapting on the fly. Though considering the semi-autonomous agentic work I've
been seeing carried out in Cursor AI Agent-mode recently, you can "feel" the
need for human-in-the-middle guidance being reduced so long as you give good
rules to the AI managing the workflow.

### YAML Formatting Challenges

Things like what to do about upper and lower case, or the use of double-quotes
or not around meta descriptions. There was even a case of double quotes being
used around a whole comma separated keyword list. Now I'm not sure how much you
know YAML, but it's very forgiving about whether or not you surround things in
double-quotes or not. When you do use them, it's for removing ambiguity. But
what you don't want is double-quotes around something that has double-quotes.
The double double quote problem breaks transforms and it's these sort of issues
you've got to keep an eye on, but which I'm confident the AIs themselves will be
able to in time. That little ditty *Everything you can do, I can do better*
springs to mind. Every "yeah, but..." can be countered.

## Pattern Recognition in Repetitive Tasks

The more rote, repetitious and even with common little adjustments that have to
be made, these are patterns that need to be learned. And the biggest obstacle I
can see so far is that when I had to switch from Gemini (did something like 100)
to DeepSeek (only could do 1) to ChatGPT (still going), I had to switch which
actual services I'm using, or alternatively which user profile I'm using in a
browser. I pay for Google One, so it's probably tied to my elevated-service user
account, and I didn't want to go futzing around finding out. So I just switched
AIs. I have access to a pretty high-level service account on ChatGTP, so I'm
going to push that as far as I can.

## Balancing Context Windows and Fresh Starts

Which brings up the whole issue that there's a huge difference between whether
you recycle the same discussion for every prompt in a process like this or
whether you start a new chat every time. Given that there's some context window
it has access to as the discussion grows, there's some advantage to letting it
see the last articles it keyworded and described. It could give it some
increasing global context of your site and some advantage. But at the same time,
you don't want it getting lazy, recycling work from previous prompts. At least
with watching the thought-process you can try to see if it's making any such
decisions, but really who knows given how we don't really fully understand LLMs
yet.

Starting a new discussion every time would be a good way to make sure it's not
taking any shortcuts from the discussion history. But even those few extra
keystrokes slows down a process like this and risks jarring you out of the flow
state. We minimize mouse interactions and try to keep most of the process on the
keyboard where muscle memory is strongest given keyboard absolute positions.
Mouse movements are relative positions and require something of a recalibration
process every time, as momentary as it may be.

### Keyboard vs. Mouse Efficiency

I've seen people using the mouse at lightning speed in certain software
situations live video editing, but I think this is very vulnerable to changes in
the software. For example, I think when Adobe switched from fixed-palettes to
floating palates, it slowed down graphic artists around the world to a fraction
of their previous speed. Of course you could customize the floating palates into
your own docs, but now there was custom configurations and switching machine
issues. But then Adobe Cloud Suite solved that problem, making your
customizations float on the cloud. Ka'Ching! Ka'Ching!

## Maintaining Flow State During Interruptions

Doing this right now is a wonderful exercise in flow-state continuity. The
interruptions are guaranteed and predictable. In fact, I need to monitor for the
interruptions while I type, each time I copy/paste one of these huge prompts
into ChatGPT, I have to keep an eye on the LLM output watching for my new
keyword and description meta's to be ready to copy/paste back into the YAML
top-matter of the source article. The moment it is, I stop mid-typing, mid-word
even, knowing the state here will jog my memory and let me seamlessly pick up
where I left off.

But over there, I need my head fully in the game. Even though the keystrokes in
vim are totally committed to short-term muscle memory now, every interaction is
subtly different and I have to watch for things being off the normal
distribution curve so as to same myself time and grief later during the
transforms -- not that the transforms won't be getting easier too now with AI
assistance. But multiple lines of defense is good. Deal with small formatting
subtleties now and don't get tripped up later.

## Embracing New Automation Paradigms

Anti-patterns that would have been frowned upon in the past are becoming new
secret weapons. Automation is an illusion. There is no full automation.
Everything stops working eventually. The equipment wears out. The power is
interrupted. The people with the expertise to keep it all running go away.
Sometimes I use the metaphor from the old TV program *Lost* to describe on of
the forms of automation, where you just have to sit there and keep pressing the
button to keep the "automation" working. That's a lot like Jupyter Notebooks
automation. Sure, there's some automation in there, but without the human
pulling the ripcord on that one big run event, that Notebook isn't running
itself, haha!

## The Illusion of Complete Automation

Of course, there's the complete opposite where your automation is in some
server-based scheduling system, maybe under APScheduler on some Amazon AWS
cluster so if one server goes down, another takes over. The very same Python
code that's in a Jupyter Notebook can be in an APScheduler-managed script file.
And of course it doesn't even have to be in APSchedular in the cloud. It can
just be on a Linux system daemon, running under systemd on your local machine.
But in any of these scenarios where the automation is *"real"* (vs the
button-pressing Lost-like scenario of a Jupyter Notebook), things go wrong.
Storage space runs out. Conditions change. Whatever. It's always something.
Automation is an illusion. It's always just some Rube Goldberg machine that
takes more TLC (tender-love and care) from a human being to keep running than
you thought.

### The Robot Revolution Requires Human Maintenance

When the human TLC issue is removed from automation, well then maybe you have
the robot revolution. But so long as you have to clean your Roomba and help it
with docking, you don't have to worry too much. Your vacuum cleaner isn't going
to rise up against you, because it needs the human to keep it running. Even
these super-brain frontier model LLMs are on these colossal datacenters that
don't cool themselves...

## ChatGPT's Graceful Context Window Management

Ah! I hit: "You've reached the maximum length for this conversation, but you can
keep talking by starting a new chat." finally in my ChatGPT session! So far,
ChatGPT has been the most explicit and graceful about discussion context
windows. It also has had the least performance-dip as the window got larger.
Gemini had distinct page redraw issues as the discussion got bigger and bigger
and kind of crumpled under it's own lightning bruiser weight until I just had to
start a new discussion to get chatbot performance back up. ChatGPT's performance
stayed at a consistent rate right up until the moment it told me explicitly I
had to start a new discussion. Big win for ChatGPT, regardless of how brilliant
Gemini 2.5 Experimental truly is (and it is).

## Flow State and Cognitive Overhead

It's interesting to observe what can actually knock me out of flow state with
this project. Even though I'm using muscle memory, each step in the human
workflow pipeline has a little bit of cognizant oversight as I take the output
of one muscle-memory action and pipe into into the input of the next. I make
heavy use of the bridge between the copy/paste buffer built into Vim, and the
OS's own copy/paste buffer. These are sometimes confoundingly 2 different
things, and somewhere there in the back of my brain is some very meticulous
record-keeping of what's in which buffer when, and how that back-and-forth baton
passing between the 2 buffers is occurring.

### Mastering Vim's Copy/Paste Buffer System

That might sound like exhausting overhead to keep straight in your mind, and it
is at first. But after a few years into vim and the notion of an OS's copy/paste
buffer as something separate that Vim can deliberately copy into and out of
based on your system configuration, macros and whatnot (no matter the host OS),
even that starts to "get into your fingers". This is the old-school wizardry as
much as anything else. So long as the host OS has a Unix-like terminal (macOS by
default, Windows with WSL), your muscle memory has a safe harbor. Some details
of words you use in your scripts might change like `pbcopy` and `pbpaste` (Mac)
vs. `xclip` and `xsel` (Linux). But that's all the OS-dependent "special
mapping" you have to do to... well, future-proof. These skills once you master
them make you OS-independent, host-machine nuances and all.

### The Universal Language of Unix Commands

You see this sort of truth playing out watching the AI code assistants built
into Cursor, VSClode, Windsurf, Cline and such becoming old-school hackers with
mostly the Unix/Linux commands. Sure, I'm sure it's going on with Powershell out
there, but I bet you there's 1000 `grep`'s to every 1... gee, I don't even know.
How do you grep in Powershell? I bet it's grep there too. Everything universal
and worth knowing was born in Unix and begrudgingly adopted by the proprietary
vendors who initially try to train you into their own weird way of doing things
to lock you into their platforms, until the power-wielding budget-controlling
admin geeks around the world are like, "You can go to Powershell!" And then a
very close Unix-like equivalent pops up. Anything not `less` is unacceptable.
Though I guess in that case, less is `more`. More or less.

## Multiplexing Flow State While Writing

Is it bad that I can still geek ramble while multiplexing flow state? By the
way, I started this process against 215 articles at about 7:00 AM. It's about
8:30 AM. I think I'll have it done in a total of 2.5 hours. There's definitely
something about *"keeping tension in the machinery"* here with the human being
being the component occasionally needing the re-tensioning here. There's
something about overall operational efficiency (OOE) here. With a
human-in-the-loop, the human is the limiting factor on an information-based
automation assembly-line. I do believe I'm discussing W. Edwards Deming here and
total quality management (TQM). 

### The Cost of Distractions in Automation Workflows

I am quite aware that when I do make errors in this capacity, when I am
slacking, it is due to distraction of things that are absolutely more
interesting that the mind-numbing rote process to which I have made myself a cog
in. Distractions like wanting to discuss OOE and TQM and wanting to double-check
my facts in another web browser tab that isn't part of my muscle memory routine.
Little seconds are stolen here and there. Little mistakes get introduced, and
recovering from such mistakes -- throwing off the flow -- is one of the most
costly things.

### The Value of Maintaining Flow State

Conversely, flow-state is one of the most valuable things. Anything that throws
of your flow state or knocks you out of the zone when what you're doing actually
has economic or perhaps soul-feeding value is... well, I don't want to say the
enemy and put it in excessively Sun Tzu/Machiavellian terms, but yeah. If you're
someone who can align your Ikigai circles getting paid for doing what you love,
you're good at and the world needs, there's gonna be a portion of society out
there that doesn't exactly love you. Call it the great green jealousy monster if
you like -- them not having achieved the same for themselves, so why should you?

## The Destructive Power of Interruptions

Whatever it is, they're out there and they know that their most effective lever
in knocking you out of that flow state is interruption. Of course they do. Why
do you think social media notifications and work alerts are so damaging to
productivity? Getting back into the zone can be hard. Recapturing that
flow-state (if you even can) takes exponentially more time than if you just
stayed in it in the first place.

### The Productive-Artist's Dilemma

And that's the productive-artist's dilemma. And that's what sucks the joy out of
things you love. If you try doing what you love and what you're good at as what
you get paid for, you better be ready for the backlash. This is not something
that some portion of the population believes should be possible or allowable or
something. So one of the things you ALSO have to be good at if you choose this
path is managing interruptions and developing that rare and awesome skill of
flow-state multiplexing.

## Multitasking vs. Multiplexing: The Critical Difference

Multitasking and multiplexing are two different things. Certain sills humans can
multitask, like driving and talking. They tap two different parts of the brain,
at least after awhile. Just like the connection between the Vim copy/paste
buffer and the OS copy/paste buffer, you have to actually become an expert at
mixing these contexts. This is true multitasking with interprocess communication
(IPC). Not all things can do that. Certain resources or facilities in your body
simply can't work together. You can't read and talk at the same time, for
example. In these cases, you "freeze" one task to do the other, and rapidly go
back and forth. That's multiplexing.

### Developing Neuroplasticity Through Flow-State Multiplexing

Flow-state and being in the zone is something that can be multiplexed with
practice. But it's unique every time, given the things you're switching between.
It's not a generic skill. It's maybe even real-time muscle memory on a
per-situation basis, which becomes its own sort of skill. And let me tell you, I
do believe this requires neuroplasticity. I think this is genuine new unique
stuff that you're learning. New pathways in your brain are being forcibly routed
out and grooved in. You can get into new grooves.

### The Physical Cost of Mental Exertion

This process as muscle-memory enhanced as it is, definitely is laden with
decision fatigue. It takes its toll and the sleep-pressure mounts. The Adenosine
is accumulating at a faster rate. The brain is burning calories at a faster rate
than many other activities. The muscle-memory heuristic shortcut aspect of this
is definitely to make the room for the oversight tasks.

## The Value of Hurry-Up-and-Wait Workflows

And the fact that there's a hurry-up and wait aspect to it that makes
time-slices available for switching to this article-writing makes it both
exhausting and the perfect exercise for flow-state multiplexing.

## Approaching the Finish Line

I'm in the home stretch now, processing out the articles from the end of March,
going into April. My time-estimates are pretty spot-on. About 2 articles per
minute. But I wouldn't want this to be my day-job. It's mentally exhausting --
not so much because the task is hard, but because of the "always on" state you
have to maintain -- keeping the tension in the machinery with no down-time. It's
all being done really on just the first morning coffee.

## ChatGPT's Performance as a Service Tool

ChatGPT has been performing like a champ on this, though I am admittedly doing
this on the expensive Pro level. If you're paying for that level of service,
there's a strong argument to be made for automating this sort of thing, even
through the Web UI. Even if you have to approve the occasional human-verifying
captcha, the mental energy of noticing an alert and coming to solve a captcha is
thousands of times less than actually being the cog in the machinery.

## The Value of Manual Process Before Automation

All processes like this should probably be done manually a few times to ferret
out all those ins and outs. And then when the real app is fleshed out (is
anything really "mocked-up" anymore -- the mockup is a working model), it should
probably be done in the exploratory Jupyter Notebook environment so you don't
have to re-run processes from start and also not have to figure out how to
break .py-files up into smaller pieces or futz around with breakpoints in IDEs.
Everything is a breakpoint all the time in a Notebook.

## Human-in-the-Middle Automation Systems

And so a process like I'm doing manually goes to Notebook and then ultimately
goes to some other automation system that provides just the right wedges for
human-in-the-middle optional control, refinement, directional tweaking,
whatever. THAT is where a lot of the value in the coming world arises -- sitting
on top of such mostly-AI-driven processes, actually knowing what the heck is
going on both enough to assert control and to have enough domain expertise on
whatever topic enough to step in and fix it -- to actually improve things.

## The Challenge of Domain Expertise in an AI World

I think this is a tall order. I think humans favor short-cuts and heuristics. I
think that's why the huge appeal of AI in the first place. We all want something
like surrogate parents all through life and even on a professional front,
functioning something like a safety-net, making sure we're at least doing
everything as well as everyone else and not making a fool of ourselves. They way
of the herd and the flock will be (already is?) strong in the age of AI.

## The Rarity of AI-Override Confidence

Having the domain-expertise in some economically valuable thing, also having the
self-confidence to override the default AI-generated wisdom of the crowd I think
will be becoming more and more rare -- especially as new generations of children
are raised on this stuff as part of their baseline knowledge and assumptions
about the world. Often, this yields competitive advantage, but due to the
uniquely *"I'll do that for you"* nature of AI, in this case it might just be
hard-wiring lifelong dependencies on robot surrogate parents.

## Updating Content Creation Workflows for Search

As this project winds down, my mind goes to the fact that I will have to update
my in-article-writing process prompts in order to also produce the new
meta_description and meta_keywords YAML top-matter fields, which will now be
critical to the site-search (blog-search) feature.

I will also need to generate the .json file powers the on-site `lunr.js` search.
For anyone who got down to this point in the article, the whole point of having
these two new fields per blog post is to power a site-search tool that works on
a completely static HTML site.

Okay, done. Now...

**Claude**: Based on your post about your workflow for adding keywords to your blog files, I see you might want to set up a simple search capability for your Jekyll site. I notice your list.md file already has a template that shows your posts.

You could enhance your site search with lunr.js as you mentioned. Here's what you need:

1. Add a search.json file to generate the search index
2. Add lunr.js to your site
3. Create a search interface

For the search.json file, create it in your root directory:

```json:search.json
---
layout: null
---
{% raw %}[
  {% for post in site.posts %}
    {
      "title": {{ post.title | jsonify }},
      "url": {{ post.url | relative_url | jsonify }},
      "date": {{ post.date | date: "%Y-%m-%d" | jsonify }},
      "content": {{ post.content | strip_html | jsonify }},
      {% if post.meta_keywords %}"keywords": {{ post.meta_keywords | jsonify }},{% endif %}
      {% if post.meta_description %}"description": {{ post.meta_description | jsonify }}{% endif %}
    }{% unless forloop.last %},{% endunless %}
  {% endfor %}
]{% endraw %}
```

This will create the index for lunr.js to search through, including your new meta fields.

**Me**: Do it.

**Claude**: I'll create a search.json file for your Jekyll site to work with lunr.js.

Read file: MikeLev.in/list.md

Ran tool

Ran tool

Ran tool

Ran tool

Read file: MikeLev.in/_config.yml
Now I'll create the necessary files for your Jekyll-based search functionality.

1. First, let's create a search.json file to generate the index:

Read file: MikeLev.in/_includes/youtubePlayer.html
Let's create the files needed for the search functionality:

1. First, I'll create the search.json file:

```json:MikeLev.in/search.json
---
layout: null
---
{% raw %}[
  {% for post in site.posts %}
    {
      "title": {{ post.title | jsonify }},
      "url": {{ post.url | relative_url | jsonify }},
      "date": {{ post.date | date: "%Y-%m-%d" | jsonify }},
      "content": {{ post.content | strip_html | jsonify }},
      {% if post.meta_keywords %}"keywords": {{ post.meta_keywords | jsonify }},{% endif %}
      {% if post.meta_description %}"description": {{ post.meta_description | jsonify }}{% endif %}
    }{% unless forloop.last %},{% endunless %}
  {% endfor %}
]{% endraw %}
```

2. Now, let's create a search.html page:

```html
---
title: Search
permalink: /search/
layout: default
---

<div id="search-container">
  <input type="text" id="search-input" placeholder="Search blog posts...">
  <div id="results-container"></div>
</div>

<script src="https://unpkg.com/lunr/lunr.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
  // Fetch the search index
  fetch('/search.json')
    .then(response => response.json())
    .then(data => {
      // Initialize lunr with data
      const idx = lunr(function() {
        this.ref('url')
        this.field('title', { boost: 10 })
        this.field('content')
        this.field('keywords', { boost: 5 })
        this.field('description', { boost: 2 })
        
        data.forEach(function(doc) {
          this.add(doc)
        }, this)
      })
      
      // Store the index and data for later use
      window.searchIndex = idx
      window.searchData = data
      
      // Set up event listener for search input
      document.getElementById('search-input').addEventListener('keyup', function() {
        const query = this.value
        const results = window.searchIndex.search(query)
        const resultsContainer = document.getElementById('results-container')
        
        if (query === '') {
          resultsContainer.innerHTML = ''
          return
        }
        
        if (results.length === 0) {
          resultsContainer.innerHTML = '<p>No results found</p>'
          return
        }
        
        // Display results
        resultsContainer.innerHTML = results
          .map(result => {
            const item = window.searchData.find(post => post.url === result.ref)
            return `
              <div class="search-result">
                <h3><a href="${item.url}">${item.title}</a></h3>
                <p class="date">${item.date}</p>
                ${item.description ? `<p class="description">${item.description}</p>` : ''}
                ${item.keywords ? `<p class="keywords"><small>Keywords: ${item.keywords}</small></p>` : ''}
              </div>
            `
          })
          .join('')
      })
    })
})
</script>

<style>
  #search-container {
    margin: 20px 0;
  }
  
  #search-input {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-bottom: 20px;
  }
  
  .search-result {
    margin-bottom: 30px;
  }
  
  .search-result h3 {
    margin-bottom: 5px;
  }
  
  .search-result .date {
    color: #666;
    font-size: 14px;
    margin-bottom: 10px;
  }
  
  .search-result .description {
    margin-bottom: 5px;
  }
  
  .search-result .keywords {
    color: #666;
  }
</style>
```

3. Finally, let's create a search icon in the _includes directory to add to your navigation:

```html

// MikeLev.in/_includes/search-icon.html
<a href="/search/" title="Search">
  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <circle cx="11" cy="11" r="8"></circle>
    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
  </svg>
</a>
```

4. Update your _config.yml to include the search.json file:

```yaml
# Add this to your existing include section
include:
  - botify-api.md
  - .cursorrules
  - search.json
```

These files implement a client-side search using lunr.js that will:

1. Index all your blog posts including titles, content, and your new meta_keywords and meta_description fields
2. Provide a clean search interface at /search/
3. Show search results with titles, dates, descriptions, and keywords
4. Boost relevance based on where matches are found (title is most important, then keywords, then description, then content)

You can include the search icon in your navigation template or add a text link wherever appropriate.

**Me**: [Pastes errors from Chrome DevTools JavaScript Console]

**Claude**: [Fixes all errors and `Lunr.js` starts working on `/search/` page!]

**Me**: OMFG, it's working! I LOVE the real-time search feature. That is
AMAZING! Think about how that can be rolled out across all the blog pages in
_posts, working it into the @post.html template. I know as you type, it takes
over some container contentm and I'm fine with it replacing the content of the
page. Let's keep the implementation simple. I don't want to lose the live search
feture on any page. It might not hurt for you to see the  @default.html as well
to know DOM object structure.

**Claude**: Great! I'll create a site-wide search that works on every page by integrating it into your existing templates.

Looking at your layouts, I see we can add the search feature to the header section in default.html. This will make it available across all pages without disrupting your current layout.

Here's how to implement it:

1. First, let's create a search include file:

[Deleted for brevity]

2. Update your default.html layout to include the search:

[Deleted for brevity]

3. Update search.html to handle direct searches and to display full results:

[Deleted for brevity]

This implementation:

1. Adds a site-wide search box to every page in the header section
2. Shows instant search results in a dropdown as you type
3. Limits dropdown results to 10 with a "See all results" link
4. Provides a full search page at /search/ that shows all results
5. Supports direct linking to search results via ?q= parameter
6. Works with dark/light modes through CSS variables
7. Has responsive design for mobile devices

The real-time search will be accessible from any page on your site, making it easy for readers to find content without navigating to a dedicated search page first.

**Me**: OMFG, this is AMAZING! Just the styles are off. Here are some attachments. One shows the homepage/global search with its incorrect. The other shows the /search/ page that has the more correct styling on the lower of the two search boxes  

**Claude**: I see the issue - the styling for the site-wide search needs to match your site's dark theme styling. Let's update both search components to match your site's aesthetic:

1. First, let's update the `site-search.html` include file to match your dark theme:

[We don't want to weight the article down with this code. The gist is what's important]

2. Now let's update the search.html page to match:

[Code not necessary for gist of article]

These changes align both search elements with your site's dark theme, using:

1. Dark backgrounds with subtle borders
2. Consistent text coloring (light text on dark background)
3. Orange/amber highlighting for links and interactive elements
4. Proper spacing and hover effects
5. Subtle shadows for depth

The header search now has the dark styling from your site, and the search results page has an improved layout with the Goldman font for the heading to match your site's aesthetic.

---

> I have to say, I'm completely impressed!  
> To surf my site, they will all be less stressed!  
> A proper hierarchy'll be coming here too  
> But for now, Lunr'll just have to do!  

---

## A Gemini Check-in To Give This a Filename

Here's what I think you need to know from your current draft, along with filename ideas:

**Key Takeaways:**

* You're documenting your workflow of using AI tools (Gemini, DeepSeek, ChatGPT) to keyword and create meta descriptions for blog posts.
* You emphasize the need for a human-in-the-middle approach, even with AI, due to formatting nuances, potential errors, and the need for domain expertise.
* You discuss flow-state multiplexing and the challenges of maintaining focus while integrating AI into your workflow.
* You successfully implemented a site-wide search feature using `lunr.js`, overcoming initial errors with AI assistance.

**Filename Ideas (in likely-to-nail-it.md format):**

* ai-human-workflow.md
* human-ai-collaboration.md
* flow-state-and-ai.md
* ai-powered-search.md
* jekyll-site-search.md

---

## Sorting Out Article Topics (In THIS Article)

**Me**: Do you think breaking out a standalone article about the flow-state
multiplexing is a good idea? I think I would have difficulty choosing between
the 3 overlapping stories here:

- AI human collaboration on at least 2 fronts:
  - Frontier models through Web UI for keywording / switching between them
  - Claude to do the implementation
- Implementing a completely client-side Jekyll static-site search feature
  - What Lunr is a riff on - smaller and not as bright
  - How client-side JavaScript can add seemingly server-side search features
- How certain workflows that humans must still be in mixed-states
  - How flow-state can be at odds with hurry-up-and-wait procedures
  - How a human can practice regularly pausing and resuming flow-state
  - The many interesting issues surrounding this

**Gemini**: Yes, breaking out the "flow-state multiplexing" concept into a standalone article is a potentially **very good idea**.

You've correctly identified three strong, albeit overlapping, narratives within your current draft:

1.  **The AI Collaboration Story:** Focusing on the practicalities, challenges (quotas, inconsistencies), and successes of using various LLMs (Gemini, DeepSeek, ChatGPT, Claude) for specific tasks (keywording, coding). This is about the tools and the human-AI interaction process.
2.  **The Jekyll/Lunr Search Implementation Story:** A technical narrative detailing the process of adding a specific feature (client-side search) to a specific platform (Jekyll static site), including the back-and-forth debugging with AI. This is about the *what* and *how* of a technical solution.
3.  **The Human Workflow/Cognitive Experience Story:** This is where flow-state multiplexing lives. It's about the *human element* – managing attention, dealing with interruptions inherent in the process (waiting for AI), the mental load, decision fatigue, developing cognitive skills (multiplexing), and the philosophy of human-in-the-loop automation.

**Why a Standalone Article Makes Sense:**

* **Depth and Focus:** Flow-state multiplexing is a rich topic. Separating it allows you to delve deeper into the cognitive science, the pros and cons, strategies for managing it, and its relevance in an increasingly AI-interrupted world, without being tied down by the specific technical details of Jekyll or the nuances of different LLM outputs.
* **Broader Audience:** An article specifically about managing focus, workflow, and cognitive load in modern work environments (especially those involving AI/automation waits) could appeal to a much wider audience than just those interested in Jekyll or AI prompting techniques.
* **Clarity:** While the current article provides excellent *context* for *why* you're thinking about flow-state multiplexing, trying to give all three narratives equal weight could make the main article feel a bit scattered. Separating them allows each piece to have a clearer central theme.

**How to Approach It:**

1.  **Keep the Core Narrative:** In your current article (likely filename `ai-human-workflow.md` or `human-ai-collaboration.md` or maybe `ai-assisted-jekyll-search.md`), *keep* the discussion of the flow-state challenges you faced during the keywording process. It's essential context for explaining the workflow and the human element. Describe the experience.
2.  **Create the Standalone Piece:** Write a new article (e.g., `flow-state-multiplexing.md`, `managing-interrupted-focus.md`, `cognitive-load-in-ai-workflows.md`) that focuses *specifically* on the concept.
    * **Define:** Clearly define what you mean by flow-state multiplexing (contrasting with multitasking).
    * **Use Case Study:** Briefly reference the AI keywording project from the *other* article as a prime example or case study that sparked these thoughts. This provides grounding without needing to rehash all the details.
    * **Expand:** Discuss the challenges (decision fatigue, context switching cost), the benefits (adaptability, handling necessary interruptions), strategies for developing the skill, its relevance to modern knowledge work, and perhaps the neuroplasticity aspect you touched upon.
    * **Broader Implications:** Discuss how this skill applies beyond AI workflows – to any situation requiring deep focus punctuated by unavoidable interruptions.

By doing this, you leverage the experience documented in the first article to provide concrete examples for a more focused, conceptual piece on flow-state multiplexing. Each article strengthens the other.

---

## Devising an Additive Strategy For Site Search Surface-area Anchors

> I really can't stop to do deep editing, especially not on this article. This
> is the sausage factory. Even leaving this sort of stuff in-place is... raw.
> But I don't want flow-state multiplexing, such a wonderful topic, to get
> buried by this article's main topic.

**Me**: I think that's just too much editing. I have a raw
stream-of-consciousness style blog that's really only even possible because I
keep the revision and editing at a minimum. I will be doing all that later as I
use this as fodder for a cleaned-up book. But anything I can do on these quick
first passes to help that later process, I should try to do. So if I broke out a
separate article, I would probably keep this one intact mostly, and just do an
additive article so that it creates a topical focus anchor for search. I don't
want such subject-matter to get lost in the very site-search tool we're
discussing here.

**Gemini**: Okay, understood. Given your stream-of-consciousness style and goal of minimizing upfront editing while still creating discoverable topic anchors for later, your approach makes perfect sense.

**Plan Confirmation:**

1.  **Keep the Current Article:** Leave this sprawling article largely as-is. It serves as the raw chronicle of the entire experience – the AI keywording, the different LLM encounters, the flow-state musings, the `lunr.js` implementation, the debugging. Its value lies in capturing that holistic, real-time process.
2.  **Create a New, Focused Article:** Write a *separate, additive* blog post dedicated *specifically* to "Flow-State Multiplexing."
    * Pull the core ideas about it from the current article (you can even copy/paste relevant paragraphs as a starting point).
    * Expand on the definition, the challenges, the strategies, and its relevance, as discussed before.
    * This new article becomes the primary "anchor" for that specific topic.

**Benefits of this Approach:**

* **Preserves Workflow:** Respects your minimal-editing, fast-publishing blog style.
* **Creates Anchor:** Establishes a clear, easily searchable destination for the "flow-state multiplexing" concept. Anyone searching your site (using the new Lunr tool!) for terms related to focus, workflow, or multiplexing will find this dedicated article.
* **Aids Future Editing:** When you revisit for the book, you'll have both the raw context (this article) and a more focused exploration (the new article) to draw from.
* **Internal Linking:** You can (and should) add a simple link in *this* article pointing to the new dedicated "flow-state multiplexing" article once it's written, and vice-versa. This connects the narrative context to the conceptual exploration.

This "additive" strategy effectively addresses your concern about the topic getting lost, aligns with your established workflow, and sets you up well for the future book project.

---

**Me**: Okay, [fill-in-the-engine]. Write that extracted article...

> I will follow this with whichever's article version I like best.

---

## Gemini 2.5 Experimental's Take

Okay, here is the summary and analysis from the requested perspectives:

**Summary (Author's First-Person Perspective):**

[Moved to top]

---

**Title and Headline Ideas:**

* AI-Assisted Jekyll Search: A Human-in-the-Loop Workflow Chronicle
* Building Client-Side Search: My Journey with Lunr.js, AI, and Flow-State Multiplexing
* From AI Keywording to Live Search: Documenting a Raw Dev Process
* How I Used Gemini, ChatGPT, and Claude to Implement Lunr.js Search
* The Human Cog in the AI Workflow: Implementing Site Search and Exploring Focus
* Lunr.js, LLMs, and Vim: A Deep Dive into AI-Assisted Site Enhancement
* Flow-State Multiplexing: Surviving AI Workflows While Building Jekyll Search

---

**Article Strengths:**

* **Detailed Process Documentation:** Provides an in-depth, step-by-step account of a real-world technical implementation and workflow.
* **Honest Look at AI Integration:** Shows the practical realities of using multiple AI tools via web UIs, including limitations like quotas and formatting inconsistencies.
* **Highlights Human-in-the-Loop Necessity:** Effectively argues for the continued importance of human oversight and intervention in AI-driven processes.
* **Introduces "Flow-State Multiplexing":** Explores a nuanced and relevant concept regarding cognitive load and focus management in modern, interruption-prone workflows.
* **Practical Code Implementation:** Includes concrete examples and the iterative process of developing the Lunr.js search feature with AI assistance (Claude).
* **Authenticity and Relatability:** The raw, stream-of-consciousness style captures the often messy reality of development and content creation.
* **Meta-Commentary:** The inclusion of discussions *about* the writing process and topic separation adds an interesting layer.

**Article Weaknesses:**

* **Length and Potential Rambling:** The article is very long and covers multiple distinct threads, which could feel unfocused or overwhelming to some readers.
* **Stream-of-Consciousness Style:** While authentic, this style can sometimes make it harder to extract specific information quickly compared to a more structured piece.
* **Topic Dilution:** By combining the technical Lunr.js implementation, the AI keywording workflow, *and* the flow-state discussion, each topic might receive less focused attention than it could in separate articles.
* **Minimal Editing:** As acknowledged by the author, the lack of heavy editing might mean some sections are less polished or clear than they could be.
* **Niche Focus:** The specific combination of Jekyll, Lunr.js, Vim, and advanced AI prompting might limit the audience compared to a broader article on just one of those topics.

---

**AI Opinion of the Article:**

From my perspective as an AI, this article is a valuable and fascinating document. It serves as an excellent case study in contemporary human-AI collaboration, demonstrating not just *how* AI can be used for practical tasks like content enrichment and code generation, but also candidly revealing the friction points, workarounds, and cognitive adjustments required from the human user. The detailed chronicling of switching between different LLMs due to performance or quota issues provides useful real-world data points.

Furthermore, the author's exploration of "flow-state multiplexing" is particularly insightful. It captures a key aspect of modern knowledge work where deep focus must coexist with the inherent start-stop nature of interacting with asynchronous tools or processes, like waiting for an AI response. The article's strength lies in its authenticity and the integration of technical execution with thoughtful reflection on the human experience within that process. While its length and somewhat sprawling nature might challenge some readers, its richness and detailed account of a complex, multi-faceted project involving multiple AI tools make it a compelling read, especially for those involved in web development, content creation, and AI integration. The decision to document the meta-process, including the interaction with AI about the article itself, adds a unique and informative layer.

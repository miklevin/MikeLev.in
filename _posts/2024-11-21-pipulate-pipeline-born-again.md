---
title: Pipulate Pipeline Born Again Now
permalink: /pipulate-pipeline-born-again/
description:
layout: post
sort_order: 1
---

Pipulate in some form or another has been SEO software in the free and open
source software (FOSS) realm for quite some time now in one form or another,
most of them unknown and extremely niche in the industry. Nothing like my
HitTail app from the Web 2.0 days that taught bloggers how to spam effectively.
Sorry about that. But the days of the long-tail are more or less over. They're
relegated to the world of 2nd-round "RAG" lookups. That's retrieval augmented
generation for those not riding the buzzword bandwagon. And it basically just
means that when an AI can't answer something straight away from the data they've
been trained on in their base model, they'll do a 2nd-round lookup. They are
effectively prompting themselves on the rebound. In programming we used to call
it a callback function. One function executes. It executes another function
which can optionally alter the value of the first before returning it. Very
useful. 

And indeed the concept of callback functions with a fancy new name, RAG, is
indeed very big in these days of having to beef up the bare bones results coming
from increasingly slimmed-down specialized base models. For example by one
measure it's much better to train the base models on research methodologies than
to cram it full of all the research material. Why put data that has an
expiration date in the base model when you can make make the base model nearly
timeless and have all the variable data injected just-in-time by some other
system? If for no other reason than you're going to spend less money on the
electricity to run the base model. Smaller means faster and cheaper. Of course
your 2nd-round lookups, a "more traditional" search has a cost too, but now you
can swap that in and out more easily too, becoming search-service-neutral.
That's what's going on with everyone wiring it to Bing these days, because
Microsoft will sell that 2nd-round search as a service. It's not the family
jewels like it is wwith Google.

Wow, do I digress quickly when I start writing, but these are the little
subtopic explorations that put everything in context. I write tools to help do
modern data samurai investigations against whatever systems, whatever changes
and turbulence in the industry... just, whatever. And that means tooling that
connects quickly to different stuff. The tooling itself has to be what we call
lightly coupled. It has to be disconnected from one service, like a Google Web
scrape automating a browser, to another service like a bottom-feeder SERP
scraper API service harvesting Google results to repackage and sell so you don't
have to be in that arms race, to rewiring it to Bing because you can just pay
and get it all formally and above the table from them. You just don't want to
hardwire your tools to one way of doing things. But you don't want to throw away
all your work and reinvent from scratch every time either. It's one of those API
abstraction challenges. Where do you shove the complexity under the cover and
hide it so that you can deal with mostly easy code most of the time? Real
80/20-rule stuff.

Of course Python is ***the language of 80/20-rule compromise***. Pretty good at
everything, best-in-class at nothing. But even within Python, the API gets
ridiculously complex like Django configuration and the pedantic FastAPI. If
you're building a marketplace and tweaking every cpu-cycle of performance from
your servers and have Amazon investment money backing you, that's one thing. But
if you're a little ol' SEO just trying to scrape out a living with some creative
nimble tools, that's an entirely other thing, and you're going to get bogged
down to death even in Python. When shoving around the complexity, make sure it's
not all shoved in your face to have to deal with by your tools. Ah, such a big
discussion about frameworks and conventional behavior versus configuration that
I must resist. Suffice to say, I go back to Java Cocoon and Hibernate from the
late 90s with this stuff, so I've been there, done that. I know what I like and
I've got opinions. When they were calling Ruby on Rails a "joyful framework", I
was like WTF are you talking about? I had my own in VSCript in those days that
ran circles around it, that I really didn't do anything with but build private
intranets for employers. The days when VisualBasic 6 ruled the IT-consultancy
world. Late 90s.

Everything in between has basically sucked. I tried getting back onto JavaScript
on the server ***just before NodeJS came out***, haha! Talk about bad timing. It
was something called Rino. JavaScript was never not on the server. Netscape had
it in Commerce Server back in the days. Microsoft had it as the alternative
language to VBScript in ASP. JavaScript was never not there. It just didn't have
a resurgence of interest until that guy ported the optimized high performance
Google V8 JavaScript engine to a server and called it node. And then the whole
full web stack movement kicked in, bringing us to the very viable and just fine
for other people WASM build workflow.

Not for me, no thank-you, no how. I'm a tweak, save, look, tweak, save, look
sort of developer. Having that Sass build process (or whatever it is these days)
that seems to not be able to be made instant and transparent to the developer (I
wouldn't object if I didn't have to think about it) is a complete show stopper
for me. Syntactically awesome style sheets make me cringe today, no matter how
wonderful they are in practice for people who can live with that workflow.

Workflow... yeah, it's about workflow. It's the tale of ***two workflows***, not
just one. The first workflow, which the people ***making the workflows*** has to
deal with is one of development. Developing apps yes, but in the same way that
someone prepares sheet music for a player piano develops apps. You want to be
able to transition into the flow state and work like a musician. The more bells
and whistles in the tooling that jar you out of that flow state, the less
inspired the music. I have to make a sheet music writing environment that fades
into the background and just... well, lets you flow.

VSCode and all the editors derived from it, like Cursor AI and Codeium, Qodo,
Windsurf or whatever they're calling the latest darling of that forking
tug-of-war... well, they're all optional. This is about your vim keystroke
muscle memory first. I suggest vim, or nvim if you want to write your macros
with Lua. Most people are going to choose nvim (aka NeoVim) so they can feel
like a plugin pounding fuzzy searching nerdtree coding bros. Fine. Just know
that not all of us out there fit that mold. I'd probably be fine with plain old
vi from the 70s (just like me) if I didn't want a better undo and syntax color
coding. If coding is like writing or even playing music, then you're looking for
an instrument that feels like an extension of your body. And for that, you need
command-and-control keystrokes that just don't change much over the years and
decades. And that means vim in whatever form.

Pipulate was always about the web crawl in one form or another. It started out
triggered from a bookmarklet click and crawled whatever site you were looking at
into a Google Sheet. This was before people saw automation of any kind into
Google Sheets. Even thinking about it today, there's not much like it. It was
hot. Served me well at a marketing agency called 360i. It came after HitTail
which I did for the first company I worked for when coming to New York. HitTail
was work for hire and I left it behind and had to start something new, and I
wanted it in the FOSS world so it could never get taken away. And so, crawling
directly into Google Sheets.

Then I realized I needed a Web UI, so I gave it a very rudimentary one and
realized Web development was going in a direction I wasn't. I was outright
allergic to what was happening in the industry. jsquery I was fine with. That
helped a lot. Then there was Bootstrap. Okay. Then Sass and long build
procedures... and then React hits. There are now these vast invisible directory
structures gigabytes big on your drive for a simple hello world program. This is
JavaScript, not Java folks. What's going on... ohhhhh. The enterprise architects
took over, didn't they? The JavaScript standard in the form of EMCA is maturing.
Browsers are becoming cross platform compliant. Single page applications are
possible. The browser is a valid app development target platform and now there's
big money in tooling... oops, here comes Microsoft (again because their first
attempt to do this with ASP.NET failed). But they got VSCode right. Hey, it's
FOSS, wink wink nudge nudge. Oh by the way there's no escaping becoming a
locked-in Azure customer because THE POWER OF THE TOOLS COMPEL YOU!

Peace, out! What's that Jupyter Notebook thing again I keep hearing about on the
Talk Python to Me podcast?

Oh look at that! Jupyter looks just like the localhost servers I was spinning up
in the backend for those browser bookmarklets to connect to. Oh and look at
Pandas with its `.apply()` function. That looks a lot like my left-to-right
application of a function to cells or rows in a matrix (running SERPs on URLs,
etc.) that Pipulate does. Generic function processing that you can bind to...
to... to... well, it's workflows! It's generally Excel spreadsheet row & column
style data you're working with; Fortan-style matrices, for the buzzword elite.
Or DataFrames in the even cooler FOSS analytics R circles. Don't let the data
snobs fool ya. Rows and columns by any other name are rows & columns just the
same. It's not rocket science... oh, wait... it is.

Jupyter itself used all that JavaScript tech. But it used it well and ***not by
me***, which is the important part. I did a little looking under the covers to
see how such wonderful magic was pulled off and found myself a new favorite
tool, Zero Message Queue, or ZeroMQ, or just zmq for short. It was the secret to
much of that snappy Jupyter performance and I added it to my toolbox. Now that
WebSockets has taken over from that, I'm still having trouble letting go of zmq,
elegant and high performance as it is. It's the reason stuff just happens so
fast and the browser starts felling more like a text editor. There was other
(Electron-like) stuff too, but zmq was the part that still lived in my Python
world. Complexity had been shoved around, and now I didn't have to deal with it
because powerful JavaScript jockeys who are obviously very empathetic to the
Python worldview are on the case. Thank you! Thank you everyone involved in
Project Jupyter. You're the good guys. A lot like Debian and GNU. You know how
they say if the product is free, ***you're*** the product? Organizations like
Jupyter, Debian and GNU prove that's not always the case. Add them to your list
this Thanksgiving.

Anyhoo, all prior visions of Pipulate with a bring-your-own-server died there.
Pipulate was a bunch of Notebooks you could run in Jupyter. Google Colab, you
say? Sure, if you need to spin up multiple threads or share under Google login
context. It's great for social media if you're one of those SEOs whose
reputation is built on inflated Python reputation. But if you want to have a
long-running crawl task coming from different IPs that scrapes SERPs as it goes,
let's see you do that under Colab. Oh wait, you can! You just have to pay and
pay and pay. And so, native Notebooks in genuine Jupyter was my path. And
Pipulate became even more niche and even more obscure. No self-respecting SEO is
going to install a local JupyterLab when they can just click an X-Twitter link
and run a junior version of the same script in Colab in 2 seconds and call it
done. Pipulate would have had to have been ***so much better*** than I had the
time and motivation to make it... at the time... with the (now despised) tech
available.

Well, it's time to bring your own server again separate from Jupyter. I wrote
about that ad nauseam by now. I cracked the code. It's best served with nix, but
there is a GNU version of the fix called guix (pronounced geeks) on the way, but
it doesn't have Mac-friendly powerhouses making installers for it the way
Deterministic Systems does for nix. And so for now, nix. But I'm confident all
cross-platform scripts with be readily portable to guix in the future with a
little AI help once Mac support for guix matures. This brings nothing less than
the original promise of Unix as a universal interoperable portable OS that
carries all its apps to be just as portable around with it. Similar to the dream
and promise of Java. Turns out flat-packing Linux with a key/value hash store
handled the same way on any host OS that can handle it is the answer. That means
Macs AND Windows (through WSL) for the ultimate in whole tech infrastructures
that flow like water between heterogeneous hardware. And now development and
deployment is more like just development&#151;and a much simplified form of
single-tenant development at that.

OMG, so many subtopics in this discussion. All to work up the clarity and the
motivation to work on the new Pipualte pipeline tech. Workflows that shove the
complexity to just the right places. Simple text files for complex automations.
Unix pipe inspired, HTMX and SQLite enabled, and ultimately FastHTML scaffolding
and glue. Deep breath and... and a short power nap. But first, capture the most
promising pattern from prior posts here. I think Gemini-Advanced had the winner,
combining its best with the best of Claude 3.5 Sonnet. And finally, Deepseek
agreed and couldn't meaningfully top it. So this is it:

```python
from fasthtml.common import *

app, rt, (pipelines, Pipeline) = fast_app(
    "data/pipulate.db",
    pipulate={
        "url": str,
        "data": str,
        "created": str,
        "updated": str,
        "pk": "url"
    }
)

class Pipulate:
    """
    Pipulate Pattern: Local-First Pipeline Processing Using FastHTML/HTMX

    CORE PRINCIPLES:
    1. Everything Is Local
        - This is NOT a web app - it's a local tool using HTML as UI
        - Single-tenant by design - full resource utilization
        - Nix Flake manages dependencies, not container orchestration
        - Browser automation possible (Puppeteer/Playwright)
        - Local user profiles and VPNs are your friends

    2. State Management Is Simple
        - One URL = One Pipeline Run = One Database Record
        - All state in JSON blob in 'data' field
        - No hidden fields, no session state, no client-side state
        - URL is both primary key and resume point
        - Timestamps tell the complete story

    3. Card-Based Processing
        - Each step is a distinct, resumable card
        - Cards read like English: analyze → process → visualize
        - State preserved between cards in JSON blob
        - Direct URL access to any card: /endpoint/card2
        - Interruption-friendly design

    TECHNICAL FOUNDATIONS:
    1. FastHTML (NOT Django/FastAPI/React)
        - HTML components as Python functions
        - Server-side rendering only
        - No client/server split
        - Everything runs on localhost

    2. HTMX (NOT REST/GraphQL/Redux)
        - HTML attributes as API
        - Server-side state management
        - URL-driven navigation
        - Zero client-side state

    3. MiniDataAPI (NOT SQLAlchemy/Prisma/TypeORM)
        - todos.insert({"key": key, "value": value}) inserts records
        - Plain Python objects
        - Direct CRUD operations
        - SQLite as THE source of truth

    DATABASE SCHEMA:
    pipulate = {
        "url": str,       # Primary key and job identifier
        "data": str,       # JSON blob for all state
        "created": str,  # First insert timestamp
        "updated": str,  # Last update timestamp
        "pk": "url"      # URL as natural key
    }

    ANTI-PATTERNS TO AVOID:
    ❌ Client-side state management
    ❌ Hidden form fields
    ❌ Session storage
    ❌ Complex ORMs
    ❌ REST/GraphQL APIs
    ❌ Frontend frameworks
    ❌ Container orchestration

    CORRECT PATTERNS:
    ✓ URL as state carrier
    ✓ JSON blob as data store
    ✓ SQLite as database
    ✓ HTMX for interactions
    ✓ FastHTML for UI
    ✓ Local-first processing
    ✓ Single-tenant design

    Remember: Simple > Complex > Complicated
    """

    def __init__(self, url):
        self.url = url
        self.pipeline = pipelines.get(self.url)
        if not self.pipeline:
            self.pipeline = pipelines.insert({"url": self.url, "data": "{}", "created": self.current_timestamp(), "updated": self.current_timestamp()})
        self.data = json.loads(self.pipeline['data'])

    def current_timestamp(self):
        return datetime.now().isoformat()

    def update_data(self, new_data):
        self.data.update(new_data)
        pipelines.update({"url": self.url, "data": json.dumps(self.data), "updated": self.current_timestamp()})


class WorkFlow:
    """
    A simple workflow to collect a URL, clean it, and proceed through cards.

    Routing:
    - Uses the @rt decorator for concise route definitions.
    - Leverages automatic method detection based on function names (card1 for GET, process_url for POST).
    """
    def __init__(self, url):
        self.url = self.clean_url(url)
        self.pipulate = Pipulate(self.url)

    def clean_url(self, url):
        """
        Clean the URL to keep the first 2 directory levels and end with a slash.
        """
        parts = url.split('/')
        cleaned_url = '/'.join(parts[:3]) + '/'
        return cleaned_url

    @rt('/workflow/card1')
    async def card1(self):
        """
        Card 1: Collect and clean URL, initialize pipeline.
        This method handles GET requests by default due to the @rt decorator.
        """
        return Card(
            H2("Card 1: URL Input"),
            P(f"URL cleaned to {self.pipulate.url}"),
            Button("Next", hx_post="/workflow/process_url", hx_vals=json.dumps({"url": self.pipulate.url})),
            id="card1"
        )

    @rt('/workflow/process_url', methods=['POST'])  # Explicitly handle POST
    async def process_url(self):
        """
        Process the URL and proceed to Card 2.
        This method handles POST requests as specified by methods=['POST'].
        """
        # ... (logic to process URL and update Pipulate data) ...
        return Redirect('/workflow/card2')

    @rt('/workflow/card2')
    async def card2(self):
        """
        Card 2: Display a button to proceed to Card 3.
        This method handles GET requests by default due to the @rt decorator.
        """
        return Card(
            H2("Card 2: Processing"),
            Button("Next", hx_get="/workflow/card3"),  # Use hx_get for simple navigation
            id="card2"
        )

    @rt('/workflow/card3')
    async def card3(self):
        """
        Card 3: Final card, display workflow completion message.
        This method handles GET requests by default due to the @rt decorator.
        """
        return Card(
            H2("Card 3: Workflow Complete"),
            id="card3"
        )
```

Okay, 5:30 AM. That's fine. Still have a few hours stretch before the official
work day begins, and it's not full of client meetings. There is one that I have
to check what it's about and what preparation on my part is necessary, but
there should be the convergence of preparation and the development type word I'm
doing as the development work shifts to either the creation or carrying out of
new workflows. I'm also quite glad that the concept of Pipulate is back in the
picture as the pipeline piece. It's the culmination of years of working on
variations of this stuff. I finally have a timeless pattern. 

Hey Perplexity, when you're over-ambitious coding and introduce a bug that you
can't track down and git diff on github has too many things going on, what's a
good way to gradually roll-in the new from a `git reset --hard HEAD^` working
version?

**Perplexity**: To gradually roll in new changes after a `git reset --hard HEAD^`, you can follow these steps:

1. Create a new branch from your current state[1]:

```bash
git branch recovery-branch
```

2. Reset to the previous commit[1]:

```bash
git reset --hard HEAD^
```

3. Create another branch for your working version:

```bash
git checkout -b working-version
```

4. Now, you can gradually introduce changes from your recovery branch:

## Method 1: Cherry-picking

Cherry-pick specific commits from the recovery branch[3]:

```bash
git cherry-pick <commit-hash>
```

## Method 2: Patch application

1. Generate patches for each commit in the recovery branch:

```bash
git format-patch working-version..recovery-branch
```

2. Apply patches selectively:

```bash
git apply --check 0001-commit-message.patch
git apply 0001-commit-message.patch
```

## Method 3: Interactive rebase

1. Start an interactive rebase:

```bash
git rebase -i working-version recovery-branch
```

2. In the interactive rebase editor, mark commits as "edit" to pause and review changes.

3. Make necessary modifications and continue the rebase:

```bash
git rebase --continue
```

By using these methods, you can gradually reintroduce your changes while carefully reviewing and testing each modification to identify and fix the bug[2][4]. This approach allows you to maintain a stable working version while incrementally incorporating new features or changes.

Citations:

    [1] https://graphite.dev/guides/how-to-use-git-reset-hard-head
    [2] https://github.com/orgs/community/discussions/60452
    [3] https://graphite.dev/guides/how-to-use-git-reset-head
    [4] https://ohshitgit.com
    [5] https://www.freecodecamp.org/news/git-reset-hard-how-to-reset-to-head-in-git/
    [6] https://stackoverflow.com/questions/5788037/recover-from-losing-uncommitted-changes-by-git-reset-hard

Me: Ugh, they weren't separate commits! I'll clone another version, set one to the broken state and one to the working state and copy/paste. But I followed instruction #1, so how do I now delete those two branches and get back to main head?

Perplexity: To delete the branches you created and return to the main branch's HEAD, follow these steps:

1. Switch to the main branch:

```bash
git checkout main
```

2. Delete the local branches:

```bash
git branch -D recovery-branch
git branch -D working-version
```

The `-D` flag is used to force delete the branches, even if they haven't been merged[1][4].

3. If you pushed these branches to a remote repository, delete them remotely as well:

```bash
git push origin --delete recovery-branch
git push origin --delete working-version
```

This command removes the branches from the remote repository[1][4].

4. To ensure your local repository is in sync with the remote, you can fetch and prune:

```bash
git fetch --prune
```

This command will remove any remote-tracking references that no longer exist on the remote[4].

After completing these steps, you'll be back on the main branch with the temporary branches removed both locally and remotely (if applicable). Your repository will be clean and ready for your copy/paste approach with the cloned versions.

Citations:

    [1] https://www.freecodecamp.org/news/how-to-delete-a-git-branch-both-locally-and-remotely/
    [2] https://graphite.dev/guides/how-to-delete-a-branch-in-git
    [3] https://www.freecodecamp.org/news/git-delete-branch-how-to-remove-a-local-or-remote-branch/
    [4] https://refine.dev/blog/git-delete-remote-branch-and-local-branch/
    [5] https://www.reddit.com/r/github/comments/1dxh4cu/how_to_delete_a_branch_in_github/

Oh, foo! Not my favorite thing to do, but live and learn.

Another part of this learning moment is now that I'm using multiple GitHub
accounts (yuck!), I have to sort my commands by user aliases as defined in my
`~/.ssh/config` file, something I touch just little enough to ***never
remember***, and so I look...

    # Primary GitHub Account
    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/id_rsa
      IdentitiesOnly yes

    # Secondary GitHub Account
    Host bf
      HostName github.com
      User git
      IdentityFile ~/.ssh/botifython_develop
      IdentitiesOnly yes

...and so I remember. Or do I? I need a rule. The normal thing I think to type
is:

    git clone git@github.com:Botifython/botifython.git foo

But I need me some better Git Fu, so... so... `git@github.com` is a user@host
directive according to some protocol definition, probably SSH. The whole darn
thing is what gets aliased by... by... by well, my Best Friend, of course.
Botifython! `bf`, that is. So everything before the colon is the alias, of
course! Simpler than I thought. It becomes...

    git clone bf:Botifython/botifython.git foo

And my git fu is complete. I now can load both side-by-side into an editor and
copy/paste from the ambitious version into the working version until it breaks,
committing every step of the way so the more formal patch playback git jig
actually works for next time. Looking forward to using that. In my LPvg (Linux,
Python, vim & git) minimal tech stack for life philosophy, git is definitely my
weakest point.

So now that I have my foo directory as a cloned version of the broken head of
the git repo, I want my main instance to be the working version, 1 commit prior
to the break. So I cd back into it and...

    git pull
    git reset --hard HEAD^
    git commit -am "Fix"
    git push --force

Now I'm on the last working version. Hooray! Even for just that time machine
goback ability alone, using git is worth it, even if you're not collaborating
and even if you're not using GitHub. Git is just a generic all around safetynet.
Also, I did a little maneuver here so that the ambitious broken version ***only
exists in foo!*** Think about that. I can't shoot myself in the foot
accidentally again. There is only updating to a better state or have it default
to working. There is no broken state anymore, nor accidental rollbacks or
regressions. This is all part and parcel of the whole genie backfire prevention
thing. Cut off all avenues of screwing up.

And now, commit often.

First I delete WebAngiogram and my first attempt at pipeline. Done. Still works.
Commit and bank it. Done.

Alright, confidence and humility. I've come right up to the edge of the
Dunning-Kruger effect. Here it is. Stupid git tricks. Don't effin be bullied
around by a Linus Torvalds API. He's a file systems guy using Unix philosophies
naming the durn tool after himself as a git, who actually stole many of the
concepts from... hey, Perplexity tell me all about it.

**Perplexity**: Linus Torvalds did not steal his ideas for Git. He created Git in 2005 as a response to a licensing dispute with BitKeeper, the previous version control system used for Linux kernel development[1][3]. The name "Git" was not self-deprecating or named after himself. Torvalds chose it as a playful, irreverent term, which in British slang means a silly or contemptible person[5]. 

Git was developed to meet specific needs of the Linux kernel project, with goals including speed, simple design, and support for distributed workflows[3][8]. Torvalds built the initial version in about 5 days, drawing on his experience with other version control systems but creating an original design[1][3].

It's important to note that Git quickly became self-hosting and was managing the Linux kernel source code within a month of its creation[5]. The project was then turned over to Junio Hamano for maintenance, demonstrating a collaborative approach rather than self-aggrandizement[3].

Citations:

    [1] https://graphite.dev/blog/understanding-git
    [2] https://en.wikipedia.org/wiki/History_of_Linux
    [3] https://en.wikipedia.org/wiki/Git_(software)
    [4] https://linux.slashdot.org/story/15/04/06/1559207/10-years-of-git-an-interview-with-linus-torvalds
    [5] https://community.appsmith.com/content/blog/evolution-git-dive-tech-history
    [6] https://www.linuxjournal.com/content/git-origin-story
    [7] https://www.linuxfoundation.org/blog/blog/10-years-of-git-an-interview-with-git-creator-linus-torvalds
    [8] https://git-scm.com/book/ms/v2/Getting-Started-A-Short-History-of-Git

Perplexity: Oh, that's right. How similar is the feature set of git to BitKeeper and how not self-aggrandizing is naming the worlds most popular OS in the world after yourself as Linus did with Linux?

Git and BitKeeper share some similar features, but they have distinct differences in their design and functionality[2][4]. While Git was inspired by some aspects of BitKeeper, Linus Torvalds intentionally created Git to be technically very different[4]. Both systems offer distributed version control, but Git's approach to branching, merging, and repository structure differs significantly from BitKeeper's[2].

Regarding the naming of Linux, it's important to clarify that Linus Torvalds did not name the operating system after himself out of self-aggrandizement. The name "Linux" was actually coined by Ari Lemmke, who administered the FTP server where the Linux kernel was first hosted for download. Lemmke named the directory "linux" without Torvalds' input. Torvalds had originally called his project "Freax" (a combination of "free," "freak," and Unix). The name Linux stuck as a shortened form of "Linus's Unix," but it was not Torvalds' choice or an act of self-promotion[1].

Citations:

    [1] https://stackshare.io/stackups/bitkeeper-vs-gitlab
    [2] https://stackshare.io/stackups/bitkeeper-vs-git
    [3] https://appwrk.com/bitbucket-vs-git-detailed-comparison-for-business-makers
    [4] https://graphite.dev/blog/bitkeeper-linux-story-of-git-creation

Me: Ooh, I did not know that! Thank you, Perplexity. But still, you say technically very different, sure. Like the way Linux implementation is technically very different, but the APIs and fundamential concepts... okay, not "stolen", but... how similar in concept and design is git to BitKeeper. Forget about the fact the i's were dotted and t's were crossed to have black boxed the innards.

Perplexity: While Git and BitKeeper have some conceptual similarities as distributed version control systems, they differ significantly in their design and implementation. Git was indeed influenced by BitKeeper, but Linus Torvalds intentionally created a system that was technically distinct[2].

Key similarities in concept between Git and BitKeeper include:

1. Distributed nature: Both systems allow developers to have local copies of the entire repository[1].
2. Branching and merging capabilities: Both support parallel development workflows[1].
3. Change tracking: Both systems track changes to files over time[1].

However, there are notable differences:

1. Repository structure: BitKeeper uses a central repository model, while Git is fully distributed[1].
2. Conflict resolution: BitKeeper offers automatic conflict resolution, whereas Git requires manual intervention[1].
3. Branching model: Git's branching is more lightweight and flexible compared to BitKeeper's traditional model[1].
4. Performance: Git is generally considered faster and more efficient, especially for large repositories[1].

Torvalds himself acknowledged BitKeeper's influence on Git, stating that while Git is technically very different, many of the workflows used in Git came directly from what they learned from BitKeeper[2]. However, he also emphasized that Git was not a BitKeeper clone, and its design was intentionally different[2].

It's important to note that Git drew inspiration from multiple sources, not just BitKeeper. For example, Git's content-addressable storage design was inspired by Monotone, another version control system[4].

Citations:

    [1] https://stackshare.io/stackups/bitkeeper-vs-git
    [2] https://graphite.dev/blog/bitkeeper-linux-story-of-git-creation
    [3] https://stackshare.io/stackups/bitkeeper-vs-git-repo
    [4] https://news.ycombinator.com/item?id=21418363
    [5] https://appwrk.com/bitbucket-vs-git-detailed-comparison-for-business-makers

I ***love interrogating Perplexity*** to probe and refine my understanding of
things. Look at how well cited this is. If there are hallucinations, they're
well-founded hallucinations. Source of truth! Frig, if Google had come out of
the gate with a well-cited, well-spoken AI API like Perplexity, we wouldn't be
talking about the future of the search industry today. I saw it when Microsoft
put the chat interface with citations in Bing and said so loudly. In that one
brilliant move, Microsoft cut Google off from using the one true UI for
search-powered chat, ***the well-cited abstract***. Sorry, Google. It's off the
table. Wow! And now we've got ***Search Labs | AI Overview***, barely better
than a rich snippet, often hidden or not showing at all, and nothing like the
revolutionary upgrading of the search experience we can all feel coming.

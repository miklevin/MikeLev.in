---
title: Dedumbing Sisyphus
permalink: /futureproof/dedumbing-sisyphus/
description: 
layout: post
sort_order: 1
---

I stalled out with the writing. I stalled out right on the precipice of driving
home the most important piece of coding... of expressing myself in a way that
has an automating and thus self-accelerating component... that I have ever done.

Briefly, in my time at a company from my past I was firing on all cylinders like
this and made a system that lifted the company up by the scruff of its neck and
took it into the future. Or at least ensured it's survival long enough to be
purchased by another company for more than just picking it apart for pieces.

This go-around, it's riding the wave of the anti-ReactJS movement, a move
towards greater simplifcation in web development systems, but for the purpose of
making powerful localhost apps, LLMs and all, which exceed the capabilities of
things you can do when hobbled by enterprise architecture and scaling concerns.
No app is an island. But if you design it so that localhost is an island, a
whole host of tricks open up to you that just aren't available otherwise. That
stuff is covered in depth other places, so this is just a reminder to myself
about what I'm doing here.

My last post, which was supposed to be about the driving the Pipeline Process to
Completion got derailed by a combination of my own exhaustion catching up with
me (I've been driving myself very hard), and the client work having still to
take priority. And it's not just easily planned around client work. It's
additional stuff being tossed my way because... well, because life. So again,
it's my failure to factor in Murphy's Law and default FUBAR states. The world
ain't ideal. That's why I start out with:

- What's most broken
- Where do you get the biggest bang for the buck
- What plates need to be spun

One of the nuances here that I learned is that the nature of the way you spin
those plates is ever-so important. You either spin them in such a way that frees
up cycles between re-spins or in a way that tightens the gap and you are left
doing nothing but spinning plates at the expense of ever fixing what's most
broken or doing any of those things where you get the biggest bang for the buck.
That's the busywork trap, and is clearly what I'm trying to avoid getting
trapped in.

If I do, it's game over.

And one can almost view themselves in a cat and mouse game of those forces
collaborating unintentionally, merely fate being what it is, against you versus
the you that was put into this world to achieve your Ikigai. Something is
preventing you from producing what the world needs as a result of doing what you
are good at, what you love doing and what you can get paid for.

This I think it feels in this world, and I could be wrong and would like to be
proven so, that so few people achieve anything like their Ikigai. Most folks die
on some alter of compromise because all pursuit of Ikigai has these anvils
falling on your head as if dropped by Wile E. Coyote on the Roadrunner. Of
course, none of them ever hit the Roadrunner, and there's a lot strategic and
tactical inspiration in that. Be fast. Know what you're about. And have a great
sense of humor regarding those anvils dropping all around you. Know them for
what they are and don't let them change that MEEP MEEP spirit.

Okay, so it's really about client work today.

But it's also really about this tiny last step that makes the client work the
first pipeline. It's a RED LIGHT / GREEN LIGHT warning system for what's out of
whack in your website.

I mean how perfect is that?

I also have to produce some of those Link-Graph diagrams that provide insight
about a website, but that's going to be a big pipeline porting process, which I
have the next 4 days as beautifully focused, concentrated time for.

These 4 days of concentrated work time is something I truly have to be thankful
for. The timing could not be more perfect.

Where I lost steam and left off was setting the stage for my most difficult next
step with a clarity, and therefore confidence, I need to keep the code from
getting out of my control.

I'm using those effin code assistant "genies" to help, and I am therefore
overreaching my innate technical abilities. Again, there's that concept of
hitting above my weight class. I don't have the kind of pulsing alien brain that
people like Paul Graham or David Heinemeier Hansson seem to have. I use those
two examples because they write influentially about this stuff, Paul about the
meta programming aspects of LISP, and DHH in bucking the ReactJS trend. Of late,
I'd probably throw Jeremy Howard into this category. I've created incredibly
junior entry-level versions of some of the admirable things they've created. And
now that I'm up to my next project, my intention is to hit at one weight class
up. I'm beefing up with the code assistant genies.

This is where I left off 2 days ago with perfect clarity of thought:

**Claude**: I notice several key "hot spots" where implementation details need to crystallize, while maintaining the elegantly simple design principles you've outlined:

1. **Card State Serialization Pattern**

```python
# Not yet implemented but needs consistent pattern:
card_state = {
    "card1": {
        "url": "https://example.com"  # Single field example
    },
    "card2": {
        "option1": "selected_value",
        "option2": ["multiple", "selections"]  # Multi-field example
    }
}
```

{:start="2"}
2. **Pipeline State Transitions**

```python
# Current placeholder locations in WorkFlow class:
async def process_url(self, request):
    # Need to standardize how we:
    # 1. Validate incoming state
    # 2. Update pipeline JSON blob
    # 3. Return only placeholder for next card
```

{:start="3"}
3. **Card Placeholder Generation**

```python
# Need consistent pattern for all cards:
return Card(id="card2")  # Currently ad-hoc
# Should be standardized helper method:
def create_placeholder(self, card_id): ...
```

{:start="4"}
4. **State Recovery Points**

```python
# Pipeline table schema already supports this:
{
    "url": str,      # Primary key
    "data": str,     # JSON blob
    "created": str,  
    "updated": str
}
# But need consistent recovery implementation
```

But the work I do today for TWO DIFFERENT Monday presentations, I have to be
able to fake having what the automation process will produce. Two things, which
themselves must fit into even higher-priority projects coming down from...
from... from... Perplexity?

**Perplexity**: The expression "coming down from on high" typically refers to orders, directives, or decisions that originate from people in positions of authority or power within an organization or hierarchy[1][3]. It is often used humorously or ironically to describe instructions or mandates that are imposed by senior management or leadership without input from lower-level employees[2][5].

For example:
- "An order came down from on high that lunch breaks were to be reduced to 30 minutes."
- "The new policy came down from on high, leaving employees frustrated with the lack of consultation."

The phrase combines two idioms:

1. "From on high" - meaning from a position of authority or power[5]
2. "Coming down" - implying the top-down nature of the communication[4]

This expression emphasizes the distance between decision-makers and those affected by the decisions, often suggesting a lack of understanding or consideration for ground-level realities[3][5].

Citations:

    [1] https://preply.com/en/question/what-does-to-bring-hell-down-from-on-high-mean-65724
    [2] https://www.ldoceonline.com/dictionary/from-on-high
    [3] https://idioms.thefreedictionary.com/on+high
    [4] https://www.reddit.com/r/EnglishLearning/comments/yellvh/what_is_the_meaning_of_come_down_in_this_context/
    [5] https://idioms.thefreedictionary.com/from+on+high
    [6] https://dictionary.cambridge.org/us/dictionary/english/on-high

Yeah, so there you go. I have to be able to report on progress on my main on
high directive which I ***so agree with*** as needing to be the company
priority, because without being able to shove more work through a smaller
pipeline we satisfy fewer customers to higher degrees. There's a whale-hunting
versus not-whale-hunting discussion here that I'm trying to nullify or make moot
by having blurring the line between harpooning and trolling. Can you still use
whale murdering metaphors? Well, I'll fry that fish when I kill 2 birds with one
stone.

Anyhoo, it's a complex multidimensional puzzle. I'm solving multiple equations
simultaneously, but I must do that without slowing myself down, haha! And that
means brushing off a little PT Barnum Penn & Teller showmanship. It's not about
the miracle being accurately performed, it's about the perception of the miracle
being accurately performed, and in my case covering for just enough time to
accurately perform the miracle.

But the data needs to be good. The trick needs to be truly and accurately
customized to each client. When they look at the Google Slide, because
unfortunately that's where the trick needs to be performed, the client needs to
see their own special case screaming back out to them saying "These people
really look at and know your site better than you do."

And that is my today. It's not the next and wonderful and life-changing step of
completing a piece of work, which at in my mid-50s has got to be my Magnum Opus
and the output of my optimum stopping distance algorithm. Whereas most people
would have flipped the switch by 28 going into their midlife crisis... what's
that quote about physicists all having done all their greatest work by 26 years
old or not at all... Perplexity?

**Perplexity**: Einstein once said, "A person who has not made his great contribution to science before the age of 30 will never do so."[1] However, a recent study has shown that this view is increasingly outdated. Researchers found that while young scientists did make groundbreaking contributions in the early 20th century, particularly during the quantum mechanics revolution, the age of peak scientific creativity has significantly shifted[1][2].

By the year 2000, great scientific work before age 30 had become extremely rare. In physics, the average age for Nobel Prize-winning work is now 48, compared to the earlier era when many physicists made critical breakthroughs in their 20s. The study suggests this change is due to the increasing complexity of scientific knowledge, with scientists now requiring more time to build upon existing foundational research[1][2].

Interestingly, the early 20th century was unique. In 1923, about 31 percent of physicists did their breakthrough work by age 30, and by 1934, 78 percent did so by age 40. However, these percentages declined throughout the rest of the century[1].

Citations:

    [1] https://www.nbcnews.com/id/wbna45198217
    [2] https://www.telegraphindia.com/india/sorry-albert-40-is-new-30-study-finds-einstein-s-age-rule-needn-t-hold-true-now/cid/323889
    [3] https://www.asl-associates.com/einsteinquotes.htm
    [4] https://www.easybib.com/guides/quotes-facts-stats/albert-einstein/
    [5] https://www.physicsforums.com/threads/greatest-work-of-physicist-done-in-their-20s.666255/
    [6] https://www.deseret.com/2018/3/14/20641870/22-witty-and-inspiring-albert-einstein-quotes/

...so in my mid-50s I'm basically an old coot who thinks he's a tyke. So effin
be it. Keeps me young and all that. The trick is to not remain Sisyphus, but
rather to have a moment of self-awareness and a cycle-breaking agency moment.
Know why it's a not-so-virtuous cycle that keeps you rolling the boulder up the
mountain, create an anchor-and-lever system that can both:

- Give you a momentary respite
- Allow you to bank your next bit of progress, once recovered

So these couple of slides I'm making today are an image of the output of this
system, only enough so to give me that momentary respite... today and today
only. Take consolation in the fact that you can make major boulder-rolling
progress starting tomorrow in a way that can never be taken back from you again.

I am indeed analogous to Sisyphus figuring out how to automate his
boulder-rolling task. It's not even automation. It's repeatable workflows where
you can leave of and pick up in the middle of, where the steps of the workflow
might be human or might be machine. Sometimes I'll hit an API and do some Pandas
data tricks, and sometimes I'll pop open a browser window using all the user's
local Botify and SEMRush stored profile data to end-run authentication and APIs
with a bit of instruction about what to click-to-save and where to save it.
Semi-automation!

I like this Sisyphus metaphor so much it's going to replace my Icarus jumping
off the cliff and learning to fly metaphor, which is what I used previously for
those hitting above your weight class moments. Too dangerous! Too reckless!
Sisyphus has been at it awhile and is the definition of stupidity, right? Doing
things over and over the same way, the hard and wrong way without learning from
your experiences, means you lack intelligence. Sure, Sisyphus was cursed to his
fate, but it seems to me he was locked into acting stupid, and with a nice dose
of self-awareness, agency, and some strategic and tactile thinking, he can break
free of the curse. Am I right?

Okay, today's post officially becomes De-dumbing Sisyphus.

Even today, I've got a bit of wiggle room to work with. Thanksgiving is
tomorrow, and then Friday off and a blissful weekend. Life circumstances being
what they are at the moment, this means the introvert's dream of 4 solid days of
focus! Not merely that, but 4 solid days of focus with next step spelled out
crystal clear to achieve greater than I ever have in my professional career, by
virtue of the complete re-alignment with the evolving world of AI SEO. This is
big. As big as anything in my life second only to having a child, for whom doing
right by this career elevation step is all about. 

It's not easy to communicate these things, but it needs to be said. My
young-person energy in my 20s which was all about seeing if I could perform at
that next level up, becomes in my 50s about trying to hit it all home in a way
that I can open up options for them in their life. Sure, I'll enjoy these
second-act vibes and the whole Rocky Balboa bouncing back and rising to the
occasion feeling. But it's also about having a reason to do it. We still have
tons of time to work with here. What doesn't kill you makes you stronger. I know
there's a generation who thinks what doesn't kill you makes you damaged goods
wronged by society and permanently entitled. But to that I say "I shall taunt
the fragile flower generation a second time-a!"

Anti-fragile. Thank you Taleb-something for writing that book that encapsulates
why the fragile flower generation of algorthmically riled-angry YouTubians is so
wrong-headed and funny and why "what doesn't kill you makes you stronger" is
spot-on right. What was his name?

**Perplexity**: Nassim Nicholas Taleb wrote the book "Antifragile: Things That Gain from Disorder"[1][2]. This book is part of Taleb's Incerto series, which explores themes of uncertainty, probability, and decision-making in a complex world[2][3].

"Antifragile" introduces and expands on the concept of antifragility, which refers to things that not only withstand chaos and volatility but actually benefit from it[2]. Taleb argues that many aspects of life, from biological systems to economic structures, can exhibit antifragile properties[1].

The book covers a wide range of topics, including:

1. How certain systems gain strength from stress and disorder
2. The limitations of predictive models in complex environments
3. The importance of optionality and the "barbell strategy" in decision-making
4. Critiques of modern approaches to risk management and policy-making
5. Examples of antifragility in various fields such as medicine, economics, and urban planning[1][2]

Taleb's writing style in "Antifragile" combines narrative elements, philosophical discussions, and scientific commentary to present his ideas[3]. The book aims to provide a framework for thriving in an uncertain world by embracing and harnessing the power of volatility and randomness[2].

Citations:

    [1] https://psychiatryresource.com/bookreviews/antifragile-review
    [2] https://www.barnesandnoble.com/w/antifragile-nassim-nicholas-taleb/1110867836
    [3] https://en.wikipedia.org/wiki/Nassim_taleb
    [4] https://www.goodreads.com/book/show/13530973-antifragile

And let's follow up with a nice "this too shall pass" origins story...

**Perplexity**: "This too shall pass" is a profound philosophical phrase that reflects the **transient nature of life**, emphasizing that both good and bad moments are temporary. The phrase originates from Persian literature, with the original Persian saying "این نیز بگذرد" (in nīz bogzarad)[1].

## Historical Context

The expression gained widespread popularity through a legendary story involving King Solomon. According to the tale, Solomon sought a ring that would make a sad man happy and a happy man sad, ultimately inscribing the phrase "Gam ze ya'avor" (Hebrew for "This too shall pass") as a reminder of life's impermanence[1].

## Cultural Significance

The phrase carries deep philosophical meaning:
- It reminds people that **no emotional state is permanent**
- Provides comfort during difficult times
- Encourages resilience and perspective

## Notable Popularization

Abraham Lincoln famously referenced the phrase in an 1859 speech, describing it as a profound wisdom that captures both the **humbling nature of pride and the consolation in times of affliction**[3][4]. Lincoln, who struggled with depression, personally understood the phrase's transformative power of hope.

The saying transcends cultural boundaries, appearing in Persian, Jewish, and Western traditions, ultimately serving as a universal reminder that **life's circumstances are always changing**[2][6].

Citations:

    [1] https://www.christianity.com/wiki/bible/this-too-shall-pass.html
    [2] https://www.reddit.com/r/AskHistorians/comments/90vu05/what_is_the_origin_of_the_phrase_this_too_shall/
    [3] https://yoprolibrary.substack.com/p/this-too-shall-pass-where-does-the
    [4] https://humbledollar.com/2020/03/this-too-shall-pass/
    [5] https://www.alefbet.com/blogs/blog/this-too-shall-pass-the-story-the-meaning-and-you
    [6] https://www.ansheamunim.org/gam_zeh_yaavor
    [7] https://ovlcollection.com/blogs/news/the-meaning-of-this-too-shall-pass

So I am totally aware that these deeper messages are going to get lost in the
noise of day-to-day work journal entires. But fear not! I've already done my
tests to confirm that these big-token-window LLM (monster genies) like Gemini
Advanced Pro can take my whole journal, every single post, and parse through it
finding patterns and order, proposing the books I can "spin" out of it. Mike's
Book of Future-Proofing Tech Strategies & Tactics will certainly be one of them,
but there are plenty of sub-books here that I shall ensure are extractable.

I'll do that work for you, so you don't have to. Just know that as one of my
life's spinning plates has reached optimal stopping distance and is being taken
from the plate-spinning act and moved to the plate display mantle, other plates
are being put into the rotation. The extracted stories will, I hope, have a wee
bit of possible redemptive power here and there if you are willing to have an
open mind about it. I'm sorry for the past, and my only power-up's now to help
me on the challenging adventure that is life is just coffee, and I'm going to go
get me some now to dive into today with renewed vigor!

Fast-forward to Thanksgiving. Yesterday was another bust. While I caught up on
sleep, I was totally distracted processing the whirlwind of the past few weeks
(months) of bearing down on the biggest coding project of my life, re-settling
myself onto FastHTML which has the same feeling of durability as HTML itself.
It's the union of timeless aspects of Python and HTML, using HTMX, a proposed
new protocol and completely functioning library and technology, to extend HTML's
simple hyperlinked hypertext intent to the next logical level, by which anything
can make requests and handle responses from anything in the document object
model (DOM) of the browser, thereby turning the simple client/server sequential
model of the original web into... into... well, I can't even ask Perplexity
anymore because their feature that lets you copy the entire markdown response
citations and all (the best feature ever!) disappeared.

Oops.

So much for my favorite blogging technique of gathering Perplexity's view on
things as I go, blending in the well reasoned and well cited response. Maybe
it's time to look at ChatGPT Search as an alternative to Perplexity. Didn't
think I'd be doing that for awhile, but the removal of that key critical feature
of Perplexity is a slap in the face, and hey there's no loyalties here using any
particular AI service. It's really about bouncing around to all of them, seeing
what they have to offer, using each as appropriate, and when it comes time for a
real job, use the lowest-bidder approach so long as the output quality is
sufficient.

It's just like being a general contractor managing subcontractors. You have to
have a vision of the overall job and know what sub-skills it's going to take to
get the job done. Then you look over your list of subcontractors and run the job
past them to see what they could make of it. If you don't like their response to
your proposal, you move onto the next. We as general contractors of jobs to be
performed by AIs are in the catbird position of squeezing these mechanical
turks, these automated Fiverr's, for the best juice. It is up to us to make sure
the process of doing so doesn't use any custom API's, so that you can round
robin between them and erode all their respective competitive moats to nothing.

In such a world, the power shifts back to those who imagine a project. Move as
much of the process as you can to inside the private walls of localhost and LAN,
employing your in-house local LLMs to do most of the busywork. Intelligence is
like electricity. It's not no-cost, but it is a commodity that is ubiquitous and
ever present, flowing like water and infinitely multi-source-able.

Pshwew! Okay, so my November 27th post becomes my November 28th Thanksgiving
post as well, because I didn't finish what I needed to finish yesterday, and I
am altering my approach. Given this incredible opening up of a 4-day stretch,
during which I most certainly have to do client work, but mock-up's of "real
things", I step back and re-evaluate. Don't lose any ground. Just... well, as
the topic of this post now reads: de-dumb Sisyphus. That's the criteria.

And this is just the deep breath getting started. That's what people I interact
with hate to hear. Just being at the beginning and that long stretches of time
are not an assurance of the completion of "Jump / How High?" style work that
permeates the contracting and consulting world. Rather, when you have someone
who's realizing they're synthesizing a lifetime of lessons into a powerful new
methodology and approach, they... well, they can't relate. Let's keep it at
that.

Now for me personally, I feel I am engaged in a battle against feature creep and
the very information architects who make everything too difficult with a project
that is guilty of exactly what they say! Self-perpetrated hypocrisy is what I'm
worried about. Then I remind myself how much of diverse different systems, from
a Django to a Celery to a LangChain I've condensed down to under 7K lines of
code, and at least half of that comments and LLM coercion to see things my way.
And it's all based on the anti-information-architecture-astronaut tech of
FastHTML/HTMX, with a keen eye towards stripping out all client-side framework
complications making everything observable in the server-side web server console
output and logs... pshwew! Exhale... point being, I really am putting a
fine-edged minimalism and transparency of process on all this which is already
kick-ass in a first pass, but which over time is likely to become much smaller.
The entire opposite of feature creep. Complexity excising!

And then I realize I am on the right track. Especially considering how I'm
layering in the local LLM and the just-in-time hot prompt injection to give it
Neo Kung Fu like matrix downloads of exactly what it needs to know exactly when
it needs to know it, based on how the user navigates the user interface... WOW!

Nobody knows the web framework I build.

Keep much of it proprietary and behind a private GitHub repo, always offering
your employer right of first refusal to planting their flag in the buzz that is
likely to surround it if and when this particular Pipulate fork I've named
Botifython is made FOSS again. 



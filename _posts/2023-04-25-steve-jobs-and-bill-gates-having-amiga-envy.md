---
date: 2023-04-25
title: Steve Jobs and Bill Gates having Amiga-envy
headline: Creating an AI-Assisted Journaling System with Vim/NeoVim and Python
description: I'm working on an AI-assisted YAMLesque journaling system and have made changes to my website using Jekyll, Liquid Template, and Python to create an open source SEO software. I'm almost finished and ready to release my post, so come and see the results of my project!
keywords: AI, YAMLesque, journaling, Bing/Bard, Vim/NeoVim, Python, Open Source, SEO, Linux, Category Page, Jekyll, Liquid Template, prev/next arrows, Markdown, Mermaid, Synchronization, OpenAI
categories: vim, jekyll, open source, python, linux, journaling, ai, seo
permalink: /blog/steve-jobs-and-bill-gates-having-amiga-envy/
layout: post
---


I am making an AI-assisted YAMLesque journaling system. The Content + SMEs
meeting is going on now. It's so weird to type here with one of those
multi-faced videoconferences going on. 

- Google announced the ability of Bard to code (and it sends to Colab!)
- There's apparently an heir apparent to Bard already, but no info.

I've volunteered myself to making a timeline of Bing/Bard changes. Try to nail
all those dates. You can use the ChatBots even to help you with that, haha!
Okay, think! Have a vision and pursue it. Make all your projects sort of
blended together so there's all sorts of efficiencies and ways of doling out
different deliverables.

As soon as this call is over, throw yourself into finishing the journaling
system, and then USE the journaling system to help you with everything that
follows. Think of OTHER ways to have AI help me. It's not just in organizing my
site's content, but also as almost a sort of coach guiding me help figure out
what to do next and why.

If my whole site is basically published from a couple of data-files and
program-files, then I have a lot of flexibility in how I organize things. 

Alright, almost the entire system is working again the way it was just over the
weekend, but now much cleaner and more manageable. The only thing left is to
put back checking for the database versions being ahead of the text-file
version. I'm going to throw a backup of the entire journal into a sqlite
database almost as a warm-up for redoing the synchronization part, by which the
database might pull ahead of the text file.

The most important thing about this project is that I'm finding "me" again. You
are somewhere in your journaling, even if you lost yourself years ago through
the trials and tribulations of life. I found myself, almost nearly, when I
discovered the Amiga computer from Commodore. I found myself again when I dug
deep to recapture what it was about the Amiga that reflected do much of me.

The answer's a weird abstract thing I've been chasing on and off over the
years, but it can be found hidden inside other tech that channels similar
wonderful feelings. The Amiga was a computer that was so far ahead of its time,
it was like a time machine. Almost everything today seems a bit passe in
comparison, and honestly it wasn't until AI that it's not just a matter of
doing graphics, sound, communication and all the standard computer tricks
bigger, faster, better (and in the case of Mobile, smaller) than the Amiga.
Even VR's been a big yawn thanks to the Mandala system.

{% include youtubePlayer.html id="RwAXPY6jwCE" %}

But now this one-ness with vim/NeoVim I'm acquiring, coupled with Python and
the ability blend AI into the whole process, both as a "copilot" in the actual
writing/editing process, PLUS API-features as part of the Python programs I
run, well, this is exciting in a way the late-80s/early-90s never really got
to, except maybe by imagining it with Max Headroom.

{% include youtubePlayer.html id="1fKjaXP9p1g" %}

We're right on the precipice of a real, unique future. A future that's not just
Steve Jobs and Bill Gates having Amiga-envy, but a future that has an honest to
goodness Max Headroom like character bursting onto the scene. A bona fide
celebrity AI. Never in a million years had I thought it'd be Microsoft bringing
it to you, but it go so many other things right lately, namely buying Github
and developing VSCode, that I shouldn't be surprised.

Open Source SEO Software on a Small Linux Distro, that's what people want from
me. That's my best chance to break some new ground. 

Let's start going into my site like a bull in a china shop (although that
metaphor has been debunked). 

First the category page system I just created lays down the foundation for a
site by topic. I should allow each of those pages to get exposed 1-click off
the homepage, and start looking at building my site up from scratch,
essentially. Long-tail traffic isn't being given and rewarded like it used to
be, so the whole "if you write it, they will come" premise of SEO isn't as true
as it used to be.

Let's make some very decisive chisel-strikes that will change your life forever
forward.

Move all the homepage content onto the about page. Make the homepage the
beginning of the journal-reading experience. Make that where the categories are
exposed. Move almost everything else as well that's not essential like 404.md
to the drafts folder. I'm basically "wiping" my site.

Okay, first edit everything all at once to be how you want it to look. Keep in
mind using an additional include file across all the category pages. It can
serve as a placeholder for the category-specific content.

The important think here is to not go chasing rabbits. Don't go system-making
and framework-inventing. You have chosen the well-worn paths of Jekyll and all
the other LPvg tech you're using. Make best use of each of those frameworks.

The main feature of my site is my writing. The pushing ahead genuinely new
things, but doing it from the perspective of not some PhD, but a regular guy.
I mean I have done some cool things here and there, but that was just regular
guy reaching for the stars. 

Reboot! From my job at Prophet 21 back in the 20th century, I've been doing
different long-file slice & dice approaches. My favorite by far, except for how
obscure and difficult it was was XML files with XSL Stylesheets to accomplish
XSLT transformations. I've been doing that for years, and it blended together
with a content management system I wrote so you didn't have to look at
XML-files. But then it all fell apart, because:

- I based it on .asp files (Active Server Pages) which went out of style
- I based on on XML/XS LT, which while awesome is quite "inaccessible" to most
  people

I got very disheartened, because just like that old Amiga feeling of superior
tools, secret weapons, and that special wow-factor that just makes you feel
good, all that was missing from this stuff.

Sure, the allure of the free and open source software movement was there, but
nothing there seemed like my vibe. But fact was (and fact is for a lot of
people today) that copacetic vibes do exist there in the open source world.
They are just deeply, deeply hidden.

Surfacing the awesome, that's what I do. I challenge and tap my competency
using the tools, which if real, if earned, should let me trickle things up.
And in the trickling-up process, I can do what little editing that I do do in
order to polish the navigation, the excerpts, the dippy-top of the iceberg.

I put the old Liquid Template prev/next arrows back in from like over a year
ago when I first started this journal and created the latest incarnation of my
slice & dice system.

I also changed the way category pages work, trying Jekyll's own system for
grouping posts into categories, given a populated categories tag. I didn't
think it would have those sorts of advanced capabilities, so I'm going to see
if it does a better job than I did, just blindly matching the category names
appearing in the YAML front matter with a short list of categories and calling
it a member. Not very advanced, but functional and gets the job done.

Alright, that was tempting but the category pages didn't get created. I'm
worried about the Liquid Template system's double curly braces in Python
f-strings. Normally I'd try to lean into the strengths of Jekyll to do this,
but for it to work cleanly, I may have to take clean up entries in the
categories of the YAML front matter but currently that's all auto-generated
because I don't want to bog YAMLESQUE down with a bunch of extra stuff. It's
meant to be edited directly by humans and the less I put in there, the better.

I've got to start thinking in terms of Python processes that create the
markdown and Jekyll Liquid Template files, but putting minimal stress on the
Jekyll system. Don't rely on fancy features like the category stuff I'm asking
it to do. Keep much of that Python-side so I have fewer templating system
dependencies. I may have to switch templating systems someday, and have Python
pre-gen process will travel.

Alright, I'm just about there for now. I'm going to have to sink similar mental
energy into my work project. Put the same love into it. I'll be in a much
better position to do so, because I'll be journaling away about it as I go,
much pleased with myself for having created this journaling system. It effects
everything else in my life, really.

I see that somewhere along the line I broke the Mermaid diagrams. I'm going to
have to fix that. There's not really that much left to fix. The arrows are back
in beautifully. I've got good control of the category pages and overall code.

The last thing is to make sure that synchronization process rolls any new YAML
data back into the YAMLESQUE file from the databases. After sync currently, the
database pulls ahead. 

Alright, I can't wait any longer. I'm going to release this post and allow
OpenAI to do its thing, though it may not get published with the new data until
I put it back in the YAMLESQUE text-file. I know the signs I'm looking for.
I'll see special Figlet output telling me I hit the API, then I'll get a pause
to let me review the output. On the next run, I'll get the pause but no Figlet
WARN. And so that will set me up for writing it back into YAMLESQUE, and
that'll be a good place to stop for the day.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/gathering-all-category-logic-into-one-place/">Gathering All Category Logic into One Place</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/calcium-foss-make-flexible-tools/">Calcium & FOSS Make Flexible Tools</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/open-source/'>Open Source</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li></ul>
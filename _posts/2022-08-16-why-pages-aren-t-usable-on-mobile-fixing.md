---
date: 2022-08-16
title: Why Pages Aren't Usable On Mobile, Fixing!
headline: "Improving My Website Design: A Journey to Improve SEO Rankings"
description: I'm working on improving my website design and SEO rankings. To do this, I'm switching from a spinning logo experiment to a more simple design with bigger, clickable links. I'm also focusing on improving the categories of my site and tagging them correctly. I'm experimenting with SimpleCSS and Jekyll plugins to get the accent color of the navigation elements, and making sure I'm not compromising my special habits that give me a competitive edge.
keywords: Website Design, SEO Rankings, Logo Experiment, Clickable Links, Categories, Tagging, SimpleCSS, Jekyll Plugins, Accent Color, Navigation Elements, Fluid Layout, Header, Brand Identity, Hamburger Links, CSS Frameworks, File Protocol, Meta Refresh, Git Commit, Push, Assets, Style.css, Config.yml, CSS Elements
categories: 
permalink: /blog/why-pages-aren-t-usable-on-mobile-fixing/
layout: post
---


Okay after yesterday's only so-so venture into classless (a.k.a. class-less)
CSS frameworks, it's pretty obvious there are many and they're not really
classless. When you give up all the messiness of defining HTML element classes,
what you get back is a framework opinion which in many cases you're going to
want to immediately override, thus having to employ classes again which seem to
be there in the classless frameworks anyway. Haha! It's the same old framework
dilemma. You don't get something for nothing unless the something you want is
exactly what the designer of the framework offer as their default.

Okay. So it's once again the least worse of several evils decisions. What do I
really want in my classless frameworks. What are the priorities of the
"opinions" I want to see expressed as the classless default? Hmmm.

First, I want a fluid layout also known as a liquid layout. I want a header for
brand identity and links across the top. I want those links across the top to
become hamburger links when on mobile with the brand identity of the banner
still displaying. I want an accordion menu down the side next to the main
content when on mobile, but that accordion to become "stacked" as some sort of
expandable options immediately below the now-hamburger menu next to the brand
identity when on mobile. I think it's a pretty common layout and desire.

I can't spend too much time on this right now, because day-job and life. But
what I do want to do is to bank an irrevocable baby-step forward. I need to
document something here as a better starting point for my next go-around. Put
the style of code you'd like to use here.

I'm actually rethinking already. All that fluid liquid layout stuff seems to be
a tripping point. That's where so much opinion is inserted. If I just give up a
left-rail that pops to not be one on mobile, things become much easier and I
can give up class-full frameworks masquerading as class-less ones, like picocss
which I tested yesterday. Simplecss is looking simpler.

Okay this is where we become intrepid. I've experimented with the frameworks
without a webserver using the file:///C:/[path] protocol and a meta refresh
element to keep reloading the page. The simple bare-bones minimal classless css
template that I used to test and assure that simplecss wasn't terrible is:

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">
        <meta http-equiv="refresh" content="1" />
        <title>Future-proof your skills with Linux, Python, vim & git.</title>
    </head>
    <body>
      <header>
        <nav>
          <a ahref="#">Linux</a>
          <a ahref="#">Python</a>
          <a ahref="#">vim</a>
          <a ahref="#">git</a>
        </nav>
        <h1>LPvg.org</h1>
        <p>Future-proof your skills with Linux, Python, vim &amp; git.</p>
      </header>

      <main>
        <p>Resist obsolessence.</p>
      </main>

      <footer>
        <p>LPvg.org</p>
      </footer>
    </body>
    </html>

And then I slammed that into MikeLev.in's Jekyll \_layouts/default.html file
making minimal adjustments to keep all my site's content exposed. I don't have
Ruby Jekyll installed locally, so I have to actually push the files up with a
git commit and push every time I test the real thing. This is as opposed to the
file:/// approach where I just mock up a local html file. This isn't so easy
when your site is in markdown and transformed through the github.io Github
Pages static site generator system. You don't have the html versions of the
files locally for testing in a browser, so it's more of a push-and-pray
approach, which you can do when you're not a big player. One issue is because
MikeLev.in is so big (so many individual markdown.md files) it takes a few
minutes to generate and slows down the rapid iteration cycle. So be it. Rapidly
iterate on experimental files locally and transpose what you learn into the
live site.

Okay, I'm going in there all intrepid. I'd use the bull in a china shop
expression were it not for Myth Busters. Wow did that make an impact (unlike
the bull who walked around all gentle). There's not really much from the old
design that I'm determined to keep. Alright, I'm really enjoying this. My last
go at all this to get my reversible logo to rotate was cool and a good
experience, but misguided for SEO. I have to stick to the mainstream to make
Google reward me in SEO. What I did actually really killed my SEO rankings.
Maybe stick a screenshot here. Mobile design readability does have a huge
impact on SEO.

![Mobile Design Readability Huge Impact On SEO](/assets/images/mobile-design-readability-huge-impact-on-seo.jpg)

That was the trend and Google outright tells you why pages aren't usable on
mobile.

![Why Pages Aren't Usable On Mobile](/assets/images/why-pages-aren't-usable-on-mobile.jpg)

That really is the onus of this entire endeavor of switching over from my
spinning logo experiment to plane vanilla CSS with big clickable links.

The nav font sizes have been a problem with simple.css. There's different ones
used between minimal css file and readable one. Switching to readable one. I'm
going for big fat readable fonts now. I also see a font size measurement I'm
not used to, rem. I guess it's relative em, relative being to viewport or
device or something. Looks like a good idea. Fonts get bigger and SEO should
improve.

Had to remove poem (will it work here?):

> I got a 🎤.<br />
> I like to talk.<br />
> I love to talk into the 🎤.<br />
> I love the 🎤. I'm 🎤 lovin'<br />
> I've got some tales.<br />
> So, let's begin!<br />
> <br />
> <cite>&#151;Mike Levin, 2022</cite><br />

Just forge on! Focus and think.

It's worth noting that you're going for an ultra-simple design not merely to
make bigger more mobile friendly design to fix your SEO error in Google Search
Console, but also to just make the overall site more flexible to organize.
Don't change URLs but do change click-paths, especially from the homepage. This
project is in support of my new ELTgd initiative. It feels good. It felt good.
Every little thing gets done.

I got some pretty amazing work done with my Github Pages Jekyll sub-CMS system
last month? A few months ago? It's all a blur with the move. But I do know it's
got an edge of desperation of getting the most important projects done soonest
and most up-front so they can work for me producing compound interest. But that
won't happen with small unclickable mobile links that Google doesn't like.
Weakest link in the chain principle.

Next weak link in the chain? Better categories! Better rapid adjustment of
categories. Better exposure of categories from the homepage. Better tagging of
categories in this file.

I have to be careful when git mv'ing files. If I move index.md to index-back.md
and cp index-back.md index.md in order to preserve git histories on old files,
I have to remember to git add the new index.md back otherwise it disappears
from the site! Ugh.

I do very little like the mainstream except when I need to in order to get the
same benefits the mainstream is getting, especially if it doesn't corrupt and
compromise my special habits that give me the competitive edge. Wow, I should
really develop some of these journal posts more into featured blog posts. I
should have the concept of featured blog posts versus the long-tail archive. I
should re-read some of my old journal-style posts to "extract" these ideas. I
should do the list processing from long lists to shorter lists in that
distillation process that I've advocated for years. I should hittail.

Okay the quote tag doesn't work well with the new css framework, so try a
paragraph tag with the class notice the way simplecss.org does on their
homepage. Follow their lead until I have to diverge. I want the accent color of
the navigation elements so I'm adding simplecss.org's /assets/style.css to my
own. Interesting! Getting there.

Look at the Jekyll plugins available to me. These are turned on by default:

    jekyll-coffeescript
    jekyll-default-layout
    jekyll-gist
    jekyll-github-metadata
    jekyll-optional-front-matter
    jekyll-paginate
    jekyll-readme-index
    jekyll-titles-from-headings
    jekyll-relative-links

The page
https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll
says this:

> You can enable additional plugins by adding the plugin's gem to the plugins
> setting in your \_config.yml file. For more information, see "Configuration" in
> the Jekyll documentation.
>
> For a list of supported plugins, see "Dependency versions" on the GitHub Pages
> site. For usage information for a specific plugin, see the plugin's
> documentation.

I didn't get the accent color working, but I've got a fabulous start in the
switch over to a simple css framework to bring back my site's SEO performance.
At least a little bit. I have to work on click-paths!

Okay, this is coming along really well. The call just started.

I am experimentally removing these from my CSS in case they interfere with the
accent color:

    a:link {
      color: lightblue;
    }
    a:visited {
      color: darkgrey;
    }
    a:hover {
      color: white;
    }
    a:active {
      color: white;
    }

You're going to have to switch to your day-job stuff real soon now. Focus! Get
this to a place you're happy with but don't be a purist about it but don't be a
purist about it.

I'm not selling you anything but for the ad bucks I make on my YouTube, which
isn't much. Advice I give is because I only engage in work that feeds my soul
and makes me happy. I find joy in sharing that with you.

I'm not selling you anything but for the ad bucks I make on YouTube. Advice I
give here is because the work I do feeds my soul and I find joy in sharing that
with you.

Beware, this blog is not for you. It's every little thing I do. The content
here is not prepared, so turn back now and please be spared.

Wow, I need a way to insert a message at the top of my blog index page. That's
under my CMS system. Think!

Look on my macro what happens when I hit @p.

Ugh! Okay, I fixed it in the .py files but nbdev is no longer generating the
.py files from the Python Notebook. I'm going to have to be very careful to not
lose these updates.

<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/bring-pipulate-levinux-back-into-the-picture/">Bring Pipulate & Levinux Back Into The Picture</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/choosing-best-css-framework-for-github-pages-and-jekyll/">Choosing Best CSS Framework For Github Pages and Jekyll</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul></ul>
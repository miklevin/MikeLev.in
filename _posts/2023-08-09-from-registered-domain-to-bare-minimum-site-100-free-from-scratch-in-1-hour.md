---
date: 2023-08-09
title: From Registered Domain to Bare Minimum Site 100% Free & From Scratch in 1 Hour
headline: I Launched a Site 100% From Scratch and Free in Under an Hour!
description: Launch a website 100% from scratch and free in under an hour! Follow along as I create a site with a static site generator, setting up DNS records, creating a repo, and deploying a bare minimum HTML page. Learn how to use GitHub Pages to create a website and make it live.
keywords: Registered Domain, Bare Minimum Site, Free, Scratch, Launch, Marketed, Meme-fied, Source of Income, AI-automation, User Interface, Original Thought, New Ideas, AI, Uncompressible, Jekyll, Static Site Generator, Contrarian Methods, Static Site, Plain Text Files, MikeLev.in, MyKoz.AI, Funnel, Messaging, Optimized, Grow, Tribe, Domain Registrar, DNS, Apex Domain
categories: static site generator, jekyll, ai
permalink: /blog/from-registered-domain-to-bare-minimum-site-100-free-from-scratch-in-1-hour/
layout: post
group: blog
---


Alright, so let's tackle launching a site 100% from-scratch and launching it as
we go. Let's plan it out so that it will be marketed and meme-fied and blow up
into something big, and those joining now can follow along and watch it happen,
because I'm now dedicating myself to it and trying to make it a source of
income. I'm going to try to set it up so that I can make a living off of it. It
is my passion and it is subject-matter that should be of interest to a huge
audience, whether or not they know it yet. And so it is my job now to cross
that chasm and make it happen.

Each of these articles I make, I can make a video and podcast out of. This is
one of the places I can look to get the AI-automation advantage. I see no
reason why I should have to slow myself down now to actually produce the
videos or podcasts. I can just do the writing, and then later, I can go back
and produce the videos and podcasts in a way that is automated. That is like
the "user interface" part of the project, or the 20% of the project where you
spend 80% of the effort that you ***could*** put into it, and still have it
equally effective. 

So in principle, I'm outsourcing the part of every project that violates the
80/20-Rule. And that is user interface development and video editing, for sure!
Anyone can do that stuff. Busy worker-elves, if not AI. Those are commodity
things. But ***original thought*** and genuinely ***new ideas*** are not
commodity things. Because they break traditional patterns, AIs are not going to
be able to produce them from scratch, at least not too far off the mark of what
has gone before. Value is in such utter and complete newness that you surprise
and impress the audience, be it AI or human.

A great example of this is when an AI cowriting assistant fails to predict
anything next for you to type. Or everything that it is auto-completing for you
is completely off the mark and nothing like what you are saying. Sometimes it's
nice to yield to such assistance to take on a more "accessible" writing style
for the audience. But for the most part, our mind should be in a place that's
completely unfathomable to the AI. And that's where the value is. You can't be
compressed. All of your input that is not unique is just noise to an AI. You're
compressible, that's what you are. Be uncompressible.

So, let's launch a site from scratch. Let's use completely contrarian methods.
First, it's going to be a completely static site with no features. That means I
can use a static site generator (SSG) like Jekyll to produce the site from
plain text files like this one. This particular article will reside on my
MikeLev.in blog, but over time I will sieve or filter the best concepts, like
the mouth of the funnel, over to MyKoz.AI, really super-focusing and
super-concentrating the best messaging. It will be optimized for one purpose
and one purpose alone: to grow the MyKoz.AI "tribe".

An attempt to visit mykoz.ai today resolves to the parking page of my domain
registrar. We change that by logging into our registrar and pointing the DNS
records to the IP address of the [Github Pages
servers](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)
that will host our site. This effectively gives us free hosting. You can do
this with a free Github account these days because you can get private
repositories now, if you're not collaborating on those repos.

Me: Can you get private github repositories for free?

Bing: Yes, you can get private GitHub repositories for free. In fact, GitHub Free now includes unlimited private repositories. For the first time, developers can use GitHub for their private projects with up to three collaborators per repository for free². This was announced on January 7th, 2019².

Source: Conversation with Bing, 8/10/2023

    (1) New year, new GitHub: Announcing unlimited free private repos and .... https://github.blog/2019-01-07-new-year-new-github/.
    (2) Pricing · Plans for every developer · GitHub. https://github.com/pricing.
    (3) GitHub is free for teams - The GitHub Blog. https://github.blog/2020-04-14-github-is-now-free-for-teams/.
    (4) GitHub makes unlimited private repositories free for all - devm. https://devm.io/open-source/github-private-repos-171030.

Okay, good. I'm paying my $100/year or whatever "developer tax" to Github, so
I'm good to go. I can have private repos. But if I ever stopped paying, I can
still have private repos for free. That's good to know. Next?

We go into our domain registrar's website and find their DNS settings. For me,
its hitting a `Manage` button next to my domain list, then hitting a `Advanced
DNS` button, and then deleting the existing CNAME record that's making the
parking page appear. There was also an A record that caused attempts to visit
the ***apex domain*** (subdomain-less registered domain) to resolve to the
www version of the parking page. So I've deleted ALL of the DNS records for
this domain.

Next, we plug in the following A records, using the `@`
symbol for the Host field:

- 185.199.108.153
- 185.199.109.153
- 185.199.110.153
- 185.199.111.153

Depending on your registrar's setup, the changes may get committed and start
propagating as you go. By the time it's done, an attempt to visit your site
should no longer be going to the registrar's parking page, but rather to a 404
page on Github:

![Registrar DNS A Records Pointing To Github Pages](/assets/images/registrar-dns-a-records-pointing-to-github-pages.png)

Can you feel the power? So few steps and so much closeness to goal. All we need
now is a site to actually be there, haha! Well, for a system that uses the
Jekyll static site generator, what is the bare minim for a site to be there?
Well, this is a case where the bare minimum is actually ***more work*** than
just choosing a ready-made site template provided by Github Pages. But I hate
those templates. They're full of bloat that forces you down a bunch of rabbit
holes the moment you want to customize. None-the-less, we're going to start out
with them, because when you have a tool like this that's trying to make it easy
for you, first you lean into its strengths. ***Then*** you make sure you're not
becoming dependent on it.

So I open a Linux command-line Terminal which automatically drops me into my
`repos` folder, and I type `mkdir mysite` to create a folder for my site. I
already have a folder named mykoz for the MyKoz.AI project itself, and I don't
want a name like mykozsite because I don't want to have to type all of mykoz to
have command-line completion auto-suggest. I want it to auto-suggest after just
the `mys` part. Also, I'm not going to use a branch of the mykoz project
because switching branches is way more confusing than just having one folder
for the site and another folder for the project - easy mental model.

So next I `cd mysite` and `git init`. Now it's a git repo. There actually needs
to be a file there for it to push to github, so I type `touch foo.txt` and then
`git add foo.txt` and `git commit -m "First file"`. Next, I go to Github and
tell it to make a new repo there too. I give it the identical name `mysite`,
switch it to private and hit the `Create Repository` button. 

Now I copy these 3 lines and execute them locally in my Terminal:

```bash
git remote add origin git@github.com:miklevin/mysite.git
git branch -M main
git push -u origin main
```

Now for that repo, you go to the `Settings` tab and scroll down to the
`Pages` section. There you can choose a theme. You switch Branch from `None`
to `main` and then hit the `Save` button. The user interface will expand. Going
top-down, I put `mykoz.ai` in the `Custom domain` field. It tells me:

    www.mykoz.ai is improperly configured
    Domain's DNS record could not be retrieved. For more information, see documentation
    (InvalidDNSError).

...so I go back to my registrar and ad a new CNAME record for `www` pointing
to `mykoz.github.io`. I hit the `Save` button again. I tell it to check again.
The new message says:

    DNS check successful.

Then it starts a little process for provisioning the security certificate. It
only took a minute or two, and after a refresh I was able to check `Enforce
HTTPS`. 

Okay, it's deployed but no template is chosen. Also the system for choosing a
template has changed. It used to be right out there on the Github Pages
Settings page, but I can't find it. I'll take that as a sign to do bare
minimum publishing. Before I show Jekyll doing `index.md` to `index.html`, I'll
just drop an `index.html` file in there because you can do that too. That's the
simplest possible way to get instant results. So from the command line, I type:

```bash
git pull
git mv foo.txt index.html
echo "<html><head><title>mykoz</title></head><body>MyKoz.AI</body></html>" >> index.html
git commit -am "Bare minimum html page"
git push
```

And now I can watch the site being generated at https://github.com/miklevin/mysite/actions

And there it is. From registered domain to ***something*** all for free in
under an hour.

![Bare Minimum Html Site Launch Github Pages](/assets/images/bare-minimum-html-site-launch-github-pages.png)








<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/from-registered-domain-to-bare-minimum-site-100-free-from-scratch-in-1-hour/">From Registered Domain to Bare Minimum Site 100% Free & From Scratch in 1 Hour</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-bare-minimum-styles-css-file/">The Bare Minimum Styles CSS File</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/static-site-generator/'>Static Site Generator</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>
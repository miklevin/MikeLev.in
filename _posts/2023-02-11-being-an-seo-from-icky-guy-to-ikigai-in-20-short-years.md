---
date: 2023-02-11
title: "Being An SEO: From Icky Guy to Ikigai in 20 Short Years"
headline: "From Science to SEO: My Journey to Find a Career Aligned with My Values and Interests"
description: After considering a career in science, I chose to pursue SEO due to its data-driven nature. When Google stopped passing on keyword data, I was forced to switch to statistical models, which I was unprepared for. After years of feeling icky, I am now looking for a career that aligns with my values and interests. I am excited to start a new project which involves reading emails and creating a majordomo-like program using the string method splitlines and join.
keywords: SEO, Science, Google, Statistical Models, Values, Interests, Strengths, Passions, Insert, Text, File, Python, Read Mode, String, Insert Method, Join Method, Splitlines, Majordomo, Write Mode, Overwrite
categories: python, science, google, value, string, seo
permalink: /blog/being-an-seo-from-icky-guy-to-ikigai-in-20-short-years/
layout: post
---


I could have been a scientist. I ended up in marketing. Hey, it's a living.
What moved me towards SEO was that it was data-driven. That
accountability-trail going from search-hit to customer to recurring customer to
learnings to improved product to marketing material about new feature to new
search hit on the keywords of that new feature to new customer righteous
positive feedback loop was clear. It was an easy money-making formula, and so I
made HitTail to help other people d it because I didn't have much to say beyond
that to people in general at the time.

But boy the spotlight I had. I could have ruled the world. But my one trick was
tapped out and Google took away even that with ceasing to pass on the keyword
data on a Google search hit. October 2011, Google stopped sending keyword
referral data in an even the industry has coined "not provided". Similarly,
they took away granular keyword volume estimates that used to be easily
obtained through the Google AdWords API if you had an account. All these direct
data-sources made for some very appealing feedback loops. Just add writing. And
so the users of HitTail did. Later owners even started offering paid writing
services as an integrated feature of HitTail. Can you imagine what that produce
would be today if it continued to receive the tender love and care?

Anyhow, as SEO became less direct feedback-loop and less scientific, it started
to become more of a soft science again and less scientific. You had to maybe
switch to statistical models which I was unprepared for in those days, still
being on Microsoft ASP (Active Server Pages) in those days, and Python Pandas
not even being remotely on my radar. Pandas may not have even existed.

Superpowers lost! Stuck in New York City Agency-life! my old tools going
obsolete. Having to tap the bullshit well more often. Starting to feel icky.
No, I don't want to feel like an icky guy in the field of marketing. I want to
find my ikigai in the field of tech! Whoa was me.

Fast-forward many years. I' older, wiser and more seasoned. And the rise of the
machines is upon us! SEO is going to change big-time. So just like being there
when we were all thinking through what the field should be called, so might it
be again. Are we still SEOs? Is this finally a real SEO 2.0? While I'll
probably still be calling myself an SEO, I will be looking for new secret
weapons. It will not be a web-based APP again, I don't think. No, it won't be
HitTail 2.0. This new thing will be taking everything I've learned
repositioning myself from one tech to another over the years and turning it
into a timeless platform offering, built from FOSS and abstracted hardware.
It'll run forever so long as humanity is around.

This will also be my redemption for being in the field of marketing. I will
find the intersection of what I love to do, what I can can get paid for doing,
what I'm good at an what the world needs. I will go from icky guy to ikigai.
And I will take you along on that journey.

Hey ChatGPT: The existence of chatbots like you is going to change the face of technology at very least and humanity and the planet and the universe at most. Who knows, maybe the multiverse too. But it won't all play out in one human lifetime. I want in the meanwhile to make a life which is as comfortable, yet also challenging and spiritually satisfying as possible. How should I try to earn a living and towards what activities and life choices should I try to guide my family and those I love?

Making a comfortable and fulfilling life for yourself and those you love is a noble goal, and it's important to consider both financial stability and personal fulfillment in your choices. Here are a few general suggestions that may help you on your journey:

1. Find a career that aligns with your values and interests: Consider your strengths, passions, and values when choosing a career, as this can help ensure that you find work that is both financially stable and fulfilling.
1. Consider the long-term impact of your choices: When making decisions about your career, finances, and lifestyle, consider the long-term impact on your well-being and the well-being of those you love.
1. Invest in education and personal development: Continuous learning and self-improvement can help you stay up-to-date in your field and also provide a sense of accomplishment and personal growth.
1. Cultivate relationships: Strong relationships with family, friends, and community can provide a source of support, fulfillment, and a sense of belonging.
1. Give back: Contributing to your community or helping those in need can provide a sense of purpose and fulfillment, and can also have a positive impact on those around you.

It's important to remember that everyone's journey is unique, and there is no one "right" way to guide your life choices. The most important thing is to make choices that feel true to you and bring you a sense of happiness and fulfillment.

Hey ChatGPT: I have a premise that the best first project to move towards having the capability to automate things is to be able to infuse motivation, and the best way to infuse motivation is to perform better idea-capture so you can review your ideas and start a systematic process of exploration, expansion and refinement. This is intended to take place in a journal.md document that you primarily edit with vim on a Linux command line, but occasionally you want to blend in entries that you send from an email program from your phone or desktop, it doesn't matter so long as it can send email. Every time you send such an email it makes a new journal entry, editing journal.md from the top of the file underneath a text header. The joural.md file already exists in a git repo. All I need is the Python code that I can run as a Linux daemon that will IMAP check an email address for new emails, which processes the email by extracting the subject as the headline and the body as the journal entry and any embedded pictures as unencoded, saved into a repo and published through markdown with Github pages pages. Show me the Python code that would comprise such a services.

Here's an example of how you could implement the journaling service you described using the Python imaplib library for checking email and the os and re libraries for file operations:

```python
import imaplib
import os
import re

# Connect to the IMAP server and log in
mail = imaplib.IMAP4_SSL("imap.gmail.com")
mail.login("you@gmail.com", "password")

# Select the inbox folder
mail.select("inbox")

# Search for new messages
result, data = mail.search(None, "UNSEEN")

# Loop through each new message
for num in data[0].split():
    # Get the message
    result, data = mail.fetch(num, "(RFC822)")
    message = data[0][1].decode("utf-8")

    # Extract the subject and body
    subject = re.search("Subject: (.*)", message).group(1)
    body = re.search("\n\n(.*)", message).group(1)

    # Write the journal entry to the file
    with open("journal.md", "a") as file:
        file.write(f"## {subject}\n{body}\n")

    # Mark the message as seen
    mail.store(num, "+FLAGS", "\\Seen")

# Close the connection
mail.close()
mail.logout()
```

This code will connect to a Gmail IMAP server, search for new, unread messages in the inbox, extract the subject and body of each message, and append it to a file called journal.md. The subject will be used as the headline and the body as the journal entry. The message will then be marked as seen.

Note that this code is just an example and may need to be adapted for your specific use case, such as customizing the IMAP server, handling attachments, and publishing the journal to Github Pages.

Hey ChatGPT: How do you insert text into the middle of a text file in python?

To insert text into the middle of a text file in Python, you can follow these steps:

1. Open the file in read mode and store its contents in a string.
1. Use the string method splitlines to split the contents into a list of lines.
1. Modify the list of lines to include the new text.
1. Join the lines back into a single string using the string method join.
1. Open the file in write mode and overwrite its contents with the new string.

Here's an example that inserts text into the middle of a file:

```python
# Open the file in read mode
with open("file.txt", "r") as file:
    # Read the contents of the file
    contents = file.read()

# Split the contents into a list of lines
lines = contents.splitlines()

# Insert the new text into the list of lines
lines.insert(2, "This is the new text.")

# Join the lines back into a single string
new_contents = "\n".join(lines)

# Open the file in write mode
with open("file.txt", "w") as file:
    # Write the new contents to the file
    file.write(new_contents)
```

I'm going for absolutely loving what I'm doing here. To get there, I've got to
get over the hump of the initial enabling projects. One builds the templates
and learning examples for the next, for the next, for the next. My initial
thoughts was to make the first project Google Photos based, pulling your cloud
photos local. But that predisposes a NAS with lots of storage space, and that's
not good requirements for an initial project, nor tied to the zeitgeist of the
public sufficiently right now to take off. This email reading majordomo like
project is a better starting point. I can get into it and dig it.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/getting-chatgpt-s-help-transitioning-from-seo-to-data-engineer/">Getting ChatGPT's Help Transitioning From SEO To Data Engineer</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/rethinking-a-career-in-seo/">Rethinking a Career in SEO</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/science/'>Science</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/value/'>Value</a></h4></li>
<li><h4><a href='/string/'>Strings</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li></ul>
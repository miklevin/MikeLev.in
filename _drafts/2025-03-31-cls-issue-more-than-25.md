---
title: "CLS issue: more than 0.25 (desktop)"
permalink: /futureproof/cls-issue-more-than-%2E25/
description: 
layout: post
sort_order: 1
---

Have you heard of the CrUX Chrome UX Report? To get to the crux of the matter,
Google can see the performance of websites as reported back by the Chrome web
browser. You have likely opted into providing Google this information, as if you
were on the Comscore or Nielson Ratings opt-in marketing panel. But you don't
have to actually opt in. It's just on by default, reporting website usage
statistics to Google there quietly in the background. This is different from
Google Analytics (GA), Google Search Console (GSC) or any other tracking system.
This is because Google controls the Chrome web browser, plain and simple.

And this is how Google tracks Core Web Vitals (CWV) and puts the scores into
Google Search Console. So while it's reported in GSC, the data actually comes
from user statistics sent back to mama from the browser. These can go into
scoring your site for search. They don't want to deliver a bad user experience.
So if you score poorly in any of these 3 criteria the consider the most
important, it could be a negative search signal:

1. **Largest Contentful Paint (LCP)**: Measures loading performance by tracking
   how long it takes for the largest visible content element (e.g., an image or
   text block) to appear on the screen. A good LCP score is under 2.5
   seconds.

2. **First Input Delay (FID)**: Measures interactivity by calculating the time
   from a user's first interaction (e.g., clicking a button) to when the browser
   responds. A good FID score is less than 100 milliseconds.

3. **Cumulative Layout Shift (CLS)**: Measures visual stability by tracking
   unexpected layout shifts during page load. A good CLS score is less than
   0.1.

If you launch a website from scratch, you are not in this database yet. You can
get some benchmark data against your site with the developer tools built into
Chrome, but these are real-time tests against your site. It's not actually
representative of the data Google has been (or has not been) collecting about
your site. For that, you go to [CrUX Vis](https://cruxvis.withgoogle.com/). 

That's
because it's collected from actual user experience data. This is part of Google
owning Google Chrome. It's reporting performance statics about sites you visit
back to Google to keep the CrUX database up-to-date.

The upshot of this, is if you don't have an active site, you're not in the CrUX
database. Even though there's security issues with this and it plays into the
Google antitrust lawsuit, getting a newly launched site into the CrUX database
is a badge of honor. It's a sign that you've crossed a certain threshold and
your site is worth tracking.


Users must deliberately disable this setting if they do not want their data to
be included in CrUX reports. Additionally, users must opt into other
prerequisites, such as browsing history syncing without a passphrase, and be
logged into their Google account for their data to be collected. But if you meet
these criteria, you are likely contributing website usability data to Google.



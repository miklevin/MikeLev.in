---
date: 2023-01-09
title: Automating 2FA Web Login via Microsoft Playwright
headline: Solving My Authentication Problem with Microsoft Playwright and PyPi Authenticator
description: After researching options, I decided to create a service to check if I still had web-based authentication. I then found the PyPi Authenticator project which allowed me to automate 2FA from the command line. After a long day, I was able to get it working and move on to the next project. Come read my story to learn how I solved my authentication problem!
keywords: 2FA, Web Login, Microsoft Playwright, Authentication, PyPi Authenticator, YouTube Analytics, Automation, Command Line, Email, Service
categories: service, email, microsoft playwright, automation
permalink: /blog/automating-2fa-web-login-via-microsoft-playwright/
layout: post
---


For work, I'm torn currently between getting some difficult YouTube Analytics
analytics to work "on behalf of" other user versus just using a Web login that
gives me what I need. The Web login requires OAuth2 login for the browser as
opposed to OAuth2 under an API. Under the browser appears to be considerably
more fragile.

Hmmm, okay. So think it through systematically. Don't abandon the API-route
before it's time because it is likely more stable, especially holding its type
of authenticated login for the duration. And with API-based authentication,
there's the refresh token and re-authentication when the session expires.
Web-based authentication does not have that. It's the human.

This Microsoft page https://playwright.dev/python/docs/auth describes the
browser-based approach "cookie/token-based authentication". Exploration into
the other type of authentication reveals it's just old fashioned .htaccess HTTP
authentication per this page https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication
That's not going to help.

A few projects are dove-tailing. It's forcing my hand on a project that I have
long-deferred. It's having a service, which is basically just a long-running
looping script, check if it still has the web-based authentication and if not,
sending an email. You reply to the email with the number from Google
Authenticator pasted in and the service fetches the email and uses the number
in the time-window provided.

If email-shuttled Authenticator-app verification doesn't occur, the service
will try maybe once per hour (on the same loop as the check) send another
email. In fact it's not variable behavior at all. The whole purpose of this
loop is to check and if bad, wait... check and if bad, wait... and so on.

Hmmm, and I actually proposing that the 2FA take place directly on the server
in that tiny-window the Authenticator app provides? Email shuttling may not
provide enough time. Think!

Maybe email isn't fast enough.

Research 2FA automated solutions... https://pypi.org/project/pyotp/

Hmmm. Even better: https://pypi.org/project/authenticator/

Woah. Is 2FA from a server needing Playwright-controlled browser access a
solved problem with the most obvious project name it could have in PyPi?

I think the answer to this is yes. I need to work through the issues.

Wow, so this is going to become an automated 2FA automation tutorial article?
Maybe so. Just keep rolling with it and see where it takes you. That page gives
some very specific advice regarding getting the 2FA secret from a few years
ago. Let's see if it still works...

Wow, okay I got it working from the command-line. It prompts for a password and
the output streams until you CTRL+C and I want to automate it in a script.

...fast forward to end of a long day. I did it. The solution was PyPi
Authenticator. Wow, it took some finesse. There are race conditions to deal
with again. It's not as bad as it used to be with flaky web automation. But you
definitely do have to give URLs time to breath immediately after login.

It's time to zoom along to the next project.



## Categories

<ul>
<li><h4><a href='/service/'>Service</a></h4></li>
<li><h4><a href='/email/'>Email</a></h4></li>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li>
<li><h4><a href='/automation/'>Automation</a></h4></li></ul>
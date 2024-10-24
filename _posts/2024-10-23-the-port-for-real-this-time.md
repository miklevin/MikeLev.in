---
title: The Port For Real This Time
permalink: /the-port-for-real-this-time/
description: 
layout: post
sort_order: 1
---

## Hail Mary at Porting Apps Tonight

Ugh, it's weeks later and I still haven't ported the 2 key apps. But that's
okay. I do it tonight. I go late and long if I have to. And tomorrow, I have my
first client call that I'm managing myself in a long while. So I can do both
things without screwing up, right? Right!

## The Art of AI-Enabled Problem Solving Is Evolving Quickly

Everything becomes easier as you get more adept at AI-wrangling, right? It's
just like being an SEO or Webmaster before it. There are no hard and fast rules.
Some people might think so or try to tell you so, usually to make money off of
you some way or another, but all best are off. The deck is being reshuffled, but
thankfully some skills will shine through and serve you in any tech-enabled age.

## I've Found My Creative Spark Again Through Tiny Details of New Era

I've fallen back in love with those tiny details. I thought I might have been
burnt out, but I was challenged by my boss to to the best work of my life. And
with AI reshuffling everything the way it is, it's really when I'm at my best.
And I'm coming up from a rather deep dive on recalibrating the new reality and
aligning my skills just so, and tweaking my tool-set. 

The iron is hot and it's time to strike quickly, shaping and tempering the stuff
of a new generation into new tools and secret weapons for SEO. Just when I
thought I was out, they pull me back in! And happily, things are interesting
enough again to infuse another decade or so of love into it. So, let's hit it.

## Making Work a Show: Connecting Old and New Skills

Tomorrow, it's back to managing meetings and such, but I have to make it a show.
And the key to making it the magic show (with the substance behind it) that
makes it so enjoyable for me and everybody else, is to connect the dots of my
new work with my old job. Bring my new skills and new tools and new shows to
bear every day. Let the word and the wonder spread of this new thing, this way
Mike works that is just... just... well, words ***should*** fail.

## The Port Awaits a Fast and Eventful Few Hours Ahead

And that's why the port is going to be fun. I'm going to blast through it the
best and as fast as I can. We're talking a few hours, as opposed to the few
weeks it took me to get this far. 1, 2, 3... 1? ...is how it goes. That's the
language I use. I'm always on step #1, because you can't do anything more that
what's immediately before you. The now-moment is everything... and now... and
now... methinks App #1 in the app placeholder section is... set token!

I'm not going to make the same mistakes I made getting to this point, which is
leaving choices too open-ended for the AI. In the state they're in today, they
are only too anxious to lead you down deep, winding rabbit holes from which
there is no return&#151;at least not in the same night and not without
frustration and exhaustion. To keep frustration and exhaustion at bay by not
going rabbithole-diving, one must attach some rappelling rope at the top of the
abyss and be ready to pull yourself up at a moment's notice. And so we do that.

## Switching From ZeroMQ to WebSockets for Real-Time Communication

I have two code-bases. One was my first web app implementation under FastHTML,
and only barely at that. For interprocess communication, I used the still
amazing ZeroMQ, aka Zero-wait Message Queue, or just zmq for short. It was big
in the Python world and made it around to lots of other platforms for its
timeless inherent cross-domain value, like embedding RegEx or SQLite. However,
an alternative industry standard called WebSockets has really taken off, and
despite their different use-case sweet spots, one does not not use WebSockets
anymore. 

Everything that chats uses them, and it's that distinct real-time difference you
feel in ChatGPT, Perplexity, Anthropic and all the other chatty user interfaces
that are copying each other these days. While you could make things tighter with
zmq if it's all on the same physical hardware, why would you when you could be
learning what the world uses to write chat apps? So a big part of the porting
and refactoring is unwiring things from zmq and rewiring them to websockets.

## Using Small Databases for Smaller Applications Is Totally Adequate

The other major difference is the way database stuff works. Even calling it
database does it a disservice because it makes you think ***big*** stuff like a
SQL server of some sort like PostgreSQL, Redis or MySQL. Or a NoSQL database
like MongoDB or Cassandra. These things are built to support big enterprise
infrastructures. But sometimes you just want a database to replace browser
cookies. If you have total control of the server, why not just keep track of who
the user is client-side with a session-id and do all your database stuff on the
server in an extremely lightweight fashion with SQlite or even reading and
writing text files. 

## Using JSON Files for Text Persistence with a Library Approach

If you read and write textfiles, the best candidate is using a library that
treats it as a JSON data structure so that your library takes care of all the
API-work making you feel like it's not just a textfile. And so, that's what I
did to achieve a sort of cookie-like persistence on the server. I read from and
wrote to a JSON file on the drive. It's a great strategy if you're not using
FastHTML, which I am, which wraps SQLite in this nifty little MiniDataAPI spec
wrapper making it even easier than SQL. It's an interoperable API layer that
almost any database or database-like thing can be wired to, so you can swap out
the actual physical database mechanism without changing your code. And so
another part of this port is rewiring these bits from the JSON file to
FastHTML's MiniDataAPI.

And then finally, there's the details of the app itself, which involves...

- Getting the user to find and input their Botify API token
- Helping the user find a Botify Project URL (reminder to self: find a slicker
  way later)
- Present a list of Crawl Dates, which we call Analysis Slugs (analyze any
  interesting slugs lately)
- Using the user selections to perform several API-calls to Botify
- Allow a long-running task to occur, informing the user when it's done even if
  they surf away
- Allowing multiple of these long-running tasks to be performed at the same
  time.
- Automatically downloading the file produced as a result of these API calls and
  long-running jobs.
- Hosting a "secondary" web server that serves up these downloads "funneling"
  the request through the querystring API of another service.

Pshwew! This would all sound intimidating if it weren't actually already done.
And so to make it fun and interesting, it has to be as Pipulate/Botifyton-like
as possible. And that means lots of LLM help and fun.

- We need a home message. Set the stage for the magic.
- We need a 1-page-application that does it all (App 1 on the menu)
- We need a token acquisition experience.

## Creating a New App: Breaking Free from Conventional Wisdom

Okay, let's start there. The rest falls into place as the momentum gets rolling.
But I see that I don't want to feel constrained by keeping a main app template
intact and dancing around it frightened to break it and all that nonsense. I
want to go into it like a bull in a china shop and just slam this app out. And
that means... that means... that means I may be intentionally git branching for
the first time in my life. I hate branches and forks. I'm a linear non-linear
thinker Mr. Unicorn, so leave me alone. 

Okay... this looks like a job for... git cloning for starters. This thing works
out of whatever directory, so let's give it a strong new identity tied to the
app. All the automatic white-label rebranding tricks I designed into it will
kick in. That's how it starts out Pipulate and becomes Botifython. But now due
to the Link-graph nature of the work, it's going to be Botifymograph! It's a bit
long of a word, but hey, it'll help put this whole thing through the paces. A
stress-test, if you will.

Already, I hit a snafu. Because proprietary stuff outside the Pipulate main
codebase is going to be used here, I broke it off into a whole other GitHub
account and even disconnected the fork so that I could make it private. And as
such, I have multiple SSH keys to manage in my `~/.ssh/` folder, and I have to
actually distinguish between and use particular ones on particular actions,
which is about one of the most arcane and nonsensical APIs in existence. Doing
this is what AI's are made for.

---

# SSH Keys to Success

**Me**: I have a ~/.ssh folder with various key pairs that I use for different GitHub accounts. Normally, it defaults to using my main id_rsa key pair, but I need to do an ssh protocol git clone telling it to use a particular key. The repo is https://github.com/Botifython/botifython and the keys are named botifython_develop and botifython_develop.pub. All the permissions are already set up GitHub-side and botifython_develop.pub is registered as a full permission developer. How can I first, do the git clone in ssh mode to download it locally a folder named botifymograph? And second, how can I change it's main origin so that all subsequent git pulls and pushes use the right key and origin without requiring any special git command modifiers?

**Perplexity**: To accomplish your tasks, you'll need to follow these steps:

## 1. Git Clone with SSH Using a Specific Key

To clone the repository using SSH with a specific key, you can use the following command:

```bash
GIT_SSH_COMMAND='ssh -i ~/.ssh/botifython_develop' git clone git@github.com:Botifython/botifython.git botifymograph
```

This command does the following:
- Sets the `GIT_SSH_COMMAND` environment variable to use your specific key
- Clones the repository using the SSH URL
- Renames the local folder to "botifymograph"

## 2. Changing the Origin to Use the Right Key

After cloning, you can set up a custom SSH configuration to always use the correct key for this repository. Here's how:

1. Edit your SSH config file:

```bash
nano ~/.ssh/config
```

2. Add the following configuration:

```
Host github-botifython
    HostName github.com
    User git
    IdentityFile ~/.ssh/botifython_develop
```

3. Save and close the file.

4. Change the repository's origin URL:

```bash
cd botifymograph
git remote set-url origin git@github-botifython:Botifython/botifython.git
```

Now, all subsequent git operations (pull, push, etc.) will automatically use the correct key without requiring any special modifiers.

## Additional Notes

- Ensure that your `botifython_develop` private key has the correct permissions (typically 600).
- If you're using multiple GitHub accounts, this method allows you to manage them separately without conflicts.
- Always verify that you're using the correct key by testing with `ssh -T git@github-botifython`.

By following these steps, you'll have successfully cloned the repository and set it up to use the specific SSH key for all future operations.

---

Hmmm. The fancy schmancy `GIT_SSH_COMMAND=` version isn't working, and so...

**Me**: I have this entry in my ~/.ssh/config file:

```
# Secondary GitHub Account
Host bf
  HostName github.com
  User git
  IdentityFile ~/.ssh/botifython_develop
  IdentitiesOnly yes
```

...give me instructions based on that.

**Perplexity**: Based on the SSH configuration you provided, you can use the following instructions to clone the repository and set up the origin for future operations:

## Cloning the Repository

To clone the repository using the specified SSH key, use this command:

```bash
git clone bf:Botifython/botifython.git botifymograph
```

This command will:
- Use the SSH configuration for the host "bf"
- Clone the repository from GitHub
- Create a local folder named "botifymograph"

## Setting Up the Origin

After cloning, you don't need to change the origin URL because your SSH config is already set up correctly. The origin will automatically use the right key for all git operations. However, you can verify the remote URL with:

```bash
cd botifymograph
git remote -v
```

If for any reason you need to set or update the origin URL, use:

```bash
git remote set-url origin bf:Botifython/botifython.git
```

## Verifying the Setup

To ensure everything is working correctly:

1. Try pushing a test commit:

```bash
touch test.txt
git add test.txt
git commit -m "Test commit"
git push origin main
```

2. Or pull from the repository:

```bash
git pull origin main
```

These operations should now use the `botifython_develop` SSH key automatically without any additional parameters.

## Additional Notes

- Ensure the `botifython_develop` private key has the correct permissions (typically 600).
- If you're using multiple GitHub accounts, this method allows you to manage them separately without conflicts.
- You can test the SSH connection with: `ssh -T bf`

With this setup, all git operations for this repository will automatically use the correct SSH key, simplifying your workflow and eliminating the need for special command modifiers.

Citations:

    [1] https://locall.host/git-clone-with-a-specific-ssh-key/
    [2] https://support.circleci.com/hc/en-us/articles/21182136871835-How-to-use-a-Specific-SSH-Key-for-Git-Clone
    [3] https://www.baeldung.com/linux/ssh-private-key-git-command
    [4] https://ma.ttias.be/specify-a-specific-ssh-private-key-for-git-pull-git-clone/
    [5] https://stackoverflow.com/questions/4565700/how-to-specify-the-private-ssh-key-to-use-when-executing-shell-command-on-git/60530467
    [6] https://www.warp.dev/terminus/git-clone-ssh
    [7] https://graphite.dev/guides/git-clone-ssh-vs-https
    [8] https://ralphjsmit.com/git-custom-ssh-key

---

Oh yeah? Let's see...

```bash
[mike@nixos:~/repos]$ git clone bf:Botifython/botifython.git botifymograph
Cloning into 'botifymograph'...
remote: Enumerating objects: 712, done.
remote: Counting objects: 100% (329/329), done.
remote: Compressing objects: 100% (157/157), done.
remote: Total 712 (delta 233), reused 265 (delta 172), pack-reused 383 (from 1)
Receiving objects: 100% (712/712), 289.92 KiB | 7.83 MiB/s, done.
Resolving deltas: 100% (453/453), done.

[mike@nixos:~/repos]$ cd botifymograph/

[mike@nixos:~/repos/botifymograph]$ git remote -v
origin	bf:Botifython/botifython.git (fetch)
origin	bf:Botifython/botifython.git (push)

[mike@nixos:~/repos/botifymograph]$ git remote set-url origin bf:Botifython/botifython.git

[mike@nixos:~/repos/botifymograph]$ touch test.txt
git add test.txt
git commit -m "Test commit"
git push origin main
[main da88f96] Test commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test.txt
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 48 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 272 bytes | 272.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To bf:Botifython/botifython.git
   fb9ff2b..da88f96  main -> main

[mike@nixos:~/repos/botifymograph]$ git pull origin main
From bf:Botifython/botifython
 * branch            main       -> FETCH_HEAD
Already up to date.

[mike@nixos:~/repos/botifymograph]$
```

Well, I guess so! One hurdle overcome. And it's barely 8:30 PM. I've got the
whole night to go!

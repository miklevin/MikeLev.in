---
title: "Open Source SEO: My Journey to Codebase Consolidation"
permalink: /futureproof/open-source-seo/
description: I'm feeling great about finally unifying my little side projects, Botifython and Pipulate, into a single codebase under the Pipulate banner on GitHub. I've figured out a clever way to manage the app's name, defaulting to "Pipulate" but easily customizable based on the directory name or a simple `app_name.txt` file. This makes it flexible for my own variations and even allows others to rebrand it easily. Plus, I'm simplifying things by removing some proprietary dependencies, focusing on the core idea of lightweight SEO tools alongside enterprise solutions. It's exciting to bring Pipulate back into the public eye and start building real-world workflows with it!
layout: post
sort_order: 1
---

Alright, there are so many tiny little projects now that collectively will
finish and polish this project... okay, even though it's not the client work
(which I'll get to momentarily), I'm in a very good state of mind to unify the
disparate project names into one. It's time to make it one and only one codebase
again, unifying Botifython and Pipulate. 

First, I have to control the name of the app. The thing is going to default to
being called Pipulate, unless the folder it's in contains "botify" or there's a
file named `app_name.txt` in the directory, which `flake.nix` now writes out.
This makes the nix flake for this project deviate from my darwinix standard, but
it's inevitable and a good trade. This is the code that controls the messaging
during the `nix develop` stage, where people effectively "meet" the project.

```bash
# Create a fancy welcome message
if [ ! -f app_name.txt ]; then
  APP_NAME=$(basename "$PWD")
  if [[ "$APP_NAME" == *"botify"* ]]; then
    APP_NAME="$APP_NAME"
  else
    APP_NAME="Pipulate"
  fi
  echo "$APP_NAME" > app_name.txt
fi
APP_NAME=$(cat app_name.txt)
```

And now the Python app, now named the conventional `server.py` can do this to
know the app name.

```python
def get_app_name(force_app_name=None):
    name = force_app_name
    if not name:
        app_name_file = 'app_name.txt'
        if Path(app_name_file).exists():
            try:
                name = Path(app_name_file).read_text().strip()
            except:
                pass
        if not name:
            name = THIS_FILE.parent.name
            name = name[:-5] if name.endswith('-main') else name
    return name.capitalize()


APP_NAME = get_app_name()
```

The logic now is that I can make all sorts of Botify variations by just renaming
the directory. It automatically capitalizes, so: Botifython, Botifymo,
Botifynix, etc. I can make it a funny ongoing thing by just changing the
directory name knowing it will use it. Or I can just change the name in
`app_name.txt` because once that gets created, that overrides everything except
for the `force_app_name` parameter override in the Python code.

If "botify" does not appear in the repo name on the first `nix develop` then
`app_name.txt` gets written out with **Pipulate** in it, making that the
default. But if people don't like it, they can change the contents of
`app_name.txt` and it will use that. Subsequent `nix develop` commands will not
overwrite it, but it can always be deleted and recreated. Okay, this is a good
system that satisfies my needs at work, the FOSS project branding needs, and
individuals wanting to relabel open source SEO software as their own. Good!

That's huge towards codebase reunification. Also, I took out this "magic cookie"
stuff I had to retrieve from a private repo. The proprietary stuff that uses
Botify just won't work if you don't have a Botify API key in location. The
Botify API is publicly documented, anyway. It actually helps make the point
about lightweight local SEO software vs. industrial enterprise SaaS SEO. That's
an idea I'll have to develop a lot. It's part of the show in front of the
clients. Doing stuff the lightweight way to flesh out one picture of things, and
then tapping the enterprise SEO product for only things a Botify customer can
do.

Solid. Alright. Time is precious. Avoid rabbit holes. But do go ahead and unify
the code bases back into the Pipulate side of the house. Let people see this
start to come alive under GitHub. It's the pulling back of the curtains, such as
it were. Specifically, the GitHub README.md is going to be a dramatic change.

These are the things I do to move all the new files I did behind closed doors to
the public pipulate repo whose folder sits side-by-side with the one I'm working
in.

```bash
cp .cursorignore ../pipulate/
cp .cursorrules ../pipulate/
cp README.md ../pipulate/
cp favicon.ico ../pipulate/
cp flake.nix ../pipulate/
cp pyproject.toml ../pipulate/
cp requirements.txt ../pipulate/
cp server.py ../pipulate/
cp sizeit.py ../pipulate/
cp -r static ../pipulate/
cp -r training ../pipulate/
cp -r workflows ../pipulate/
```

Okay, the pipulate repo is set up to become my new main working directory. This
effectively amounts to a re-basing of the code. It's going to be quite a
dramatic change in the pipulate's project history in the git repo, haha! But I'm
keeping it intact and in the main branch. Now to clean up remnants of its past
nix flake and turn it into the latest work...

```bash
cd ../pipulate
rm -rf .venv  # Surprisingly critical step
rm flake.lock
nix flake update
nix develop
python server.py
```

Excellent! It built perfectly. And even though I'm working out of a repo folder
named pipulate now, which wall also be tied to my main public pipulate repo on
my GitHub account, I can still change its identity to Botifython, and not even
with the directory renaming trick.

```bash
exit
echo botifython > app_name.txt
nix develop
python server.py
```

Momentarily, I thought I might strip out looking for "botify" in the folder name
when `app_name.txt` is written as it seemed redundant to have that check on
setting the default value in there if you can overwrite it anyway like I just
did, but then I realized I'd be giving cloning commands to my coworkers to do
this trick, and this way I can have them do any clone command like this knowing
it will take on that name as the app, haha!

```bash
git glone git@github.com:miklevin/pipulate botifybot
```

Okay, welcome back Pipulate!

As much as it's pulling time away from other things, you also took a very large
step for commitment and consistency, coming out publicly again with Pipulate,
more than just the articles you write here.

You got the snowball rolling, such as it were. Ideas are easy. Implementation is
hard. Consistency is harder.

Taking it out from behind the curtains of private repos, and casting aside the
fear of keeping things proprietary, I can now plant my flag. And because it's
out there, and because the templates are so far along, I can begin making
workflows that actually are real day-to-day tasks.

- One workflow to be the overarching story with every client
- A number of workflows to produce individual deliverables

---

## An AI's Take

Alright, let's dive into this!

[Moved to top]

Here are some ideas for titles and headlines:

**Titles:**

1. Unifying My Code: The Return of Pipulate
2. Botifython & Pipulate: One Codebase at Last!
3. Open Source SEO: My Journey to Codebase Consolidation
4. Pipulate Reborn: A New Chapter for My Project
5. Simplifying Development: Merging Botifython and Pipulate

**Headlines:**

1. Finally! Botifython and Pipulate Become One
2. Say Goodbye to Separate Projects: Pipulate Takes Center Stage
3. My Open Source SEO Software Gets a Major Overhaul
4. The Curtains Rise: Pipulate's Public Comeback
5. Codebase Clarity: Unifying My Development Workflow

Okay, now for my opinion as Brainstormer:

I think this article provides a really insightful look into the often messy but ultimately rewarding process of software development and project management. The author's enthusiasm for streamlining their work and making their project more accessible is contagious. The clever solution for naming the application shows a practical and forward-thinking approach. It's also interesting to see the strategic decision behind separating the lightweight, open-source aspects from the enterprise-level features. Overall, it feels like a significant step forward for the author's project and a testament to the dedication required to bring creative ideas to life.

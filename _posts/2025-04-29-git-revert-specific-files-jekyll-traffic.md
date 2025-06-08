---
title: "Pinpointing and Rolling Back Specific Files with Git: A Jekyll Case Study"
permalink: /futureproof/git-revert-specific-files-jekyll-traffic/
description: My website's traffic plummeted after I implemented a new JavaScript-based Table of Contents (TocBot) by modifying key Jekyll template files (`default.html`, `post.html`, `styles.css`, `index.md`). Suspecting these changes were the culprit, but not wanting to lose the blog posts I'd written since, I used specific `git diff` commands to identify newly added and modified files compared to a known good commit. Then, employing `git mv` and `git checkout <hash> -- <file>`, I effectively reverted only the problematic template and CSS files on my main branch back to their older state, while renaming and keeping the newer versions alongside them for future analysis, successfully restoring the site's structure without deleting my recent articles.
meta_description: How to revert specific Jekyll template files (like _layouts/default.html, _posts.html, CSS) to an older commit using git checkout <hash> -- <file> and git mv to fix issues like traffic drops without losing newer content or Git history.
meta_keywords: git, revert, checkout, specific files, particular file, restore file, old commit, commit hash, jekyll, template, layout, default.html, post.html, styles.css, index.md, css, traffic drop, seo issue, website performance, git mv, rename file git, preserve history, selective rollback, version control, git diff, compare commits, diff-filter, list added files, list modified files, TocBot, javascript, github pages, ssg, static site generator, site search, jekyll include error, git push, branch, remote branch, set-upstream, troubleshooting, debug
layout: post
sort_order: 1
---

## Understanding Git for Website Recovery: A Practical Example**

This article delves into a common challenge faced by website owners and developers: troubleshooting unexpected negative impacts after making changes. Specifically, it focuses on a website built using Jekyll, a popular tool for creating static websites (sites made of pre-built HTML files), often used for blogs hosted on platforms like GitHub Pages. When website performance, like visitor traffic, suddenly decreases after updates, pinpointing the exact cause and fixing it without losing valuable new content can be tricky.

The author uses Git, a powerful version control system essential in modern software development, to manage their website's code. Git allows developers to track every change made to files over time, create experimental branches, and crucially, revert files back to earlier versions. This piece showcases a real-world scenario where specific Git commands are used strategically to undo problematic changes to website template files while carefully preserving newly added content (like blog posts) created since those changes were made. It highlights how Git can be a lifesaver for managing website updates and recovering from issues.

---

## Identifying the Traffic Drop Source

The performance of my website continues to be tanked, and I can pinpoint it to
the day, which means I can pinpoint it to a github repo push. It's a Jekyll SSG
site featuring a blog for GitHub Pages, which means it follows the standard file
layout conventions with the `_layout`, `_posts` and other conventional
directories with templates in `_layouts` and blog posts in `_posts`.

## Pinpointing the Template Changes

Now I am pretty sure I tanked my traffic due to changes in `_layouts/post.html`
and `_layouts/default.html` which I plan on reverting experimentally to a
pre-traffic-loss state. I added a nifty Table of Contents to every blog post on
my site using the popular client-side JavaScript TocBot library, but it required
quite a major reworking of my site's templates.

## Weighing User Experience vs. Traffic Impact

I really enjoyed that rework and think it's an improved user experience, however
it's not worth the tradeoff in traffic. And a straight out reversion of the repo
to that older state will lose the articles that I've written and put in `_posts`
since then. And so, it's time to think through strategies.

## Planning the Branch Strategy

It's the main branch of the git repo that gets published, so I can take the
current work in main and shuffle it off for safety with:

**Me**: I have a git repo and I want to do some radical experimentation and keep the main branch and new branch all safe remotely on GitHub, where the repo currently is hosted. To make the new branch from main, I believe it is:

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ git checkout -b toclayout
Switched to a new branch 'toclayout'
```

But then how to I make sure it's also a branch in the repo on GitHub?

**Gemini**: Okay, you've correctly created the new local branch named `toclayout` and switched to it.

To make this new branch exist on your remote repository on GitHub, you need to **push** it. Since this is the first time you're pushing this specific branch, you should also tell Git to link your local branch with the new remote branch.

The command to do this is:

```bash
git push --set-upstream origin toclayout
```

Or the shorter version:

```bash
git push -u origin toclayout
```

Here's a breakdown of the command:

1.  `git push`: This is the fundamental command used to upload local repository content to a remote repository.
2.  `--set-upstream` (or `-u`): This flag does two things:
    * It pushes the branch to the remote repository (`origin`).
    * It sets up a "tracking relationship" between your local `toclayout` branch and the newly created `toclayout` branch on the `origin` remote. This means that in the future, when you are on the `toclayout` branch, you can simply run `git push` or `git pull` without specifying `origin toclayout` again, as Git will know where to push to and pull from for this branch.
3.  `origin`: This is the default short name for your remote repository (the one on GitHub, typically). You can check your remote names with `git remote -v`.
4.  `toclayout`: This is the name of the local branch you want to push. By default, it will create a branch with the same name on the remote repository.

After running this command, you will see output indicating the push was successful, and you should be able to see the new `toclayout` branch listed in your repository on the GitHub website.

Now, both your `main` branch and your new `toclayout` branch exist locally *and* remotely on GitHub, safely stored and independent of each other. You can continue your radical experimentation on the `toclayout` branch.

---

## Creating Git Branch As Safety Net

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ git push --set-upstream origin toclayout
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
remote: 
remote: Create a pull request for 'toclayout' on GitHub by visiting:
remote:      https://github.com/miklevin/MikeLev.in/pull/new/toclayout
remote: 
To github.com:miklevin/MikeLev.in
 * [new branch]          toclayout -> toclayout
branch 'toclayout' set up to track 'origin/toclayout'.

[mike@nixos:~/repos/MikeLev.in/_posts]$ git push -u origin toclayout
branch 'toclayout' set up to track 'origin/toclayout'.
Everything up-to-date

[mike@nixos:~/repos/MikeLev.in/_posts]$ git checkout main
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
```

**Me**: Okay, so now I have a remote branch that has backed up the current state
of my site. It would be easy now to do a `git reset --hard [hash]` to the hash
of the last known state that worked well in search, but I actually want to have
on-hand the new files to layer back in. But to do that I want to make sure I
very meticulously get a list of the files that are in the new state of the repo
that were no tin the old state of the repo. Given that I've switched back to
`main`, how do I compare the file contents of the new version of the repo versus
an older version given their known hashes? I only want the list of the new files
added that are present in the new version that are not present in the old.

**Gemini**: Okay, you've successfully pushed the `toclayout` branch to GitHub and switched back to `main`.

To get a list of files that were *added* in the `toclayout` branch compared to an older commit, you can use the `git diff` command with specific flags.

Assuming you know the commit hash of the "last known state that worked well" (let's call it `<old_commit_hash>`), the command you need is:

```bash
git diff --name-only --diff-filter=A <old_commit_hash> toclayout
```

Here's the breakdown:

1.  `git diff`: The command used to show differences between commits, branches, files, etc.
2.  `--name-only`: This flag tells `git diff` to output *only* the filenames of the files that have changed, rather than the full content differences (the "diff" itself).
3.  `--diff-filter=A`: This is the crucial part for your specific request. It filters the list of changed files to show *only* those that were **A**dded in the second commit/branch (`toclayout`) compared to the first (`<old_commit_hash>`).
    * Other common filters include `M` (Modified), `D` (Deleted), `R` (Renamed), `C` (Copied). You only need `A` here.
4.  `<old_commit_hash>`: **Replace this** with the actual commit hash (e.g., `a1b2c3d4`) of the older state you want to compare against. You can find this using `git log`, `git log --oneline`, or by Browse the history on GitHub.
5.  `toclayout`: This specifies the newer state you want to compare. Git will use the latest commit on the `toclayout` branch for the comparison.

**How to use it:**

1.  Find the exact commit hash for the older state you care about (e.g., using `git log` or GitHub).
2.  Run the command, replacing `<old_commit_hash>` with that hash. For example, if the old hash is `f3a9e1c2`:
    ```bash
    git diff --name-only --diff-filter=A f3a9e1c2 toclayout
    ```
3.  The output will be a list of file paths, one per line, representing only the files that exist in `toclayout` but did *not* exist in the commit `f3a9e1c2`.

This command works perfectly even though you are currently checked out on the `main` branch, as you are explicitly telling `git diff` which two points in history to compare.

---

## Finding New Files Added With Git

> This is using the above Gemini git advice to list new files added between two
> git hashes. I guess it assumes the branch/head where it only shows the
> `toclayout` branch name at the end. 

```bash
[mike@nixos:~/repos/MikeLev.in]$ git diff --name-only --diff-filter=A 84f30bb01e65b268d262159d27a42886b6d09768 toclayout
_posts/2025-04-21-bing-search-api.md
_posts/2025-04-21-fasthtml-anywidget-host.md
_posts/2025-04-21-generate-cursor-rules.md
_posts/2025-04-21-regex-google-docs-markdown.md
_posts/2025-04-22-cursor-ai-updates-nixos.md
_posts/2025-04-22-optimizing-jekyll-rendering.md
_posts/2025-04-22-python-rich-widgets-fasthtml-htmx.md
_posts/2025-04-23-digital-independence-solarpunk-future-visions-self-hosting.md
_posts/2025-04-23-pfsense-firewall-secure-home-network-hosting-setup.md
_posts/2025-04-23-vim-regex-google-docs-markdown-cleanup.md
_posts/2025-04-24-jekyll-front-matter-seo-social-metadata-guide.md
_posts/2025-04-24-modern-interactive-toc-tocbot-guide.md
_posts/2025-04-25-ai-code-assist-seo-traffic-drop-cls-fix.md
_posts/2025-04-26-fasthtml-htmx-javascript-rendering.md
_posts/2025-04-26-htmx-widgets-ai-implementation.md
_posts/2025-04-26-llm-architecture-ai-collaboration-coding-workflows.md
_posts/2025-04-27-integrating-prismjs-pandas-html-table-widgets.md
_posts/2025-04-27-local-javascript-download-script.md
_posts/2025-04-27-refining-pipulate-widgets-ux-ai-collaboration.md
_posts/prompt.md
assets/js/header.js
images/hamster-big.gif
images/tanked-traffic-with-ai-code-assistance.png
insights.md

[mike@nixos:~/repos/MikeLev.in]$
```

---

Alright, this is excellent! This gives me a list of the new files that I've
added. But I've done a lot of work on my default.html, post.html,
`assets/css/styles.css` and others. Can you give me a similar command to show me
the files that I have changed since that git hash?

**Gemini**: Okay, absolutely! You can get the list of *modified* files between that same old commit and your `toclayout` branch using a very similar `git diff` command, just by changing the `--diff-filter` value.

To see only the files that were **M**odified, use this command:

```bash
git diff --name-only --diff-filter=M 84f30bb01e65b268d262159d27a42886b6d09768 toclayout
```

Here's the breakdown again, highlighting the change:

1.  `git diff`: The comparison command.
2.  `--name-only`: Show only filenames.
3.  `--diff-filter=M`: This time, filter the list to show only files whose status is **M**odified between the old commit (`84f30bb...`) and the `toclayout` branch tip.
4.  `84f30bb01e65b268d262159d27a42886b6d09768`: The hash of your older commit.
5.  `toclayout`: The branch representing the newer state.

When you run this, the output will be a list of file paths for files like your `default.html`, `post.html`, `assets/css/styles.css`, etc., that existed in the old commit (`84f30bb...`) but have different content in the current `toclayout` branch.

Just like before, running this from your `main` branch is perfectly fine.

---

## Double Checking Which Files Have Changed

> My strategy of starting with the newest git repot state and then pulling old
> templates "forward in time" leaves the new state of the site in place, so I
> don't have to worry too much about new files. Nonetheless, I want to know what
> other files I've added that I'm giving safe harbor. It's an FYI.

```bash
[mike@nixos:~/repos/MikeLev.in]$ git diff --name-only --diff-filter=M 84f30bb01e65b268d262159d27a42886b6d09768 toclayout
.gitignore
_config.yml
_data/gsc_top_keywords.json
_includes/roadmap-gantt.html
_layouts/default.html
_layouts/post.html
_posts/2025-03-12-real-time-ai-research.md
_posts/2025-03-15-web-app-fasthtml-htmx.md
_posts/2025-03-25-python-plugin-architectures.md
_posts/2025-04-17-git-without-server-local-filesystem.md
_posts/2025-04-17-github-pages-logfiles.md
_posts/2025-04-17-ime-mse-psp-tee-sep.md
_posts/2025-04-18-ai-prompts-xml-tags.md
_posts/2025-04-18-bridging-code-and-context.md
_posts/2025-04-18-nixos-failed-to-install-bootloader.md
_posts/2025-04-18-super-intelligent-ai-coding-assistance.md
_posts/2025-04-19-detecting-nix-shell-environments.md
_posts/2025-04-19-export-botify-csv-api.md
_posts/2025-04-20-file-polling-progress-indicator.md
_posts/2025-04-20-widgets-in-workflows.md
assets/css/styles.css
flake.lock
flake.nix
images/hamster.gif
index.md
pipulate.md
```

---

**Me**: Wow, this level of precision is pretty stunning. It's always been there
in git, but the thing is git is difficult. It all makes sense, but it's just
that there's so much to remember and using git is one of those sweet spots with
LLMs the same way RegEx is! The same can be said for the whole Unix/Linux
command-line, and if you can articulate it in English, there's a pretty good
chance an LLM can tell you how to do it in git.

Okay Gemini, here's my deal. All my work on:

- `_layouts/default.html`
- `_layouts/post.html`
- `assets/css/styles.css`
- `index.md`

...tanked my site traffic. Now admittedly I have added a ton of articles too so
overloading my homepage with a long list of links is a potential culprit too,
but I don't want to roll back my articles. In fact, I'll be adding new ones
including this one I'm working on about git skills and blending old commit
states back into new ones. But I do want the ability to essentially toggle
between my old set of `default.html`, `post.html`, `styles.css` and `index.md`
versus the new. I don't want to lose my new work nor make it excessively
inaccessible requiring further git manipulations. Rather, I want the old and the
new files present in the new repo. I am open to different possibilities, but the
most likely is keeping each from the current version in-location but with a
rename:

- `_layouts/default-new.html`
- `_layouts/post-new.html`
- `assets/css/styles-new.css`
- `index-new.md`

...and then I want to retrieve the older versions of each of those files out of
84f30bb01e65b268d262159d27a42886b6d09768, therefore "reverting" much of my site
to the older templates while keeping all the new articles in place.

I guess my questions is how do I best accomplish this? Probably with `git mv` on
the current repo to keep repo continuity. But then how do I "pluck" those older
versions and put them in location? I guess in my older days before LLMs, I would
probably have git cloned in a side-by-side repo, done a `git reset --hard` to
the hash, then copied the files over. But now given that you pretty much know
the totality of the situation, please recommend what you think is the best
approach.

## Gemini Runs Down Classic Git Scenario

> We are in a git repo where many things are right but a few particular
> file-based things are wrong. We can pull forward those particular files from
> the past into the present state of the repo. This is apparently a classic
> git thing to do.

**Gemini**: Okay, this is a classic Git scenario, and you're right, LLMs can definitely help navigate the complexities! Your thinking is spot on: you need to revert specific files on `main` to an older state (`84f30bb...`) while preserving all other changes (new posts, etc.) made since then. You also want to keep the *current* versions of the reverted files handy.

Your proposed strategy of renaming the current files and then restoring the old ones is excellent and exactly what I would recommend. Using `git mv` for the rename is also the correct approach as it explicitly tells Git about the move/rename, preserving history better than a simple OS `mv` followed by `git add`/`git rm`. The `git checkout <commit> -- <pathspec>` command is the perfect tool to "pluck" specific files from an old commit without disrupting the rest of your history or working directory.

Here is the step-by-step plan using Git commands, assuming you are currently on the `main` branch (run `git checkout main` if not):

**1. Rename the Current Files (Using `git mv`)**

This stages the rename operations, preserving the history link between the old and new filenames.

```bash
# Ensure you are on the main branch
git checkout main

# Rename the files you want to replace
git mv _layouts/default.html _layouts/default-new.html
git mv _layouts/post.html _layouts/post-new.html
git mv assets/css/styles.css assets/css/styles-new.css
git mv index.md index-new.md
```

**2. Restore the Old Versions (Using `git checkout <hash> -- <file>`)**

This command reaches back into the specified commit (`84f30bb...`) and pulls out *only* the listed files as they existed then, placing them into your working directory and staging them. It does *not* change your current branch or affect any other files.

```bash
git checkout 84f30bb01e65b268d262159d27a42886b6d09768 -- _layouts/default.html
git checkout 84f30bb01e65b268d262159d27a42886b6d09768 -- _layouts/post.html
git checkout 84f30bb01e65b268d262159d27a42886b6d09768 -- assets/css/styles.css
git checkout 84f30bb01e65b268d262159d27a42886b6d09768 -- index.md
```

**3. Review and Commit the Changes**

Check the status to see what Git is about to commit. You should see the renamed files and the restored files staged for commit.

```bash
git status
```

You should see something like:

```
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    _layouts/default.html -> _layouts/default-new.html
        modified:   _layouts/default.html  # This is the restored version
        renamed:    _layouts/post.html -> _layouts/post-new.html
        modified:   _layouts/post.html     # This is the restored version
        renamed:    assets/css/styles.css -> assets/css/styles-new.css
        modified:   assets/css/styles.css  # This is the restored version
        renamed:    index.md -> index-new.md
        modified:   index.md               # This is the restored version
```
*(Note: The `modified` status on the restored files indicates their content now differs from the version at the previous HEAD, which is exactly what you want)*

Now, commit these changes with a clear message:

```bash
git commit -m "Revert layout/CSS/index to pre-TocBot state (84f30bb)" -m "Preserved current TocBot versions with '-new' suffix for comparison. Kept all new posts and other changes."
```
*(Using `-m` twice creates a subject and body for the commit message)*

**4. Push the Changes (Optional, but Recommended)**

Since `main` is your published branch, push the changes to your remote repository on GitHub.

```bash
git push origin main
```

**Why this approach is best:**

* **Precision:** You only touch the files you intend to change. All your new posts and other modifications remain untouched.
* **Keeps Both Versions:** Your current ("new") templates are safely renamed and still tracked by Git, right alongside the restored older versions. You can easily compare them (`git diff _layouts/default.html _layouts/default-new.html`) or switch back later if needed.
* **Clean History:** You avoid `git reset --hard` which rewrites history and loses work. You also avoid potentially complex `git revert` commands. This approach creates a clear, single commit that achieves the desired state.
* **Uses Git's Strengths:** Leverages `git mv` for tracking renames and `git checkout <commit> -- <path>` for targeted file restoration.

This strategy directly addresses your requirements and is much cleaner and safer than the old side-by-side clone method. You get the exact state you want on `main` while preserving both the new content and the work you did on the newer templates.

---

## And So I Do

> It's amazing how little I really know about git. You can `checkout` precise
> files against a hash from the past and pull them into the currently checked
> out branch/commit. It's amazing how many sci-fi time-travel tropes are in git.

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ # Ensure you are on the main branch
git checkout main

# Rename the files you want to replace
git mv _layouts/default.html _layouts/default-new.html
git mv _layouts/post.html _layouts/post-new.html
git mv assets/css/styles.css assets/css/styles-new.css
git mv index.md index-new.md^C

[mike@nixos:~/repos/MikeLev.in/_posts]$ ^C

[mike@nixos:~/repos/MikeLev.in/_posts]$ cd ..

[mike@nixos:~/repos/MikeLev.in]$ # Ensure you are on the main branch
git checkout main

# Rename the files you want to replace
git mv _layouts/default.html _layouts/default-new.html
git mv _layouts/post.html _layouts/post-new.html
git mv assets/css/styles.css assets/css/styles-new.css
git mv index.md index-new.md
Already on 'main'
Your branch is up to date with 'origin/main'.

[mike@nixos:~/repos/MikeLev.in]$ git checkout 84f30bb01e65b268d262159d27a42886b6d09768 -- _layouts/default.html
git checkout 84f30bb01e65b268d262159d27a42886b6d09768 -- _layouts/post.html
git checkout 84f30bb01e65b268d262159d27a42886b6d09768 -- assets/css/styles.css
git checkout 84f30bb01e65b268d262159d27a42886b6d09768 -- index.md

[mike@nixos:~/repos/MikeLev.in]$ git status
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   _layouts/default-new.html
	modified:   _layouts/default.html
	new file:   _layouts/post-new.html
	modified:   _layouts/post.html
	new file:   assets/css/styles-new.css
	modified:   assets/css/styles.css
	new file:   index-new.md
	modified:   index.md


[mike@nixos:~/repos/MikeLev.in]$ git commit -m "Revert layout/CSS/index to pre-TocBot state (84f30bb)" -m "Preserved current TocBot versions with '-new' suffix for comparison. Kept all new posts and other changes."
[main 95bf69f6b] Revert layout/CSS/index to pre-TocBot state (84f30bb)
 8 files changed, 2467 insertions(+), 608 deletions(-)
 create mode 100644 _layouts/default-new.html
 create mode 100644 _layouts/post-new.html
 create mode 100644 assets/css/styles-new.css
 create mode 100644 index-new.md

[mike@nixos:~/repos/MikeLev.in]$ git push
```

I got the Jekyll warning:

```
  Rendering Markup: _posts/2024-09-08-Future-proofing.md/#excerpt
  Liquid Exception: Could not locate the included file 'site-search.html' in any of ["/home/mike/repos/MikeLev.in/_includes", "/home/mike/repos/MikeLev.in/.gem/ruby/3.3.0/gems/jekyll-theme-primer-0.6.0/_includes"]. Ensure it exists in one of those directories and is not a symlink as those are not allowed in safe mode. in /_layouts/default.html
             Error: Could not locate the included file 'site-search.html' in any of ["/home/mike/repos/MikeLev.in/_includes", "/home/mike/repos/MikeLev.in/.gem/ruby/3.3.0/gems/jekyll-theme-primer-0.6.0/_includes"]. Ensure it exists in one of those directories and is not a symlink as those are not allowed in safe mode.
             Error: Run jekyll build --trace for more information.
```

...and so:

```bash
[mike@nixos:~/repos/MikeLev.in]$ git checkout 84f30bb01e65b268d262159d27a42886b6d09768 -- _includes/site-search.html

[mike@nixos:~/repos/MikeLev.in]$ git status
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   _includes/site-search.html

[mike@nixos:~/repos/MikeLev.in]$ git commit -am "Added site search back in"
[main 3bf14e0dd] Added site search back in
 1 file changed, 303 insertions(+)
 create mode 100644 _includes/site-search.html

[mike@nixos:~/repos/MikeLev.in]$ git push
```

...and my Jekyll rendering warnings go away, and my whole site is being reverted
template-wise but not article-wise.

## Maybe Even Older Templates?

**Me**: Alright now as a final bonus, there is a chance I may need to "travel
back in time" to even older versions of those four files using a different git
hash. Can you give me a command where I can just re-run it with a different git
hash to swap the older files in for those four?

**Gemini**: Okay, you want a straightforward way to swap the *current* versions of those four key files (`_layouts/default.html`, `_layouts/post.html`, `assets/css/styles.css`, `index.md`) with the versions found in *any* specific past commit, essentially allowing you to easily "time travel" for just those files.

The command you previously used to restore files is perfect for this. You can simply re-run it, substituting a different commit hash each time.

**The Re-runnable Command:**

```bash
git checkout <commit_hash_to_restore_from> -- _layouts/default.html _layouts/post.html assets/css/styles.css index.md
```

**How to Use It:**

1.  **Ensure you are on the `main` branch:**
    ```bash
    git checkout main
    ```
2.  **Find the hash:** Identify the commit hash (e.g., `a1b2c3d4` or `84f30bb0`, etc.) that contains the versions of the four files you want to restore.
3.  **Run the command:** Replace `<commit_hash_to_restore_from>` with the actual hash you found. For example, to restore from commit `a1b2c3d4`:
    ```bash
    git checkout a1b2c3d4 -- _layouts/default.html _layouts/post.html assets/css/styles.css index.md
    ```
4.  **Review the changes:** The command will overwrite the versions of these four files currently in your working directory and staging area with the versions from commit `a1b2c3d4`. Check the result:
    ```bash
    git status
    git diff --staged  # Optional: See the content changes being staged
    ```
    You should see the four files listed as `modified` and staged.
5.  **Commit the change:** If you're happy with the restored versions, commit them:
    ```bash
    git commit -m "Revert layout/CSS/index to state from commit a1b2c3d4"
    ```
6.  **Push (Optional):** If you want this change reflected on your remote/published site:
    ```bash
    git push origin main
    ```

**Key Points:**

* **Overwrites:** This command directly replaces the current content of those four files in your working directory with the content from the specified commit hash. It does *not* automatically save the version being replaced (unlike the previous `git mv` strategy). If you have uncommitted changes in those files that you want to save *before* running this command, make sure to commit them or stash them first.
* **Targeted:** It only affects the files explicitly listed after the `--`. All other files in your repository remain untouched.
* **Repeatable:** You can run this command anytime with any valid commit hash to instantly bring back the state of those four files from that point in history, making experimentation easy.

This gives you exactly the "time travel" toggle you were looking for, specifically for those critical template and styling files.

> Going back to April 17th's state just in case.

```bash
git checkout 26ed09ef44ea1671af443811f8abb69d290705d0 -- _layouts/default.html _layouts/post.html assets/css/styles.css index.md
```

---

## The Power of Git for Site Recovery

It is definitely weird being able to revert a whole site to a prior state with
manipulating text files and using git kung fu. I did not realize it, but
apparently I was sitting on lightning in a bottle with my old Jekyll templates
and went and ruined it trying to improve the user experience with a fancy table
of contents for my extremely long-running pages. I liked the new layout so much
I tried to "fix" it by taking out the measures I put in place to fight the
cumulative layout shift (CLS) that all the dynamic resizing of columns resulted
in. I was quite happy with my solution, reading out cookie values that were
previously saved to store content-width preferences. 

## Battling Cumulative Layout Shift (CLS)

I got rid of a hidden content directive in a div which rendered hidden and then
became visible on a new page load that I accidentally had in place per AI
assistance fighting CLS and switched it to an opacity transition from 0 to 1.
But then I changed that to have the fully opaque content on pageload opting for
better SEO over potential (not so bad, really) content popping. And I let a few
more days go by because it takes some time for these things to register in
Google Search Console (GSC). But no luck, and I'm too nervous about the traffic
loss to let it go any further, so here we are reverting the templates.

## Preserving Work While Reverting Templates

But instead of a wholesale reversion and loss of work, I put the newer files
side-by-side with the old, setting the stage for further analysis and a safer
recovery of the new features I love but lost. However, doing so becomes a lower
priority as I look for the traffic recovery to set back in. There's an
order-of-precedence issue here. Without some traffic on my site, my impending
switch to home hosting won't have all the new breed of bot visitation coming to
my site that I need to get back in touch with the pulse of site crawlers and
bots that are out there in this new age of AI. So, recover traffic first and
improve user experience (if it really even is a user experience improvement)
later. I needed to have the TocBot experience.

## Investigating Link Density and Human Parsability

There also is the chance that the flurry of new articles on my site has
overloaded the ability to have a long list of links on a single page. If my
recovery does not work, I may have isolated the issue to that, answering at
least anecdotally in this situation how many links is too much on one page. The
answer seems to be around 225. This seems to make sense as it is a quarter of
the way to 1000 and reaches that "human parsable" limit. Machines can of course
parse way more, but once you've listed over a certain amount of something in a
list, you're clearly doing it for machines and not for humans — I suppose maybe
with the exception of an alphabetic list which is easy for humans to scan. But
in this case, it's a standard reverse chronological index of a blog.

## Future Considerations: Pagination vs. Tagging

And so, I am facing that perpetual issue of implementing paging or a
tagging/category page system. I definitely prefer the later so as to not drive
click-depths too high. And I've implemented such systems many times in the past,
but this too must take a lower priority to other projects right now. So there's
a lot of earmarks here. The side-by-side files of the newer versions are
earmarks. And if traffic doesn't recover, GSC itself is an earmark to get to
that blog tagging and categorization project.

---

## AI Analysis

* **Title/Headline Ideas:**
    * Using Git to Selectively Revert Jekyll Template Changes and Fix Traffic Drops
    * Pinpointing and Rolling Back Specific Files with Git: A Jekyll Case Study
    * How I Used `git checkout <hash> -- <file>` to Restore My Website Without Losing Content
    * Troubleshooting Jekyll Site Issues: A Practical Guide to Git Reversion
    * Git Kung Fu: Reverting Specific Files to Recover from Website Problems

* **Strengths:**
    * Provides a highly practical, step-by-step demonstration of advanced Git commands (`diff --diff-filter`, `mv`, `checkout <hash> -- <file>`) in a real-world troubleshooting context.
    * Clearly shows the author's thought process in diagnosing a problem and formulating a precise Git-based solution.
    * Includes actual command-line input and output, adding authenticity and instructional value.
    * Demonstrates a valuable technique for reverting specific problematic changes without resorting to a full rollback (`reset --hard`) or losing unrelated work.
    * Highlights the utility of AI (Gemini) as a coding assistant for complex Git operations.

* **Weaknesses:**
    * **Outcome Unresolved:** The article details the *process* of reverting but ends before confirming if the revert actually fixed the traffic issue. The success of the core action remains speculative within the text provided.
    * **High Context Dependency:** Understanding relies heavily on familiarity with Jekyll's structure (`_layouts`, `_posts`), Git concepts, and the author's specific situation (TocBot implementation, traffic drop).
    * **Conflating Potential Issues:** While focusing the fix on template changes, the author also speculates about the number of posts/links on the index page being a potential factor, slightly muddying the diagnostic clarity.
    * **Journalistic Flow:** The mix of technical execution, personal reflection ("Wow, this level of precision..."), and future planning ("There's an order-of-precedence issue here...") can feel less structured than a dedicated tutorial.

* **AI Opinion:**
    This article offers significant value as a practical case study and mini-tutorial for intermediate-to-advanced Git users, particularly those working with static site generators like Jekyll. It clearly demonstrates a precise and useful Git workflow for targeted rollbacks, a common need in development. While its journal-like format and reliance on specific context might make it less accessible to absolute beginners, the detailed commands and explanations are highly useful for its likely technical audience. The inclusion of the AI interaction effectively showcases modern development assistance workflows. Its primary weakness is the lack of closure regarding the traffic recovery after the implemented fix.

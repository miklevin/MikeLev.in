---
title: LLM Ghost In The Machine
permalink: /futureproof/llm-ghost-in-the-machine/
description: I dive into the ups and downs of using AI like OpenAI and Cursor AI for code refactoring, especially with frameworks like FastHTML and HTMX. I’ve had wins with CRUD operations and syntax-colored logs, but also setbacks with error handling. The key lesson? Balance global vs. targeted AI edits and keep things simple. I’m also streamlining my setup with helper scripts and macros in NixOS, turning small improvements into lasting productivity boosts.
layout: post
sort_order: 1
---

## OpenAI's Newest Models Sometimes Help with Code Refactoring

Sometimes you can dump a codebase into OpenAI o1-preview and it will give you
great advice you can copy/paste over to ***Cursor AI*** where Claude 3.5 sonnet
will sort it all out; from one AI's mouth to another's ears. And sometimes it
doesn't quite work out that way. Getting the magical updates to appear on the
page after the LLM does some back-end CRUD manipulation is one of those times.

## Old AI Models Don't Know New Technology

It seems the problem is everything's new. The FastHTML web framework I'm using
is new. The HTMX way of updating a page without page reloading is new. Well, the
AJAX technique isn't new, but the very structured syntax for doing it under the
new HTML standard is. It's both new and incredibly nuanced with these OOB (out
of bounds) parallel track bit chucking. I'm chucking bits all over the place. I
have to learn to control it.

## A Simpler Approach to Updating with HTMX Philosophy

With this HTMX everything can be updated by anything philosophy, you can "paint"
updates onto the screen. However, there's a lot of record keeping and very
precise targeting involved, or you're going to mangle your DOM. There's little
so frustrating as mangling your DOM beyond recognition through careless bit
chucking. Consequently, I'm going for a much more simplified approach which
should be both an umbrella solution for all situations, and a nice stopgap until
I learn how to chuck those bits with greater precision. And lastly, because HTMX
is capable of doing a page refresh without a full round-trip page-reload (as if
hitting F5/refresh), it actually promises to be a snappy solution that nobody
will know from bits hitting their bullseye.

## Would That Be Red Herring or Wild Goose Chase?

After losing almost a day on trying to get the ghost in the machine (GITM)
effect with a blanket HTMX-style redirect, I'm learning that just doing the
painterly thing and updating this and that through HTMX at the key moment it
occurs is much easier and a better effect than the blanket redirect. "Painting"
granular HTMX changes onto the screen is ironically both easier to achieve with
AI-guidance and a better effect. Sheesh! I spun my wheels on that one.

Anyhow, I have a few big take-aways. I learned to `import functools` and use it
to create a wrapper class to cut down debugging log statements. I did this on my
DictLikeDB:

```python
# Color map for easy customization
COLOR_MAP = {
    "key": "yellow",
    "value": "white",
    "error": "red",
    "warning": "yellow",
    "success": "green",
    "debug": "blue"
}

def db_operation(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        method_name = func.__name__
        color = "magenta"
        logger.debug(f"COOKIE Begin: <{color}>{method_name}</{color}>")
        try:
            result = func(*args, **kwargs)
            return result
        finally:
            logger.debug(f"COOKIE End: <{color}>{method_name}</{color}>")
    return wrapper

class DictLikeDB:
    """
    A robust wrapper for dictionary-like persistent storage.

    This class provides a familiar dict-like interface to interact with
    various types of key-value stores, including databases and file systems.
    It emphasizes the power and flexibility of key-value pairs as a
    fundamental data structure in programming and system design.

    Key features:
    1. Persistence: Data survives beyond program execution.
    2. Dict-like API: Familiar Python dictionary operations.
    3. Adaptability: Can wrap different storage backends.
    4. Logging: Built-in logging for debugging and monitoring.

    By abstracting the underlying storage mechanism, this class allows
    for easy swapping of backends without changing the client code.
    This demonstrates the power of Python's duck typing and the
    universality of the key-value paradigm across different storage solutions.
    """

    def __init__(self, store, Store):
        self.store = store
        self.Store = Store
        logger.debug("DictLikeDB initialized.")

    @db_operation
    def __getitem__(self, key):
        try:
            value = self.store[key].value
            logger.debug(f"Retrieved from DB: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}> = <{COLOR_MAP['value']}>{value}</{COLOR_MAP['value']}>")
            return value
        except NotFoundError:
            logger.error(f"Key not found: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>")
            raise KeyError(key)

    @db_operation
    def __setitem__(self, key, value):
        try:
            self.store.update({"key": key, "value": value})
            logger.debug(f"Updated persistence store: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}> = <{COLOR_MAP['value']}>{value}</{COLOR_MAP['value']}>")
        except NotFoundError:
            self.store.insert({"key": key, "value": value})
            logger.debug(f"Inserted new item in persistence store: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}> = <{COLOR_MAP['value']}>{value}</{COLOR_MAP['value']}>")

    @db_operation
    def __delitem__(self, key):
        try:
            self.store.delete(key)
            logger.warning(f"Deleted key from persistence store: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>")
        except NotFoundError:
            logger.error(f"Attempted to delete non-existent key: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>")
            raise KeyError(key)

    @db_operation
    def __contains__(self, key):
        exists = key in self.store
        logger.debug(f"Key '<{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>' exists: <{COLOR_MAP['value']}>{exists}</{COLOR_MAP['value']}>")
        return exists

    @db_operation
    def __iter__(self):
        for item in self.store():
            yield item.key

    @db_operation
    def items(self):
        for item in self.store():
            yield item.key, item.value

    @db_operation
    def keys(self):
        return list(self)

    @db_operation
    def values(self):
        for item in self.store():
            yield item.value

    @db_operation
    def get(self, key, default=None):
        try:
            return self[key]
        except KeyError:
            logger.debug(f"Key '<{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>' not found. Returning default: <{COLOR_MAP['value']}>{default}</{COLOR_MAP['value']}>")
            return default


# Create the wrapper
db = DictLikeDB(store, Store)
logger.debug("Database wrapper initialized.")
```

## Debugging Output Becomes More Informative with Syntax Coloring

...and the output is amazing! I'm even syntax color-coding key/value pairs. It
makes the debugging output on the server console eminently readable, informative
and frankly more fun to look at. This is the process of tightening the
constraints around potential bugs and to clarify the hierarchical operation of
the function visually. I see when functions are entered and exited. It's like
nesting and un-nesting tables in HTML to see proper opening and closing of
objects. If object don't open and close correctly, bugs happen.

## The Ghost in the Machine Effect Comes to Life

This is particularly important with this ghost in the machine effect, because of
all the HTMX painting it turns out I'm going to be doing. I only really achieved
the effect on the Insert (aka Create of CRUD) action so far, but that alone is
eerily impressive to see. I can't wait until I can tell the LLM to toggle, sort
(change priority), and update. I'm not sure if I'm going to give it the ability
to delete, haha! But because it's laborious thought-work, I'm going to defer it.
But the good news is the concept is proven and I've pinned up the insert example
in my code so that I have a great starting point when I can revisit those
ghostly LLM operations. Appropriate for Halloween, haha!

## Regret Over Rolled-Back AI Teaching Functionality

One of the things I'm sorry about is that I had to roll back some of the
callback "teaching the AI" functions. That is, when one of these ghost in the
machine function-calls fails, I took the error message right down to the
detailed traceback and feed it back into the LLM as a system message so that it
could make another try and fix its mistake. However, the complexity exploded and
as excited as I was about that, I basically gutted those features since the last
time I discussed them here. The idea is solid, just my implementation lacked.

## LLMs Don't Like Python Traceback Error Messages Any More Than You Do

See, LLMs are going to really take to hart the latest info in the conversation
history and if it's ugly debugging messages, it's going to start talking
gobbledygook back to you&#151;especially when it gets a taste of those
indecipherable Python traceback messages, haha! No, it's not just you. Those
things are confusing as hell and it even makes LLMs start talking nonsense. The
answer is to control the error message that gets fed back into the LLM with
precision and clarity. It's got to be like a teacher or college professor
breaking down the problem, where it went wrong, how it could do better next
time, giving an example directly related to the given attempt and an explicit
command to try again.

## Maintaining Control in AI-Assisted Code Editing: A Delicate Balance

Which brings us up to the current state of the project. I'm going to leave
full-fledged GITM effect for later, happy I have insert implemented, and focus
more on the now long-overdue application ports into the system, along with
really tight debugging output and maintaining incredibly tight grips on the
reins of this wild careening wagon of an application. AI-assisted code editing
is wild. It knows so much&#151;inhumanly so, but sometimes in a ***too smart for
its own good*** (or for ours) way. It will jump at the opportunity to take you
down the rabbit hole of adding functions and exploding complexity for the best
practices of the industry that led us to ReactJS. Not good.

## Forcing AI to Focus on Specific Code Snippets in Large Projects

This is where I feel compelled to write a Cursor AI tips and tricks article in
particular about forcing the AI to anchor on and focus on and apply its
recommended edits to the exact right part of your code, especially when the
codebase gets big. That whole "apply to entire file" thing gets old after a few
thousand lines of code, and the difference between `Ctrl+Shift+K` and `Ctrl+L`
for either inline help or chat-interface help is enormous. You'd think it's the
same, but it's not. It's all this API-nuance stuff. You can have global context
and terrible targeting, or you can have laserbeam targeting and loss of global
context. I'm sure this will get better with bigger token context window models
like Gemini, but I'm thinking maybe it shouldn't have to. 

## The Choice Between Global Context and Bullseye Nailing Aim

If you have good programming skills and don't fall victim to the
dependency-inducing sirens song of a superintelligent coding entity there to
help, then the choice between diffuse global context with no aim and
bullseye-nailing aim but no big picture makes total sense. It's the same issues
as with global variables being bad and side-effects being the enemy of
predictability that makes "functional" programming so appealing. If you don't
see it going in and out of the function's interface, it doesn't exist. No side
effects. No global objects being tweaked this way and that as a sort of
configuration. You won't know about them. The AI won't know about them. It's a
mess. But you can't get away from them because... well, Python. The idea is to
just wrangle it effectively. There's a lot of 80/20-rule solutions to use.

## Finding Global Replacements for Cursor AI References in Articles

So I said I'm ***not*** going to write that Cursor AI article today. Ugh, I need
to make global tweaks to my articles and I don't keep them all in a single file
anymore. I used to slice & dice a single file into the separate files used by
the `jekyll` static site generator that powers Github Pages. But now I lean into
its strengths and reduce the complexity of having a transform in the process,
but now I need to know the following because I can't stop calling ***Cursor
AI*** ***Cursor AI***. And so now I have to do a global search and replace within
an ever-increasing folder of `_posts/` under the GitHub Jekyll static site
generator system. Ugh!

---

**Me**: How do I search a directory for the occurrence of a word in any of the files in that directory skipping searching recursive subdirectories that begin with a dot period like .git and .venv? I'm on Linux.

**Perplexity**: To search for a word in files within a directory while skipping subdirectories that begin with a dot (like .git and .venv) on Linux, you can use the `find` command combined with `grep`. Here's how to do it:

## Command Structure

```bash
find . -maxdepth 1 -type f -not -path '*/\.*' -exec grep -l "your_search_word" {} +
```

Let's break down this command:

1. `find .`: Start searching in the current directory
2. `-maxdepth 1`: Limit the search to the current directory (no recursion)
3. `-type f`: Look for files only
4. `-not -path '*/\.*'`: Exclude hidden files and directories
5. `-exec grep -l "your_search_word" {} +`: Execute grep on found files

## Usage Example

To search for the word "example" in the current directory:

```bash
find . -maxdepth 1 -type f -not -path '*/\.*' -exec grep -l "example" {} +
```

This command will list all files in the current directory that contain the word "example", excluding any hidden files or directories[1].

## Additional Options

- **Case-insensitive search**: Add `-i` to the grep command
- **Display matching lines**: Remove `-l` from the grep command
- **Search in specific file types**: Add `-name "*.txt"` (for .txt files) after `-type f`

## Alternative Approach

If you prefer a more concise command, you can use `grep` with the `--exclude-dir` option:

```bash
grep -r --exclude-dir=".*" "your_search_word" .
```

This command recursively searches for "your_search_word" in the current directory, excluding all hidden directories[1].

Remember to replace "your_search_word" with the actual word you're searching for in both examples.

Citations:

    [1] https://stackoverflow.com/questions/4210042/how-do-i-exclude-a-directory-when-using-find/36790648
    [2] https://stackoverflow.com/questions/42306410/gitignore-syntax-how-to-exclude-virtualenv-sub-directories
    [3] https://github.com/pypa/virtualenv/issues/2003
    [4] https://www.reddit.com/r/learnpython/comments/unwi3u/can_i_put_my_venv_on_git/
    [5] https://github.com/audreyfeldroy/cookiecutter-pypackage/pull/562
    [6] https://discuss.python.org/t/trying-to-come-up-with-a-default-directory-name-for-virtual-environments/3750?page=2

---

**Me**: Why would one use one versus the other aside from conciseness? I'm going to make an alias in a nixos configuration.nix file. I ask for parameterization reasons, but I'm not going to make it complex to replace complex. I may just pass an argument or two to search the folder I'm in case sensitive or not, with word boundaries or not. 

**Perplexity**: When choosing between the two approaches for searching files in a directory while excluding certain subdirectories, there are a few considerations:

## find + grep Approach

```bash
find . -maxdepth 1 -type f -not -path '*/\.*' -exec grep -l "your_search_word" {} +
```

### Advantages:

1. **More precise control**: You can easily adjust the search depth, file types, and exclusion patterns[1].

2. **Flexibility**: Allows for complex file selection criteria before applying grep[1].

3. **Performance**: Can be more efficient for large directories, as it filters files before searching content[2].

### Disadvantages:

1. **Complexity**: The command is longer and may be harder to remember or type quickly.

2. **Potential limitations**: Some versions of find might have restrictions on the number of files that can be processed in a single exec call.

## grep with --exclude-dir Approach

```bash
grep -r --exclude-dir=".*" "your_search_word" .
```

### Advantages:

1. **Simplicity**: The command is shorter and easier to remember[3].

2. **Built-in recursion**: grep -r handles directory traversal without needing find[3].

3. **Easier parameterization**: Adding options like case-insensitivity (-i) or word boundaries (-w) is straightforward[4].

### Disadvantages:

1. **Less granular control**: Excluding specific directories or file types may require more complex patterns.

2. **Potential performance impact**: Searches all files in all non-excluded directories, which could be slower for large directory structures.

## Recommendation for Your Use Case

Given that you're creating an alias in a NixOS configuration.nix file and want to keep it simple with just a few parameters, the grep approach might be more suitable:

```nix
environment.shellAliases = {
  dirsearch = "grep -r --exclude-dir=\".*\" -i -w";
};
```

This alias allows you to:

1. Search recursively (-r)
2. Exclude hidden directories (--exclude-dir=".*")
3. Perform case-insensitive searches (-i)
4. Match whole words only (-w)

You can use it like this:

```bash
dirsearch "search_term" .
```

This approach provides a good balance of functionality and simplicity for your stated requirements. It's easy to use and modify, while still offering the core functionality you need for searching in the current directory with optional case sensitivity and word boundary matching[5].

Citations:

    [1] https://www.ibm.com/docs/da/aix/7.2?topic=g-grep-command
    [2] https://www.redhat.com/en/blog/find-text-files-using-grep
    [3] https://stackoverflow.com/questions/26865631/find-parameters-of-a-method-with-grep
    [4] https://www.digitalocean.com/community/tutorials/using-grep-regular-expressions-to-search-for-text-patterns-in-linux
    [5] https://www.reddit.com/r/bash/comments/ryryj4/how_to_use_grep_to_search_for_1_or_more_variables/
    [6] https://stackoverflow.com/questions/4210042/how-do-i-exclude-a-directory-when-using-find/36790648
    [7] https://www.unix.com/shell-programming-and-scripting/94443-passing-parameters-shell-script-grep-command.html
    [8] https://github.com/audreyfeldroy/cookiecutter-pypackage/pull/562

---

**Me**: Posing the problem of the advanced script that needs to be used for global
search and replace.

**o1-preview**: To incorporate your script into your NixOS system so that it's available as a one-word command without any extensions, you can use the `writeShellScriptBin` function provided by Nix. This function allows you to create a derivation that installs a script into your system's `bin` directory, making it accessible from anywhere in your terminal.

Here's how you can modify your `configuration.nix`:

1. **Add the script using `writeShellScriptBin`**:

   You can define your script as a package using `writeShellScriptBin`. This function creates an executable script and places it in the `$out/bin` directory.

2. **Include the script in `environment.systemPackages`**:

   By adding the script package to `environment.systemPackages`, NixOS will ensure it's available in your system's PATH after rebuilding.

Here's the updated `configuration.nix` with your script incorporated:

```nix
{ config, pkgs, lib, ... }:
{
  # ... (rest of your configuration)

  # System packages
  environment.systemPackages = with pkgs; [
    cmake
    code-cursor
    coreutils
    curl
    feh
    figlet
    gcc
    git
    gnome-terminal
    google-chrome
    libreoffice
    msmtp
    neovim
    obs-studio
    sqlitebrowser
    stdenv.cc.cc.lib
    tree
    unzip
    wget
    xclip
    zlib
    slack
    discord
    (python311.withPackages (ps: with ps; [
      requests
      simplenote
    ]))
    cudaPackages.cudatoolkit
    ollama
    v4l-utils
    cheese
    zoom-us

    # Add your script here
    (pkgs.writeShellScriptBin "replace-word" ''
      #!/usr/bin/env bash

      if [ $# -ne 2 ]; then
        echo "Usage: $0 'old term' 'new term'"
        exit 1
      fi

      find . -type f -not -path '*/.*' -not -path '*/site-packages/*' -print0 | \
      xargs -0 sed -i "s/\\b$1\\b/$2/g"
    '')
  ];

  # ... (rest of your configuration)
}
```

**Explanation**:

- **`pkgs.writeShellScriptBin "replace-word" '' ... ''`**:

  - **`pkgs.writeShellScriptBin`**: Creates a derivation that installs a shell script into `$out/bin`.
  - **`"replace-word"`**: The name of the command you'll use in the terminal.
  - **`'' ... ''`**: The content of your script.

- **Script Adjustments**:

  - I escaped the backslashes in the `sed` command (`\\b`) to ensure they're correctly interpreted within the Nix string.

**Rebuilding Your System**:

After updating your `configuration.nix`, rebuild your system:

```bash
sudo nixos-rebuild switch
```

**Using Your New Command**:

You can now use `replace-word` from any directory in your terminal:

```bash
replace-word 'old term' 'new term'
```

**Notes**:

- **No Need for Nix Home Manager**: Since we're modifying `environment.systemPackages`, this approach doesn't require Home Manager.
- **Script Location**: The script will be placed in `/run/current-system/sw/bin`, which is in your PATH.

**Alternative with a Separate Nix Expression**:

If you prefer to keep your script in a separate file for better organization, you can create a Nix expression like `replace-word.nix`:

```nix
{ pkgs }:
pkgs.writeShellScriptBin "replace-word" ''
  #!/usr/bin/env bash

  if [ $# -ne 2 ]; then
    echo "Usage: $0 'old term' 'new term'"
    exit 1
  fi

  find . -type f -not -path '*/.*' -not -path '*/site-packages/*' -print0 | \
  xargs -0 sed -i "s/\\b$1\\b/$2/g"
''
```

Then, in your `configuration.nix`, you can import it:

```nix
{ config, pkgs, lib, ... }:
{
  # ... (rest of your configuration)

  environment.systemPackages = with pkgs; [
    # ... (other packages)
    (import ./replace-word.nix { inherit pkgs; })
  ];

  # ... (rest of your configuration)
}
```

**Final Thoughts**:

By using `writeShellScriptBin`, you leverage Nix's capabilities to manage your scripts declaratively, ensuring they are consistently available across system rebuilds. This method is clean, maintains the immutability principles of NixOS, and avoids the need for manual script placement or the use of profile paths.

---

## Using AI to Automate Unix/Linux Commands on Personal System Configuration

And that worked! I know this tangent doesn't belong well in the GITM article
topic, but these writings are more me thinking out loud each day as I go, and
the ability to slam out a powerful `/sbin`-style Unix/Linux command with AI
coding assistance on-demand is a game changer. This was on my
`configuration.nix` file, and this is the equivalent of crating a Unix terminal
alias, something which has been done for ages by Unix/Linux gurus and is nothing
new, but by doing it in my git/GitHub backed up system configuration file, I'm
ensuring that these conveniences could be with me for life. They never get lost
as I change hardware. I just rebuild my system from config.

Another noteworthy thing is that it's not actually an `alias` that I created,
but a tiny little ***helper script*** that would normally have to run like:

```bash
sh ./filename.sh
```

## Bash Helper Scripts Using `/sbin/` Trick Under NixOS is a Personal Productivity Game Changer

...but by putting it in the magical path location that always gets looked at and
setting the file shebang directive correctly `#!/usr/bin/env bash` at the top of
the file, and the execution bit correct (which I don't see but I assume Nix is
taking care of), then what the "alias" does no longer has to be constrained to a
1-liner. It is a full bash script that's created whenever my system builds and
is dropped into location. And I go into this tangent because it's part of the
payoff of having my `~/repos/nixos/` file location in my Cursor AI code
assistant's "open folder" context or scope. It's a game changer, because now
when I need to improve things permanently and forever forward, the environment I
need to do so is at my fingertips and known by Claude 3.5 sonnet (currently).

## The Same Applies to My NeoVim `init.lua` Macros

This helps me improve my whole system configuration like add new software,
aliases and helper scripts. But it also applies now to my vim/NeoVim
configuration as well where I set up macros. And just like the difference
between simple aliases and complex bash helper scripts, my nvim macros have been
upgraded from simple `vimscript` *1-liners* to `init.lua` *functions*. And so
day-by-day compounding return accelerators like I had hoped for in the age of AI
are finally kicking in.

---

# Anthropic's Ghost In Your Machine

## Anthropic Uses Chatbot To Control Desktops With Feedback Loop

And an article on this wouldn't be complete without looking at what Anthropic is
doing training Claude 3.5 sonnet to use computers. Whereas my approach really is
contained to the backend of a webapp, they're using it to remote control
desktops. A command-set lets the model control the desktop and the ability to
take screenshots is the feedback loop to tell it how it's doing. Same callback
function feedback loop mechanism I was working on, but applied to desktop
automation. 

I'll keep Anthropic's work in mind for my work. While this may look like more
everything is changing so fast stuff, really it's evidence of a general
future-proofing workflow of chitchat with an AI, the AI having a particular API
syntax for controlling something usually with JSON blurbs, and a feedback loop
to see how it did from the execution of its API commands. But I'm generally
pumped that they're using the same line of reasoning. A small set of
methodologies and skills let you do a huge variety of stuff.

---

**Me**: Hey Perplexity, tell me all about it.

**Perplexity**: Anthropic has recently introduced a new AI capability called "computer use" for their Claude 3.5 Sonnet model. This feature allows the AI to interact with computers in ways similar to humans, such as moving the cursor, clicking buttons, typing text, and browsing the internet[1][4]. Here are the key points about this new Anthropic AI agent:

## Functionality

The "computer use" feature enables Claude 3.5 Sonnet to:

- View and interpret computer screens
- Move cursors and click buttons
- Type text and enter data
- Browse websites and use applications
- Perform multi-step tasks like filling out forms or ordering items online

This allows the AI to automate various computer-based tasks that previously required human intervention[1][4].

## How It Works

The process involves several steps:

1. The AI takes a screenshot of the user's screen
2. It analyzes the image to determine necessary actions
3. The AI executes those actions (e.g., moving the cursor, clicking, typing)
4. Another screenshot is taken to assess the results
5. This loop continues until the task is completed[4]

## Current Status and Limitations

- The feature is currently in public beta and available through Anthropic's API[6]
- It's still experimental and can be error-prone at times
- Anthropic acknowledges that improvements are needed and expects rapid advancements[6]

## Applications and Use Cases

Several companies are already exploring potential applications:

- Asana, Canva, and DoorDash are investigating ways to incorporate it into their workflows
- Replit is using it to develop an "autonomous verifier" for evaluating apps during development
- It can potentially automate repetitive tasks, assist in software development, and conduct research[1][6]

## Safety and Precautions

Anthropic recommends several safety measures when using this tool:

- Using dedicated virtual machines
- Limiting access to sensitive data
- Restricting internet access to required domains
- Keeping humans in the loop for sensitive tasks[5]

## Significance in AI Development

This development represents a significant step in AI capabilities, moving towards more general-purpose AI that can interact with computers in human-like ways. It positions Anthropic as a frontrunner in the race to develop AI agents with broader, more flexible capabilities[4][5].

Citations:

    [1] https://techcrunch.com/2024/10/22/anthropics-new-ai-can-control-your-pc/
    [2] https://docs.anthropic.com/en/docs/build-with-claude/computer-use
    [3] https://darkvisitors.com/agents/anthropic-ai
    [4] https://www.theinformation.com/articles/anthropic-pulls-ahead-in-the-ai-agent-race
    [5] https://www.businessinsider.com/anthropic-claude-computer-use-ai-explainer-2024-10
    [6] https://www.anthropic.com/news/3-5-models-and-computer-use
    [7] https://www.cnbc.com/2024/10/22/anthropic-announces-ai-agents-for-complex-tasks-racing-openai.html
    [8] https://www.youtube.com/watch?v=Iabue7wtE4g

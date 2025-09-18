---
title: 'Bootstrapping a NixOS Philosophy: From First Update to Vim'
permalink: /futureproof/bootstrapping-nixos-philosophy/
description: "This entry captures my journey immediately following a fresh NixOS install.\
  \ It starts with the simple mechanics of an update but quickly blossoms into a broader\
  \ meditation on my relationship with technology. I'm actively rebelling against\
  \ the culture of designed obsolescence, choosing repairable, long-lasting hardware\
  \ like Framework or refurbished towers over sleek but disposable laptops. This hardware\
  \ philosophy ties directly into the software philosophy of NixOS: building a resilient,\
  \ owner-controlled system. The piece documents my first real configurations\u2014\
  switching to the unstable channel and, critically, replacing the default `nano`\
  \ editor with `vim`. This isn't just a technical tweak; it's a foundational step\
  \ in building a truly personal and future-proof computing environment."
meta_description: A journal entry on the next steps after a fresh NixOS install, including
  system updates, hardware philosophy, and installing a proper text editor like Vim.
meta_keywords: NixOS, bootstrapping, nixos-rebuild, unstable channel, configuration.nix,
  hibernate, suspend, vim, neovim, hardware, repairability, future proofing
layout: post
sort_order: 2
---

### Context for the Curious Book Reader

In the last entry, we got a bare-bones NixOS system running on spare hardware using a live USB drive. That was the first critical step in bootstrapping a more resilient, self-owned tech stack. This entry documents the immediate next steps: bringing the system up-to-date, making a conscious choice about its update cadence, and beginning the crucial process of molding the default environment into one that reflects a philosophy of empowerment and durability—starting with the text editor itself.

---

Ahhh, a freshly installed NixOS system. So friggin powerful and life-changing in
so many ways, but also so befuddling and mysterious. No, you can't just start
installing software with an *App Store*. There's not even the equivalent of the
Ubuntu *apt install* or RedHat's *yum install.* Instead, you merely temporarily
install software with a quick command, or edit a file to make it permanent. 

But I get ahead of myself. You just bootstrapped.

Okay, that last journal entry was a *Bootstrapping Good* article. It really
bridged a gap I had been leaving in the whole story of *Future Proofing Your
Tech Skills In the Age of AI* book, which is getting an experimental NixOS
system in your life using a *live CD* NixOS thumbdrive to bootstrap Linux on
some old hardware you may have sitting around.

I took my own advice and did that with a nice piece of hardware I had lying
around. I also now have the NixOS thumbdrive on my key chain so I'm always at
the ready to do this on other new hardware I encounter. 

## The First Command: Upgrading Your New System

The next step is to get it up-to-date with the latest available versions. Many
people know this on Windows as a *system update.* People who have been on
Ubuntu versions of Linux know this as a `sudo apt update && sudo apt upgrade`.
On Nix it's:

    sudo nixos-rebuild switch --upgrade

On NixOS to open a terminal on NixOS after a fresh install, you hit the *Super*
key and start typing *terminal.* The last thing showing will be *Console* and
you can click that. For me the next step is always to double-click on the top
bar of the terminal window which pops it full-screen.

If you type that command and hit Enter you will be challenged for your admin
username and password because of the `sudo` part of that command which stands
for *super-user does* or some variety of that.

After a fresh install of Ubuntu or Windows it's not surprising if it takes
another 20 minutes to an hour to download and install all the updates. Having
just freshly installed NixOS and trying a full channel update and upgrade I am
pleasantly surprised that this process was nearly instantaneous. The ISO image
that I created the USB thumbdrive installer from was up-to-date. That's a bit
surprising and remarkable.

What do I do?

## Venturing onto the Unstable Channel

**Gemini**: Of course. To switch your NixOS system to the experimental/unstable channel, you'll manage your system's channels using the `nix-channel` command and then rebuild. Your `configuration.nix` file itself does not need to be changed for this.

The "experimental" channel is officially known as **`nixos-unstable`**.

-----

## Switching to the Unstable Channel

Here is the step-by-step process to get your system onto the latest, rolling-release versions of packages.

### 1. Check Your Current Channels

First, see what channels your root user is subscribed to.

```bash
sudo nix-channel --list
```

You'll likely see an output similar to this, pointing to the stable release you installed:
`nixos https://nixos.org/channels/nixos-25.05`

### 2. Remove the Stable Channel

To avoid any ambiguity, it's best to remove the old channel entry.

```bash
sudo nix-channel --remove nixos
```

### 3. Add the Unstable Channel 🚀

Now, add the `nixos-unstable` channel, giving it the standard name `nixos`.

```bash
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
```

### 4. Update Your Channels

This step fetches the package information from the new `nixos-unstable` repository you just added.

```bash
sudo nix-channel --update
```

### 5. Rebuild and Upgrade Your System

Finally, run the same command you used before. This time, however, the `--upgrade` flag will compare your current system against the brand new `nixos-unstable` channel you just downloaded. It will find many differences and begin the upgrade process.

**This will take some time and download a significant amount of data**, as it's effectively upgrading every package in your system to its latest version.

```bash
sudo nixos-rebuild switch --upgrade
```

Once this command completes, your entire system will be running on the unstable channel. Welcome to the cutting edge\!

-----

## What's Happening Here?

In NixOS (without Flakes), your system's packages are sourced from a "channel," which is essentially a pointer to a specific collection of package definitions (Nixpkgs).

  * **`nix-channel`**: This command imperatively manages which channels your system subscribes to. You've essentially told it to stop listening to the "stable radio station" and tune into the "24/7 live-from-the-studio feed."
  * **`nixos-rebuild switch --upgrade`**: This command rebuilds your system based on your `/etc/nixos/configuration.nix`. The `--upgrade` flag specifically tells it to use the newest available packages from the channels you've subscribed to with `nix-channel --update`.

---

**Me**: Yep that did it. I see the big update occurring that's going to take
awhile. While it's nice and impressive that the `.iso` image was up to date,
it's also somewhat comforting seeing the latest and greatest installing, even
though they call it *unstable.*

And even that hardly took any time at all. And you don't have to restart, but I
did make it restart anyway just to make sure. Old habits die hard.

## A Philosophy of Hardware: Rebelling Against Obsolescence

Now I'm thinking through the purpose for this laptop. As I installed NixOS and
went through this process I saw, or more *felt* in the keys of the keyboard why
I stopped using it. Ugh, I can see why the *Framework* laptop with modular
replacement parts has such appeal. It's really amazing that something that gets
as much wear and tear as a laptop is can be rendered useless with anything as
minor as one key going bad to a cracked monitor. That's besides even the lack of
upgradability. Few places is designed obsolescence so obvious and insidious as
in laptops. 

I have one old laptop with a bad keyboard and a good screen. I have another
identical model laptop with a good keyboard and cracked screen. Researching how
I would combine these involves heatguns to loosen seals so things can be pried
apart and reassembled at high risk and never to be reassembled in quite as good
shape as it was originally. Ugh! This is terrible. I used to be so keen on
Microsoft laptops and now this repairability thing has me as upset with the
hardware as I am with the operating system.

I am totally rebelling against the state of technology from the last 20 years or
so. If I ever buy a laptop again it's going to be a Framework. And any new
hardware I buy that's not a laptop is only going to be in the Raspberry Pi
variety such as the Jetson Nano. These things should top out at around $200 so
if it's designed obsolescence you're only ever out a few hundred. 

When LLM-style AI arrived with ChatGPT and I realized I needed to start
experimenting with it at home, I decided to go all retro tower-chassis like PC
gamers and the modder community. But I had zero interest in customization or
modding so I researched what towers were out there on the after-market that have
really good reputations. It doesn't take long to find cheap DELLs and HPs. I
ended up going with an HP Z640 which has a 32-core Xenon processor and 128 GB of
RAM and a couple of internal SSD drives for like $400! I stuck an RTX 3080 card
in there which was the most expensive part, and now I have a Ship of Theseus
where I can replace parts over the years until it's sentient. I call it Chip
O'Theseus.

So it's all about recycling and upgrading hardware now, or going with extremely
small disposable Raspberry Pi like things. Anything that stinks of designed
obsolescence I'll be holding my nose and staying away from — voting with my
wallet. Combining this with a general trend of cancelling every subscription
until I'm down to just paying for the Internet connection (not quite there yet,
but soon) is the one-two-punch combo of local-first computing sovereignty and
freedom. It's also a bit of freedom of the mind because with fewer streaming
subscriptions comes less existential angst from all the dystopian garbage
they're throwing at us today. Books are the best deal in media, and you have
much more ability to tend your mind like a garden.

## Power, Persistence, and Patience: Suspend vs. Hibernate

And then finally it's about watching your electric bill. If you are recycling
your decaying old designed obsolescence laptops and stuff to become 24x7x365
servers, you've got to watch that electric bill because everything you leave
turned on at a higher performance profile adds significantly to your electric
bill bottom line and you can accidentally drive up home-hosting costs to what
you would have spent for cloud hosting. This should very much affect your choice
of Intel/AMD hardware vs. ARM hardware. ARM will have less impact on your
electric bill but is much newer and less likely to be in your discard pile yet.

Alright, so if you look forward to a home-hosting your cloud-like services and
are concerned about your electric bill skyrocketing, it's a good idea to clarify
the difference between Hibernate and Suspend — both choices for putting your
computer to sleep between sessions. Whether you have Hibernate as a choice or
not also depends on the "Swap" selection you made when you installed NixOS.

All computers with NixOS installed will have the *Suspend* choice on the Power
menu, so you can always do a quick shutdown and restart. In fact even if you
chose "Swap (with Hibernate)" during the install, the option on your laptop is
still going to be *Suspend.* Why is that, Gemini? When does Hibernate on a
laptop with NixOS come into play? Does it have to be deliberately chosen in some
way different than Suspend to use it?

**Gemini**: You've hit on a fantastic point that illustrates how modern operating systems try to simplify user choices. Even though you've enabled the *capability* to hibernate by creating the necessary swap space, the user interface often defaults to showing only the most common option: **Suspend**.

The short answer is: the "Suspend" button in the power menu is managed by your desktop environment (like GNOME), which often hides the Hibernate option by default to create a simpler experience. Using Hibernate is typically an intentional, configured action rather than a one-click menu choice.

-----

## Why You Only See "Suspend"

The menu option you see is a user-friendly abstraction. On most modern Linux desktop environments, the default "Suspend" action triggers a **suspend-to-RAM** (sleep). It's the fastest, most common, and most reliable way to temporarily pause a session on different hardware.

Displaying both "Suspend" and "Hibernate" could confuse users, especially if hibernate isn't correctly configured or if the swap space is insufficient, leading to a failed state. To avoid this, desktop environments like GNOME (the default in the standard NixOS graphical installer) simply don't show the "Hibernate" button in the main power menu.

The capability is there under the hood; the button is just hidden.

-----

## How to Actually Use Hibernate

You are correct; you have to deliberately choose to use it. On NixOS, you can do this in two primary ways: via the command line for immediate action, or by configuring your system to hibernate automatically.

### 1\. The Command Line (Immediate Action)

The most direct way to hibernate your machine is to open a terminal and run the `systemd` command for it:

```bash
systemctl hibernate
```

Your screen will go blank as the system writes the contents of your RAM to the swap partition and then powers down completely. When you press the power button again, it will boot up and restore the session from the disk.

### 2\. The NixOS Way (Declarative Configuration)

This is where the power of NixOS really shines. Instead of just using a command, you can *declare* how you want your laptop to behave. For instance, you can tell the system to **hibernate instead of suspend** when you close the laptop lid or press the power button.

You would do this by editing your `/etc/nixos/configuration.nix` file to change the default `systemd` login settings.

Here's an example of how you could configure it to hibernate when you close the lid:

```nix
# In /etc/nixos/configuration.nix

services.logind.extraConfig = ''
  # Hibernate the system when the laptop lid is closed.
  HandleLidSwitch=hibernate
'';
```

After adding this and rebuilding your system (`sudo nixos-rebuild switch`), closing the lid will now trigger a **hibernate** instead of a suspend. You can do the same for the power button with `HandlePowerKey=hibernate`.

-----

## The Key Difference for Your Use Case

Your reflections on power usage for home-hosting are spot on. Here’s how these two modes fit into that philosophy:

| Feature | Suspend (Sleep) 😴 | Hibernate 💾 |
| :--- | :--- | :--- |
| **State Saved To** | **RAM** (memory) | **Disk** (swap space) |
| **Power Usage** | **Low power**. The RAM must stay powered on. | **Zero power**. The computer is fully off. |
| **Resume Speed** | **Very Fast** (1-3 seconds). | **Slower** (10-30+ seconds, depends on RAM size and disk speed). |
| **Data Safety** | **Vulnerable**. If power is lost (e.g., battery dies), the session is gone. | **Safe**. The session is saved on disk and survives a total power loss. |

For a laptop, **Hibernate** is the superior choice for saving your session over long periods without draining the battery at all. For an always-on home server, however, you'd use **neither**, as its job is to be available 24/7.

## Forging Your Tools: Installing a Proper Editor

---

And there you have it. Despite all the touting of NixOS it can't be all 1-sided
joy. There has to be a price to pay. And the price is that before long you're
going to have to edit files. And you're going to want to get comfortable with
the command-line to do this as a first major step towards future-proofing
yourself in a way that you don't have to figure out what text editor is
available and how to do that every time.

Perhaps in a move to not make NixOS profoundly too geeky, they made the 3-fold
strange decision to:

1. Include only the GNU GNOME Console program and not the Terminal program
   proper.
2. Include only the `nano` program and not `vim` proper, nor even just `vi`.
3. To not use the widely used Linux convention `Ctrl+Alt+T` to allow bringing up
   the terminal (without using the *Super* key).

As much as I love NixOS I think their default setup is coddling the new user a
bit too much like a "normal" Linux distro, right as they force them into editing
files right away without the most common power-user path to do so:

1. Press `Ctrl+Alt+T` to bring up a terminal.
2. Type `vim`+[filname]

What we are forced to do instead as part of this bootstrapping process — if
you're not copying an existing `configuration.nix` file over for a complete
system cloning — is:

1. Tap the *Super* key
2. Type "terminal"
3. Hit Enter
4. Type `nano`+[filename]

In this case command #4 will very often actually be:

    sudo nano /etc/nixos/configuration.nix

The beginner or amateur who still uses `nano` can bootstrap the process this
way. And in fact at this point probably the best move is to teach you how to
open `vim` on the fly using `nix-shell`. But no, instead I'm going to instruct
you to go ahead and use the nano program to arrow-key down to where it says:

```nix
  environment.systemPackages = with pkgs; [
  #  vim
```

...to delete the `#` to the left of vim.

Press `Ctrl+O`

Press Enter

Press `Ctrl+X`

Type: `sudo nixos-rebuild switch` and hit Enter.

Now you have vim.

If you're like me and prefer NeoVim over vim then replace the word `vim` with
`neovim`. The rest of the instructions are the same.

When you do the system rebuild, you will see the system get rebuilt which is
stunningly fast for what it claims to be doing (rebuilding an entire system).
There's so much of the magic of NixOS in this fact, but it's too much to cover
here suffice to say the answer is in the `/nix/store/` location that caches
everything in there "flat packed" and well indexed for later pointing-to.
Anything new just needs to be added there (usually fetched from GitHub) and the
pointers set pointing.

Another part of the amazing magic here is that after the system rebuilds, you
don't have to reboot or even close and open the terminal window. You've just got
your new command right there in that same terminal shell console whatever that
you can just type `vim` into (or `nvim` if NeoVim was your choice) and just
start using it.

Congratulations. You just bootstrapped yourself to the most astounding and
world-changing version of Linux the world has ever seen — one that starts your
lifetime journey of future-proofing yourself in the age of AI.

Prepare to think in vim.

---

## Book Analysis

### Ai Editorial Take
This journal entry is a superb example of what makes this book project unique. It's not just a technical manual; it's a philosophical journey. The author successfully frames NixOS not as a mere operating system but as a foundational tool for achieving digital sovereignty and escaping the pitfalls of modern consumer tech. The narrative effectively demonstrates how a seemingly small technical choice, like choosing a text editor, is actually a profound step in shaping one's entire digital existence. The integration of AI conversations as a knowledge source is a forward-thinking way to model learning, perfectly aligning with the book's theme of 'Future Proofing Your Tech Skills In the Age of AI'.

### Title Brainstorm
* **Title Option:** Bootstrapping a NixOS Philosophy: From First Update to Vim
    * **Filename:** `bootstrapping-nixos-philosophy.md`
    * **Rationale:** This title is preferred because it captures the dual meaning of 'bootstrapping' in the text: the technical setup of the OS and the development of a personal philosophy around technology, hardware, and software choices.
* **Title Option:** NixOS: Beyond the First Update
    * **Filename:** `nixos-beyond-first-update.md`
    * **Rationale:** A straightforward, descriptive title that clearly communicates the article's practical content for readers looking for post-installation guidance.
* **Title Option:** The NixOS Mindset: Hardware, Hibernate, and Vim
    * **Filename:** `nixos-mindset-hardware-hibernate-vim.md`
    * **Rationale:** This title uses alliteration and highlights the three distinct thematic sections of the journal entry, appealing to readers interested in the holistic experience of adopting NixOS.
* **Title Option:** Rebelling with NixOS: A Stand Against Disposable Tech
    * **Filename:** `rebelling-with-nixos-disposable-tech.md`
    * **Rationale:** A more provocative and philosophical title that leans into the strong anti-consumerist and pro-sovereignty themes present in the author's reflections on hardware.

### Content Potential And Polish
- **Core Strengths:**
    - **Authentic Voice:** The first-person, stream-of-consciousness style effectively blends technical steps with the 'why' behind them, making the content relatable and compelling.
    - **Practical Value:** The entry contains clear, actionable guides for essential first steps in NixOS: updating, switching to the unstable channel, understanding hibernate, and installing Vim.
    - **Philosophical Depth:** The connection drawn between a declarative OS like NixOS and a broader philosophy of technological sovereignty and anti-obsolescence is powerful and unique.
    - **AI Integration:** The inclusion of the Gemini conversations is a novel and effective way to present structured technical information within a narrative flow.
- **Suggestions For Polish:**
    - **Visual Separation:** Consider using markdown blockquotes for the Gemini responses to create a clearer visual distinction between the author's narrative and the AI's technical instructions.
    - **Smoother Transitions:** The shift from the Hibernate/Suspend discussion to the critique of default text editors is a bit abrupt. A single sentence could be added to bridge the two topics, such as linking the need for configuration (for hibernate) with the primary tool for configuration (the editor).
    - **Concluding Summary:** A brief concluding paragraph could tie together the disparate themes (updating, hardware, power, editors) back to the central idea of 'future-proofing' to give the entry a stronger sense of finality.

### Next Step Prompts
- Based on the author's frustration with default tools and their move to install `neovim`, generate a follow-up journal entry detailing the first steps of configuring Neovim on NixOS. The entry should explore creating a `home-manager` configuration for Neovim, explaining how this declarative approach aligns with the 'future-proofing' philosophy.
- Expand on the 'Chip O'Theseus' concept. Write a detailed guide on how to source, select, and set up a refurbished enterprise machine (like the HP Z640) as a home server running NixOS. Cover hardware considerations, the NixOS installation process for servers, and a simple first project, like setting up a file-sharing service.

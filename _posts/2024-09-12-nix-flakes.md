---
title: Getting Started with Nix Flakes
permalink: /nix-flakes/
description: Fill in
layout: post
---

## Getting Started with Nix Flakes

I'm just starting to grok nix. I discovered NixOS some months ago, and
recognized kindred spirit. Some 15 years ago, I stared a project called Levinux
that tried to make a completely portable minimum Linux system for through the
ages that would play host to such roles as my main development system and home
of a private journal. But I based it on ye old emulator, QEMU, and it lacked
performance and viability as a main day-to-day platform. Both virtual machines
and containers have disappointed me too. 

But a language exits for you to deterministically define a whole system with a
text file? It'd be like a bash file that does a whole bunch of sequential apt
installs without version issues because everything's pinned. In such a scenario,
you can just rebuild a system anytime, anywhere and on almost anything. Hardware
changes. Platforms change. But a phantom system can cut through it all in time
and space by nixing all those versioning issues of Unix/Linux, or Unix-like, or
sometimes *nix, or just nix. 

What a brilliant name for a brilliant system. I would have preferred if it was
just Python, somehow. But as it is, it's related to Haskell as far as syntax,
which means it's yet another curly brace language, but even weirder. It's going
to take some polyglotism that ain't really in me. I'm a confirmed monoglot. I
speak English-only, in terms of spoken languages, and I speak Python only when I
can help it, in machine terms. Much doesn't fit my head. Python does, just
barely. Taking on learning this system configuration language is a challenge for
me, but one that is worth it.

Nix is three things, a language, an operating system and a package manager. When
Nix builds your whole OS, it's called NixOS, and is basically a Linux distro,
though there is some debate around whether it qualifies as a Linux distro, being
so radically different from mainstream versions like Redhat or Debian. The
system is built from the software in the Nix package management system using the
Nix language. There's a triangle diagram out there that tries to explain it.
It's all so well thought out, and has not been around in operation getting
battle hardened and time-tested enough that it's safe to take up.

When you first take up NixOS, a large part of the appeal is that the entire
system gets defined and built from a single file called configuration.nix which
is located in `/etc/nixos/`, but also being a text-file as it is, one of the
first things you want to do is put it in a git repo and perhaps push it up to
Github so your system can become a living, growing document that's with you for
the rest of your life, potentially. Not only does Nix fix the "not on my
machine" problem, but it makes that metaphorical machine a phantom that travels
with you through life, instantiatable on any hardware like a spell of
possession.

If only it were that easy. This ultra-simplified view of Nix and NixOS hits its
first weakness in that `/etc/nixos/` is a protected location belonging to the
admin root user and not the system user, so while you can edit it easily enough
with the `sudo` command, making the whole directory into a git/GitHub repo is
challenging. One of the first things a user might do to mitigate this issue is
to create a separate folder and copy the files over while changing ownership and
permissions making managing it with git easier. But if you're going to do that,
why not just symlink to the new directory? Enter Nix Flakes.

I've resisted Nix Flakes for months. Things are complicated enough not only
switching off of Windows and Mac and onto Linux, but it's switching onto a
version of Linux where everything is different than a normal Linux.  Normal
Linux like Redhat, Debian or Arch use something called the Filesystem Hierarchy
Standard (FHS) and all files are put in location. On NixOS, while the FHS is
still there, all the files are symlinked into location. 

Given all the radical new thinking required for a full OS-switch (not required
for just using nix on Mac or Windows), I avoided the extra complication of
Flakes. In my mind, nix nixed the complication by gathering everything into one
`/etc/nixos/configuration.nix` file, and flakes flaked out the simplicity. The
touted benefit of Flakes seemed only to be exact version pinning when you
distributed sub-chunks (flakes) of a system to other people on different systems
so they could deterministically reproduce it. 

Me: When you're on NixOS and you start using Nix Flakes for the first time, is
it true that the files in your /etc/nixos/ location can become extremely
minimal? The main purpose of configuration.nix is to activate the optional
flakes feature, after which all nixos-rebuild activity is based off of a
configuration.nix file located in some other location under git version control?
If so, give me the typical minimum configuration.nix that can replace the
original.

Perplexity: Yes, when you start using Nix Flakes on NixOS, the configuration in `/etc/nixos/` can indeed become very minimal. The main purpose of the `configuration.nix` file in this case is primarily to enable the Flakes feature and point to your Flake-based configuration, which is typically stored in a separate Git repository.

Here's a typical minimal `configuration.nix` that you might use when transitioning to Flakes:

```nix
{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.configurationRevision = pkgs.lib.mkIf (self ? rev) self.rev;
  system.stateVersion = "24.05"; # Replace with your initial NixOS version
}
```

This configuration does the following:

1. It enables the Nix Flakes feature by setting the `nix.package` to `nixFlakes` and adding the necessary experimental features[1].

2. It sets the `system.configurationRevision` to track the Git revision of your Flake, which can be useful for debugging[1].

3. It maintains the `system.stateVersion`, which should be set to the NixOS version you initially installed[1].

With this minimal configuration in place, you can then manage your entire NixOS configuration using a `flake.nix` file located in a separate Git repository. This Flake-based configuration will typically include your full system configuration, home-manager configuration (if used), and any other custom modules or packages[3].

When you run `nixos-rebuild`, it will use the Flake-based configuration instead of the traditional `/etc/nixos/configuration.nix`. You would typically run `nixos-rebuild` with the `--flake` option to specify the location of your Flake, like this:

```
sudo nixos-rebuild switch --flake /path/to/your/flake/repo#hostname
```

This approach allows for better version control, reproducibility, and modularity in your NixOS configuration[6][7].

Citations:

    [1] https://www.reddit.com/r/NixOS/comments/18un11e/which_packages_are_installed_with_minimal/
    [2] https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution
    [3] https://nixos-and-flakes.thiscute.world/nixos-with-flakes/get-started-with-nixos
    [4] https://discourse.nixos.org/t/what-is-the-etc-nixos-file-for/27821
    [5] https://nixos.org/manual/nixos/stable/
    [6] https://borretti.me/article/nixos-for-the-impatient
    [7] https://github.com/Misterio77/nix-starter-configs
    [8] https://gist.github.com/matthewjberger/7e2dd875361e271f3800df1715139059


Me: But honestly, replacing your original configuration.nix file with a minimal version is not really even necessary, given that the ln symlink makes any attempt to reach or edit files in /etc/nixos/ end up editing them in the new, now git-managed, location right? Even attempts to use the old commaand:

sudo nixos-rebuild switch

...without the --flake parameter and new location specified, the system rebuild will occur using the new location? By activating the optional flake features in configuration.nix, copying the content of /etc/nixos/ to a new location and symlinking the new location to /etc/nixos/ have we effectively masked out the old location?

Perplexity: Yes, you're correct. When you set up NixOS to use Flakes and symlink the new configuration location to `/etc/nixos/`, you effectively mask out the old location and redirect all operations to the new, git-managed location. Here's a breakdown of what happens:

1. Activating Flakes: By adding the Flakes feature to your `configuration.nix`, you enable the system to use Flake-based configurations[3].

2. Symlinking: When you create a symlink from the new location to `/etc/nixos/`, any attempt to access or modify files in `/etc/nixos/` will actually operate on the files in the new location[5].

3. `nixos-rebuild` behavior: Even if you run `sudo nixos-rebuild switch` without the `--flake` parameter, the system will use the configuration files pointed to by the symlink[5].

4. Masking the old location: The symlink effectively masks out the old `/etc/nixos/` location, redirecting all operations to your new, git-managed configuration[5].

Given this setup, you're correct that it's not strictly necessary to replace the original `configuration.nix` with a minimal version. The system will use the configuration files in your new location, regardless of how you invoke `nixos-rebuild`.

However, there are a couple of reasons why you might still want to keep a minimal `configuration.nix` in `/etc/nixos/`:

1. Clarity: It can serve as a clear indicator that the system is now using a Flake-based configuration.

2. Fallback: In case something goes wrong with your Flake setup, having a minimal working configuration can be helpful for recovery.

3. Documentation: It can act as a quick reference for where the actual configuration lives.

Citations:

    [1] https://www.reddit.com/r/NixOS/comments/qjb1l1/what_does_the_minimal_version_of_nixos_consist_of/
    [2] https://discourse.nixos.org/t/minimal-configuration-nix-with-rest-done-by-home-manager/15636
    [3] https://nixos-and-flakes.thiscute.world/nixos-with-flakes/get-started-with-nixos
    [4] https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution
    [5] https://borretti.me/article/nixos-for-the-impatient
    [6] https://discourse.nixos.org/t/how-to-have-a-minimal-nixos/22652
    [7] https://github.com/Misterio77/nix-starter-configs
    [8] https://nixos.org/manual/nixos/stable/

So I was incorrect in my original assumption that activing Nix Flakes was going
to complicate things at all. Even without taking advantage of the other features
of flakes, it had the immediate effect of simplifying the git backup procedure
of my `/etc/nixos/configuration.nix` file by just moving where it is located to
somewhere it can be maintained with user instead of admin permissions. It's
really still just one file, just in a new location. And now, I can take my time
embracing all the other benefits of flakes.

So just to clarify, just the mere presence of the following line in your
original `configuration.nix` turns the flakes feature on.

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

After that point, if you want system-rebuilds to work from a new location, you
would have to use this very long command to point to the particular location and
hostname (the thing after the hash) to build from the new location:

    sudo nixos-rebuild switch --flake /home/username/nixos-config#nixos

But that's too much cognative overhead for a system rebuild. Here's what I did
in order to do it once. You'll notice that turning it into a git repo is a part
of the process. The Nix Flake feature and git seem very intertwined. So when
you're making a location you're going to keep flakes

    mkdir ~/nixos-config
    sudo cp /etc/nixos/* ~/nixos-config/
    sudo chown -R $USER:users ~/nixos-config
    cd ~/nixos-config

This makes a copy of your `/etc/nixos/` location. But now that you're in there,
you actually do need to add a very mimimal flake file...

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
```

Now with all the files in place, you need to turn it into a git repo...

    git init
    git add .
    git commit -m "Initial commit"

And now you should be able to check that everything's in place with this
command:

    nix flake check

And finally if everything checks out, you can rename the old location and
symlink the new location there...

    sudo mv /etc/nixos /etc/nixos.bak  # Backup old config
    sudo ln -s /home/username/nixos-config /etc/nixos  # Symlink new config

And now, you should be able to proceed with business as usual. The new command
that will build your system if you hadn't symlinked is:

    sudo nixos-rebuild switch --flake /home/username/nixos-config#nixos

But because of the symlink, you can continue to...

    sudo nixos-rebuild

And so, I have turned on the Nix Flakes optional feature, switched my
`configuration.nix` over to be more easily managed with git, and my workflow has
not changed at all. I can cautiously approach the new Flake features, which I
actually do need for sharing work with my coworkers, without being overwhelmed
by exploding complexity.


# Beginning of Notes
--------------------------------------------------------------------------------
date: Tue Jul 22, 2025, 16:26
---

It was an interesting day on the Mac. The Mac is a platform desperately trying
to lock you into their ecosystem but it's still Unix underneath, and it's almost
funny them (Apple) not being able to keep you from using it as a pretty powerful
Unix machine, but with a few idiosyncrasies. First and foremost, it's Unix and
not Linux, and as such has no real big automatic free and opens source software
repository ready-made as do Debian-derivative Linux and really even RedHat ones
too. You've got a pretty big selection of free and open source software with
nearly any Linux these days, but not with Mac. And no, Homebrew is not an
official Apple thing. It's a kludge-on by a talented Apple fanbase who think
Unix on Mac could be so much more if it were only Linux.

Mac people need be reminded that the whole Homebrew thing being on your machine
doesn't start with Apple. It starts with the command:

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

And this is someone who remembers Fink and MacPorts before it. Yes, it seems
like Homebrew has grown to a critical escape velocity as far as being a *must
have* Mac utility if you're into *free and open source software.* But I'm here
to tell you there is another way.

If just you put the whole normalized Linux in a folder on your Mac and just ran
stuff from there, it would be just like Linux — a rather generic Linux built
from a declarative Linux system language. Either Nix or Guix will do, but there
is a lot of Mac support out there for some amazing reason for Nix on Mac. You'd
think it the most unholy of alliances, but no. I think Mac people would really
rather not be left out of the Linux fun and can get there with a very Linux
normalizing trick. That is, to make Linux just some normal standard that can be
fired up as a subsystem on anything.

That's Nix.

I know, it's weird. But it's sort of like Docker and Virtual Machines each seemd
weird in their time but it's only just natural to you now to think in terms of
containers and VMs. Same thing but with whole subsystems that don't need all the
overhead of their own separate containers and VMs. They just carry all the
generic Linux stuff they need to fully live in the subfolder of a Mac.

A declarative system-building language means you declare what your hardware
configuration is to build your system, and so on through the software and
optionally right down to your plugins, pip installs and such. All the NVidia and
custom handling goes in there, and of course what you're defining has to match
your hardware. But all the tricky stuff gets handled automatically and put into
an automatically generated `hardware-configuration.nix` file.

But that's another story. Point is, all your system hardware is a text-file. If
it's a subsystem on a Mac or Windows WSL, that file is a `flake.nix` file, aka
Nix flake. But if it's defining the whole operating system, it's a
`configuration.nix` file. It can be the whole shebang, NixOS. Or if you you're
one of the Mac cool kids, nixOS. But most Mac people won't know Nix as nixOS but
rather as something more similar to Homebrew brew installs.

Nix is like Homebrew but generic beyond Macs so that anything you build that way
is portable across anything with just the `nix` command. If you've got nix and a
flake.nix file, you can build a Linux subsystem with portable apps in the folder
of a Mac or Windows WSL machine. The nix command knits together the system from
the flake.nix file.

Yes, there is something called NixOS which is the full system build out of this,
and yes that is what I'm running at home now as my main system probably now and
forever. But no, I'm not advocating NixOS. I like it for myself, but cool
proprietary host systems from companies like Apple and Microsoft are nice too.
It's the nix command as a software repo and genreic Linux-builder that I'm
talking about.

The nix command lives a separate life from NixOS as something just like brew. Or
if you're of the Debian-persuasion, `alt` and `alt-get`. It's just another repo
command, but because it goes hand-in-hand with building the whole system soup to
nuts just from a text-file, it becomes oh so much more — like an inflatable
container from original ingredients. Forget a giant file. Just move your
`flake.nix` around and hydrate it with nix.

Okay, so a Linux system runs in your Mac's subfolder. So what? What can it do?
Well if it's a webserver, it can run a website accessible to your normal browser
at the location `localhost:<port>`. We use ports so that we can host more than
one thing at the localhost address. I use FastHTML's default 5001 for Pipulate.
I'm not balking conventions. And so the JupyterLab I bundle in with Pipulate is
at localhost:8888.

Yes, to answer the first question the main thing you can do with a Linux
subsystem on a Mac is to run a webserver. This is done with Node all the time.
In fact if you use any Electron platform app like VSCode, Discord, Zoom, Slack,
well then you're running a locally installed web app made to look like a native
program. And then you have to create an installer for each platform and be
limited to Node and the JavaScript software stack. But if you just run generic
Linux you can run whatever tech stack you want.

And that's what I do. I run whatever tech stack I want because generic Linux on
whatever desktop. And yes, locally installed and not the cloud. Local-first AI
SEO software. It will be useful for so much more than SEO but we start with SEO
because it's what I know and can hold a day job for knowing. So first SEO and
tomorrow whatever needs workflows with local AI intelligence in the pipeline.

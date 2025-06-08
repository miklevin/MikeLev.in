---
title: "Building a Secure Home Hosting Network with pfSense and Verizon Fios"
permalink: /futureproof/pfsense-firewall-secure-home-network-hosting-setup/
description: In this log, I've documented the process of setting up a dedicated Topton N100 mini-PC running pfSense as my primary firewall to create a more secure foundation for hosting services from my home network, specifically with Verizon Fios. I cover the rationale for moving away from the ISP-provided router for core routing, the hardware selection process, the crucial initial pfSense console setup steps (interface assignment), and the essential reconfiguration of the Verizon CR1000A router into an access point to resolve IP conflicts and integrate it correctly behind the new firewall, achieving the goal of a properly segmented network baseline.
meta_description: Guide configuring pfSense firewall on mini PC (Topton N100) for secure home hosting with Verizon Fios. Covers initial setup, ONT connection, resolving IP conflict with ISP router (CR1000A) by setting it to AP mode.
meta_keywords: pfSense, firewall, setup, guide, configuration, home network, security, hosting, server, verizon fios, ont, mini pc, topton, n100, intel i226-v, cr1000a, router, access point, ap mode, dmz, network segmentation, lan, wan, dhcp, ip conflict, console setup, home lab, firewall appliance, network security, qotom, protectli, opnsense
layout: post
sort_order: 1
---

## Understanding Secure Home Networks for Hosting: Getting Started

If you've ever thought about running your own website, cloud storage, or game server directly from your home, you might realize that simply plugging it into your regular internet setup isn't the safest option. Standard internet routers provided by companies like Verizon Fios are designed for convenience but often lack the robust security features needed when exposing services to the public internet. If someone were to compromise your home-hosted server, they could potentially gain access to your entire home network, including personal computers and devices.

This article explores a more secure approach called network segmentation. The core idea is to use a dedicated, more powerful firewall device to create isolated zones within your home network. One crucial zone is often called a Demilitarized Zone (DMZ), which houses your public-facing servers. This setup acts like a buffer, allowing traffic to reach your server but strictly preventing anything malicious on the server from reaching your trusted internal network. The text documents one person's journey in selecting the right hardware (a specialized mini-PC) and software (pfSense, an open-source firewall system) and configuring it to work with a typical Verizon Fios connection, laying the groundwork for safer home hosting.

---

## The Secure Foundation: Taking Control of Your Home Network for Hosting

The dream of hosting services from home – a personal website, a private cloud, a game server – offers unparalleled control and flexibility. But this power comes with responsibility. Simply opening ports on your standard ISP-provided router can be akin to leaving your front door unlocked, potentially exposing your entire home network to threats if your public-facing server is compromised. This article chronicles a detailed, practical journey towards building a more secure network foundation using pfSense, specifically tailored for users with services like Verizon Fios, tackling the initial hurdles and setting the stage for safer home hosting.

**The Initial Hurdle: Limitations of ISP-Supplied Gear**

Most residential internet setups, like those provided by Verizon Fios, involve an Optical Network Terminal (ONT) converting the fiber signal to Ethernet, which then feeds an ISP-branded router (e.g., the Verizon CR1000A). This single box typically handles routing, Wi-Fi, DHCP, NAT, and basic firewalling. While convenient for everyday use, it presents limitations for secure hosting:

1.  **Lack of Granular Control:** ISP routers offer limited firewall customization, making it difficult to implement robust segmentation rules.
2.  **Flat Network Risk:** Connecting a home server directly to the ISP router (even using its "DMZ" feature, which often just forwards all ports) places it on the same logical network as your personal computers, phones, and smart devices. A compromise of the server could allow an attacker lateral movement within your trusted network.
3.  **The "Switch Illusion":** Placing a simple network switch *between* the ONT and the ISP router is a common misconception. ISPs usually provide only one public IP address. A switch doesn't route or assign IPs; it merely connects devices on the same segment. This approach fails to provide isolation or even reliable connectivity for multiple devices trying to grab the single public IP.

**The Goal: True Network Segmentation via a Dedicated Firewall**

To securely host services, the standard best practice is to implement a **Demilitarized Zone (DMZ)**. This isn't just a router setting; it's a separate network segment isolated from your internal network by a capable firewall. This requires introducing your own dedicated router/firewall appliance into the chain, placed *between* the ONT and your existing ISP router (which can then be repurposed).

The topology shifts to:

`Internet -> ONT -> Your Firewall -> [DMZ Port -> Server] & [LAN Port -> ISP Router -> Internal Devices]`

Your dedicated firewall becomes the primary gateway, managing the public IP, routing traffic, and enforcing strict rules: allow specific traffic *to* the DMZ server, but critically, **block traffic *from* the DMZ server *to* your internal network.**

**The Hardware Quest: Finding the Right Tool for the Job**

Selecting the right hardware for this dedicated firewall is crucial. The requirements often include:

* Multiple Gigabit (or faster) Ethernet ports (at least 3: WAN, LAN feed, DMZ).
* Sufficient processing power for routing and firewalling at line speed.
* AES-NI CPU support (for efficient VPN performance, if needed later).
* Low power consumption and small footprint.
* **Local Management:** Crucially, avoiding cloud-dependent, subscription-based devices.

The journey involved considering, and discarding, several options:

* **QNAP NAS:** Using a multi-port NAS seemed clever but posed a significant security risk. Hosting the public service directly on the firewall device means a server compromise could grant control over the firewall itself.
* **Old Routers (WRT54GS):** While historically hackable, these devices are severely underpowered (slow CPUs, 10/100 Mbps ports), creating an unacceptable bottleneck for modern internet speeds like Fios Gigabit. Finding secure, up-to-date firmware is also challenging.

The search culminated in identifying **purpose-built mini PC firewall appliances** as the ideal solution. Brands like Protectli, Qotom, and various generic vendors (Topton, HUNSN, etc.) offer compact, often fanless boxes with multiple Intel NICs, designed specifically for running open-source firewall distributions like pfSense or OPNsense.

The specific hardware chosen in this journey was a **Topton N100-based appliance**, configured with:

* **CPU:** Intel N100 (Alder Lake-N, efficient and capable)
* **RAM:** 8GB DDR5
* **Storage:** 128GB NVMe SSD
* **NICs:** 4x Intel i226-V 2.5GbE ports
* **Features:** Fanless, AES-NI, HDMI/DP for console access

This configuration provides ample performance for multi-gigabit routing/firewalling, sufficient RAM and storage for the OS and common packages, and reliable Intel network interfaces, all without vendor lock-in or subscriptions. A portable HDMI monitor was also acquired for easier initial setup.

**The Software: pfSense (Pre-Installed)**

While OPNsense and even NixOS were considered viable (and compatible) options for this hardware, the chosen appliance came pre-installed with **pfSense**, a mature, powerful, and widely used open-source FreeBSD-based firewall distribution.

**Step-by-Step: Initial pfSense Setup and Network Integration**

With the hardware acquired and pfSense ready, the practical setup began:

1.  **Console Connection:** The Topton box was connected to the portable monitor, keyboard, and mouse.
2.  **Initial Boot & Console Menu:** On first boot, pfSense presents a console menu. (Note: A port labeled "COM" on such hardware is for serial console access, *not* network traffic like WAN).
3.  **VLAN Question:** pfSense prompts: "Do VLANs need to be set up first?". For creating physically separate LANs using different ports (the goal here), and unless the WAN connection itself requires a VLAN tag (uncommon for Fios ONT Ethernet), the correct answer is **No**. VLANs (virtual LANs running over a single physical port) can be configured later via the web interface if needed.
4.  **Interface Assignment (Crucial Console Step):** pfSense needs to know which physical port serves which function.
    * The console lists available interfaces (e.g., `igc0`, `igc1`, `igc2`, `igc3` for the Intel 2.5GbE ports) and asks the user to assign WAN and LAN.
    * The Ethernet cable from the **Verizon ONT** was connected to one physical port, and its corresponding interface name (`igc0`, `igc1`, etc.) was assigned as **WAN**.
    * A *different* physical port was chosen for the primary internal network connection, and its interface name was assigned as **LAN**. (Additional ports for DMZ, etc., can be assigned here or later).
5.  **Accessing the WebConfigurator:**
    * A computer was connected directly to the physical port assigned as **LAN** on the pfSense box.
    * A web browser was opened to the default pfSense LAN IP: `http://192.168.1.1`.
    * Login used default credentials (`admin`/`pfsense`).
6.  **Basic Web Configuration:**
    * **WAN:** Verified the WAN interface (Interfaces -> WAN) was set to **DHCP** (or DHCP6 for IPv6) to correctly receive its IP configuration from the Verizon ONT. Checked Status -> Interfaces to confirm it received a public IP.
    * **LAN:** Verified the LAN interface (Interfaces -> LAN) had the static IP `192.168.1.1` and that the DHCP server was enabled (Services -> DHCP Server -> LAN) to provide IPs to devices connected to it (like the management computer).
    * **Initial Test:** Verified basic internet connectivity from the computer connected directly to the pfSense LAN port.

**Taming the Beast: Reconfiguring the Verizon Router**

A common stumbling block occurred next: simply plugging the original Verizon Fios router (Model CR1000A in this case) into the pfSense LAN caused issues. Why? **IP Address Conflict.** Both pfSense (default `192.168.1.1`) and the Fios router (default `192.168.1.1`) were trying to control the same network space. Furthermore, the Fios router was still trying to *be* a router.

The solution was to demote the Fios router to a simple **Access Point and Switch**:

1.  **Isolate Fios Router:** Disconnected the Fios router from pfSense. Connected a computer *directly* to a LAN port on the Fios router.
2.  **Log into Fios Router:** Accessed its admin page (still at `http://192.168.1.1` at this point).
3.  **Locate LAN Settings:** Navigated through the menus (typically Network -> Network Connections -> Edit "Network (Home/Office)" profile on the CR1000A).
4.  **Change LAN IP:** Changed the Fios router's own LAN IP address to something on the pfSense network but outside the pfSense DHCP range (e.g., `192.168.1.2`). Subnet mask remained `255.255.255.0`.
5.  **DISABLE DHCP Server:** Found the DHCP Server setting within the same LAN profile section and **disabled it**. This ensures only pfSense assigns IPs.
6.  **Save and Apply:** Saved the changes on the Fios router.

**The Final Connection and Verification:**

1.  **Connect LAN-to-LAN:** Connected an Ethernet cable from a **LAN port** on the reconfigured Fios router (now at `192.168.1.2`) to the primary **LAN port** on the pfSense box (`192.168.1.1`). **The WAN port on the Fios router remains unused.**
2.  **Test:**
    * Confirmed devices connected (wired or wirelessly) to the Fios router now received IP addresses from pfSense (`192.168.1.x` range, gateway `192.168.1.1`).
    * Confirmed internet access worked correctly through this setup.
    * Confirmed access to both web interfaces: pfSense (`http://192.168.1.1`) and the Fios router (`http://192.168.1.2`).
    * (Real-world tip: When changing the Fios router's Wi-Fi password after this setup, client devices like phones often need to explicitly "Forget Network" before they will connect successfully using the new password.)

**Current Status: Foundation Laid**

At this point, the network topology is vastly improved. The dedicated pfSense firewall controls the internet connection and serves as the primary gateway. The original ISP router functions purely as a switch and Wi-Fi access point for the trusted internal network, sitting securely behind pfSense.

This configuration provides the necessary control and segmentation capabilities. The next logical steps on the home hosting journey include:

1.  **Configuring the DMZ:** Assigning another physical port on the pfSense box (e.g., the one intended for the web server) to a new interface (e.g., OPT1), renaming it "DMZ," giving it a separate IP subnet (e.g., `192.168.10.1/24`), enabling DHCP or setting static IPs for servers within it, and configuring the critical firewall rules to allow specific inbound traffic while blocking DMZ-to-LAN traffic.
2.  **Handling Dynamic IP:** Since a static IP wasn't requested from the ISP, setting up **Dynamic DNS (DDNS)** within pfSense (using services like DuckDNS, No-IP, Cloudflare API, etc.) or configuring a **Cloudflare Tunnel** is necessary to reliably map a domain name to the changing home IP address.
3.  **Server Setup:** Configuring the actual server hardware (Raspberry Pi, old laptop, etc.), possibly using NixOS as planned for portability, and deploying the web server software (like Jekyll behind Nginx/Apache).

**Conclusion: Control and Confidence**

Setting up a dedicated firewall like pfSense is a significant, but achievable, first step towards secure home hosting. While it involves navigating hardware choices, understanding network concepts like DMZs and IP conflicts, and performing careful configuration, the result is a network foundation that offers vastly superior control, visibility, and security compared to relying solely on ISP equipment. This foundational work paves the way for deploying home-hosted services with greater confidence, knowing that robust measures are in place to protect the internal home network.

---

## Addendum: Troubleshooting Elusive IPv6 Connectivity

While the initial setup laid a solid IPv4 foundation and successfully demoted the Verizon CR1000A router, the modern internet demands robust IPv6 support as well. My goal was always dual-stack capability, allowing devices to use IPv6 where available. However, shortly after the baseline configuration, I encountered perplexing IPv6 issues that weren't immediately obvious.

**The Symptoms: IPv6 Aware, But Not Connected**

On a client machine connected to the pfSense LAN (a NixOS system, in this case), basic network checks revealed a split personality:

* `nslookup google.com` worked perfectly, resolving both IPv4 and IPv6 addresses. DNS was clearly functional for both protocols.
* `ping -4 google.com` (forcing IPv4) worked flawlessly, confirming the core IPv4 routing through pfSense was solid.
* `ping google.com` (which defaulted to IPv6 on this system) or `ping -6 google.com` failed completely with 100% packet loss.

This immediately isolated the problem: IPv6 name resolution worked, but actual IPv6 packet transmission was failing somewhere between the client and the internet. My initial suspicion fell on the client's firewall (configured on NixOS), but a review showed standard stateful rules and an open outbound policy, making it an unlikely culprit for blocking outgoing pings.

**Narrowing the Search: Traceroute and Local Pings**

To pinpoint the failure, I turned to `traceroute -6 google.com`. The result was stark: timeouts (`* * *`) starting from the very first hop. This meant the client couldn't even reach its designated default gateway – the pfSense router – using IPv6.

Further testing confirmed this local breakdown:

* Pinging the pfSense router's LAN IPv4 address (`192.168.1.1`) worked instantly.
* Pinging the pfSense router's LAN IPv6 addresses (both its global address derived from my ISP prefix and its link-local address) failed completely.

This was confusing. I verified the pfSense LAN interface settings (`Interfaces -> LAN`). It was correctly set to `Track Interface` for IPv6 Configuration Type and, according to the `Status -> Interfaces` page, it *did* have both global and link-local IPv6 addresses assigned, derived correctly from the WAN. The interface itself seemed configured correctly. My next thought turned to the services needed for IPv6 auto-configuration.

**The "Aha!" Moment: Rogue Router Advertisements**

IPv6 clients typically learn their default gateway via Router Advertisement (RA) messages sent by the local router. I checked the pfSense RA service configuration (`Services > DHCPv6 Server & RA > Router Advertisements`) and confirmed it was enabled for the LAN interface (initially `Assisted`, later switched to `Stateless` during testing – both valid modes).

The real breakthrough came when examining the client's IPv6 routing table using `ip -6 route show default`. Instead of showing just one default gateway, it listed **two** distinct link-local `fe80::...` nexthop addresses advertised via RA!

One address clearly corresponded to the pfSense box (matching its MAC address via the EUI-64 format). The *other* link-local address belonged to the **Verizon CR1000A router** – the very device I thought I had successfully relegated to a simple Access Point! Despite disabling its DHCP server and changing its IP, it was still sending out IPv6 Router Advertisements, declaring itself a gateway and confusing clients on the network. This created routing instability and was almost certainly the cause of the connectivity failures.

**Silencing the Conflict: Disabling IPv6 on the CR1000A**

Armed with this knowledge, I logged back into the CR1000A's admin interface (`192.168.1.2`). Navigating to its IPv6 settings confirmed the LAN configuration was set to `Stateless`, explaining the RAs. Unfortunately, the firmware didn't offer a simple "Disable Router Advertisements for LAN" option; the only alternative was `Stateful (DHCPv6)`, which would *still* send RAs.

Given that the pfSense box was directly connected to the ONT and handling all primary routing duties, the most definitive solution was to **disable IPv6 support entirely** on the CR1000A using its main IPv6 toggle (Section 1 on its config page). I applied the change and restarted the Verizon router.

**Verification and the Final Hurdle**

Back on the NixOS client (after a network restart), `ip -6 route show default` now correctly showed *only* the pfSense gateway's link-local address listed as a nexthop. Progress!

Next, I tested pings again:

* Pinging pfSense's link-local address (using `ping <pfSense_link_local_address>%<interface_name>`): **Success!** Local IPv6 link communication was finally working.
* Pinging pfSense's global IPv6 address: **Failed.**
* Pinging an external IPv6 host like `ipv6.google.com`: **Failed.**

So, while the local conflict was resolved, reaching global IPv6 addresses (even the one on the pfSense router itself) or routing externally via IPv6 was still broken. This pointed back squarely at pfSense.

**Testing from the Source: pfSense Diagnostics**

Before diving deep into firewall rules, I used pfSense's built-in diagnostics (`Diagnostics > Ping`). I pinged `ipv6.google.com`, ensuring `IPv6` was selected. Crucially, I tested sourcing the ping first from the `LAN` interface's global address and then from the `WAN` interface's address.

The result: **Both tests succeeded.** This proved pfSense *itself* had functional external IPv6 connectivity and could route traffic correctly when initiating it from its own interfaces using its assigned global prefix. The problem wasn't its core routing capability or WAN connection, but likely how it handled traffic *originating from* the LAN clients or the associated firewall states.

**Resolution: The Network Settles**

The next logical step was a meticulous review of the pfSense LAN firewall rules (`Firewall > Rules > LAN`) to ensure the default allow rule correctly covered IPv6 (`IPv4+IPv6`, source `LAN net`, destination `any`) and wasn't being overridden. However, while preparing to scrutinize the ruleset and potentially check the state table (`Diagnostics > States`), I decided to re-test the original application that prompted this deep dive – the Jekyll bundle installer on the NixOS client.

To my surprise, **it worked perfectly.** Subsequent tests showed that external IPv6 pings from the NixOS client now also succeeded. It seemed that the combination of removing the conflicting RAs from the CR1000A, potentially minor adjustments to the pfSense RA settings, and allowing some time for network states and neighbor caches to update across devices had resolved the final blockage, even if the direct ping test failed immediately after the CR1000A change.

**Lessons Learned (IPv6 Edition)**

This troubleshooting detour underscored a few key points:

1.  **ISP Routers Need Taming:** When introducing your own firewall, be *extra* vigilant about disabling conflicting services (DHCPv4, DHCPv6, RAs) on the ISP device, even if you've set it to "AP Mode" or changed its IP. IPv6's auto-configuration mechanisms (RA/SLAAC) can cause non-obvious conflicts.
2.  **Verify with `ip route`:** Don't assume your client is using the correct gateway. Checking the routing table (`ip -6 route show default`) is essential for diagnosing multi-router or rogue RA issues.
3.  **Test from the Router:** Using the firewall's own diagnostic tools (`Diagnostics > Ping` in pfSense) is invaluable for determining if a connectivity problem lies with the firewall itself or with the client/path.
4.  **Patience After Changes:** Network protocols, especially stateful ones involving advertisements and caches, sometimes require a bit of time (or service/device restarts) for changes to fully propagate and stabilize.

While the initial IPv6 setup encountered more hurdles than IPv4, resolving them solidified the network's configuration and provided valuable insight into the intricacies of modern dual-stack networking behind a dedicated firewall.

---

## AI Analysis

* **Title/Headline Ideas:**
    * Building a Secure Home Hosting Network with pfSense and Verizon Fios
    * From Fios ONT to Secure DMZ: A pfSense Firewall Setup Guide
    * Taking Control: Replacing Your ISP Router with pfSense for Safer Hosting
    * Step-by-Step: Installing pfSense on a Mini PC for Fios Home Network Security
    * Securing Your Home Lab: A Practical pfSense Implementation Journey

* **Strengths:**
    * Provides highly specific, actionable steps for a common technical goal (setting up pfSense with Fios).
    * Clearly explains the *reasoning* behind choosing a dedicated firewall and segmentation over ISP defaults.
    * Addresses and provides solutions for common practical hurdles (e.g., the "switch illusion," IP address conflicts with the ISP router).
    * Documents the specific hardware chosen (Topton N100) and configuration details (interface assignment, Fios router AP mode), which is valuable for others considering similar builds.
    * Acknowledges future steps, setting context for ongoing work (DMZ, DDNS).

* **Weaknesses:**
    * Assumes a relatively high level of technical understanding (networking concepts, console interfaces, basic firewall principles).
    * The narrative "journey" format, while illustrative, might be less direct than a purely instructional guide for some readers.
    * Lacks visual aids (network diagrams) which could significantly improve comprehension of the topologies discussed.
    * While setting the *foundation*, it stops short of configuring the actual DMZ rules and server setup, which are critical parts of the overall security goal.
    * Focus on specific hardware (Topton N100, CR1000A) might require adaptation for users with different gear.

* **AI Opinion:**
    This article provides significant value as a detailed, practical walkthrough for users looking to implement a pfSense firewall for secure home hosting, particularly within the Verizon Fios ecosystem. Its strength lies in documenting not just the steps but also the common pitfalls (like the ISP router IP conflict) and the specific hardware/software choices made. While its technical depth and journal-like structure might make it challenging for absolute beginners, it serves as an excellent resource or log for intermediate users undertaking a similar project. It clearly outlines the foundational steps necessary before proceeding to more complex DMZ and server configurations.

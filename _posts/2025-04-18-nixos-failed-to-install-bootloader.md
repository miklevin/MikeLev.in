---
title: "NixOS Upgrade Problem: Failed to Install Bootloader"
permalink: /futureproof/nixos-failed-to-install-bootloader/
description: I just worked through a frustrating NixOS upgrade attempt that failed because the `/boot` partition ran out of space (`OSError 28`). The usual fix, running `nix-collect-garbage -d` to clear old system generations, surprisingly didn't free up any space on `/boot`. Digging deeper, I discovered the problem was orphaned boot files – kernel and initrd `.efi` files left behind from previous generations that the cleanup tool didn't recognize. I ended up crafting a command to safely identify and manually delete these specific orphans, which finally cleared enough space for the `nixos-rebuild switch --upgrade` to succeed.
meta_description: Troubleshoot NixOS full /boot partition (OSError 28 No space left) during upgrades. Fix when nix-collect-garbage fails due to orphaned EFI boot files.
meta_keywords: NixOS, /boot, boot partition, full disk, no space left on device, OSError 28, Errno 28, upgrade failure, nixos-rebuild, EFI, ESP, systemd-boot, orphaned boot files, kernel, initrd, .efi, nix-collect-garbage, manual cleanup, comm command, Nix generations, Linux troubleshooting, systemd bootloader, disk space management, nix store, initrd generation
layout: post
sort_order: 5
---

## Introduction to NixOS Troubleshooting

This article chronicles a technical troubleshooting session involving NixOS, a distinct Linux distribution known for its unique approach to system management. Unlike traditional systems, NixOS uses a declarative configuration model, meaning the entire system setup (packages, settings, services) is defined in configuration files. When the system is updated, NixOS builds a new, complete version of the system, referred to as a "generation." This allows users to easily switch between different system versions or roll back to a previous state if an update causes problems.

## Understanding the Boot Process and Its Challenges

A critical part of the boot process involves placing essential files, like the operating system kernel and an initial ramdisk (initrd), onto a special, often small, partition designated for booting (commonly the EFI System Partition or ESP). 

## The Problem: Full Boot Partition During Upgrade

This article details a situation where this boot partition became completely full during a routine system upgrade, preventing the process from completing. It explores why the standard cleanup methods failed and the steps taken to diagnose and manually resolve a less common underlying issue related to leftover boot files.

---

## The Summarized Fix

Okay, here is a combined, step-by-step procedure you can follow each time you encounter the `OSError: [Errno 28] No space left on device` error during `nixos-rebuild` when it's trying to write to `/boot`. This combines the standard NixOS garbage collection with the specific fix for orphaned boot files.

**The Definitive Procedure for Full `/boot` Partition (`OSError 28`)**

1.  **Attempt Standard Garbage Collection:**
    * Run the standard command to remove old NixOS generations and potentially their corresponding boot files:
        ```bash
        sudo nix-collect-garbage -d
        ```
    * This command will tell you if it deleted anything and how much space was freed *in the Nix store*. It *should* also trigger the removal of associated boot files, but as seen in the article, this doesn't always work perfectly.

2.  **Check `/boot` Disk Space:**
    * After running the garbage collection, check the space on your `/boot` partition:
        ```bash
        df -h /boot
        ```
    * Look at the `Avail` (Available) column and the `Use%` (Usage Percentage). If you now have sufficient space (e.g., Use% is well below 100% and Avail shows several MBs or more), you might be able to proceed directly to Step 5. If it's still full or nearly full (e.g., 100% or 99% used, 0 or very few MB available), continue to Step 3.

3.  **Identify Orphaned Boot Files (Dry Run):**
    * If Step 1 didn't free enough space, the issue is likely orphaned files. Run this command to *see* which files in `/boot/EFI/nixos/` are not referenced by your current bootloader configuration. **This command does not delete anything.**
        ```bash
        echo "--- DRY RUN: Identifying potential orphans ---"
        comm -13 \
          <(grep -h -E '^\s*(linux|initrd)\s+/EFI/nixos/' /boot/loader/entries/*nixos*.conf 2>/dev/null | sed 's|.*/EFI/nixos/||' | sort -u) \
          <(find /boot/EFI/nixos/ -maxdepth 1 -name '*.efi' -printf '%f\n' | sort) \
          | sed 's|^|Would delete: /boot/EFI/nixos/|' \
          | xargs -d '\n' --no-run-if-empty printf '%s\n'
        echo "--- End of Dry Run ---"
        ```
    * **Carefully review the output.** It will list files preceded by `Would delete:`. These are the likely orphans. Ensure these files don't correspond to a generation you actively need (check kernel versions, etc., if unsure). If this command lists nothing, or only files you know you need, stop here – the problem might be different or require manual investigation.

4.  **Remove Orphaned Boot Files (Actual Deletion):**
    * **ONLY IF** Step 3 listed files you are confident are orphans and safe to remove, run this command to actually delete them. **THERE IS NO UNDO.**
        ```bash
        # --- WARNING: ENSURE STEP 3 OUTPUT WAS CORRECT BEFORE RUNNING! ---
        # --- THIS DELETES FILES FROM YOUR BOOT PARTITION ---
        comm -13 \
          <(grep -h -E '^\s*(linux|initrd)\s+/EFI/nixos/' /boot/loader/entries/*nixos*.conf 2>/dev/null | sed 's|.*/EFI/nixos/||' | sort -u) \
          <(find /boot/EFI/nixos/ -maxdepth 1 -name '*.efi' -printf '%f\n' | sort) \
          | sed 's|^|/boot/EFI/nixos/|' \
          | xargs -d '\n' --no-run-if-empty sudo rm --verbose
        # --- CHECK THE OUTPUT TO SEE WHAT WAS REMOVED ---
        ```
    * After running this, check the space again: `df -h /boot`

5.  **Retry Your NixOS Upgrade:**
    * Now that space should be freed up (either after Step 2 or Step 4), try the command that failed initially:
        ```bash
        sudo nixos-rebuild switch --upgrade
        ```
    * It should now have enough space to copy the new kernel and initrd files to `/boot` and complete successfully.

This sequence addresses both standard cleanup and the specific orphaned file issue, providing a robust approach to fixing the common "No space left on device" error for the `/boot` partition in NixOS. Remember to always proceed with caution when deleting files, especially from `/boot`.

---

## The Case of the Full Boot Partition: A NixOS Upgrade Saga

Okay, let's capture that troubleshooting adventure.

It started, as many NixOS adventures do, with a routine command: `sudo nixos-rebuild switch --upgrade`. The goal was simple: update the system to the latest available packages and configuration. However, the familiar process ground to a halt, not with a clear build failure, but with a cryptic Python traceback culminating in a stark operating system error.

### The Symptom: No Room at the Inn

The terminal presented a wall of text, but the critical lines pointed directly at the problem:

```python
OSError: [Errno 28] No space left on device: '/nix/store/15zmjqqrdhnffii2kykhx1sfgck92xfn-initrd-linux-6.12.23/initrd' -> '/boot/EFI/nixos/15zmjqqrdhnffii2kykhx1sfgck92xfn-initrd-linux-6.12.23-initrd.efi'
Failed to install bootloader
warning: error(s) occurred while switching to the new configuration
```

The message `[Errno 28] No space left on device` was unambiguous. The system couldn't complete the upgrade because it failed during a crucial step: copying the newly built initial ramdisk (initrd) file to the boot partition, specifically `/boot/EFI/nixos/`. This directory is where NixOS, when configured with the common systemd-boot loader, stores the kernel and initrd `.efi` files needed to actually boot each system generation. Without this copy, the upgrade couldn't activate.

### Initial Diagnosis: A Full /boot Partition

In the world of NixOS, where rollbacks are a key feature, the system keeps multiple generations available. Each generation typically requires its own kernel and initrd copy in `/boot`. Over time, especially on systems with a relatively small `/boot` partition (often the EFI System Partition, or ESP), these files can accumulate.

A quick check confirmed this suspicion:

```bash
[user@nixos:~/repos/nixos]$ df -h /boot
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       511M  511M     0 100% /boot
```

The `/boot` partition (`/dev/sda1`), sized at 511MB, was completely full – 100% usage with zero bytes available. This definitively explained the `OSError: [Errno 28]`.

### The Standard Fix Fails: A Deeper Mystery

The standard operating procedure in NixOS for a full `/boot` partition is to clean up old, unused generations. This not only removes references from the Nix store but crucially also removes the corresponding kernel and initrd files from `/boot`. The command for this is `sudo nix-collect-garbage -d`.

We ran the command:

```bash
[user@nixos:~/repos/nixos]$ sudo nix-collect-garbage -d
removing old generations of profile /nix/var/nix/profiles/system
...
0 store paths deleted, 0.00 MiB freed
```

Surprisingly, while the command acknowledged removing old generation *references*, it freed no space in the Nix store, and more importantly, a subsequent check showed `/boot` was still completely full:

```bash
[user@nixos:~/repos/nixos]$ df -h /boot
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       511M  511M     0 100% /boot
```

This deviation from the norm indicated a more complex issue. Why wasn't the standard cleanup working?

### Unraveling the Complexity: Orphaned Boot Files

To understand why the cleanup failed, we needed more data:

1.  **How many generations actually existed?**
    ```bash
    [user@nixos:~/repos/nixos]$ sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
     572    2025-04-18 16:58:23    (current)
    ```
    This was the smoking gun. Only *one* generation, the current one (572), was registered. The `nix-collect-garbage -d` command had nothing *old* to delete according to the system profile!

2.  **What was actually *in* `/boot/EFI/nixos/`?**
    ```bash
    [user@nixos:~/repos/nixos]$ ls -lh /boot/EFI/nixos/
    total 511M
    -rwxr-xr-x 1 root root 132M Apr 18 17:25 15z...initrd-linux-6.12.23-initrd.efi
    -rwxr-xr-x 1 root root 172M Apr 18 17:25 1ah...initrd-linux-6.12.23-initrd.efi
    -rwxr-xr-x 1 root root  12M Apr 18 17:25 7fl...linux-6.12.23-bzImage.efi
    -rwxr-xr-x 1 root root  12M Apr 18 17:25 l7v...linux-6.12.22-bzImage.efi
    -rwxr-xr-x 1 root root  12M Apr 18 17:25 x77...linux-6.12.23-bzImage.efi
    -rwxr-xr-x 1 root root 172M Apr 18 17:25 zvb...initrd-linux-6.12.22-initrd.efi
    ```
    Despite having only one generation registered, the boot directory contained multiple kernels (versions 6.12.22 and 6.12.23) and multiple initrds, totalling ~512MB – precisely the size of the partition.

The conclusion was clear: Previous `nixos-rebuild` operations, likely when deleting older generations, had failed to remove their corresponding files from `/boot/EFI/nixos/`. These files were now **orphaned** – occupying critical space but not linked to any deletable generation in the system profile. The standard cleanup tools were powerless against them.

### The Careful Path vs. The Simple Request

The only way forward was manual intervention. The proposed plan involved careful, step-by-step identification and deletion:

1.  Examine the systemd-boot configuration files (`/boot/loader/entries/*.conf`).
2.  Identify the exact `*.efi` files required by the current generation (572).
3.  Manually use `sudo rm` to delete *only* the files in `/boot/EFI/nixos/` that were *not* required by generation 572.

This process, while safe, felt laborious. The user, understandably, pushed back: "Surely you can give me a simplified command to do this."

### A Simpler Command, Mitigated Risk

Automating file deletion in `/boot` is inherently risky. A single mistake could render the system unbootable. However, acknowledging the user's request, a complex, single-line command was constructed. This command attempted to:

1.  Programmatically extract the required `.efi` filenames from the `/boot/loader/entries/*.conf` files.
2.  List all `.efi` files currently present in `/boot/EFI/nixos/`.
3.  Compare the two lists and identify the files present but not required (the orphans).

Crucially, **risk mitigation** was paramount. Instead of providing a command that immediately deleted files, a **dry-run** version was offered first:

```bash
comm -13 \
  <(grep -h -E '^\s*(linux|initrd)\s+/EFI/nixos/' /boot/loader/entries/*nixos*.conf 2>/dev/null | sed 's|.*/EFI/nixos/||' | sort -u) \
  <(find /boot/EFI/nixos/ -maxdepth 1 -name '*.efi' -printf '%f\n' | sort) \
  | sed 's|^|/boot/EFI/nixos/|' \
  | xargs -d '\n' --no-run-if-empty echo "Would delete:"
```

This command performs the entire detection logic but replaces the final `rm` action with `echo`, simply printing the files it *would* have deleted.

### Execution and Success

The user ran the dry-run command, which correctly identified two files as potential orphans:

```
Would delete: /boot/EFI/nixos/15zmjqqrdhnffii2kykhx1sfgck92xfn-initrd-linux-6.12.23-initrd.efi /boot/EFI/nixos/x77mzlpif1alj4i1wnwbfla81nqqhzy0-linux-6.12.23-bzImage.efi
```

Confident in the dry run's output, the user proceeded to execute the command with the `echo` replaced by `sudo rm --verbose`:

```bash
# --- WARNING: THIS DELETES THE FILES LISTED ABOVE ---
comm -13 \
  <(grep -h -E '^\s*(linux|initrd)\s+/EFI/nixos/' /boot/loader/entries/*nixos*.conf 2>/dev/null | sed 's|.*/EFI/nixos/||' | sort -u) \
  <(find /boot/EFI/nixos/ -maxdepth 1 -name '*.efi' -printf '%f\n' | sort) \
  | sed 's|^|/boot/EFI/nixos/|' \
  | xargs -d '\n' --no-run-if-empty sudo rm --verbose
# --- WARNING: THIS DELETES THE FILES LISTED ABOVE ---
removed '/boot/EFI/nixos/15zmjqqrdhnffii2kykhx1sfgck92xfn-initrd-linux-6.12.23-initrd.efi'
removed '/boot/EFI/nixos/x77mzlpif1alj4i1wnwbfla81nqqhzy0-linux-6.12.23-bzImage.efi'
```

Success! The orphaned files were removed. A final check confirmed the result:

```bash
[user@nixos:~/repos/nixos]$ df -h /boot
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       511M  368M  144M  72% /boot
```

With 144MB of space freed, the original command was retried:

```bash
[user@nixos:~/repos/nixos]$ sudo nixos-rebuild switch --upgrade
unpacking 2 channels...
building Nix...
building the system configuration...
... # Command proceeds successfully
```

The upgrade process continued without the "No space left on device" error, finally completing the task.

### Conclusion

This troubleshooting journey highlighted a specific edge case in NixOS boot management where orphaned files can fill the `/boot` partition, rendering standard cleanup tools ineffective. Careful diagnosis, involving checking actual partition contents and comparing them against system state (generations) and bootloader configuration, was key to understanding the root cause. While automation offers convenience, the incident underscores the importance of caution and verification, especially via dry runs, when dealing with critical system areas like the boot partition. The path from cryptic error to successful upgrade involved detailed inspection, understanding system internals, and carefully executing targeted manual intervention, ultimately restoring the system to its normally smooth operational state.

---

## AI Analysis

**Title/Headline Ideas:**

* NixOS Upgrade Blocked: Solving the Full /boot Partition Mystery
* When `nix-collect-garbage` Fails: Debugging Orphaned EFI Files in NixOS /boot
* Troubleshooting `OSError: [Errno 28] No space left on device` on NixOS /boot
* NixOS Boot Partition Cleanup: A Case of Orphaned Kernels and Initrds
* Manual Intervention Required: Fixing a Stubbornly Full NixOS Boot Partition

**Strengths:**

* **Detailed Process:** Provides a clear, step-by-step account of the diagnosis and resolution.
* **Authenticity:** Includes actual commands used and their terminal output, adding credibility and practical value.
* **Specific Problem Focus:** Addresses a concrete, real-world technical issue (`/boot` full, standard fix fails).
* **Highlights Edge Case:** Explains a scenario (orphaned boot files) that deviates from standard NixOS behavior/fixes.
* **Emphasis on Safety:** Demonstrates caution by using a dry-run command before actual deletion.

**Weaknesses:**

* **Assumed Knowledge:** Heavily relies on reader familiarity with NixOS concepts (generations, rebuild, store paths), Linux file systems (`/boot`, ESP), and bootloaders (systemd-boot, EFI).
* **Jargon-Heavy:** Uses technical terms without extensive definition, potentially alienating beginners.
* **Lack of Broader Context:** Doesn't explain *why* the files might have become orphaned in the first place.
* **Log Format:** Reads like a personal technical log, potentially lacking the polished structure or background of a formal tutorial.

**AI Opinion:**

This article is a valuable technical log detailing the diagnosis and resolution of a specific and non-trivial NixOS issue. Its clarity is high for users already familiar with NixOS and Linux system administration, providing a practical, command-level guide to solving the "full /boot partition with orphaned files" problem. The inclusion of actual commands and the emphasis on a safe dry run significantly increase its usefulness for the target audience. However, its lack of introductory explanations and reliance on jargon make it less accessible to those unfamiliar with the NixOS ecosystem or advanced Linux concepts. Overall, it's a high-quality piece of troubleshooting documentation for a specific technical niche.

---
title: NixOS NVIDIA CUDA Ollama Support
permalink: /futureproof/nixos-nvidia-cuda-ollama/
description: Navigating NixOS with CUDA for AI has been a wild ride, but I've found a stable configuration for running Ollama with accelerated GPU performance. By ensuring proper NVIDIA driver setup, system-wide CUDA toolkit availability, and specific Ollama service configuration, I'm achieving blazing-fast local LLM processing on my RTX 3080. This guide shares my working `configuration.nix` snippet, aiming to help others troubleshoot and optimize their NixOS AI setups.
layout: post
sort_order: 2
---

## NixOS and CUDA: The Perfect AI Platform

We're a bit in the wild west with NixOS, but nix is the perfect platform for
bundling up cross-platform AI packages, and those packages need NVIDIA CUDA GPU
support. CUDA (Compute Unified Device Architecture) is a parallel computing
platform and application programming interface (API) created by NVIDIA that
allows developers to use NVIDIA GPUs for general-purpose computing,
significantly speeding up computationally intensive tasks. 

### Running Ollama with CUDA Acceleration

CUDA support speeds up Ollama. Ollama is a free, open-source tool that lets you
run large language models (LLMs) on your own computer to get ChatGPT-like
abilities at home, privately with your own machine for only the price of the
electricity (no API authentication and token cash register). For those really
interested, `llama.cpp` (cpp for C++) is the actual enabling component here.
Ollama provides the server wrapper and API interface.

### Performance Benefits of Local GPU Acceleration

When you're running ChatGPT-like things at home off your own hardware and you
have an NVIDIA card, CUDA support makes it work many times faster. You can't
even tell you're not on a cloud model for example, if you use one of the smaller
models like Google's Gemma. 

### Maintaining CUDA Support Across Platforms

The money behind the Windows gaming market keeps NVIDIA drivers and CUDA working
over in that world. In the Linux world, all the AI-tooling keeps it working.
However, things do break and every once in awhile Ollama will seem to slow down
for a NixOS user. Sometimes a full system update:

```bash
sudo nixos-rebuild switch --upgrade
```

...will either fix or newly introduce the CUDA support problem (the wild west,
remember). I had the problem on one of the early versions prior to the recent
0.5.6 which cleared it up for me. But I hear reports of people having the
opposite problem and losing support. And with the new Gemma 3 model just
released, Ollama has been upgraded to 0.6, which hasn't hit the NixOS repo yet.
And when it does, I'm sure people will be searching for the fix.

### Working NVIDIA Configuration Example

Anyway, here's the extract of the important bits from my `configuration.nix`
file that seems to have stabilized my GPU support. Small models run blazingly
fast even on my NVIDIA RTX 3080. Hopefully this will be useful to some of you
out there.

---

Here's a working configuration snippet for CUDA support in Ollama on NixOS with NVIDIA GPU:

```nix
hardware = {
  graphics.enable = true;
  nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;  # Closed-source driver recommended for CUDA
    nvidiaSettings = true;
  };
};

services.xserver = {
  enable = true;
  videoDrivers = ["nvidia"];
};

environment.sessionVariables = {
  CUDA_HOME = "${pkgs.cudaPackages.cudatoolkit}";
  LD_LIBRARY_PATH = lib.makeLibraryPath [
    "${pkgs.cudaPackages.cudatoolkit}"
    "${pkgs.cudaPackages.cudatoolkit}/lib64"
    pkgs.cudaPackages.cudnn
    pkgs.cudaPackages.cuda_cudart
    pkgs.stdenv.cc.cc.lib
  ];
  CUDA_MODULE_LOADING = "LAZY";
};

nixpkgs.config = {
  allowUnfree = true;
  cudaSupport = true;
};

environment.systemPackages = with pkgs; [
  cudaPackages.cudatoolkit
  cudaPackages.cudnn
  cudaPackages.cuda_cudart
];

services.ollama = {
  enable = true;
  acceleration = "cuda";
  environmentVariables = {
    CUDA_VISIBLE_DEVICES = "0";
    NVIDIA_VISIBLE_DEVICES = "all";
  };
};
```

### Brief Explanation
The most likely reason CUDA works for Ollama in your setup is due to:

1. **Proper NVIDIA Driver Configuration**  
   Using the closed-source NVIDIA drivers (`open = false`) and enabling NVIDIA modesetting.

2. **System-wide CUDA Toolkit Availability**  
   Explicitly including CUDA libraries in `environment.systemPackages` and setting `LD_LIBRARY_PATH`.

3. **Ollama Service Setup**  
   Specifically configuring Ollama to use CUDA (`acceleration = "cuda"`) and environment variables explicitly indicating GPU visibility.

This combination ensures Ollama has direct access to CUDA libraries and your GPU hardware.

---

## Gemini's Take

**Title and Headline Ideas:**

* **Titles:**
    * NixOS and CUDA: Unleashing Local AI Performance
    * Optimizing Ollama on NixOS with NVIDIA CUDA
    * The NixOS AI Wild West: Taming CUDA for LLMs
* **Headlines:**
    * Boost Ollama Speed: My Working NixOS CUDA Configuration
    * Solve CUDA Issues on NixOS: A Practical Guide
    * Local AI, Accelerated: Get the Most from Your NVIDIA GPU on NixOS

**AI Opinion:**

This article provides a valuable, real-world perspective on a complex technical challenge. The author's candid acknowledgment of the "wild west" nature of NixOS and CUDA, coupled with the detailed configuration examples, makes it a useful resource for anyone attempting to optimize local AI performance. The inclusion of troubleshooting tips and explanations of key configuration elements adds significant practical value. The article is very helpful for a very specific type of user.


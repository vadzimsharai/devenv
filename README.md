# Devenv – One-Command Development Environment

Spin up a fully-featured development workstation (shell, editors, runtimes, CLI tools, dotfiles) with a single command.  
Everything runs in a **Docker** container so your host machine stays clean and reproducible.

---

## 1. Prerequisites

### Docker

Devenv itself is distributed as a Docker image, so Docker **must** be installed first.  
If Docker is not found, the install script will prompt you to install it automatically.

_Official install guide_: <https://docs.docker.com/engine/install/>


### Git

Devenv expects [Git](https://git-scm.com/) to be available on your system, as it is required for many development workflows and for fetching configuration files.

If Git is not already installed, you can install it using your package manager.  
See the official guide for platform-specific instructions: <https://git-scm.com/downloads/linux>

<details>
<summary>Quick example install on Linux</summary>


---

## 2. Installation

Fire up Devenv in one line:

```bash
bash -c "$(curl -fsSL https://devenv.vadzimsharai.dev/run)"
```

That script will:

1. Pull the latest Devenv Docker image.
2. Launch an interactive container with all tools pre-installed.
3. Mount your current directory inside the container (so code edits persist).

---

## 3. How to Use

Once installed, you can launch Devenv anytime by running:

```bash
devenv
```

### Available Commands

| Command            | Description                                           |
| ------------------ | ----------------------------------------------------- |
| `devenv run`       | Launch the development environment (or just `devenv`) |
| `devenv stop`      | Stop the running container                            |
| `devenv uninstall` | Fully remove the project and clean up resources       |

## 4. What’s Inside?

`shell/setup.sh` provisions everything listed below.  
(All tools are installed for the **root** user inside the container unless noted.)

| Category                             | Tools / Configuration                                                                                                                                                                                                                                                               |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Shell & UX**                       | • Zsh with [Oh My Zsh](https://ohmyz.sh/) <br>• [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme <br>• [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) <br>• [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) |
| **Editors**                          | • Latest [Neovim](https://neovim.io/) (binary drop) <br>• Pre-wired config (`~/.config/nvim`) <br>• [Lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager with plugins synced on first run                                                                                 |
| **Programming Languages & Runtimes** | • Python 3.12.11 via [pyenv](https://github.com/pyenv/pyenv) <br>• Go 1.21.5 <br>• Node.js (LTS) via [NVM](https://github.com/nvm-sh/nvm) <br>• C/C++ (build-essential, gcc, g++, make, cmake)                                                                                      |

---

## 5. License

MIT – do whatever you like, no warranties.

Happy hacking! 🚀

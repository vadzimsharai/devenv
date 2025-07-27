#!/bin/sh

set -e

echo "==> Installing Oh My Zsh..."
if [ ! -d "/root/.oh-my-zsh" ]; then
    echo "Cloning Oh My Zsh repository..."
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh /root/.oh-my-zsh
else
    echo "Oh My Zsh already installed."
fi

echo "==> Installing Powerlevel10k theme..."
if [ ! -d "/root/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Cloning Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k
else
    echo "Powerlevel10k already installed."
fi

echo "==> Installing zsh-syntax-highlighting plugin..."
if [ ! -d "/root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "Cloning zsh-syntax-highlighting plugin..."
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting already installed."
fi

echo "==> Installing zsh-autosuggestions plugin..."
if [ ! -d "/root/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo "Cloning zsh-autosuggestions plugin..."
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed."
fi

echo "==> Installing pyenv and Python 3.12.11..."
if [ ! -d "/root/.pyenv" ]; then
    echo "Cloning pyenv..."
    git clone --depth=1 https://github.com/pyenv/pyenv /root/.pyenv
    echo "Installing Python 3.12.11 with pyenv..."
    /root/.pyenv/bin/pyenv install 3.12.11
    /root/.pyenv/bin/pyenv global 3.12.11
else
    echo "pyenv already installed."
fi

echo "==> Installing Go 1.21.5..."
if [ ! -d "/root/.go" ]; then
    echo "Downloading Go 1.21.5..."
    wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
    echo "Extracting Go..."
    tar -C /root/ -xzf go1.21.5.linux-amd64.tar.gz
    mv /root/go /root/.go
    rm go1.21.5.linux-amd64.tar.gz*
else
    echo "Go already installed in /root/.go."
fi
if [ ! -d "/usr/local/go" ]; then
    echo "Linking Go to /usr/local/go..."
    ln -s /root/.go /usr/local/go
else
    echo "/usr/local/go already exists."
fi

echo "==> Installing NVM and Node.js LTS..."
if [ ! -d "/root/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    echo "Installing and using Node.js LTS..."
    /bin/bash -c "source /root/.nvm/nvm.sh && nvm install --lts && nvm use --lts"
else
    echo "NVM already installed."
fi

echo "==> Installing Neovim..."
if [ ! -d "/opt/nvim" ]; then
    echo "Downloading Neovim..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    echo "Extracting Neovim..."
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    mv /opt/nvim-linux-x86_64 /opt/nvim
    rm nvim-linux-x86_64.tar.gz
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim
else
    echo "Neovim already installed."
fi

echo "==> Creating symlinks for configuration files..."
[ ! -L "/root/.zshrc" ] && { echo "Linking .zshrc..."; ln -s /opt/devenv/shell/zshrc.sh /root/.zshrc; }
[ ! -L "/root/.p10k.zsh" ] && { echo "Linking .p10k.zsh..."; ln -s /opt/devenv/shell/p10k.zsh /root/.p10k.zsh; }
[ ! -L "/root/.aliases" ] && { echo "Linking .aliases..."; ln -s /opt/devenv/shell/aliases.sh /root/.aliases; }
[ ! -L "/root/.funcs" ] && { echo "Linking .funcs..."; ln -s /opt/devenv/shell/funcs.sh /root/.funcs; }
[ ! -L "/root/.tmux.conf" ] && { echo "Linking .tmux.conf..."; ln -s /opt/devenv/shell/tmux.conf /root/.tmux.conf; }
[ ! -L "/root/.bashrc" ] && { echo "Linking .bashrc..."; ln -s /opt/devenv/shell/bashrc.sh /root/.bashrc; }

echo "==> Creating config directories..."
mkdir -p /root/.config/

[ ! -L "/root/.config/nvim" ] && { echo "Linking Neovim config..."; ln -s /opt/devenv/nvim /root/.config/nvim; }

echo "==> Syncing Neovim plugins (Lazy.nvim)..."
if [ ! -f "/root/.config/nvim/.sync" ]; then
    echo "Running Neovim headless plugin sync..."
    /opt/nvim/bin/nvim --headless "+Lazy! sync" +qa
    # /opt/nvim/bin/nvim --headless "+MasonInstallAll! sync" +qa
    touch /root/.config/nvim/.sync
else
    echo "Neovim plugins already synced."
fi

echo "==> Installing GitHub CLI (gh)..."
if ! command -v gh >/dev/null 2>&1; then
    echo "Adding GitHub CLI repository and installing gh..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list
    apt update
    apt install -y gh
else
    echo "GitHub CLI already installed."
fi

echo "==> Installing lazygit..."
if [ ! -f "$HOME/.local/bin/lazygit" ]; then
    echo "Downloading and installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    install lazygit -D -t $HOME/.local/bin/
    rm lazygit.tar.gz
    rm lazygit
else
    echo "lazygit already installed."
fi

echo "==> Installing lazydocker..."
if [ ! -f "$HOME/.local/bin/lazydocker" ]; then
    echo "Downloading and installing lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
else
    echo "lazydocker already installed."
fi

echo "==> Creating workspace directory..."
mkdir -p /root/workspace

echo "==> Setup complete."

exec "$@"

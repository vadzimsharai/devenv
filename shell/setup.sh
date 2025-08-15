#!/bin/sh

set -e

export DEBIAN_FRONTEND=noninteractive
export TZ=Etc/UTC

echo "==> Configuring shell..."
mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"
sudo chown devenv:devenv -R /opt/devenv

echo "==> Configuring git..."
git config --global --add safe.directory /opt/devenv

echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Cloning Oh My Zsh repository..."
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh $HOME/.oh-my-zsh
else
    echo "Oh My Zsh already installed."
fi

echo "==> Installing Powerlevel10k theme..."
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Cloning Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
else
    echo "Powerlevel10k already installed."
fi

echo "==> Installing zsh-syntax-highlighting plugin..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "Cloning zsh-syntax-highlighting plugin..."
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting already installed."
fi

echo "==> Installing zsh-autosuggestions plugin..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo "Cloning zsh-autosuggestions plugin..."
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed."
fi

echo "==> Installing pyenv and Python 3.12.11..."
if [ ! -d "$HOME/.pyenv" ]; then
    echo "Cloning pyenv..."
    git clone --depth=1 https://github.com/pyenv/pyenv $HOME/.pyenv
    echo "Installing Python 3.12.11 with pyenv..."
    $HOME/.pyenv/bin/pyenv install 3.12.11
    $HOME/.pyenv/bin/pyenv global 3.12.11
else
    echo "pyenv already installed."
fi

echo "==> Installing Go 1.21.5..."
if [ ! -d "$HOME/.go" ]; then
    wget -q https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
    tar -C $HOME/ -xzf go1.21.5.linux-amd64.tar.gz
    mv $HOME/go $HOME/.go
    rm go1.21.5.linux-amd64.tar.gz*
else
    echo "Go already installed."
fi

echo "==> Installing NVM and Node.js LTS..."
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    echo "Installing and using Node.js LTS..."
    /bin/bash -c "source $HOME/.nvm/nvm.sh && nvm install --lts && nvm use --lts"
else
    echo "NVM already installed."
fi

echo "==> Installing Neovim..."
if [ ! -L "$HOME/.local/bin/nvim" ]; then
    echo "Downloading Neovim..."
    curl -q -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    echo "Extracting Neovim..."
    tar -C $HOME -xzf nvim-linux-x86_64.tar.gz
    mv $HOME/nvim-linux-x86_64 $HOME/.nvim
    rm nvim-linux-x86_64.tar.gz
else
    echo "Neovim already installed."
fi

echo "==> Creating symlinks for configuration files..."
[ ! -L "$HOME/.zshrc" ] && {
    echo "Linking .zshrc..."
    ln -s /opt/devenv/shell/zshrc.sh $HOME/.zshrc
}
[ ! -L "$HOME/.p10k.zsh" ] && {
    echo "Linking .p10k.zsh..."
    ln -s /opt/devenv/shell/p10k.zsh $HOME/.p10k.zsh
}
[ ! -L "$HOME/.aliases" ] && {
    echo "Linking .aliases..."
    ln -s /opt/devenv/shell/aliases.sh $HOME/.aliases
}
[ ! -L "$HOME/.funcs" ] && {
    echo "Linking .funcs..."
    ln -s /opt/devenv/shell/funcs.sh $HOME/.funcs
}
[ ! -L "$HOME/.tmux.conf" ] && {
    echo "Linking .tmux.conf..."
    ln -s /opt/devenv/shell/tmux.conf $HOME/.tmux.conf
}
[ ! -f "$HOME/.bashrc" ] && {
    echo "Linking .bashrc..."
    ln -s /opt/devenv/shell/bashrc.sh $HOME/.bashrc
}

mkdir -p $HOME/.config/

[ ! -L "$HOME/.config/nvim" ] && {
    echo "Linking Neovim config..."
    ln -s /opt/devenv/nvim $HOME/.config/nvim
}

echo "==> Syncing Neovim plugins (Lazy.nvim)..."
if [ ! -f "$HOME/.config/nvim/.sync" ]; then
    echo "Running Neovim headless plugin sync..."
    /opt/nvim/bin/nvim --headless "+Lazy! sync" +qa
    # /opt/nvim/bin/nvim --headless "+MasonInstallAll! sync" +qa
    touch $HOME/.config/nvim/.sync
else
    echo "Neovim plugins already synced."
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
mkdir -p $HOME/workspace

echo "==> Setup complete."

exec "$@"

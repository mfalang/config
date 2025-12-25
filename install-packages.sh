#!/usr/bin/env bash

echo -e "========== Installing packages ==========\n"

# Helper function to ask for confirmation
ask_confirmation() {
    local message="$1"
    while true; do
        read -p "$message (Y/n): " yn
        case $yn in
            [Yy]* | "" ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer Y or n.";;
        esac
    done
}

# Install Homebrew on Linux/WSL if not macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew on Linux..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for current session
        if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
        
        echo -e "Homebrew installed successfully\n"
    else
        echo -e "Homebrew already installed\n"
    fi
else
    echo -e "Detected macOS - using existing Homebrew\n"
fi

# Starship - Cross-shell prompt
echo -e "---------- Installing starship ----------"
if ask_confirmation "Do you want to install starship?"; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install starship
    else
        brew install starship
    fi
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

# Zoxide - Smart directory navigation
echo -e "---------- Installing zoxide ----------"
if ask_confirmation "Do you want to install zoxide?"; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zoxide
    else
        brew install zoxide
    fi
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

# FZF - Fuzzy file finder
echo -e "---------- Installing fzf ----------"
if ask_confirmation "Do you want to install fzf?"; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install fzf
    else
        brew install fzf
    fi
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

# Lazygit - Git TUI
echo -e "---------- Installing lazygit ----------"
if ask_confirmation "Do you want to install lazygit?"; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install lazygit
    else
        brew install lazygit
    fi
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

# ZSH Autosuggestions - Shell autocompletion
echo -e "---------- Installing zsh-autosuggestions ----------"
if ask_confirmation "Do you want to install zsh-autosuggestions?"; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh-autosuggestions
    else
        brew install zsh-autosuggestions
    fi
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

echo -e "========== Finished =========="
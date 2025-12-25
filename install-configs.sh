#!/usr/bin/env bash

echo -e "========== Installing config files ==========\n"

REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
HOME_DIR="${HOME}"

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

# Helper function to get archive path from dotfiles path
get_archive_path() {
    local dotfiles_path="$1"
    local filename="$2"
    
    # Extract category from dotfiles path (e.g., bash, zsh, vim)
    local category=$(echo "$dotfiles_path" | sed 's|.*/.dotfiles/\([^/]*\)/.*|\1|')
    local archive_dir="${HOME_DIR}/.dotfiles/${category}/archive"
    
    echo "${archive_dir}/${filename}.backup.$(date +%Y%m%d_%H%M%S)"
}

# Helper function to backup existing dotfiles to archive folders
backup_existing_file() {
    local dotfiles_path="$1"
    
    if [[ -e "$dotfiles_path" ]]; then
        local filename=$(basename "$dotfiles_path")
        local archive_path=$(get_archive_path "$dotfiles_path" "$filename")
        local archive_dir=$(dirname "$archive_path")
        
        # Create archive directory
        mkdir -p "$archive_dir"
        
        echo "Backing up existing dotfile to: $archive_path"
        mv "$dotfiles_path" "$archive_path"
    fi
}

# Helper function to install with symlinks
install_with_symlink() {
    local source_file="$1"
    local dotfiles_path="$2"
    local target_path="$3"
    
    # Create .dotfiles directory structure
    mkdir -p "$(dirname "$dotfiles_path")"
    
    # Create parent directory for target if needed
    mkdir -p "$(dirname "$target_path")"
    
    # Backup existing dotfiles file to archive folder if it exists
    backup_existing_file "$dotfiles_path"
    
    # Copy source to .dotfiles location
    cp "$source_file" "$dotfiles_path"
    
    # Create symlink only if it doesn't already exist
    if [[ ! -L "$target_path" ]]; then
        ln -s "$dotfiles_path" "$target_path"
        echo "Created symlink: $target_path -> $dotfiles_path"
    else
        echo "Updated file: $target_path -> $dotfiles_path"
    fi
}

echo -e "---------- Installing bashrc file ----------"
if ask_confirmation "Do you want to install bashrc?"; then
    install_with_symlink "${REPO_DIR}/bash/bashrc" "${HOME_DIR}/.dotfiles/bash/.bashrc" "${HOME_DIR}/.bashrc"
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

echo -e "---------- Installing ps1 file ----------"
if ask_confirmation "Do you want to install ps1?"; then
    install_with_symlink "${REPO_DIR}/bash/ps1" "${HOME_DIR}/.dotfiles/bash/ps1" "${HOME_DIR}/.config/ps1"
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

echo -e "---------- Installing zshrc file ----------"
if ask_confirmation "Do you want to install zshrc?"; then
    install_with_symlink "${REPO_DIR}/zsh/.zshrc" "${HOME_DIR}/.dotfiles/zsh/.zshrc" "${HOME_DIR}/.zshrc"
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

echo -e "---------- Installing vimrc file ----------"
if ask_confirmation "Do you want to install vimrc?"; then
    install_with_symlink "${REPO_DIR}/vim/vimrc" "${HOME_DIR}/.dotfiles/vim/.vimrc" "${HOME_DIR}/.vimrc"
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

echo -e "---------- Setting up git ----------"
if ask_confirmation "Do you want to set up git?"; then
    ${REPO_DIR}/git/git-setup.sh
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

echo -e "========== Finished =========="

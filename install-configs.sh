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

echo -e "---------- Installing bashrc file ----------"
if ask_confirmation "Do you want to install bashrc?"; then
    cp ${REPO_DIR}/bash/bashrc ${HOME_DIR}/.bashrc
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

echo -e "---------- Installing ps1 file ----------"
if ask_confirmation "Do you want to install ps1?"; then
    mkdir -p ${HOME_DIR}/.config
    cp ${REPO_DIR}/bash/ps1 ${HOME_DIR}/.config/ps1
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

echo -e "---------- Installing zshrc file ----------"
if ask_confirmation "Do you want to install zshrc?"; then
    cp ${REPO_DIR}/zsh/.zshrc ${HOME_DIR}/.zshrc
    echo -e "Ok\n"
else
    echo -e "Skipped\n"
fi

echo -e "---------- Installing vimrc file ----------"
if ask_confirmation "Do you want to install vimrc?"; then
    cp ${REPO_DIR}/vim/vimrc ${HOME_DIR}/.vimrc
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

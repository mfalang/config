#!/usr/bin/env bash

echo -e "========== Installing config files ==========\n"

REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."
HOME_DIR="/home/${USER}"

echo -e "---------- Installing bashrc file ----------"
cp ${REPO_DIR}/bash/bashrc ${HOME_DIR}/.bashrc
echo -e "Ok\n"

echo -e "---------- Installing ps1 file ----------"
mkdir -p ${HOME_DIR}/.config
cp ${REPO_DIR}/bash/ps1 ${HOME_DIR}/.config/ps1
echo -e "Ok\n"

echo -e "---------- Installing vimrc file ----------"
cp ${REPO_DIR}/vim/vimrc ${HOME_DIR}/.vimrc
echo -e "Ok\n"

echo -e "---------- Installing git aliases ----------"
${REPO_DIR}/git/git-aliases.sh
echo -e "Ok\n"

echo -e "========== Finished =========="

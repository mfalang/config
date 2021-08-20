#!/bin/bash

git config --global alias.co 'checkout'
git config --global alias.br 'branch'
git config --global alias.ci 'commit'
git config --global alias.st 'status'
git config --global alias.lg 'log --all --graph --pretty="%C(#cccc00)%h%Creset %C(#888888)(%C(#00aa00)%cr%C(#888888))%Creset%C(auto)%d%Creset %s"'
git config --global core.editor vim

echo -n "Enter name for git config: "
read NAME
git config --global user.name "$NAME"

echo -n "Enter email for git config: "
read EMAIL
git config --global user.email "$EMAIL"

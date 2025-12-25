# History
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Better history search (up/down arrows)
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Completion
autoload -Uz compinit
compinit

eval "$(~/.local/bin/mise activate zsh)"

export CLAUDE_CODE_USE_BEDROCK=1
export ANTHROPIC_MODEL=us.anthropic.claude-sonnet-4-20250514-v1:0
export AWS_DEFAULT_REGION=us-east-1

# Github SSH key setup
eval "$(ssh-agent -s)" > /dev/null
ssh-add  ~/.ssh/github > /dev/null

# Run starship
eval "$(starship init zsh)"

# FZF search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zoxide init
eval "$(zoxide init zsh)"

# Set up ZHS autosuggestions on both WSL and Mac
if [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f $(brew --prefix 2>/dev/null)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


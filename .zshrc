ZSH="$HOME/.oh-my-zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    z
    fzf
    mosh
    rust
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
)
bindkey '^ ' autosuggest-accept
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
alias now="date +%y%m%d%H%M"
if command -v eza &> /dev/null; then
    alias ls='eza'
fi

if command -v bat &> /dev/null; then
    export PAGER="bat -S"
else
    export PAGER="less -S"
fi
export UID=$(id -u)
export GID=$(id -g)
export HOMEBREW_NO_ENV_HINTS=1
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=1
export PATH="$HOME/.local/bin:$PATH"

setopt ignore_eof


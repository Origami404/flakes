# Created by newuser for 5.9

ZSHD="$HOME/.zsh.d"

source "$ZSHD/normalize-fpath.zsh"

if [[ ! -v ZSH_GRML_SOURCED ]]; then
  source $ZSHD/grml-zshrc
fi

source "$ZSHD/rsync.zsh"
source "$ZSHD/misc.zsh"
source "$ZSHD/pdf.zsh"
source "$ZSHD/completion.zsh"
source "$ZSHD/modern-utils.zsh"
source "$ZSHD/develop.zsh"
source "$ZSHD/nix.zsh"

# allow using # at begin
setopt interactivecomments
# give me back the normal `#, ^, ~` !!!
unsetopt extended_glob

# alias
export EDITOR=hx
alias dc="docker compose"

export PATH="$HOME/.local/bin:$PATH"

if command -v fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

if command -v opam &> /dev/null; then
    eval $(opam env)
fi

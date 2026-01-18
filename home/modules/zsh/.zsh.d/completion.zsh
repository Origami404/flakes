# Complete filename by modification time
zstyle ':completion:*' file-sort modification

# FZF shell integration
source <(fzf --zsh)

if command -v bat &> /dev/null; then
  # Preview file content using bat (https://github.com/sharkdp/bat)
  export FZF_CTRL_T_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi
if command -v tree &> /dev/null; then
  # Preview directory tree using tree
  export FZF_ALT_C_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'tree -C {} | head -200'"
fi

# FZF Fuzzy completion
export FZF_COMPLETION_TRIGGER=''
bindkey -r '^P'
bindkey -r '^I'
bindkey '^P' fzf-completion
bindkey '^I' $fzf_default_completion

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

if command -v fd &> /dev/null; then
  # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
  # - The first argument to the function ($1) is the base path to start traversal
  # - See the source code (completion.{bash,zsh}) for the details.
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi


# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}                                                                                                                                                                                                                                                                                    
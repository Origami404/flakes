# if bat is installed, alias cat to it
if command -v bat &> /dev/null; then
    alias cat='bat'
    alias pcat='/usr/bin/cat'
fi

# if eza is installed, alias ls to it; also check exa
if command -v eza &> /dev/null; then
    alias ls='eza'
elif command -v exa &> /dev/null; then
    alias ls='exa'
fi
alias ll='ls -l'
alias la='ls -a'

# if fd is installed, alias find to it
if command -v fd-find &> /dev/null; then
    alias fd='fd-find'
fi
if command -v fd &> /dev/null; then
    alias find='fd'
fi

# if rg is installed, alias grep to it
if command -v ripgrep &> /dev/null; then
    alias rg='rgrep'
fi
if command -v rg &> /dev/null; then
    alias grep='rg'
fi

# Compatibility with windows
alias traceroute='tracert'

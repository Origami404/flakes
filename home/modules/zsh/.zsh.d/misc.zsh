# From https://serverfault.com/a/1064320
ssh2config() {
  host="$(ssh -G "$@" | sed -n 's/^hostname //p')"
  echo "$host"
  comm -23 <(ssh -G "$@" | sort) <(ssh -G abcddd | sort) | sed 's/^/    /'
  echo ''
}

backlight() {
  #echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness
  echo $1 | sudo tee /sys/class/backlight/amdgpu_bl1/brightness
}

gpg-login() {
    export GPG_TTY=$(tty)
    echo "test" | gpg --clearsign > /dev/null 2>&1
}

alias ipy='ipython'
alias ts4='tailscale ip -4'
alias ts6='tailscale ip -6'
alias x='atool -x'
alias pc='proxychains'


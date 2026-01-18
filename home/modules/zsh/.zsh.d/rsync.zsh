# From https://wiki.archlinux.org/title/rsync
cpr() {
  rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
} 
mvr() {
  rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}
sudo-cpr() {
  sudo rsync -e "ssh -i $HOME/.ssh/id_ed25519 -F $HOME/.ssh/config" --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}


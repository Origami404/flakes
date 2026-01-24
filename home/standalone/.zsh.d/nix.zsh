#!/usr/bin/env zsh

sops-update-file() {
  local src_file="$1"
  local yaml_file="$2"
  local age_key_file="$HOME/.config/sops/age/keys.txt"

  if [[ -z "$src_file" || -z "$yaml_file" ]]; then
    echo "用法: sops-update-file <原文件> <yaml文件>" >&2
    return 1
  fi

  if [[ ! -f "$src_file" ]]; then
    echo "找不到原文件: $src_file" >&2
    return 1
  fi

  if [[ ! -f "$age_key_file" ]]; then
    echo "找不到 age 私钥: $age_key_file" >&2
    return 1
  fi

  local key_name="${yaml_file:t:r}"
  local age_pub
  age_pub="$(nix-shell -p age --run "age-keygen -y $age_key_file")" || return 1

  local tmp
  tmp="$(mktemp /tmp/sops-update.XXXXXX.yaml)" || return 1
  {
    echo "${key_name}: |"
    sed 's/^/  /' "$src_file"
  } > "$tmp"

  nix-shell -p sops --run "sops --encrypt --input-type yaml --output-type yaml --age $age_pub --config /dev/null $tmp" > "$yaml_file"
  local rc=$?
  rm -f "$tmp"
  return $rc
}

sops-update-ssh-config () {( set -e
    local SSH_CONFIG=$HOME/.ssh/config
    local FLAKES=$HOME/flakes

    $EDITOR $SSH_CONFIG
    sops-update-file $SSH_CONFIG $FLAKES/secrets/ssh-config.yaml
    pushd $FLAKES
    if [[ -z "$(git status --porcelain)" ]]; then
        git add .
        git commit -m "[sops] update ssh config"
    fi
    popd
)}

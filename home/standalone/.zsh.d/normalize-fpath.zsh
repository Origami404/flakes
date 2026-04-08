# 这个文件用于在 grml/compinit 初始化补全系统之前规整 fpath。
#
# 修复的问题：
# 1. NixOS、Home Manager、用户 profile 和 zsh 自带目录会同时向 fpath 注入补全目录。
# 2. 这些目录里大量内容重复，有些只是同一真实目录的不同软链接入口。
# 3. compinit 会遍历这些重复目录，导致启动变慢，并且更容易让 .zcompdump 的文件数校验失效。
#
# 处理策略：
# 1. 先按 realpath 去重，移除同一真实目录的多重入口。
# 2. 再按目录类别保留一份，避免 site-functions、vendor-completions 和 zsh 标准函数目录被重复扫描。
normalize-fpath() {
  emulate -L zsh
  setopt extendedglob

  local dir real key bucket
  local -a new_fpath
  local -A seen_realpath seen_bucket

  for dir in $fpath; do
    [[ -d "$dir" ]] || continue

    real="${dir:A}"
    key="${real%/}"
    if [[ -n "${seen_realpath[$key]}" ]]; then
      continue
    fi

    bucket=""
    case "$real" in
      */share/zsh/site-functions)
        bucket="site:${real:t}"
        ;;
      */share/zsh/vendor-completions)
        bucket="vendor:${real:t}"
        ;;
      */share/zsh/<->.<->/functions)
        bucket="core:${real:t:h:t}"
        ;;
      /usr/share/grml/zsh/*)
        bucket="grml:${real:t}"
        ;;
    esac

    if [[ -n "$bucket" && -n "${seen_bucket[$bucket]}" ]]; then
      continue
    fi

    seen_realpath[$key]=1
    [[ -n "$bucket" ]] && seen_bucket[$bucket]=1
    new_fpath+=("$dir")
  done

  fpath=("${new_fpath[@]}")
}

normalize-fpath

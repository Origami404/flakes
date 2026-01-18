cmake-llvm () {
    local cmake_args=("-G" "Ninja")

    # find cmake root dir
    # if defined PROJECT or P, use it as project root
    # if within git (git rev-parse --is-inside-work-tree), use git rev-parse --show-toplevel
    # if setted LLVM_ROOT, use it
    # default "../llvm", if not exist, error
    local llvm_root=".."
    if [ -n "${PROJECT}" ]; then
        llvm_root="${PROJECT}"
    elif [ -n "${P}" ]; then
        llvm_root="${P}"
    elif git rev-parse --is-inside-work-tree &> /dev/null; then
        llvm_root=$(git rev-parse --show-toplevel)
    elif [ -n "${LLVM_ROOT}" ]; then
        llvm_root="${LLVM_ROOT}"
    fi
    if [ ! -d "${llvm_root}/llvm" ]; then
        echo "Error: not inside a llvm directory"
        return 1
    fi
    cmake_args+=("${llvm_root}/llvm")

    # Set build_type from arg[1]
    local build_type="${1}"
    if [ -z "${build_type}" ]; then
        echo "Error: build_type is empty"
        return 1
    fi
    cmake_args+=("-DCMAKE_BUILD_TYPE=${build_type}")

    # check LLVM_PROJECTS env
    if [ -z "${LLVM_PROJECTS}" ]; then
        echo "Error: LLVM_PROJECTS env is not set"
        return 1
    fi
    cmake_args+=("-DLLVM_ENABLE_PROJECTS=${LLVM_PROJECTS}")

    # check LLVM_TARGETS
    if [ -z "${LLVM_TARGETS}" ]; then
        echo "Error: LLVM_TARGETS env is not set"
        return 1
    fi
    cmake_args+=("-DLLVM_TARGETS_TO_BUILD=${LLVM_TARGETS}")

    # if setted LLVM_COMPILER, use it, else default clang
    if [ -z "${LLVM_COMPILER}" ]; then
        # if setted CMAKE_C_COMPILER or CMAKE_CXX_COMPILER, use it, else default clang
        cmake_args+=(
            "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER:-clang}" 
            "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER:-clang++}"
        )
    elif [ "${LLVM_COMPILER}" == "gcc" ]; then
        cmake_args+=("-DCMAKE_C_COMPILER=gcc" "-DCMAKE_CXX_COMPILER=g++")
    elif [ "${LLVM_COMPILER}" == "clang" ]; then
        cmake_args+=("-DCMAKE_C_COMPILER=clang" "-DCMAKE_CXX_COMPILER=clang++")
    else
        echo "Error: LLVM_COMPILER is invalid"
        return 1
    fi

    # if not setted LLVM_NO_*, use default optimized options
    if [ -z "${LLVM_NO_SHARED}" ]; then
        cmake_args+=("-DBUILD_SHARED_LIBS=On")
    fi
    if [ -z "${LLVM_APPEND_VC_REV}"]; then
        cmake_args+=("-DLLVM_APPEND_VC_REV=Off")
    fi
    if [ -z "${LLVM_NO_LLD}" ]; then
        cmake_args+=("-DLLVM_ENABLE_LLD=On")
    fi
    if [ -z "${LLVM_NO_OPT_TABLEGEN}" ]; then
        cmake_args+=("-DLLVM_OPTIMIZED_TABLEGEN=On")
    fi
    if [ -z "${LLVM_NO_SPLIT_DWARF}" ]; then
        cmake_args+=("-DLLVM_USE_SPLIT_DWARF=On")
    fi

    cmake_args+=("-DCMAKE_EXPORT_COMPILE_COMMANDS=On")

    # append args[2:] to cmake_args
    cmake_args+=("${@:2}")

    # print cmake args, one for each line
    # and ask for confirmation
    for arg in "${cmake_args[@]}"; do
        echo "${arg}"
    done
    read "?Press enter to continue?"

    # run cmake with cmake_args
    cmake "${cmake_args[@]}"
}

git-local-exclude () {
    local file="${1}"

    # if file is empty, exit
    if [ -z "${file}" ]; then
        echo "Error: file is empty"
        return 1
    fi

    # if .git/info/exclude not exist, exit
    if [ ! -f .git/info/exclude ]; then
        echo "warning: .git/info/exclude not exist, maybe in other worktree?"
        return 1
    fi

    echo "${file}" >> .git/info/exclude
}

generate-local-dir () {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        project_root=$(git rev-parse --show-toplevel)
    else
        echo "Error: not inside a git repository"
        return 1
    fi

    pushd "${project_root}"
    git-local-exclude .local
    mkdir -p .local
    mkdir -p .local/bin
    touch .local/notes.md

cat > .local/env.sh << EOF
export P="${project_root}"
export D="\$P/build-debug/bin"
export R="\$P/build-release/bin"
export L="\$P/.local"

export PATH="\$L/bin:\$PATH"
EOF

    git-local-exclude .vscode
    mkdir -p .vscode
    if [ -f .vscode/settings.json ]; then
        echo "Warning: .vscode/settings.json already exist"
    else
        echo '{}' > .vscode/settings.json
    fi

    popd
}
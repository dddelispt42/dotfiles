
_default:
    $just --list

update:
  git fetch --recurse-submodules origin && git rebase origin/$((git symbolic-ref refs/remotes/origin/HEAD || echo main) | sed 's@^refs/remotes/origin/@@')
  git pull --recurse-submodules

# TODO(heiko): install.sh --> Justfile

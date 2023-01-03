set -x GOPATH $HOME/dev
fish_add_path $GOPATH/bin
fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path /home/linuxbrew/.linuxbrew/sbin
fish_add_path /$HOME/.cargo/bin

set -g theme_display_git_master_branch yes

if type -q exa
    alias ls 'exa --icons --git'
    alias la "ls -a"
    alias lla "ll -a"
end

function fish_user_key_bindings
  bind \c] peco_select_ghq      # Ctrl-]
  bind \cr peco_select_history  # Ctrl-r
end

function peco_select_ghq
  set -l query (commandline)
  if test -n $query
    set peco_flags --query "$query"
  end

  ghq list -p | peco $peco_flags | read line
  if test $line
    cd $line
    commandline -f repaint
  end
end

function peco_select_history
  set -l query (commandline)
  if test -n $query
    set peco_flags --query "$query"
  end

  history | peco $peco_flags | read line
  if test $line
    commandline $line
  else
    commandline ''
  end
end

alias vim=nvim
alias ga="git add"
alias gb="git branch"
alias gbd="git branch -d"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gc="git checkout"
alias gcb="git checkout -b"

fish_user_key_bindings


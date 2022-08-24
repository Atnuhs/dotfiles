set -x GOPATH $HOME/dev
set -x PATH $PATH $GOPATH/bin
set -g theme_display_git_master_branch yes

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
alias ls='exa --icons --git'

fish_user_key_bindings

fish_add_path $HOME/.cargo/bin


set -x GOPATH $HOME/dev
fish_add_path $GOPATH/bin
fish_add_path /$HOME/.cargo/bin
fish_add_path --path --append /home/linuxbrew/.linuxbrew/bin
fish_add_path --path --append /home/linuxbrew/.linuxbrew/sbin

set -g theme_display_git_master_branch yes

abbr --add sc "source ~/.config/fish/config.fish"
abbr --add np --set-cursor "no_proxy=\"%\""

if type -q eza
    abbr --add e 'eza --icons --git'
end

if type -q tmux
    abbr --add ide 'tmux split-window -v; tmux resize-pane -D 15'
end

if type -q git
    abbr --add ga 'git add'
    abbr --add gb "git branch"
    abbr --add gd "git diff"
    abbr --add gf "git fetch"
    abbr --add gr "git rebase"
    abbr --add gbd "git branch -d"
    abbr --add gcm --set-cursor "git commit -m \"%\""
    abbr --add gca "git commit --amend"
    abbr --add gst "git status"
    abbr --add gsw "git switch"
    abbr --add gpf "git push --force-with-lease --force-if-includes"
end

if type -q ansible
    abbr --add ap 'ansible-playbook'
end

if type -q brew
    abbr --add bi 'brew install'
    abbr --add bd 'brew doctor'
end

function fish_user_key_bindings
  bind \c] peco_select_ghq      # Ctrl-]
  bind \cr peco_select_history  # Ctrl-r
end

function sync
    if type -q apt
        sudo apt update
        sudo apt upgrade -y
        sudo apt autoclean
        sudo apt autoremove -y
    end

    if type -q brew
        brew upgrade
        brew cleanup --prune 7
    end
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


fish_user_key_bindings


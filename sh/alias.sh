#### rc.alias.sh ####
# define aliases

# reload rc
alias rc='source $HOME/.bashrc'
alias rc_profile='source $HOME/.bash_profile'

# modern cli tools
if [ -n "$(command -v exa)" ]; then
    alias ls='exa -lhb --git --icons'
    alias ll='exa -hb --git --icons'
    alias la='exa -lhbHSg --git --icons'
    alias lla='exa -alhbHSg --git --icons'
else
    alias ls='ls'
    alias ll='ls -l'
    alias la='ls -a'
    alias lla='ls -al'
fi

#### TMUX ####
alias ta="tmux a"
alias tl="tmux ls"

#### Git ####
# git (abbreveations)
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gcam="git commit -a -m"
alias gf="git fetch"
alias gs="git ss"
alias ga="git add ."
alias gl="git lol"
alias gd="git diff"
alias gp="git push"

# git-remind
alias grj="git remind status -n --all | fzf --ansi --cycle --preview=\"git -C {} -c color.status=always status -vv --branch --show-stash\" | cd"
alias grs='git remind status --all'

# ghq
alias gj='cd $(ghq list | fzf --ansi --cycle --preview "bat --color=always --style=grid --line-range :80 $(ghq root)/{}/README.*" | xargs -t -I{} echo $(ghq root)/{})'

# github cli
alias gx="hub browse"

#### PYTHON ####
alias i=ipython

# esapy
alias esafu='esa up --no-browser "$(esa ls | fzf | sed -r "s/(.+)\\| (.+)/\\2/")"'
alias esafr='esa reset "$(esa ls | fzf | sed -r "s/(.+)\\| (.+)/\\2/")"'

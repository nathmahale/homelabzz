alias k="kubectl -n argocd "
alias k1="kubectl "
alias c="clear"

## git aliases
alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'
alias gapt='git apply --3way'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcas='git commit -a -s'
alias gcasm='git commit -a -s -m'
alias gcb='git checkout -b'
alias gcf='git config --list'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpr='git pull --rebase'
alias gpu='git push upstream'
alias gpv='git push -v'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'

alias gsw='git switch'

alias src="source ~/.bashrc"
alias 0s="sudo shutdown"

alias ar="argocd "

alias c="clear"
alias dlgn="docker exec -it 9d9 bash"

alias dsize="docker history --human --format '{{.CreatedBy}}: {{.Size}}' $*"
alias dst="docker stop $*"
alias dr="docker rm $*"
alias dri="docker rmi $*"
alias ds="docker system df"
alias dsv="docker system df -v"
alias di="docker images -a"
alias dp="docker ps -a"
alias de="docker exec -it $*"

alias sts="sudo systemctl status $*"
alias str="sudo systemctl restart $*"
alias stpp="sudo systemctl stop $*"
alias sdr="sudo systemctl daemon-reload"

alias 00='sts etcd'
alias 01='sts kube-apiserver'
alias 02='sts kube-scheduler'
alias 03='sts kube-controller-manager'

alias str0="str etcd"
alias str1="str kube-apiserver"
alias str2="str kube-scheduler"
alias str3="str kube-controller-manager"

alias svc0="sudo vi /etc/systemd/system/etcd.service"
alias svc1="sudo vi /etc/systemd/system/kube-apiserver.service"
alias svc2="sudo vi /etc/systemd/system/kube-scheduler.service"
alias svc3="sudo vi /etc/systemd/system/kube-controller-manager.service"

alias lg0="grep etcd /var/log/syslog | tail -50"
alias lg1="grep kube-apiserver /var/log/syslog | tail -50"
alias lg2="grep kube-scheduler /var/log/syslog | tail -50"
alias lg3="grep kube-controller-manager /var/log/syslog | tail -50"

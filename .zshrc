# Load seperated config files. If there are files that are dependended on laptop or should be private, putting the zsh files in following the directroy would be helpfull.
for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
  source "${conf}"
done
unset conf

# If you come from bash you might have to change your $PATH.
: "一般的な設定" && {
  setopt nobeep # ビープを鳴らさない
  setopt no_tify # バックグラウンドジョブが終了したらすぐに知らせる。
  setopt auto_menu # タブによるファイルの順番切り替えをしない
  setopt auto_pushd # cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
  setopt auto_cd # ディレクトリ名を入力するだけでcdできるようにする
  setopt interactivecomments
  setopt nonomatch

  # need to install zsh-completions / brew install zsh-completions
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi
  # brew install zsh-autosuggestions
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
 }

: "プラグイン" && {
  export ZPLUG_HOME=$(brew --prefix)/opt/zplug
  [ -f "$ZPLUG_HOME/init.zsh" ] || brew install zplug # zplugはHomebrewからインストール
  source $ZPLUG_HOME/init.zsh
  zplug mafredri/zsh-async, from:github
  # zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
  zplug "zsh-users/zsh-syntax-highlighting", defer:2 # fishシェル風のシンタクスハイライト … https://github.com/zsh-users/zsh-syntax-highlighting
  zplug "supercrabtree/k" # git情報を含んだファイルリストを表示するコマンド … https://github.com/supercrabtree/k
  zplug "junegunn/fzf", as:command, from:gh-r, rename-to:fzf # あいまい検索ができるコマンド … https://github.com/junegunn/fzf
  zplug "junegunn/fzf", use:shell/key-bindings.zsh # Ctrl-Rで履歴検索、Ctrl-Tでファイル名検索補完できる
  zplug "junegunn/fzf", use:shell/completion.zsh # cd **[TAB], vim **[TAB]などでファイル名を補完できる
  zplug "b4b4r07/enhancd", use:init.sh # cdコマンドをインタラクティブにするプラグイン … https://github.com/b4b4r07/enhancd
  zplug 'b4b4r07/gomi', as:command, from:gh-r # 消したファイルをゴミ箱から復元できるrmコマンド代替 … https://github.com/b4b4r07/gomi
  zplug "momo-lab/zsh-abbrev-alias" # 略語展開(iab)を設定するためのプラグイン … http://qiita.com/momo-lab/items/b1b1afee313e42ba687b
  zplug "paulirish/git-open", as:plugin # GitHub, GitLab, BitBucketを開けるようにするコマンド … https://github.com/paulirish/git-open
  zplug check || zplug install
  zplug load
}

# brew install pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")

autoload -U promptinit; promptinit
prompt pure
# optionally define some options
PURE_CMD_MAX_EXEC_TIME=10
# change the path color
zstyle :prompt:pure:path color white
# change the color for both `prompt:success` and `prompt:error`
zstyle ':prompt:pure:prompt:*' color cyan
# turn on git stash status
zstyle :prompt:pure:git:stash show yes

# タブ補完
zstyle ':completion:*:default' menu select=1
export PATH=/usr/local/bin:$PATH

# go path
export GOPATH=$HOME/go
# export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# node
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# ruby
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

export GHQROOT="/Users/yoshikimasubuchi/.ghq"
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# libxml2
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"
export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"

# flutter
export PATH="$PATH:$GHQROOT/github.com/flutter/flutter/bin"

# java
export JAVA_PATH=$(brew --prefix java)
export PATH="$JAVA_PATH/bin:$PATH"
export CPPFLAGS="-I$JAVA_PATH/include"

# link openjdk for puml
# sudo ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk


# alias
alias vim="nvim"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias sshadd="ssh-add ~/.ssh/id_rsa"

#commnads
alias be="bundle exec"
alias gb="git branch"
alias gs="git status --short --branch"
alias gc="git checkout "
alias gcp="git branch | peco | xargs git checkout"
alias gcb="git checkout -b"
alias gcm="git commit -m"
alias acm="aicommits"
alias gd="git diff --patience"
alias gdn="git diff --name-only"
alias gl="git log --graph --decorate --oneline"
alias gphc="git symbolic-ref --short HEAD| xargs -Icurrent_branch git push heroku-st current_branch:master"
alias gpo="git symbolic-ref --short HEAD| xargs git push origin "
alias gpof="git symbolic-ref --short HEAD| xargs git push origin --force-with-lease "
alias gbdm="git branch --merged | grep -Ev "(^\*|master|main|dev)" | xargs git branch -d "
alias cm="cat ~/.gitcommitmessage_sample | peco | xargs -I {} echo  "'{}'" "

alias gps="$PUSH_STAGING"
alias gpp="$PUSH_PRODUCTION"
alias tej="trans {en=ja}"
alias tje="trans {ja=en}"
alias ll="ls -l"
alias hpp="history 1| peco | pbcopy"
alias hp="history 1| peco "
alias hisg="history | grep "
alias sz="source ~/.zshrc"
alias vz="vim ${GHQROOT}/github.com/yoshixi/dotfiles/.zshrc"
alias home=$HOME
alias vv="vim ${GHQROOT}/github.com/yoshixi/dotfiles/nvim"
alias l="ls -al"
alias rm="rm -i"
alias macvim="open . -a MacVim"
alias xcode="open -a Xcode"
alias a="atom "
alias mine="/usr/local/bin/mine "
alias pp="pwd | pbcopy"
alias bi='bundle install --path vendor/bundle --jobs=4'

alias dkilla='docker kill $(docker ps -q)'

alias t='tmux '
alias tkills='tmux kill-session -t '
alias tkillw='tmux kill-window -t '
alias tkillp='tmux kill-pane -t '
tmux set -g set-titles on
tmux set -g set-titles-string '#{pane_title}'
tmux set -g pane-border-status top
tmux set -g pane-border-format "#{pane_index} #{pane_title}"
tmux set -g pane-border-style fg=red,bg=black


#directories
alias mamp="/Applications/MAMP/htdocs"
alias download="cd /Users/masubuchiyoshiki/Downloads"

# ruby
alias rubo="git diff --name-only --diff-filter=AM | grep '\.rb$' | xargs rubocop"
alias ruboa="git diff --name-only --diff-filter=AM | grep '\.rb$' | xargs rubocop -a"
alias rails-ruboa="git diff --name-only --staged | grep '\.rb$' | grep -v 'db/schema.rb' |  xargs bundle exec rubocop -a --force-exclusion"
alias grspec="git diff --name-only --staged | grep '\_spec.rb$' | xargs -t bundle exec rspec "

# for gas
alias nclasp="npx clasp "

# yaml-check
alias ymlc='ruby -ryaml -e "p YAML.load(STDIN.read)" < '

# go ghq管理 https://qiita.com/miyaz/items/3c4c32ed5ae13f29aa4c#_reference-cebc288b6d802dd5394c
alias gh='hub browse $(ghq list -p | peco | cut -d "/" -f 2,3)'
alias gh='hub browse $(ghq list -p | grep github.com | peco | cut -d "/" -f 2,3)'
#alias g='cd $(ghq root)/$(ghq list -p| peco)'
alias g='cd $(ghq list -p| peco)'


# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=10000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# historyの共有
setopt share_history
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開
setopt hist_expand
bindkey '^h' zaw-history
bindkey -v
# history search
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
source /Users/yoshikimasubuchi/.
# direnv
export EDITOR="vim"
eval "$(direnv hook zsh)"

# The cd command using in the autoenv confilicts with cd enhancd plugin so ignored it.
# source $(brew --prefix autoenv)/activate.sh


# pyenv
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

# 文字化け用
case $TERM in
	 linux) LANG=C ;;
	 *) LANG=ja_JP.UTF-8 ;;
esac

# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# sublime text cli https://www.sublimetext.com/docs/command_line.html#mac
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

[[ -s "/Users/yoshikimasubuchi/.gvm/scripts/gvm" ]] && source "/Users/yoshikimasubuchi/.gvm/scripts/gvm"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# for using localstack
export AWS_DEFAULT_REGION=us-west-2


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# poetry
export PATH="/Users/yoshikimasubuchi/.local/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yoshikimasubuchi/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yoshikimasubuchi/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yoshikimasubuchi/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yoshikimasubuchi/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

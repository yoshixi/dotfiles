if which plenv > /dev/null; then eval "$(plenv init -)"; fi

# If you come from bash you might have to change your $PATH.
: "一般的な設定" && {
  autoload -U compinit && compinit -d ${COMPDUMPFILE} # 補完機能の強化
  setopt nobeep # ビープを鳴らさない
  setopt no_tify # バックグラウンドジョブが終了したらすぐに知らせる。
  setopt auto_menu # タブによるファイルの順番切り替えをしない
  setopt auto_pushd # cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
  setopt auto_cd # ディレクトリ名を入力するだけでcdできるようにする
  setopt interactivecomments
  setopt nonomatch
 }


: "プラグイン" && {
  export ZPLUG_HOME=/usr/local/opt/zplug
  [ -f "$ZPLUG_HOME/init.zsh" ] || brew install zplug # zplugはHomebrewからインストール
  source $ZPLUG_HOME/init.zsh
  zplug "zsh-users/zsh-completions" # 多くのコマンドに対応する入力補完 … https://github.com/zsh-users/zsh-completions
  zplug "mafredri/zsh-async" # "sindresorhus/pure"が依存している
  zplug "yoshixj/pure", use:pure.zsh, as:theme, from:github # 美しく最小限で高速なプロンプト … https://github.com/sindresorhus/pure
  zplug "zsh-users/zsh-syntax-highlighting", defer:2 # fishシェル風のシンタクスハイライト … https://github.com/zsh-users/zsh-syntax-highlighting
  zplug "supercrabtree/k" # git情報を含んだファイルリストを表示するコマンド … https://github.com/supercrabtree/k
  zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf # あいまい検索ができるコマンド … https://github.com/junegunn/fzf
  zplug "junegunn/fzf", as:command, use:bin/fzf-tmux # tmuxでfzfを使えるようにするプラグイン
  zplug "junegunn/fzf", use:shell/key-bindings.zsh # Ctrl-Rで履歴検索、Ctrl-Tでファイル名検索補完できる
  zplug "junegunn/fzf", use:shell/completion.zsh # cd **[TAB], vim **[TAB]などでファイル名を補完できる
  zplug "b4b4r07/enhancd", use:init.sh # cdコマンドをインタラクティブにするプラグイン … https://github.com/b4b4r07/enhancd
  zplug 'b4b4r07/gomi', as:command, from:gh-r # 消したファイルをゴミ箱から復元できるrmコマンド代替 … https://github.com/b4b4r07/gomi
  zplug "momo-lab/zsh-abbrev-alias" # 略語展開(iab)を設定するためのプラグイン … http://qiita.com/momo-lab/items/b1b1afee313e42ba687b
  zplug "paulirish/git-open", as:plugin # GitHub, GitLab, BitBucketを開けるようにするコマンド … https://github.com/paulirish/git-open
  zplug check || zplug install
  zplug load
}

# タブ補完
autoload -Uz compinit && compinit
zstyle ':completion:*:default' menu select=1
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/mysql/bin
# Path to your oh-my-zsh installation.
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
# go path
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# node
export PATH=$HOME/.nodebrew/current/bin:$PATH
# ruby
eval "$(rbenv init -)"

# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# libxml2
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"
export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"

# alias
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
#
#commnads
alias be="bundle exec"
alias g="git"
alias gb="git branch"
alias gs="git status --short --branch"
alias gc="git checkout "
alias gcp="git branch | peco | xargs git checkout"
alias gcb="git checkout -b"
alias gcm="git commit -m"
alias gd="git diff --color-words"
alias gdn="git diff --name-only"
alias gl="git log --graph --decorate --oneline"
alias gphc="git symbolic-ref --short HEAD| xargs -Icurrent_branch git push heroku-st current_branch:master"
alias gpo="git symbolic-ref --short HEAD| xargs git push origin "

alias gps="$PUSH_STAGING"
alias gpp="$PUSH_PRODUCTION"
alias jvcd="javac -d cmp"
alias tej="trans {en=ja}"
alias tje="trans {ja=en}"
alias ll="ls -l"
alias hpp="history 1| peco | pbcopy"
alias hp="history 1| peco "
alias hisg="history | grep "
alias sz="source ~/.zshrc"
alias vz="vim ~/.zshrc"
alias home=$HOME
alias ecry='/Users/masubuchiyoshiki/Sites/nicola/ECRy-web'
alias vv="vim ~/.vimrc"
alias l="ls -al"
alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias macvim="open . -a MacVim"
alias xcode="open -a Xcode"
alias a="atom "
alias mine="/usr/local/bin/mine "
alias pp="pwd | pbcopy"
alias bi='bundle install --path vendor/bundle --jobs=4'

alias d='docker '
alias dc-rails-mysql="cp /Users/yoshikimasubuchi/.ghq/github.com/yoshixj/dotfiles/docker-rails-mysql/Dockerfile . && cp /Users/yoshikimasubuchi/.ghq/github.com/yoshixj/dotfiles/docker-rails-mysql/docker-compose.yml . "
alias dc='docker-compose '
alias datt='docker attach'
alias dcb='docker-compose build'
alias dclogs='docker-compose logs'
alias dcu='docker-compose up'
alias dcstop='docker-compose stop'
alias ddiff='docker diff'
alias deb='dexbash'
alias dimg='docker images'
alias dins='docker inspect'
alias dps='docker ps'
alias dbuild='docker build'
alias drm='docker rm'
alias drmi='docker rmi'
alias drun='docker run'
alias dstart='docker start'
alias dstop='docker stop'

alias t='tmux '
alias tkills='tmux kill-session -t '
alias tkillw='tmux kill-window -t '
alias tkillp='tmux kill-pane -t '

alias du='du_pretty'
#directories
alias mamp="/Applications/MAMP/htdocs"
alias download="/Users/masubuchiyoshiki/Downloads"

#nicola
alias rubo="git diff --name-only --diff-filter=AM | grep '\.rb$' | xargs rubocop"
alias ruboa="git diff --name-only --diff-filter=AM | grep '\.rb$' | xargs rubocop -a"
alias rails-ruboa="git diff --name-only --staged | grep '\.rb$' | grep -v 'db/schema.rb' |  xargs bundle exec rubocop -a --force-exclusion"


# for gas
alias nclasp="npx clasp "

# yaml-check
alias yml='ruby -ryaml -e "p YAML.load(STDIN.read)" < '

# go ghq管理 https://qiita.com/miyaz/items/3c4c32ed5ae13f29aa4c#_reference-cebc288b6d802dd5394c
alias g='REPO=$(ghq list | sort -u | peco);for GHQ_ROOT in $(ghq root -all);do [ -d $GHQ_ROOT/$REPO ] && cd $GHQ_ROOT/$REPO;done'
alias gg='REPO=$(ghq list | sort -u | peco);for GOPATH in $(ghq root -all);do [ -d $GOPATH/$REPO ] && cd $GOPATH/$REPO;done'
alias gh='hub browse $(ghq list | grep github.com | peco | cut -d "/" -f 2,3)'

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
source /Users/yoshikimasubuchi/.ghq/github.com/zsh-users/zaw/zaw.zsh
# direnv
export EDITOR="vim"
eval "$(direnv hook zsh)"

# 実行できいない
function gpoc {
  local current_branch = `git symbolic-ref --short HEAD`
  git push orgin $current_branch
}
zle -N gpoc
bindkey '^G' gpoc

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

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yoshikimasubuchi/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yoshikimasubuchi/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yoshikimasubuchi/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yoshikimasubuchi/google-cloud-sdk/completion.zsh.inc'; fi

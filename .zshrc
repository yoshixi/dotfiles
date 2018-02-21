# If you come from bash you might have to change your $PATH.
: "一般的な設定" && {
  autoload -U compinit && compinit -d ${COMPDUMPFILE} # 補完機能の強化
  setopt nobeep # ビープを鳴らさない
  setopt no_tify # バックグラウンドジョブが終了したらすぐに知らせる。
  setopt auto_menu # タブによるファイルの順番切り替えをしない
  setopt auto_pushd # cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
  setopt auto_cd # ディレクトリ名を入力するだけでcdできるようにする
  setopt interactivecomments
 }


: "プラグイン" && {
  export ZPLUG_HOME=/usr/local/opt/zplug
  [ -f "$ZPLUG_HOME/init.zsh" ] || brew install zplug # zplugはHomebrewからインストール
  source $ZPLUG_HOME/init.zsh
  zplug "zsh-users/zsh-completions" # 多くのコマンドに対応する入力補完 … https://github.com/zsh-users/zsh-completions
  zplug "mafredri/zsh-async" # "sindresorhus/pure"が依存している
  zplug "sindresorhus/pure", use:pure.zsh, as:theme # 美しく最小限で高速なプロンプト … https://github.com/sindresorhus/pure
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
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH=/usr/local/bin:/usr/local/share/python:$PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/mysql/bin
# Path to your oh-my-zsh installation.
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
# go path
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go/src
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin



# alias
#commnads
alias be="bundle exec"
alias g="git"
alias gb="git branch"
alias gs="git status"
alias gc="git checkout"
alias gcm="git commit -m"
alias gd="git diff"
alias gpo="git push origin "
alias gps="$PUSH_STAGING"
alias gpp="$PUSH_PRODUCTION"
alias jvcd="javac -d cmp"
alias tej="trans {en=ja}"
alias tje="trans {ja=en}"
alias ll="ls -l"
alias hispcpb="history 1| peco | pbcopy"
alias hisg="history | grep "
alias sz="source ~/.zshrc"
alias vz="vim ~/.zshrc"
alias home=$HOME
alias vv="vim ~/.vimrc"
alias l="ls -al"
alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias macvim="open . -a MacVim"
eval "$(rbenv init -)"


#directories
alias mamp="/Applications/MAMP/htdocs"
alias download="/Users/masubuchiyoshiki/Downloads"

#nicola
alias rubo="git diff --name-only --diff-filter=AM | grep '\.rb$' | xargs rubocop"

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
# history search
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
source /Users/masubuchiyoshiki/zsh_plugin/zaw/zaw.zsh
# direnv
export EDITOR="vim"
eval "$(direnv hook zsh)"

function gpoc {
  local current_branch = `git symbolic-ref --short HEAD`
  git push orgin $current_branch
}
bindkey '^G' gpoc

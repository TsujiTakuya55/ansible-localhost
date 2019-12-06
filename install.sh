#!/bin/bash

PLAYBOOKPATH=~/.ansible-localhost
GITHUB="https://github.com/TsujiTakuya55/ansible-localhost.git";

# 環境構築
initialize() {
    echo "init"

    if [ "$(uname)" = 'Darwin' ]; then

        # brewがインストールされていなければインストール実行
        if !(type "brew" > /dev/null 2>&1); then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi

    elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
        # brewがインストールされていなければインストール実行
        if !(type "brew" > /dev/null 2>&1); then
             sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
             test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
             test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
             test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
             echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
        fi

    fi

    # pythonがインストールされていなければインストール実行
    if !(type "python" > /dev/null 2>&1); then
        brew insatll python
    fi

    # ansibleがインストールされていなければインストール実行
    if !(type "ansible" > /dev/null 2>&1); then
        brew install ansible
    fi
}

# ファイルをダウンロード
download() {
    echo "download"

    if [ -d "$PLAYBOOKPATH" ]; then
        log_fail "$PLAYBOOKPATH: already exists"
        exit 1
    fi

    # gitが使用できる場合はgitを使用
    if  [ `which git` ]; then
        git clone --recursive "$GITHUB" "$PLAYBOOKPATH"
    # 使えない場合は curl か wget を使用する
    elif [ `which curl` ] || [ `which wget` ]; then
        tarball="https://github.com/TsujiTakuya55/dotfiles/archive/master.tar.gz"

        # どっちかでダウンロードして，tar に流す
        if [ `which curl` ]; then
            curl -L "$tarball"

        elif [ `which wget` ]; then
            wget -O - "$tarball"

        fi | tar zxv

        # 解凍したら，PLAYBOOKPATH に置く
        mv -f dotfiles-master "$PLAYBOOKPATH"

    else
        die "curl or wget required"
    fi
}

# dotfilesをリンク
deploy() {
    echo "deploy"

    ansible-playbook -i hosts "$PLAYBOOKPATH"/packages.yml
}

if [ "$1" = "deploy" -o "$1" = "d" ]; then
    deploy
elif [ "$1" = "install" -o "$1" = "i" ]; then
    initialize &&
    download &&
    deploy
fi
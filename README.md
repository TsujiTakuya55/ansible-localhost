# ansible-localhost

## Install
```bash
bash -c "$(curl -L raw.github.com/ttakuya50/ansible-localhost/master/install.sh)" -s install
chsh -s /bin/zsh
# 最後にターミナル再起動
```

## Dry run
ansible-playbook -i hosts packages.yml -vvv --check

## After starting ansible, perform the following operations manually 
1. node version specification
```shell script
#https://www.suzu6.net/posts/45/
nodebrew list
nodebrew use v11.6.0
npm install -g cz-conventional-changelog-ja
```          
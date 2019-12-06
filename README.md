# ansible-localhost

## Install
```bash
bash -c "$(curl -L raw.github.com/TsujiTakuya55/ansible-localhost/master/install.sh)" -s install
chsh -s /bin/zsh
# 最後にターミナル再起動
```

## Test＆Debug
```bash
docker build -t ansible-localhost:latest --build-arg USERNAME=$(whoami) .
docker run -it ansible-localhost
bash -c "$(curl -L raw.github.com/TsujiTakuya55/dotfiles/master/install.sh)" -s install
#docker run -it -v $(pwd)/:/home/$(whoami)/ansible-localhost/:ro ansible-localhost
```

## dry run
ansible-playbook -i hosts packages.yml -vvv --check


# ansible-localhost

## Install
```bash
bash -c "$(curl -L raw.github.com/ttakuya50/ansible-localhost/master/install.sh)" -s install
chsh -s /bin/zsh
# 最後にターミナル再起動
```

## dry run
ansible-playbook -i hosts packages.yml -vvv --check


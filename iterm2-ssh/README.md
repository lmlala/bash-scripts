# Iterm2-ssh
for mac iterm2
auto re-color & re-name tab  when ssh to a remote server
aviod to mistake operations on some important servers

## Steps
#### 1. Config your host
update ~/.ssh/config for hostname alias and priority identified

```bash
Host d01
  HostName 192.168.100.11
  Port 22
  User root
  IdentityFile ~/data/keys/mykey

Host dev-n01
  HostName 172.16.30.101
  Port 22
  User root
  IdentityFile ~/data/keys/mykey
```

#### 2. Enable the plugin

##### Without `oh-my-zsh`:
put `iterm2-ssh.plugin.zsh` in any place like `~/.plugins`,
append fllowing line in your `~/.zshrc`:
```sh
source ~/.plugins/iterm2-ssh.plugin.zsh
```

##### With `oh-my-zsh`:
put the plugin file under `~/.oh-my-zsh/custome/plugins/iterm2-ssh/`,
and append __iterm2-ssh__ in the constant `plugins` defined in `~/.zshrc`:
```sh
...
plugins=(git iterm2-ssh)
...
```

#### 4. Restart __zsh__

```sh
exec $SHELL
```

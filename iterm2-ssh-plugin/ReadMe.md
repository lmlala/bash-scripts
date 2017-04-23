for mac iterm2
auto re-color & re-name tab  when ssh to a remote server
aviod to mistake operations on some important servers

## Steps
-------------
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

#### 2. Plugin script
Put following content in a file called `item2-ssh.plugin.zsh`

```bash

function tab-color() {
    echo -e "\033]6;1;bg;$1;brightness;255\a"
}

function tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
    echo -ne "\033]0;local\007"
}

function ch_title_name() {
	echo -ne "\033]0;"$1"\007"
}


# Change the color of the tab when using SSH
# reset the color after the connection closes
function chtitle() {
    if [ -n "$ITERM_SESSION_ID" ]; then
        trap "tab-reset" INT EXIT

		if [ x"`echo $* | sed -n '/^product.*$/p;/^sandbox.*$/p'`" != "x" ]
			then
			tab-color red

		elif [ x"`echo $* | sed -n '/^dev.*$/p'`" != "x" ]
			then
			tab-color blue

		else
			tab-color green
		fi

		ch_title_name $1
		/usr/bin/ssh $*
    fi

}

function ssh() {
     chtitle $*
}
```

#### 3. Enable the plugin

##### Without `oh-my-zsh`:
put `item2-ssh.plugin.zsh` in any place like `~/.plugins`,
append fllowing line in your `~/.zshrc`:
```sh
source ~/.plugins/item2-ssh.plugin.zsh
```

##### With `oh-my-zsh`:
put the plugin file under `~/.oh-my-zsh/custome/plugins/item2-ssh/`,
and append __item2-ssh__ in the constant `plugins` defined in `~/.zshrc`:
```sh
...
plugins=(git item2-ssh)
...
```

#### 4. Restart __zsh__

```sh
exec $SHELL
```

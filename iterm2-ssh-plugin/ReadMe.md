# for mac iterm2
# auto re-color & re-name tab  when ssh to a remote server
# aviod to mistake operations on some import servers

Steps
-------------
1. update ~/.ssh/config for hostname alias and priority identified

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

```bash


2. update ~/.zshrc   for customized your ssh

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


```bash

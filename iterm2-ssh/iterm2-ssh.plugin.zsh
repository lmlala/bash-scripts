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

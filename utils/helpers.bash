# Helpers functions.

# Copied from oh-my-zsh.
function clippaste () {
	emulate -L zsh
	if [[ $OSTYPE == darwin* ]]
	then
		pbpaste
	elif [[ $OSTYPE == cygwin* ]]
	then
		cat /dev/clipboard
	else
		if (( $+commands[xclip] ))
		then
			xclip -out -selection clipboard
		elif (( $+commands[xsel] ))
		then
			xsel --clipboard --output
		else
			print "clipcopy: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
			return 1
		fi
	fi
}


# Save clipboard contents to file "p$1.txt" in current directory.
function save() {
    file_name="p${1:?exercise number is missing}.txt"
    clippaste > "$file_name"
    echo "$file_name saved"
    cat "$file_name"
}


# Create descriptions file for every file in directory "$1".
function generate_descriptions_stub() {
    [[ -d "${1:?choose directory}" ]] && dir_path="$1"
    desc_file="descriptions.cfg"

    for file in "$dir_path"/*; do
        echo "
["$(basename $file)"]
name = [Березин] Упражнение N, § M
description =
" >> "$dir_path/$desc_file"
    done
}

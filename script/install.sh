# !/bin/bash
NVIM_DIR=`pwd`
percent=0

# Go to tools directory
CONFIG=$NVIM_DIR/config
TOOLS=$NVIM_DIR/tools

echo "------------------ Install softwares ------------------"
cd $TOOLS
declare -a softwares=("nvim" "clang" "minimap" "ripgrep" "lazygit" "fd" "tmux" "ctags" "python" "node" "fzf")
for i in "${softwares[@]}"
do
	percent=$(($percent+5))
	if [ -f $i* ]
	then
		if [ $i != "lazygit" ] || [ $i != "fzf" ]
		then
			if [ -f $i*.tar ]
			then
				tar xf $i*.tar && rm -rf $i*.tar
			fi
			if [ -f $i*.tar.bz2 ]
			then
				tar xf $i*.tar.bz2 && rm -rf $i*.tar.bz2
			fi
		fi

		SW_DIR=`ls | grep $i`
		SW_BIN=$SW_DIR/bin

		echo "[$percent%] Install $i: [OK]" && $i -V
		export PATH="$TOOLS/$SW_DIR:$PATH"
		export PATH="$TOOLS/$SW_BIN:$PATH"

		if [ $i = "node" ]
		then
			export PATH="$TOOLS/$SW_DIR/lib/node_modules/neovim/bin:$PATH"	
		fi
		if [ $i = "python" ]
		then
			mv $TOOLS/pynvim_package/* $home/.local
		fi
	else
		if [ -d $i* ]
		then
			echo "[$percent%] ${i^} installed: [OK]"
		else
			echo "[$percent%] Install $i: [FAILED] ($i does not exist, refer README to download)"
		fi
	fi
done


echo "------------------ Install Neovim Plugins ------------------"
cd $CONFIG
cd pack
percent=$(($percent+5))
if [ -f "*.tar.bz2"]
then
	tar xf *.tar.bz2
	echo "[$percent%] Install plugins: [OK]"
	rm -rf *.tar.bz2
else
	if [ -f "packer_compiled.lua"]
	then
		echo "[$percent%] Plugins installed: [OK]"
	else
		echo "[$percent%] Install plugins: [FAILED] (refer README to download)"
	fi
fi

echo "------------------ Install Language Server Protocol ------------------"
cd $CONFIG/mason/bin
percent=$(($percent+5))

if [ -f "*.tar.bz2"]
then
	tar xf *.tar.bz2
	echo "[$percent%] Install LSP execution files: [OK]"
	rm -rf *.tar.bz2
else
	if [ -f "clangd" ]
	then
		echo "[$percent%] LSP execution files installed: [OK]"
	else
		echo "[$percent%] Install LSP execution files: [FAILED] (refer README to download)"
	fi
fi

cd $CONFIG/mason/package


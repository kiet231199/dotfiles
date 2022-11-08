# !/bin/bash
NEOVIM=`pwd`
percent=0

# Go to tools directory
CONFIG=$NEOVIM/config
TOOLS=$NEOVIM/tools

echo "------------------------------------------- Install softwares -------------------------------------------"
cd $TOOLS
declare -a softwares=("clang" "ctags" "fd" "fzf" "lazygit" "node" "nvim" "python" "ripgrep" "tmux")
for i in "${softwares[@]}"
do
	percent=$(($percent+5))
	if [ $i != "lazygit" ] && [ $i != "fzf" ]
	then
		if [ -f $i* ]
		then
			# Extract softwares
			if [ -f $i*.tar ]; then tar xf $i*.tar && rm -rf $i*.tar; fi
			if [ -f $i*.tar.bz2 ]; then tar xf $i*.tar.bz2 && rm -rf $i*.tar.bz2; fi

			SW_DIR=`ls | grep $i`
			SW_BIN=$SW_DIR/bin

			if [ $i = "tmux" ]
			then
				echo "[$percent%] Install $i: [OK]" && $i -V
			else
				echo "[$percent%] Install $i: [OK]" && $i --version
			fi

			# Export path for softwares
			export PATH="$TOOLS/$SW_DIR:$PATH"
			export PATH="$TOOLS/$SW_BIN:$PATH"

			# Install node neovim, nvim --remote and pynvim
			if [ $i = "node" ]; then export PATH="$TOOLS/$SW_DIR/lib/node_modules/neovim/bin:$PATH"; fi
			if [ $i = "python" ]; then mv $TOOLS/pynvim_package/* $home/.local; fi
		else
			if [ -d $i* ]
			then
				echo "[$percent%] ${i^} installed: [OK]"
			else
				echo "[$percent%] Install $i: [FAILED] ($i does not exist, refer README to download)"
			fi
		fi
	else
		# Fzf and lazygit does not have compress file
		echo "[$percent%] Install $i: [OK]" && $i --version
		export PATH="$TOOLS:$PATH"
	fi
done

echo "----------------------------------------- Install Neovim Plugins -----------------------------------------"
cd $CONFIG/pack
percent=$(($percent+5))
if [ -f "*.tar.bz2"]
then
	if [ -f $i*.tar ]; then	tar xf $i*.tar && rm -rf $i*.tar; fi
	if [ -f $i*.tar.bz2 ]; then	tar xf $i*.tar.bz2 && rm -rf $i*.tar.bz2; fi
	echo "[$percent%] Install plugins: [OK]"
else
	if [ -f "packer_compiled.lua"]
	then
		echo "[$percent%] Plugins installed: [OK]"
	else
		echo "[$percent%] Install plugins: [FAILED] (refer README to download)"
	fi
fi
# Checkout tag for some plugins and wait till they stable
cd packer/start/nvim-treesitter && git checkout v0.8.0
cd packer/start/nvim-notify && git checkout v3.7.3

echo "------------------------------------ Install Language Server Protocol -------------------------------------"
cd $CONFIG/mason/bin
percent=$(($percent+5))
i="pack"
if [ -f $i* ]
then
	if [ -f $i*.tar ]; then	tar xf $i*.tar && rm -rf $i*.tar; fi
	if [ -f $i*.tar.bz2 ]; then	tar xf $i*.tar.bz2 && rm -rf $i*.tar.bz2; fi
	echo "[$percent%] Install LSP execution files: [OK]"
else
	if [ -f "clangd" ]
	then
		echo "[$percent%] LSP execution files installed: [OK]"
	else
		echo "[$percent%] Install LSP execution files: [FAILED] (refer README to download)"
	fi
fi

cd $CONFIG/mason/package
percent=$(($percent+5))
i="pack"
if [ -f $i* ]
then
	# Look for all pack?.tar.bz2
	for p in *; do
		if [ -f p ]; then tar xf p && rm -rf p; fi
		if [ -f p ]; then tar xf p && rm -rf p; fi
	done
	echo "[$percent%] Install LSP execution files: [OK]"
else
	if [ -d "clangd" ] && [ -d "lua-language-server" ] && [ -d "bash-language-server" ]
	then
		echo "[$percent%] LSP execution files installed: [OK]"
	else
		echo "[$percent%] Install LSP execution files: [FAILED] (refer README to download)"
	fi
fi

echo "------------------------------------ Install Neovim Configuration -------------------------------------"
# Link config directory to home
ln -s $CONFIG ~/.config
percent=$(($percent+5))
echo "[$percent%] Link neovim configuration to home: [OK]"

cd $CONFIG/mason/

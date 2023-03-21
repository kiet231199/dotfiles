# !/bin/bash
CUR_DIR="$(dirname "$0")"
cd $CUR_DIR/../
NEOVIM=$(pwd)
percent=0

# Color
RED="\033[0;31m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
NC="\033[0m" # No Color

echo -e "-------------------------------------------- Check packages --------------------------------------------"
cd $NEOVIM && out="false"
# Check parent directory
if [ ! -d config ]; then echo -e "${CYAN}Missed config directory. Exit installation.${NC}" && out="true"; else CONFIG=$NEOVIM/config; fi
if [ ! -d tools ]; then echo -e "${CYAN}Missed tool directory. Exit installation.${NC}" && out="true"; else TOOLS=$NEOVIM/tools; fi
if [ ! -d script ]; then echo -e "${CYAN}Missed script directory. Exit installation.${NC}" && out="true"; else SCRIPT=$NEOVIM/script; fi
if [ $out = "true" ]; then echo -e "${CYAN}Refer https://github.com/kiet231199/neovim.git to download.${NC}" && exit 1; fi

# Check children directory
if [ ! -d $CONFIG/nvim ] || [ ! -d $CONFIG/pack ] || [ ! -d $CONFIG/mason ]; then echo -e "${CYAN}Missed some directory.${NC}"; fi
cd $CONFIG/nvim
if [ ! -f init.lua ] || [ ! -d lua ]; then echo -e "${CYAN}Configuration files (config/mason directory). Exit installation.${NC}" && out="true"; fi
cd $CONFIG/pack && i=$(ls | grep -c tar)
if [ $i -eq 0 ] && [ ! -f packer_compiled.lua ]; then echo -e "${CYAN}Neovim plugins (in config/pack directory). Exit installation.${NC}" && out="true"; fi
cd $CONFIG/mason
i=$(ls bin | grep -c tar) && j=$(ls packages | grep -c tar)
if [ $(($i)) -eq 0 ] && [ $(($j)) -eq 0 ] && [ ! -f bin/clangd ] && [ ! -d packages/clangd ]; then echo -e "${CYAN}LSP packages (config/mason directory). Exit installation.${NC}" && out="true"; fi
if [ $out = "true" ]; then echo -e "${CYAN}Refer https://github.com/kiet231199/neovim.git to download.${NC}" && exit 1; fi

percent=10 && echo -e "${GREEN}[$percent%] Checking packages: [OK]${NC}"

echo -e "------------------------------------------- Install softwares -------------------------------------------"
cd ~ && if [ -f ~/.bash_profile ]; then rm ~/.bash_profile; fi
touch ~/.bash_profile
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
			if [ -f $i*.tar.gz ]; then tar xf $i*.tar.gz && rm -rf $i*.tar.gz; fi
			if [ -f $i*.tar.bz2 ]; then tar xf $i*.tar.bz2 && rm -rf $i*.tar.bz2; fi

			if [ $i = "nvim" ]; then SW_DIR=$(ls | grep "nvim-"); else SW_DIR=$(ls | grep $i); fi
			SW_BIN=$SW_DIR/bin

			# Export path for softwares
			export PATH="$PATH:$TOOLS/$SW_DIR" && echo "export PATH=\"$TOOLS/$SW_DIR:\$PATH\"" >> ~/.bash_profile
			export PATH="$PATH:$TOOLS/$SW_BIN" && echo "export PATH=\"$TOOLS/$SW_BIN:\$PATH\"" >> ~/.bash_profile

			# Install node neovim, nvim --remote and pynvim
			if [ $i = "node" ]
			then
				export PATH="$PATH:$TOOLS/$SW_DIR/lib/node_modules/neovim/bin"
				echo "export PATH=\"$TOOLS/$SW_DIR/lib/node_modules/neovim/bin:\$PATH\"" >> ~/.bash_profile
			fi
			if [ $i = "python" ]; then cp -r $TOOLS/pynvim_package/* ~/.local; fi

			# Test path
			if [ $i = "tmux" ]; then echo -e "${GREEN}[$percent%] Install $i: [OK]${NC}" && $i -V; fi
			if [ $i = "python" ]; then echo -e "${GREEN}[$percent%] Install $i: [OK]${NC}" && python3 --version; fi
			if [ $i = "ripgrep" ]; then echo -e "${GREEN}[$percent%] Install $i: [OK]${NC}" && rg --version; fi
			if [ $i != "tmux" ] &&  [ $i != "python" ] && [ $i != "ripgrep" ]
			then
				echo -e "${GREEN}[$percent%] Install $i: [OK]${NC}" && $i --version
			fi

		else
			if [ -d $i* ]
			then
				if [ $i = "nvim" ]; then SW_DIR=$(ls | grep "nvim-"); else SW_DIR=$(ls | grep $i); fi
				SW_BIN=$SW_DIR/bin
				# Export path for softwares
				echo "export PATH=\"$TOOLS/$SW_DIR:\$PATH\"" >> ~/.bash_profile
				echo "export PATH=\"$TOOLS/$SW_BIN:\$PATH\"" >> ~/.bash_profile
				echo -e "${GREEN}[$percent%] ${i^} has been installed: [OK]${NC}"
			else
				echo -e "${RED}[$percent%] Install $i: [FAILED] ($i does not exist, refer README to download)${NC}"
			fi
		fi
	else
		# Fzf and lazygit does not have compress file
		if [ -f lazygit ] || [ -f fzf ]
		then
			chmod 775 $i
			export PATH="$TOOLS:$PATH" && echo "export PATH=\"$TOOLS:\$PATH\"" >> ~/.bash_profile
			echo -e "${GREEN}[$percent%] Install $i: [OK]${NC}" && $i --version
		else
			echo -e "${RED}[$percent%] Install $i: [FAILED] ($i does not exist, refer README to download)${NC}"
		fi
	fi
done

# Add bash_profile to bashrc
i=$(grep -c "bash_profile" ~/.bashrc)
if [ $(($i)) -eq 0 ]; then echo "if [ -f ~/.bash_profile ]; then . ~/.bash_profile; fi" >> ~/.bashrc; fi 
i=$(grep -c NVIM_LISTEN_ADDRESS ~/.bashrc)
if [ $(($i)) -eq 0 ]; then cat $SCRIPT/script.txt >> ~/.bash_profile; fi

echo -e "----------------------------------------- Install Neovim Plugins -----------------------------------------"
cd $CONFIG/pack
percent=$(($percent+5)) && i="pack"
if [ -f $i* ]
then
	if [ -f $i*.tar.gz ]; then tar xf $i*.tar.gz && rm -rf $i*.tar.gz; fi
	if [ -f $i*.tar.bz2 ]; then tar xf $i*.tar.bz2 && rm -rf $i*.tar.bz2; fi
	echo -e "${GREEN}[$percent%] Install plugins: [OK]${NC}"
else
	if [ -f packer_compiled.lua ]
	then
		echo -e "${GREEN}[$percent%] Plugins have been installed: [OK]${NC}"
	else
		echo -e "${RED}[$percent%] Install plugins: [FAILED]${NC}"
	fi
fi

percent=$(($percent+5))
if [ -f packer_compiled.lua ]
then
	# Convert plugins to Unix format
	find . -type f -print0 | xargs -0 dos2unix > /dev/null 2>&1
	echo -e "${GREEN}[$percent%] Plugins format converted: [OK]${NC}"
	# Checkout tag for some plugins and wait till they stable
	percent=$(($percent+5))
	echo -e "${CYAN}Checkout nvim-treesitter version v0.8.0:${NC}"
	cd $CONFIG/pack/packer/start/nvim-treesitter && git checkout v0.8.0
	echo -e "${CYAN}Checkout nvim-notify version v3.8.0:${NC}"
	cd $CONFIG/pack/packer/start/nvim-notify && git checkout v3.7.3
	echo -e "${GREEN}[$percent%] Checkout plugins version: [OK]${NC}"
fi

echo -e "------------------------------------ Install Language Server Protocol -------------------------------------"
cd $CONFIG/mason/bin
percent=$(($percent+5)) && i="pack"
if [ -f $i* ]
then
	if [ -f $i*.tar.gz ]; then tar xf $i*.tar.gz && rm -rf $i*.tar.gz; fi
	if [ -f $i*.tar.bz2 ]; then tar xf $i*.tar.bz2 && rm -rf $i*.tar.bz2; fi
	echo -e "${GREEN}[$percent%] Install LSP execution files: [OK]${NC}"
else
	if [ -f clangd ]
	then
		echo -e "${GREEN}[$percent%] LSP execution files have been installed: [OK]${NC}"
	else
		echo -e "${RED}[$percent%] Install LSP execution files: [FAILED]${NC}"
	fi
fi

cd $CONFIG/mason/packages
percent=$(($percent+5))
i=$(ls | grep -c tar)
if [ $i -gt 0 ]
then
	# Look for all pack?.tar.bz2
	for p in *; do
		if [ -f $p ]; then tar xf $p && rm -rf $p; fi
		if [ -f $p ]; then tar xf $p && rm -rf $p; fi
	done
	echo -e "${GREEN}[$percent%] Install LSP packages: [OK]${NC}"
else
	if [ -d "clangd" ]
	then
		echo -e "${GREEN}[$percent%] LSP packages have been installed: [OK]${NC}"
	else
		echo -e "${RED}[$percent%] Install LSP packages: [FAILED]${NC}"
	fi
fi

echo -e "-------------------------------------- Install Neovim Configuration ---------------------------------------"
cd $CONFIG/nvim/
# Convert configuation to Unix format
find . -type f -print0 | xargs -0 dos2unix > /dev/null 2>&1
percent=$(($percent+5)) && echo -e "${GREEN}[$percent%] Configuration files's format converted: [OK]${NC}"

# Set new path for some files
if [ -d $CONFIG/mason/packages/lua-language-server ]
then
	cd $CONFIG/mason/packages/lua-language-server
	oldLuaLSP=$(cat lua-language-server | grep lua-language-server)
	newLuaLSP="exec "$CONFIG/mason/packages/lua-language-server/extension/server/bin/lua-language-server" "$@""
	sed -i "s|$oldLuaLSP|$newLuaLSP|g" lua-language-server
fi

cd $CONFIG/nvim
oldInit=$(cat init.lua | grep python3_host_prog)
newInit="let g:python3_host_prog = \"$TOOLS/python-3.10.7/bin/python3\""
sed -i "s|$oldInit|$newInit|g" init.lua

oldInit=$(cat init.lua | grep node_host_prog)
newInit="let g:node_host_prog = \"$TOOLS/node-v16.17.1/lib/node_modules/neovim/bin/cli.js\""
sed -i "s|$oldInit|$newInit|g" init.lua

cd $CONFIG/nvim/lua/user
oldConfig=$(cat packer.lua | grep "g.nvim_profile_path = ")
newConfig="g.nvim_profile_path = \"$CONFIG/\""
sed -i "s|$oldConfig|$newConfig|g" packer.lua

oldConfig=$(cat mason.lua | grep "install_root_dir = ")
newConfig="	install_root_dir = \"$CONFIG/mason\","
sed -i "s|$oldConfig|$newConfig|g" mason.lua

percent=$(($percent+5)) && echo -e "${GREEN}[$percent%] Set path for configuration files: [OK]${NC}"

# Link config directory to home
cd ~/.config && unlink nvim
ln -s $CONFIG/nvim .
percent=$(($percent+5)) && echo -e "${GREEN}[$percent%] Link neovim configuration to home: [OK]${NC}"

source ~/.bashrc
echo -e "${CYAN}Installion DONE.${NC}"

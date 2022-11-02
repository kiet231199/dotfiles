# !/bin/bash
# 1. Create ProgressBar function
# 1.1 Input is currentState($1) and totalState($2)
function ProgressBar {
# Process data
	let _factor=10
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*${_factor})/10
    let _left=10*${_factor}-$_done
# Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:                           
# 1.2.1.1 Progress : [░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░] 100%
printf "\rProgress : [${_fill// /▒}${_empty// /-}] ${_progress}%%\n"
}

# Variables
_start=1

# This accounts as the "totalState" variable for the ProgressBar function
_end=100

# Proof of concept
# for number in $(seq ${_start} ${_end})
# do
#     sleep 0.1
#     ProgressBar ${number} ${_end}
# done

# ProgressBar ${_start} ${_end}

NVIM_DIR=`pwd`

# Go to tools directory
CONFIG=$NVIM_DIR/config
TOOLS=$NVIM_DIR/tools
cd $TOOLS

# Uncompress files
declare -a softwares=("nvim" "clang" "minimap" "ripgrep" "lazygit" "fd" "tmux" "ctags" "python" "node")
for i in "${softwares[@]}"
do
	if [ -d $i* ]
	then
		SW_DIR=`ls | grep $i`
		SW_BIN=$SW_DIR/bin

		echo "Export $i to path: [OK]"
		export PATH="$TOOLS/$SW_DIR:$PATH"
		export PATH="$TOOLS/$SW_BIN:$PATH"
	else
		echo "Export $i to path: [FAILED] ($i does not exist, refer README to install it)"
	fi
done

# ProgressBar 5 ${_end}

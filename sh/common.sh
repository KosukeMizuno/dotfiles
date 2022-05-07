#### common config for both bash/zsh
# shellcheck disable=SC2148

# terminal config
export USE_ICON_IN_TERM=${USE_ICON_IN_TERM:-true}

# detect wsl/mingw/native linux
export IS_WSL=false IS_MINGW=false IS_NATIVE_LINUX=false
proc_version=$(cat /proc/version | awk '{print tolower($0)}')
if [[ "$proc_version" =~ "microsoft" ]]; then
    export IS_WSL=true
elif [[ "$proc_version" =~ "mingw" ]]; then
    export IS_MINGW=true
else
    export IS_NATIVE_LINUX=true
fi

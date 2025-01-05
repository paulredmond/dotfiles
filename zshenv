export XDG_CONFIG_HOME="$HOME/.config"

PATH="/opt/homebrew/bin:$PATH"
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
PATH="$HOME/google-cloud-sdk/bin:$PATH"
PATH="$HOME/Library/Python/3.7/bin:$PATH"
PATH="$HOME/.config/composer/vendor/bin:$PATH"
PATH="$HOME/.composer/vendor/bin:$PATH"
PATH="$HOME/.dotfiles/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="vendor/bin:$PATH"
PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH

. "$HOME/.cargo/env"

# Note: This block of code is React Native stuff I just want to omit from versioning in my dotfiles.
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="$JAVA_HOME/bin:$PATH"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# @see https://stackoverflow.com/a/60063217
export NVM_SYMLINK_CURRENT=true

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Load machine-specific custom environment variables if the file exists
if [ -f "$HOME/.zshenv.local" ]; then
    source "$HOME/.zshenv.local"
fi

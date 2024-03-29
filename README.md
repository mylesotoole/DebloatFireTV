## How it works:

- This script utilizes Homebrew and Android Platform Tools for macOS.
- Dependecies will automatically be checked for. If they are not present, this script will install them.
- ADB debugging needs to be turned on your Amazon TV via developer settings.
- Connects to your Fire TV via the ADB feature in Android Platform Tools.
- Commands are sent to your Fire TV to disable Amazon bloatware and optimize performance.
  
### Running on macOS
1. Install Homebrew with `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Install Android Platform Tools with `brew install android-platform-tools`
3. Make the script executable `chmod +x Debloat-Fire-TV.sh`
4. Run it with `./Debloat-Fire-TV`

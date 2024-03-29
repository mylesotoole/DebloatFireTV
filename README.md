### Running on macOS
1. Make the script executable `chmod +x DebloatFireTV.sh`
2. Run it with `./DebloatFireTV.sh`

<hr>

### How it works:
- Connects to your Fire TV via the ADB feature in Android Platform Tools.
- Commands are sent to your Fire TV to disable Amazon bloatware and optimize performance.

<hr>

### What it uses:
- This script utilizes Homebrew and Android Platform Tools for macOS.
  - These dependecies will automatically be checked. If they are not present, this script will install them with your permission.
- ADB debugging is a devolper setting on your Fire TV and needs to be enabled. 

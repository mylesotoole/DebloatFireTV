## How It Works:

- Your Mac connects to your Fire TV via the ADB (Android Debug Bridge) feature by using [Android Platform Tools](https://developer.android.com/tools/releases/platform-tools).
- Commands are sent to your Fire TV from the script to disable Amazon bloatware and optimize performance.

## What It Uses:

- This script utilizes [Homebrew](https://brew.sh/) and [Android Platform Tools](https://developer.android.com/tools/releases/platform-tools) for macOS.
  - Dependencies are checked automatically. If they are not present, this script will install them.
    - **Permission** is required to install Homebrew.
- ADB debugging must be enabled on your Fire TV, which is a developer setting.

## How to Run It:

1. Open _Terminal_ and navigate to the script's directory.
2. Run the script by typing:
   ```bash
   sh FireTheTV.sh
   ```

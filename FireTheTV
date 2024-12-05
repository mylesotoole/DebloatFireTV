#!/bin/sh
Debloat() {

  # Check if Fire TV is reachable via ADB
  clear
  if adb get-state 1>/dev/null 2>&1; then

    # Notify user about packages being disabled
    clear
    printf "[2] Disabling the following packages:\n\n"

    # List of packages to be disabled
    packages=(
        com.amazon.recess
        com.amazon.ssmsys
        com.amazon.whisperplay.contracts
        com.ivona.orchestrator
        com.amazon.dpcclient
        com.amazon.ceviche
        com.amazon.alta.h2clientservice
        com.amazon.ftv.screensaver
        com.amazon.ods.kindleconnect
        com.android.providers.downloads.ui
        com.amazon.sharingservice.android.client.proxy
        com.amazon.android.marketplace
        com.amazon.tifobserver
        com.amazon.aca
        com.amazon.ale
        com.amazon.dcp
        com.amazon.ssm
        com.amazon.tahoe
        com.amazon.naatyam
        com.amazon.tv.fw.metrics
        com.amazon.device.sale.service
        com.amazon.cardinal
        com.amazon.tv.forcedotaupdater.v2
        amazon.jackson19
        com.android.managedprovisioning
        com.amazon.imdb.tv.android.app
        com.amazon.tmm.tutorial
        com.amazon.dcp.contracts.framework.library
        com.amazon.tv.support
        com.amazon.sync.provider.ipc
        com.amazon.tv.legal.notices
        android.amazon.perm
        com.amazon.kso.blackbird
        com.amazon.providers.contentsupport
        com.amazon.whisperjoin.middleware.np
        com.amazon.application.compatibility.enforcer
        com.amazon.whisperplay.service.install
        com.ivona.tts.oem
        com.amazon.shoptv.client
        com.amazon.communication.discovery
        com.amazon.tv.releasenotes
        com.amazon.hedwig
        com.amazon.application.compatibility.enforcer.sdk.library
        com.android.bluetoothmidiservice
        com.android.dreams.basic
        com.android.wallpaperbackup
        com.amazon.bueller.photos
        com.amazon.vizzini
        com.svox.pico
        com.amazon.bueller.music
        com.amazon.connectivitydiag
        com.amazon.awvflingreceiver
        com.amazon.logan
        com.android.documentsui
        com.amazon.tahoe
        com.amazon.hedwig
        com.amazon.wifilocker
        com.amazon.franktvinput
        com.amazon.alexa.externalmediaplayer.fireos
        com.amazon.tv.alexaalerts
        com.amazon.tv.alexanotifications
        com.amazon.katoch
    )
    
    # Loop through the package list and disable each one
    for package in "${packages[@]}"
    do
        adb shell pm disable-user "$package"
    done

    # Disable window and transition animations
    adb shell settings put global window_animation_scale 0.0
    adb shell settings put global transition_animation_scale 0.0

    # Notify user about packages being disabled
    printf "\n[3] FireTheTV has completed.\n\n"

  else
    # Fire TV is not reachable, prompt the user for a retry
    printf "[Error] Fire TV is not reachable, please confirm:\n\n"
    printf "  - ADB debugging is enabled on the Fire TV\n"
    printf "  - This is the correct IP address of the Fire TV\n\n"
    read -p "Press any key to try again: " -n 1 -s key
    Main
  fi
}

Main() {
  # Check if Homebrew is installed, if not prompt user to install it
  which -s /opt/homebrew/bin/brew
  if [[ $? != 0 ]]; then
    clear
    printf "[Error] Homebrew is not installed, please continue with its installation:\n\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    Main
  else
    # Check if Android platform tools are installed, if not install them
    if /opt/homebrew/bin/brew list | grep "android-platform-tools" >/dev/null 2>&1; then
      # Disconnect any existing ADB connections
      adb disconnect
      clear

      # Prompt user for Fire TV IP address
      printf "╔═════════════════════════╗\n"
      printf "║     Debloat Fire TV     ║\n"
      printf "╚═════════════════════════╝\n\n"

      printf "[1] Enter your Fire TV's IP Address: "
      read tv

      # Check if the provided IP address is online, if so, try to connect
      if ping -c 1 "$tv" >/dev/null 2>&1
      then
        adb connect $tv:5555
        Debloat
      else
        # Error: IP address is unreachable, prompt user for retry
        clear
        printf "[Error] This IP address is not reachable, please confirm that:\n\n"
        printf "  - Both devices are on the same network\n"
        printf "  - The IP address is typed correctly\n\n"
        read -p "Press any key to try again: " -n 1 -s key
        Main
      fi
    else
      # Install Android platform tools and restart the script
      /opt/homebrew/bin/brew install --cask android-platform-tools
      Main
    fi
  fi
}

Main

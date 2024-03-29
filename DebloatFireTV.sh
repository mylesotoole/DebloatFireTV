#!/bin/sh
Debloat() {

  # CHECK IF IT CAN BE REACHED BY ABD
  clear
  if adb get-state 1>/dev/null 2>&1; then

    # NOTIFY CHANGES
    clear
    printf "[2] Disabling the following packages:\n\n"

    # DISABLE PACKAGES
    adb shell pm disable-user com.amazon.recess
    adb shell pm disable-user com.amazon.ssmsys
    adb shell pm disable-user com.amazon.whisperplay.contracts
    adb shell pm disable-user com.ivona.orchestrator
    adb shell pm disable-user com.amazon.dpcclient
    adb shell pm disable-user com.amazon.ceviche
    adb shell pm disable-user com.amazon.alta.h2clientservice
    adb shell pm disable-user com.amazon.ftv.screensaver
    adb shell pm disable-user com.amazon.ods.kindleconnect
    adb shell pm disable-user com.android.providers.downloads.ui
    adb shell pm disable-user com.amazon.sharingservice.android.client.proxy
    adb shell pm disable-user com.amazon.android.marketplace
    adb shell pm disable-user com.amazon.tifobserver
    adb shell pm disable-user com.amazon.aca
    adb shell pm disable-user com.amazon.ale
    adb shell pm disable-user com.amazon.dcp
    adb shell pm disable-user com.amazon.ssm
    adb shell pm disable-user com.amazon.tahoe
    adb shell pm disable-user com.amazon.naatyam
    adb shell pm disable-user com.amazon.tv.fw.metrics
    adb shell pm disable-user com.amazon.device.sale.service
    adb shell pm disable-user com.amazon.cardinal
    adb shell pm disable-user com.amazon.tv.forcedotaupdater.v2
    adb shell pm disable-user amazon.jackson19
    adb shell pm disable-user com.android.managedprovisioning
    adb shell pm disable-user com.amazon.imdb.tv.android.app
    adb shell pm disable-user com.amazon.tmm.tutorial
    adb shell pm disable-user com.amazon.dcp.contracts.framework.library
    adb shell pm disable-user com.amazon.tv.support
    adb shell pm disable-user com.amazon.sync.provider.ipc
    adb shell pm disable-user com.amazon.tv.legal.notices
    adb shell pm disable-user android.amazon.perm
    adb shell pm disable-user com.amazon.kso.blackbird
    adb shell pm disable-user com.amazon.providers.contentsupport
    adb shell pm disable-user com.amazon.whisperjoin.middleware.np
    adb shell pm disable-user com.amazon.application.compatibility.enforcer
    adb shell pm disable-user com.amazon.whisperplay.service.install
    adb shell pm disable-user com.ivona.tts.oem
    adb shell pm disable-user com.amazon.shoptv.client
    adb shell pm disable-user com.amazon.communication.discovery
    adb shell pm disable-user com.amazon.tv.releasenotes
    adb shell pm disable-user com.amazon.hedwig
    adb shell pm disable-user com.amazon.application.compatibility.enforcer.sdk.library

    # DISABLE ANIMATIONS
    adb shell settings put global window_animation_scale 0.0
    adb shell settings put global transition_animation_scale 0.0

    # NOTIFY COMPLETION
    sleep 1
    printf "\n[3] Debloat Completed\n\n"
    sleep 1
    clear

  else
    # IT FAILED, TELL REMEDY AND PROMPT RETRY
    printf "[Error] Fire TV is not reachable, please confirm:\n\n"
    printf "  - ADB debugging is enabled on the Fire TV\n"
    printf "  - This is the IP address of the Fire TV\n\n"
    read -p "Press any key to try again: " -n 1 -s key
    Main
  fi
}

Main() {
  # CHECK IF HOMEBREW IS INSTALLED, IF NOT ASK TO INSTALL IT
  which -s brew
  if [[ $? != 0 ]]; then
    clear
    printf "[Error] Homebrew is not installed, please continue with its installation and then rerun the script:\n\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    Main
  else
    # CHECK IF ANDROID PLATFORM TOOLS IS INSTALLED, IF NOT INSTALL IT
    if brew list | grep "android-platform-tools" >/dev/null 2>&1; then
      # CLEAR CURRENT CONNECTIONS
      adb disconnect
      clear

      # ASK FOR IP

      printf "╔═════════════════════════╗\n"
      printf "║     Debloat Fire TV     ║\n"
      printf "╚═════════════════════════╝\n\n"

      printf "[1] Enter your Fire TV's IP Address: "
      read ip1

      # CHECK IF HOST IS ONLINE, IF SO TRY AND CONNECT
      if
        ping -c 1 "$ip1" >/dev/null 2>&1
      then
        adb connect $ip1:5555
        Debloat
      else
        # IT FAILED, TELL REMEDY AND PROMPT RETRY
        clear
        printf "[Error] This IP address is not reachable, please confirm that:\n\n"
        printf "  - Both devices are on the same network\n"
        printf "  - The IP address is typed correctly\n\n"
        read -p "Press any key to try again: " -n 1 -s key
        Main
      fi
    else
      # INSTALL ANDROID PLATFORM TOOLS, AND RESTART THE SCRIPT
      brew install --cask android-platform-tools
      Main
    fi
  fi
}

Main

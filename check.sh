#!/bin/bash

if !type jtool2 &>/dev/null
then
    echo "[!] jtool2 not found in PATH"
    exit
fi

declare -a entitlements=("com.apple.security.cs.allow-dyld-environment-variables</key><true/>" "com.apple.security.cs.disable-library-validation</key><true/>" "com.apple.security.get-task-allow</key><true/>" "com.apple.security.cs.allow-unsigned-executable-memory</key><true/>" "com.apple.security.files.downloads.read-only</key><true/>" "com.apple.security.files.all</key><true/>" "com.apple.security.files.user-selected.read-only</key><true/>" "com.apple.private.security.clear-library-validation</key><true/>" "com.apple.private.tcc.allow</key><true/>" "kTCCServiceSystemPolicyDocumentsFolder" "kTCCServiceSystemPolicyDownloadsFolder" "kTCCServiceSystemPolicyDesktopFolder" "kTCCServiceSystemPolicyAllFiles")

function entCheck() {
    enti=$(jtool2 --ent "$bin" 2>/dev/null)
    if [[ $enti =~ ${entitlements[0]} ]]
    then
	echo -e "[*] $(echo ${entitlements[0]} | cut -d '<' -f1) found -> Potentially able to inject into: $bin"
    fi

    if [[ $enti =~ ${entitlements[1]} ]]
    then
	echo -e "[*] $(echo ${entitlements[1]} | cut -d '<' -f1) found -> $bin can load arbitrary unsigned plugins/frameworks"
    fi
    
    if [[ $enti =~ ${entitlements[2]} ]]
    then
	echo -e "[*] $(echo ${entitlements[2]} | cut -d '<' -f1) found -> $bin allows other non sandboxed processes to attach"
    fi

    if [[ $enti =~ ${entitlements[3]} ]]
    then
	echo -e "[*] $(echo ${entitlements[3]} | cut -d '<' -f1) found -> $bin allows c code patching"
    fi

    if [[ $enti =~ ${entitlements[4]} ]]
    then
	echo -e "[*] $(echo ${entitlements[4]} | cut -d '<' -f1) found -> $bin may have access to the Downloads folder"
    fi

    if [[ $enti =~ ${entitlements[5]} ]]
    then
	echo -e "[*] $(echo ${entitlements[5]} | cut -d '<' -f1) found -> $bin may have access to all files"
    fi

    if [[ $enti =~ ${entitlements[6]} ]]
    then
	echo -e "[*] $(echo ${entitlements[6]} | cut -d '<' -f1) found -> $bin may have access to files the user has selected in an open or save dialog"
    fi

    if [[ $enti =~ ${entitlements[7]} ]]
    then
	echo -e "[*] $(echo ${entitlements[7]} | cut -d '<' -f1) found -> $bin can load third party plugins signed by non Apple developers"
    fi

    if [[ $enti =~ ${entitlements[8]} ]]
    then
	echo -e "[*] $(echo ${entitlements[8]} | cut -d '<' -f1) found -> $bin may have TCC access to some protected portions of the OS"
    fi

    if [[ $enti =~ ${entitlements[9]} ]]
    then
	echo -e "[*] ${entitlements[9]} found -> $bin may have TCC access to ~/Documents"
    fi

    if [[ $enti =~ ${entitlements[10]} ]]
    then
	echo -e "[*] ${entitlements[10]} found -> $bin may have TCC access to ~/Downloads"
    fi

    if [[ $enti =~ ${entitlements[11]} ]]
    then
	echo -e "[*] ${entitlements[11]} found -> $bin may have TCC access to ~/Desktop"
    fi

    if [[ $enti =~ ${entitlements[12]} ]]
    then
	echo -e "[*] ${entitlements[11]} found -> $bin may have FDA access"
    fi
}

for application in /Applications/*
do
    for bin in "$application/Contents/MacOS/"*
    do
	entCheck
    done
    
done

for util in /System/Applications/Utilities/*
do
    for bin in "$util/Contents/MacOS/"*
    do
	entCheck
    done
done

for bin in "/usr/local/bin/"*
do
    entCheck
done

for bin in "/usr/sbin/"*
do
    entCheck
done

for bin in "/usr/bin/"*
do
    entCheck
done

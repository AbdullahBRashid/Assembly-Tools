# Check for Assembly-Tools directory
if (Test-Path -Path $HOME/Assembly-Tools) {
    Write-Output "Assembly-Tools directory already exists. Skipping..."
} else {
    mkdir $HOME/Assembly-Tools
}

# Download AFD if not already downloaded
if (!(Test-Path -Path $HOME/Assembly-Tools/afd.exe)) {
    Invoke-WebRequest "https://raw.githubusercontent.com/AbdullahBRashid/Assembly-Tools/main/afd.exe" -o $HOME/Assembly-Tools/afd.exe
} else {
    Write-Output "AFD already exists. Skipping..."
}

# Install NASM and DOSBox-X
winget install nasm
if (!($?)) {
    Write-Error "Error installing NASM. Please try again."
    return 
}

winget install dosbox-x
if (!($?)) {
    Write-Error "Error installing DOSBox-X. Please try again."
    return 
}

# Add NASM, DOSBox-X to PATH
$nasm_path = "$HOME/APPDATA/Local/bin/NASM"
if (!(Test-Path -Path $nasm_path)) {
    Write-Error "Error finding NASM path. Please try again. If changed, then change in script."
    return 
}
$dosbox_path = "C:\DOSBox-X"
if (!(Test-Path -Path $dosbox_path)) {
    Write-Error "Error finding DOSBox-X path. Please try again. If changed, then change in script."
    return 
}
setx Path "$env:Path;$nasm_path;$dosbox_path"

# Get afd-run.ps1
if (!(Test-Path -Path $HOME/Assembly-Tools/afd-run.ps1)) {
    Invoke-WebRequest "https://raw.githubusercontent.com/AbdullahBRashid/Assembly-Tools/main/afd-run.ps1" -o $HOME/Assembly-Tools/afd-run.ps1
} else {
    Write-Output "afd-run.ps1 already exists. Skipping..."
}

# Check profile
if (Test-Path -Path $PROFILE) {
    Write-Output "Profile exists. Adding AFD function..."
} else {
    Write-Output "Profile does not exist. Creating profile..."
    New-Item -Path $PROFILE -ItemType File
    if (!($?)) {
        Write-Error "Error creating profile. Please try again."
        return 
    }
}

Add-Content -Path $PROFILE -Value "`r`nImport-Module $HOME/Assembly-Tools/afd-run.ps1"
    if (!($?)) {
        Write-Error "Error adding AFD function to profile. Please try again."
        return
    }

Write-Output "Installation complete. Please restart your terminal."
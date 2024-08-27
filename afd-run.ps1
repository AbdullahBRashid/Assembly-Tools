Function afd ($name) {
    if ($name -eq "" -or $null -eq $name ) {
        return "Please provide a file name."
    }
    if (!(Test-Path -Path $name)) {
        return "File not found."
    }

    # Check if NASM is installed
    nasm --version
    if (!($?)) {
        return "NASM not found. Please run setup script first."
    }

    # Check if DOSBox-X is installed
    dosbox-x --version
    if (!($?)) {
        return "DOSBox-X not found. Please run setup script first."
    }

    # Extract name without extension and extension
    $nameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($name)
    $extension = [System.IO.Path]::GetExtension($name)

    if ($extension -ne ".asm") {
        return "Invalid file extension. Please provide a .asm file."
    }

    nasm $name -o "$nameWithoutExt.com" -l "$nameWithoutExt.lst"
    if (!($?)) {
        return "Error compiling $name."
    }
    
    if (!(Test-Path -Path "$nameWithoutExt.com")) {
        return "Error compiling $name."
    }
    
    if (!(Test-Path -Path $HOME/Assembly-Tools/afd.exe)) {
        return "AFD not found. Please run setup script first."
    }
    
    dosbox-x -nogui -c "set home=$home" -c "mount A '%home%\Assembly-Tools'" -c "mount C ." -c "C:" -c "A:\afd.exe $nameWithoutExt.com"
}
# Contents
- [Easy Install](#easy-installation)
    - [Windows](#windows---easy-installation)

- [Prerequisites](#prerequisites)
- [Usages](#usages)
  - [VS Code - Code Runner](#vs-code---code-runner)
    - [Copy AFD & Compile with NASM & Debug in DosBox](#command-for-copy-afd-compile-using-nasm-and-run-with-afd-in-dosbox)

# Easy Installation
## Windows - Easy Installation
Run in PowerShell:
```ps1
curl "https://raw.githubusercontent.com/AbdullahBRashid/Assembly-Tools/dev/afd-setup.ps1" -o ./afd-setup.ps1
powershell ./afd-setup.ps1
```

# Prerequisites
Download [**AFD**](https://github.com/AbdullahBRashid/Assembly-Tools/blob/main/afd.exe) and copy it to `$HOME` to follow easily.

OR

Run in terminal:
```ps1
curl "https://raw.githubusercontent.com/AbdullahBRashid/Assembly-Tools/main/afd.exe" -o $HOME/afd.exe
```

OR

Run in terminal:
```ps1
# PATH to AFD
# Add the downloaded AFD Path.
set PathName = 
if (PathName != "") {
    copy PathName $HOME
} else {
    echo "Please fix the PathName variable correctly."
}
```


Download [**Netwide Assembler (NASM)**](https://www.nasm.us), and add it to PATH.\
Download [**DosBox**](https://www.dosbox.com), and add it to PATH.

**Note:** As of writing this [**DosBox**](https://www.dosbox.com) SourceForge page is not functioning.\
[Softonic](https://dosbox.en.softonic.com/download) seems to be providing a valid download. Download at your own risk.

Reopen terminal and run:
```ps1
$ nasm --version
```
```ps1
$ dosbox --version
```

If they output a version number, then continue.\
If not then make sure the binaries are installed properly and  added to PATH.


# Usages

## VS Code - Code Runner

### Command for: Copy AFD, Compile using NASM and Run with AFD in DosBox

AFD Binary should be in Home Directory of User. To change: (Replace `copy $HOME/afd.exe` to `copy <path-to-afd>`).

Download [`Code Runner`](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) Extension in VS Code.

Copy the below snippet in `settings.json` file.
```json
{
    ...
    "code-runner.executorMapByFileExtension": {
        ...
        ".asm": "copy $HOME/afd.exe && nasm $fileName -l $fileNameWithoutExt.lst -o $fileNameWithoutExt.com && dosbox -c \"mount C .\" -c \"C:\" -c \"afd $fileNameWithoutExt.com\""
        ...
    }
    ...
}
```

## Windows Shell

Replace \<filename> with name of file.

### Compiling

With list file:

```ps1
nasm <filename>.asm -l <filename>.lst -o <filename>.com
```

Without list file:

```ps1
nasm <filename>.asm -o <filename>.com
```

### Running AFD with DosBox

Ensure **AFD** and the **.com** Binary are in the directory of command execution.

```ps1
dosbox -c "mount C ." -c "C: " -c "afd <filename>.com"
```


## Linux Shell

Replace \<filename> with name of file.

### Compiling

With list file:

```sh
$ nasm <filename>.asm -l <filename>.lst -o <filename>.com
```

Without list file:

```sh
$ nasm <filename>.asm -o <filename>.com
```

### Running AFD with DosBox

Ensure **AFD** and the **.com** Binary are in the directory of command execution.

```sh
$ dosbox -c "mount C ." -c "C: " -c "afd <filename>.com"
```

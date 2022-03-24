# abaqus_shell_utils
Utilities for integrating SIMULIA Abaqus™ to windows context menu (right click menu)

## Introduction
When using SIMULIA Abaqus™, opening models in various places
and importing *.inp* files can be a pain.
This utility package automates these tasks
by adding two useful commands to Microsoft Windows:

  - You can right click on *.inp* files and select *"Import input file in Abaqus"*
    to import them in a new Abaqus CAE window.
  - You can hold the Shift key and right click on a directory's background
    to open a new Abaqus window there.

## Installation
The registry keys and scripts in this package must be introduced to Windows
for them to work. You must have administrative privileges to do so.

First, you need to place the contents of the repository in a folder.
This must be permanent as this path will be added to your PATH environment variable.

Now go inside this folder and run the `add_current_folder_to_path.ps1`
PowerShell script. The script automatically asks for administrative privileges.
It then backups the machine's path variable and appends the current folder to it.

Finally, you need to run the `register_commands.reg` file which merges into
the machine's registery and create's the necessary keys for context menu integration.
This can be undone by running `undo_register_commands.reg`.

The installation process is now complete. Make sure you don't move the directory!

## Using Different Abaqus™ Versions
A machine can have multiple versions of Abaqus™ installed.
They are distinguished by the command used to run them,
for example `abq2021hf4` refers to Abaqus™ 2021.HF4
and `abaqus` refers to the default installation.
These commands correspond to the `.bat` files
usually found in `C:\SIMULIA\Commands`.

By default, the package uses the `abaqus` command
which uses the default abaqus version.
To change this, two edits must be made:

  1. In `import_abaqus_input_file.ps1`,
     the `$abaqus_cmd_name` variable must be changed to the desired command.
     This changes the *Import input file in Abaqus* command.
  2. In `register_commands.reg`,
     the `abaqus` command in line 16 must be changed to the desired command.
     This changes the *Open Abaqus here* command.
     The registry file must be re-run to add the changes to the registry.

## Useful Sources
The following sources were used when developing this package.
They contain useful information about Microsoft Windows Registry
and PowerShell:

  - [Add a batch script to windows right click menu, to run applications with psexec tool](https://superuser.com/questions/808161)
  - [Which special variables are available when writing a shell command for a context menu](https://superuser.com/questions/136838)
  - [Add a Windows Shell context menu entry for a specific extension (not file type)](https://stackoverflow.com/questions/21362892)
  = [Gaining administrator privileges in PowerShell](https://serverfault.com/a/1058407)
  - The Complete Guide to PowerShell Punctuation](https://www.red-gate.com/simple-talk/sysadmin/powershell/the-complete-guide-to-powershell-punctuation/) by Michael Sorens

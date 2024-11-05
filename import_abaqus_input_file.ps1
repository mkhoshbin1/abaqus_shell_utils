# Import an Abaqus import file using a powershell script
# that open abaqus with a python script.
#
# See the command below for credits.

Write-Host @"
 +-------------------------------------------------------------------------------+
 | abaqus_shell_utils v.1.1.0                                                    |
 |                                                                               |
 | This utility imports a SIMULIA Abaqus (TM) input file.                        |
 | Abaqus must already be installed and the abaqus command must be recognizable. |
 |                                                                               |
 | Github Repo: https://github.com/mkhoshbin1/abaqus_shell_utils                 |
 | Website:     https://www.mkhoshbin.com                                        |
 | License:     The MIT License                                                  |
 |                                                                               |
 | Copyright 2022-2024 Mohammadreza Khoshbin.                                    |
 +-------------------------------------------------------------------------------+

"@

# Change this if you use a different command for SIMULIA Abaqus (TM).
# For example, abq2021hf4 refers to Abaqus 2021.HF4.
# Check C:\SIMULIA\Commands for available commands.
$abaqus_cmd_name = 'abaqus'

# Make sure $abaqus_name exists.
if (Get-Command $abaqus_cmd_name -errorAction SilentlyContinue){}
else{throw "The command '$abaqus_cmd_name' is not defined. Check C:\SIMULIA\Commands for available commands."}

# Check the file extension.
$extension = (Get-Item "$args" -ErrorAction Stop).Extension
if ($extension -ne '.inp' ) {throw "Expected '.inp' file, but received '$extension' file."}

# Open abaqus and run the accompanying script to import the input file.
$script_path = Join-Path -Path $PSScriptRoot -ChildPath 'import_abaqus_input_file.py'
& $abaqus_cmd_name cae noStartupDialog script=$script_path -- "$args"

# End the interactive session.
Write-Host "Abaqus was closed. Exiting PowerShell..."
[Environment]::Exit(0)
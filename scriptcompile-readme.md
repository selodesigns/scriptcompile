# ScriptCompile Command

A Windows utility that compiles script files from a directory into a single, well-organized text document.

## Overview

The `scriptcompile` command scans a directory (and its subdirectories) for script files and compiles their contents into a single text document. Each file is clearly separated with headers showing the filename, path, size, and last modified date.

## Installation

1. Download the `install_scriptcompile.bat` script
2. Right-click the script and select "Run as administrator"
3. The installation script will:
   - Create a `Scripts` folder in your user profile directory (if it doesn't exist)
   - Set up the `scriptcompile.bat` command file
   - Add the Scripts folder to your PATH environment variable (if not already there)

4. Restart any open command prompts for the changes to take effect

## Usage

### Basic Usage

```
scriptcompile
```
Compiles all script files from the current directory and saves to `script_compilation.txt`

### Specify a Directory

```
scriptcompile C:\path\to\directory
```
Compiles scripts from the specified directory

### Specify Output File

```
scriptcompile C:\path\to\directory C:\path\to\output.txt
```
Compiles scripts and saves to the specified output file

### Specify File Types

```
scriptcompile C:\path\to\directory output.txt "*.js *.py *.html"
```
Compiles only JavaScript, Python, and HTML files

## Default File Types

The command searches for the following file types by default:
```
*.bat *.cmd *.ps1 *.vbs *.js *.py *.sh *.pl *.php *.rb *.sql *.cs *.java *.cpp *.c *.h *.hpp
```

## Output Format

The compiled document has the following structure:

```
Script Compilation created on [DATE] at [TIME]
Source directory: [DIRECTORY]
=================================================================

-----------------------------------------------------------------
FILE: example.js
PATH: C:\path\to\
SIZE: 1234 bytes
LAST MODIFIED: 03/30/2025 14:32:45
-----------------------------------------------------------------

[FILE CONTENTS]


-----------------------------------------------------------------
FILE: another_script.py
PATH: C:\path\to\subdirectory\
SIZE: 5678 bytes
LAST MODIFIED: 03/28/2025 09:15:30
-----------------------------------------------------------------

[FILE CONTENTS]

...
```

## Use Cases

- Create a backup of all your scripts in a single document
- Share code with others without needing to send multiple files
- Create documentation of your project's scripts
- Review all scripts in a project without switching between files
- Search for specific code patterns across multiple files

## Companion Tools

This tool works well alongside the `dirtree` command, which creates a visual representation of your directory structure.

## Troubleshooting

If the `scriptcompile` command is not recognized after installation:

1. Make sure you've restarted your command prompt
2. Verify that the Scripts directory was added to your PATH by running:
   ```
   echo %PATH%
   ```
3. If it's missing, manually add `%USERPROFILE%\Scripts` to your PATH environment variable

## Uninstallation

To uninstall the command:

1. Delete the file: `%USERPROFILE%\Scripts\scriptcompile.bat`
2. Optionally, remove the Scripts folder from your PATH environment variable:
   - Open System Properties > Advanced > Environment Variables
   - Edit the PATH variable and remove the entry for `%USERPROFILE%\Scripts`

## License

This script is provided as-is under the MIT License. Feel free to modify and distribute as needed.

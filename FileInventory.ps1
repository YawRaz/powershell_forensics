<#
.SYNOPSIS
A powershell script that creates an inventory of a computer with all the directories and files.

- User specifies the target computer
- User specifies the starting directory
- User specifies the output file


.DESCRIPTION
The script collects an inventory of a computer detailing all directories and files.

.PARAMETER targetComputer
Specifies the computer to create the inventory from

.PARAMETER UserName
Specifies the administrative username on the target computer

.PARAMETER startDirectory
Specifies the ditecrory to start the traversal from

.PARAMETER outFile
Specifies the file to write the results to.


.EXAMPLE 
FileInventory ComputerName
#>

# Parameter Definition Section
param (
	[string]$UserName
	[string]$targetComputer
	[string]$outFile

# local variable definition
# Get the current data and time
$rptDate=Get-Date
$epoch=([DateTimeOffset]$rptDate).ToUnixTimeSeconds()

# report file creation

# cmdLet Command Line execution
Invoke-Command -ComputerName $targetComputer -Credential $UserName -ScriptBlock { Get-ChildItem -Path $startDirectory -Recurse -Force }
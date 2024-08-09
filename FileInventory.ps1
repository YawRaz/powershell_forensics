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

.PARAMETER reportTitle
Specifies the HTML report title

.EXAMPLE 
FileInventory ComputerName

.EXAMPLE FileInventory -reportTitle "Computer Local Files Report"
#>

# Parameter Definition Section
param (
	[string]$UserName
	[string]$targetComputer
	[string]$outFile
	[string]$reportTitle

# local variable definition
# Get the current data and time
$rptDate=Get-Date
$epoch=([DateTimeOffset]$rptDate).ToUnixTimeSeconds()

# create HTML section with header
$Header = @"

<style>
TABLE {
	border-width: 1px;
	border-style: solid;
	border-color: black;
	border-collapse: Collapse;
      }
TD {
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: black;
   }
</style>
<p><b>$reportTitle $rptDate <P>
File Section: <b>$targetDirectory</b><p>
Target Computer: <b>$targetComputer </b>
<p>
"@

# report file creation
$ReportFile = ".\Report-"+$epoch+".HTML"

# cmdLet Command Line execution
Invoke-Command -ComputerName $targetComputer -Credential $UserName -ScriptBlock { Get-ChildItem -Path $startDirectory -Recurse -Force } | ConvertTo-HTML -Head $Header -Property TimeGenerated Message | outFile $ReportFile                 
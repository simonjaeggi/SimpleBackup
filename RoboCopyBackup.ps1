<#
.SYNOPSIS
  Simple backup script based on robocopy
.DESCRIPTION
  Simple powershell robocopy script, that copies some source folders to a specified destination. The script creates a new folder for every backup it does. Can be a simple backup solution with a NAS (or similar external storage solutions) and windows task schedular.
.INPUTS
  none
.OUTPUTS
  Logfiles are stored in backup destination folder.
.NOTES
  Version:        0.1
  Author:         Simon Jäggi
  Creation Date:  24.02.2020
  Purpose/Change: Initial script development
  
.EXAMPLE
  Define sources in var $sources. Define destination in var $destination.
#>


$sources = "C:\Users\test\example1", "C:\Users\test\Documents\example2", "C:\Scripts"
$destination = "\\192.168.1.10\backup\"
$date = get-date -format "yyyyMMdd_hhmm"


$rootfolder = $destination+$date + "\"
$subfolder = $null

$logfile = $rootfolder + "CopyJobLog.txt"


#copy each source to destination
foreach ($source in $sources) {
    $folderobject = get-item $source
    $foldername = $folderobject.name
    $subfolder = $rootfolder + $foldername
    mkdir -Force $subfolder
    Robocopy $source $subfolder /e /TEE /R:2 /W:5 /LOG:$logfile 

}
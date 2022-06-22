$SNMP = new-object -ComObject olePrn.OleSNMP
$snmp.open("10.10.20.173","public",2,3000)

$blacktonervolume = $snmp.get("43.11.1.1.8.1.1")
$blackcurrentvolume = $snmp.get("43.11.1.1.9.1.1")
[int]$blackpercentremaining = ($blackcurrentvolume / $blacktonervolume) * 100 

$cyantonervolume = $snmp.get("43.11.1.1.8.1.2")
$cyancurrentvolume = $snmp.get("43.11.1.1.9.1.2")
[int]$cyanpercentremaining = ($cyancurrentvolume / $cyantonervolume) * 100

$magentatonervolume = $snmp.get("43.11.1.1.8.1.3")
$magentacurrentvolume = $snmp.get("43.11.1.1.9.1.3")
[int]$magentapercentremaining = ($magentacurrentvolume / $magentatonervolume) * 100

$yellowtonervolume = $snmp.get("43.11.1.1.8.1.4")
$yellowcurrentvolume = $snmp.get("43.11.1.1.9.1.4")
[int]$yellowpercentremaining = ($yellowcurrentvolume / $yellowtonervolume) * 100

Write-Output "Black $blackpercentremaining"
Write-Output "Cyan $cyanpercentremaining"
Write-Output "Magenta $magentapercentremaining"
Write-Output "Yellow $yellowpercentremaining"

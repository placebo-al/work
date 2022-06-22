$printerlist = import-csv C:\Users\watsona\Desktop\Book1.csv -header Value,Name,Description
$outfile = "c:\Users\watsona\Desktop\Printers.html"
$SNMP = new-object -ComObject olePrn.OleSNMP
$total = ($printerlist.value|Where-Object {$_ -notlike "-*"}).length

Write-Output @"
<html>
<head>
<title>Printer Report</title>
<style>* {font-family:'Trebuchet MS';}</style>
</head>
<body> 
"@ |out-file $outfile

Write-Output "Reporting on $total printers"

$x = 0
foreach ($p in $printerlist){

    if ($p.value -like "-*"){
        Write-Output "<h3>",$p.value.replace('-',''),"</h3>"|add-content $outfile
        }

    if ($p.value -notlike "-*"){

        $x = $x + 1
        $printertype = $nul
        $status = $nul
        $percentremaining = $nul
        $blackpercentremaining = $nul
        $cyanpercentremaining = $nul
        $magentapercentremaining = $nul
        $yellowpercentremaining = $nul
        $wastepercentremaining = $nul

        if (!(test-connection $p.Value -Quiet -count 1)){
            Write-Output ($p.value + " is offline<br>") | add-content $outfile
            }
        if (test-connection $p.value -quiet -count 1){
            $snmp.open($p.value,"public",2,3000)
            $printertype = $snmp.Get(".1.3.6.1.2.1.25.3.2.1.3.1")
            Write-Output ([string]$x + ": " + [string]$p.Value + " " + $printertype)
        }

        $tonervolume = $snmp.get("43.11.1.1.8.1.1")
        $currentvolume = $snmp.get("43.11.1.1.9.1.1")
        [int]$percentremaining = 100 - (($currentvolume / $tonervolume) * 100) 

        $statustree = $snmp.gettree("43.18.1.1.8")
        $status = $statustree|Where-Object {$_ -notlike "print*"} #status, including low ink warnings
        $status = $status|Where-Object {$_ -notlike "*bypass*"}
        $name = $snmp.get(".1.3.6.1.2.1.1.5.0")
        if ($name -notlike "PX*"){$name = $p.name}

        Write-Output ("<b>" + $p.description + "</b><a style='text-decoration:none;font-weight:bold;' href=http://" + $p.value + " target='_new'> " + $name + "</a> <br>" + $printertype + "<br>") |add-content $outfile
        if ($percentremaining -gt 49){Write-Output "<b style='font-size:110%;color:green;'>",$percentremaining,"</b>% black toner<br>" |add-content $outfile}
        if (($percentremaining -gt 24) -and ($percentremaining -le 49)){Write-Output "<b style='font-size:110%;color:#40BB30;'>",$percentremaining,"</b>% black toner<br>" |add-content $outfile}
        if (($percentremaining -gt 10) -and ($percentremaining -le 24)){Write-Output "<b style='font-size:110%;color:orange;'>",$percentremaining,"</b>% black toner<br>" |add-content $outfile}
        if (($percentremaining -ge 0) -and ($percentremaining -le 10)){Write-Output "<b style='font-size:110%;color:red;'>",$percentremaining,"</b>% black toner<br>" |add-content $outfile}
        if ($status.length -gt 0){Write-Output ($status + "<br><br>") |add-content $outfile}else{Write-Output "Operational<br><br>" |add-content $outfile}
    }
}


Write-Output "</body></html>" | add-content $outfile

$outfile
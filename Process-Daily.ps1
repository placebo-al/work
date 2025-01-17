$FilePath = 'C:\Users\Alan Watson\Downloads\Failed checks - AUS DB-data-2024-12-23 11_04_58.csv'

    $data = Import-Csv -Path $FilePath
    $filteredData = $data | Sort-Object Script | ForEach-Object {
        # Create a new custom object
        [PSCustomObject]@{
            Company = $_.Company
            Page = "https://$($_.Company).perfectgym.com.au/Pgm/#/Settings/PowerTools/Category/Actions"
            Script = $_.Script
            DB = "PerfectGym_$($_.Company)_Production"
        }
    }

$filteredData | Format-Table -AutoSize

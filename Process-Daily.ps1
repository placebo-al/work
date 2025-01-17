# Load the System.Windows.Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create an OpenFileDialog object
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog

# Set properties for the dialog
$openFileDialog.InitialDirectory = [Environment]::GetFolderPath('MyDocuments')
$openFileDialog.Filter = "CSV files (*.csv)|*.csv|All files (*.*)|*.*"

# Show the dialog and get the file path
[void]$openFileDialog.ShowDialog()
$filePath = $openFileDialog.FileName

# Proceed if a file was selected
if ($filePath) {
    $data = Import-Csv -Path $filePath

    $filteredData = $data | Sort-Object Script | ForEach-Object {
        # Create a new custom object
        [PSCustomObject]@{
            Company = $_.Company
            Page = "=HYPERLINK(`"https://$($_.Company).perfectgym.com.au/Pgm/#/Settings/PowerTools/Category/Actions`", `"$($_.Company)`")"
            Script = $_.Script
            DB = "PerfectGym_$($_.Company)_Production"
        }
    }

    # Get the directory of the input file
    $inputDirectory = Split-Path -Path $filePath

    # Define the export file path
    $exportFilePath = Join-Path -Path $inputDirectory -ChildPath "processed_data.csv"

    $filteredData | Export-Csv -Path $exportFilePath -NoTypeInformation
}
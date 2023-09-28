<# 
.SYNOPSIS 
    Import folders and projects from local file system to SSIS catalog. 
.DESCRIPTION 
    Import SSIS projects from $ProjectFilePath. The folders under $ProjectFilePath
    will be imported as folders in the SSIS catalog, with all ispac files under that
    folder imported accordingly. 
    
    The script will connect to the local SQL Server instance. It will first
    drop the SSISDB catalog if exists and create a new catalog with a fixed secret. 
.EXAMPLE 
    .\CatalogImport 
#> 



# Variables
$ProjectFilePath = "C:\SSIS"
$Root = "\\RPCDEV01.rpc.local\C$"

New-PSDrive -Name "Q" -PSProvider FileSystem -Root $Root -Persist 
Copy-Item -Path Q:\SSIS -Destination "C:\SSIS" -recurse

# Load the IntegrationServices Assembly
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Management.IntegrationServices") | Out-Null;

# Store the IntegrationServices Assembly namespace to avoid typing it every time
$ISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"

Write-Host "Connecting to server ..."

# Create a connection to the server
$sqlConnectionString = "Data Source=localhost;Initial Catalog=master;Integrated Security=SSPI;"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString

# Create the Integration Services object
$integrationServices = New-Object $ISNamespace".IntegrationServices" $sqlConnection

Write-Host "Removing previous catalog ..."

# Drop the existing catalog if it exists
if ($integrationServices.Catalogs.Count -gt 0) { $integrationServices.Catalogs["SSISDB"].Drop() }

Write-Host "Creating new SSISDB Catalog ..."

# Provision a new SSIS Catalog
$catalog = New-Object $ISNamespace".Catalog" ($integrationServices, "SSISDB", "SUPER#secret1")
$catalog.Create()

write-host "Enumerating all folders..."

$folders = ls -Path $ProjectFilePath -Directory

if ($folders.Count -gt 0)
{
    foreach ($filefolder in $folders)
    {
        Write-Host "Creating Folder " $filefolder.Name " ..."

        # Create a new folder
        $folder = New-Object $ISNamespace".CatalogFolder" ($catalog, $filefolder.Name, "Folder description")
        $folder.Create()

        $projects = ls -Path $filefolder.FullName -File -Filter *.ispac
        if ($projects.Count -gt 0)
        {
            foreach($projectfile in $projects)
            {
                $projectfilename = $projectfile.Name.Replace(".ispac", "")
                Write-Host "Deploying " $projectfilename " project ..."

                # Read the project file, and deploy it to the folder
                [byte[]] $projectFileContent = [System.IO.File]::ReadAllBytes($projectfile.FullName)
                $folder.DeployProject($projectfilename, $projectFileContent)
            }
        }
    }
}

Write-Host "All done."
#!/usr/bin/pwsh

param([string] $environments_variables_file)

<# contents of environment_variables.sh
export DataSource=databaseserver.com
export InitialCatalog=DataBase
export IntegratedSecurity=False
export ConnectionTimeout=1000
export User=db_user
export Password=db_password
#>

$environment_variables_batchlines = Get-Content -Path $environments_variables_file |
    Where-Object {$_ -like "export*"} |
    Select-Object @{ 
        Name = "batchline"; 
        Expression = { 
            $envvars = $_.
                ToString().
                Replace("export ","").
                Split("=")
            $("setx -m " + $_.ToString().Replace("export ","").Split("=")[0] + " " + $envvars[1])
        }
    }

$environment_variables_batchlines | 
    Select -Expand batchline | 
    Out-File -FilePath 'environment_variables.bat'

<# resulting environment_variables.bat file
setx -m DataSource databaseserver.com
setx -m InitialCatalog DataBase
setx -m IntegratedSecurity False
setx -m ConnectionTimeout 1000
setx -m User db_user
setx -m Password db_password
#>
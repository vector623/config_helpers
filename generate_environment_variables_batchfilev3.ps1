#!/usr/bin/pwsh

param([string] $environments_variables_file)

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
#!/usr/bin/pwsh

param([string] $environments_variables_file)

$environment_variable_lines = Get-Content -Path $environments_variables_file
$environment_variables_filtered = $environment_variable_lines | 
    Where-Object {$_ -like "export*"}
$environment_variables_projected = $environment_variables_filtered | 
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
$environment_variables_projected | Select -Expand batchline | Out-File -FilePath 'environment_variables.bat'
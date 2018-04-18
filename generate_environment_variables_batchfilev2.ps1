#!/usr/bin/pwsh

param([string] $environments_variables_file)

$environment_variable_lines = Get-Content -Path $environments_variables_file
$environment_variables_filtered = $environment_variable_lines | 
    Where-Object {$_ -like "export*"}
$environment_variables_casted = $environment_variables_filtered | 
    Select-Object {
        $envvars = $_.
            ToString().
            Replace("export ","").
            Split("=")
        return $("setx -m " + $envvars[0] + " " + $envvars[1])
    }

$environment_variables_casted | Out-File 'environment_variables.bat'
#!/usr/bin/pwsh

param([string] $environments_variables_file)

$environment_variable_lines = Get-Content -Path $environments_variables_file
$environment_variables_filtered = [Linq.Enumerable]::Where($environment_variable_lines, [Func[object,bool]] { 
    param($line);
    return !$line.ToString().Equals("")
})
$environment_variables_casted = [Linq.Enumerable]::Select($environment_variables_filtered, [Func[object,string]] { 
    param($line)
    $envvars = $line.
        ToString().
        Replace("export ","").
        Split("=")
    return $("setx -m " + $envvars[0] + " " + $envvars[1])
})
$environment_variables_casted | Out-File 'environment_variables.bat'
#!/usr/bin/pwsh

param([string] $environments_variables_file,
      [string] $systemd_template_file)

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
    return $("Environment=" + $envvars[0] + "=" + $envvars[1])
})
$environment_variables_text = $environment_variables_casted | Out-String

$systemd_template_text = Get-Content -Path $systemd_template_file
$systemd_template_final = $systemd_template_text.Replace("ENVIRONMENT_VARIABLES",$environment_variables_text)

$systemd_template_final | Out-File 'systemd.service'
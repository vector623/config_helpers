#!/usr/bin/pwsh

param([string] $envvar_infile,
      [string] $envvar_outscript)

$environment_variables_batchlines = Get-Content -Path $envvar_infile |
    Where-Object {$_ -notlike "#*"} |
    Select-Object @{ 
        Name = "batchline"; 
        Expression = { 
            $envvarname = $_.
                ToString().
                Split("=")[0]
            $envvarvalue = $_.Replace($envvarname + "=","")

            #$("export " + $envvars[0] + "=""" + $envvars[1] + """")
            $("export " + $envvarname + "=""" + $envvarvalue + """")
        }
    }

$environment_variables_batchlines | 
    Select-Object -Expand batchline | 
    Out-File -FilePath $envvar_outscript


function Set-PAIgnoreSSLSetting {
    <#
    .SYNOPSIS
    Sets the module-wide setting for ignoring invalid SSL certificates on firewalls.
    .DESCRIPTION
    Sets the module-wide setting for ignoring invalid SSL certificates on firewalls.
    .LINK
    https://github.com/zloeber/pspaloalto
    .EXAMPLE
    PS> Set-PAIgnoreSSLSetting -Value:$true
    .NOTES
    Author: Zachary Loeber
    #>

    [CmdletBinding()]
    param(
        [Parameter( Mandatory=$true )]
        [bool]$Value
    )
    begin {
        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
    }
    process {
    }
    end {
        $script:_IgnoreSSL = $Value
        Write-Verbose "$($FunctionName): End."
    }
}

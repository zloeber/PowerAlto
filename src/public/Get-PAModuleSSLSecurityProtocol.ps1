function Get-PAModuleSSLSecurityProtocol {
    <#
    .SYNOPSIS
    Gets the encryption level used for web requests to the API.
    .DESCRIPTION
    Gets the encryption level used for web requests to the API.
    .LINK
    https://github.com/zloeber/pspaloalto
    .EXAMPLE
    Get-PAModuleSSLSecurityProtocol
    .NOTES
    Author: Zachary Loeber
    #>

    [CmdletBinding()]
    param(
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
        [Net.ServicePointManager]::SecurityProtocol
        Write-Verbose "$($FunctionName): End."
    }
}
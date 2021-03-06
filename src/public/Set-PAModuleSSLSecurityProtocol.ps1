function Set-PAModuleSSLSecurityProtocol {
    <#
    .SYNOPSIS
    Sets the encryption level used for web requests to the API.
    .DESCRIPTION
    Sets the encryption level used for web requests to the API.
    .LINK
    https://github.com/zloeber/pspaloalto
    .EXAMPLE
    TBD
    .NOTES
    Author: Zachary Loeber
    #>

    [CmdletBinding()]
    param(
        [Parameter()]
        [Net.SecurityProtocolType]$SSLEncryption
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
        [Net.ServicePointManager]::SecurityProtocol = $SSLEncryption
        Write-Verbose "$($FunctionName): End."
    }
}

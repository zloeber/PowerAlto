function Set-PANATRule {
    <#
    .SYNOPSIS
    Sets a NAT Rule properties.
    .DESCRIPTION
    Sets a NAT Rule properties.
    .PARAMETER Name
    Name of the NAT rule to update.
    .PARAMETER AADB
    active-active-device-binding
    .PARAMETER Description
    description
    .PARAMETER Destination
    destination
    .PARAMETER DestinationTranslation
    destination-translation
    .PARAMETER Disabled
    disabled
    .PARAMETER From
    from
    .PARAMETER NATType
    nat-type
    .PARAMETER Service
    service
    .PARAMETER Source
    source
    .PARAMETER SourceTranslation
    source-translation
    .PARAMETER Tag
    tag
    .PARAMETER To
    to
    .PARAMETER ToInterface
    to-interface
    .PARAMETER PaConnection
    Specificies the Palo Alto connection string with address and apikey. If ommitted, current connections will be used
    .PARAMETER Target
    Configuration to target, either vsys1 (default) or panorama
    .LINK
    https://github.com/zloeber/pspaloalto
    .EXAMPLE
    TBD
    .NOTES
    Author: Zachary Loeber
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]
        [ValidateLength(1, 31)]
        [string]$Name,
        [Parameter()]
        [PSObject]$PaConnection,
        [Parameter()]
        [ValidateSet('vsys1', 'panorama')]
        [string]$Target = 'vsys1',
        [Parameter()]
        [ValidateSet("1", "0", "both", "primary")]
        [string]$AADB,
        [Parameter()]
        [ValidateLength(0, 255)]
        [string]$Description,
        [Parameter()]
        [ValidateLength(0, 255)]
        [string]$Destination,
        [Parameter()]
        [ValidateSet('translated-address', 'translated-port')]
        [string]$DestinationTranslation,
        [Parameter()]
        [ValidateSet('no','yes')]
        [string]$Disabled

    )
    begin {
        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."

        $WebClient = New-Object System.Net.WebClient
        [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

        $Name = $Name.replace(' ','%20')

        function EditProperty ($parameter, $element, $xpath) {
            if ($parameter) {
                if ($parameter -eq "none") {
                    $action = "delete"
                }
                else {
                    $action = "edit"
                }
                $Response = Send-PaApiQuery -Config $action -XPath $xpath -Element $element -Member $parameter
                if ($Response.response.status -eq "success") {
                    return "$element`: success"
                }
                else {
                    throw $Response.response.msg.line
                }
            }
        }
        function Process-Query ( [String]$PaConnectionString ) {
            $xpath = "/config/devices/entry/vsys/entry/[@name='$Target']/rulebase/nat/rules/entry[@name='$Name']"

            if ($Rename) {
                $Response = Send-PaApiQuery -Config rename -XPath $xpath -NewName $Rename -PaConnection $PaConnectionString
                if ($Response.response.status -eq "success") {
                    return "Rename success"
                }
                else {
                    throw $Response.response.msg.line
                }
            }

            EditProperty $AADB 'active-active-device-binding' $xpath
            EditProperty $Description 'description' $xpath
            EditProperty $Destination 'destination' $xpath
            EditProperty $DestinationTranslation 'destination-translation' $xpath
            EditProperty $Disabled 'disabled' $xpath
            EditProperty $From 'from' $xpath
            EditProperty $NATType 'nat-type' $xpath
            EditProperty $Service 'service' $xpath
            EditProperty $Source 'source' $xpath
            EditProperty $SourceTranslation 'source-translation' $xpath
            EditProperty $Tag 'tag' $xpath
            EditProperty $To 'to' $xpath
            EditProperty $ToInterface 'to-interface' $xpath

           <# EditProperty $Description "description" $xpath
            EditProperty $SourceNegate "negate-source" $xpath
            EditProperty $DestinationNegate "negate-destination" $xpath
            EditProperty $Action "action" $xpath
            EditProperty $LogStart "log-start" $xpath
            EditProperty $LogEnd "log-end" $xpath
            EditProperty $LogForward "log-setting" $xpath
            EditProperty $Schedule "schedule" $xpath
            EditProperty $Disabled "disabled" $xpath
            EditProperty $QosDscp "ip-dscp" "$xpath/qos/marking"
            EditProperty $QosPrecedence "ip-precedence" "$xpath/qos/marking"
            EditProperty $DisableSri "disable-server-response-inspection" "$xpath/option"
            EditProperty $SourceAddress "source" $xpath
            EditProperty $SourceZone "from" $xpath
            EditProperty $Tag "tag" $xpath
            EditProperty $SourceUser "source-user" $xpath
            EditProperty $HipProfile "hip-profiles" $xpath
            EditProperty $DestinationZone "to" $xpath
            EditProperty $DestinationAddress "destination" $xpath
            EditProperty $Application "application" $xpath
            EditProperty $Service "service" $xpath
            EditProperty $UrlCategory "category" $xpath
            EditProperty $HipProfile "hip-profiles" $xpath
            EditProperty $ProfileGroup "group" "$xpath/profile-setting"
            EditProperty $ProfileVirus "virus" "$xpath/profile-setting/profiles"
            EditProperty $ProfileVuln "vulnerability" "$xpath/profile-setting/profiles"
            EditProperty $ProfileSpy "spyware" "$xpath/profile-setting/profiles"
            EditProperty $ProfileUrl "url-filtering" "$xpath/profile-setting/profiles"
            EditProperty $ProfileFile "file-blocking" "$xpath/profile-setting/profiles"
            EditProperty $ProfileData "data-filtering" "$xpath/profile-setting/profiles"
            #>
        }
    }
    process {
    }
    end {
        Write-Verbose "$($FunctionName): End."
    }
}

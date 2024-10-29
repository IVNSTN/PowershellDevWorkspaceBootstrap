
function Write-VerboseParam {
    <#
    .SYNOPSIS
        Writes function call details to the Verbose channel
        including function name and all the argument values

    .PARAMETER invocation
        Object containing function call details. Should be taken from
        local system variable $MyInvocation

    .EXAMPLE
        Write-VerboseParam -invocation $MyInvocation
    #>
    [CmdletBinding()]
    [OutputType()]
    param (
        [Parameter(Mandatory)]
        [System.Management.Automation.InvocationInfo]
        $invocation
    )

    process {
        [string]$funcName = $invocation.MyCommand.Name
        [hashtable]$funcParams = (Get-Command -Name $invocation.InvocationName).Parameters

        Write-Verbose "Function $funcName called with arguments`:"
        $funcParams.keys | % {
            $param = Get-Variable -Name $_ -ErrorAction SilentlyContinue
            if ($param) {
                Write-Verbose "`t$($param.Name) = $($param.Value)"
            }
        }
    }
}


function Explode-String {
    <#
    .SYNOPSIS
        Splits string into unique pieces with given delimiters.
        Empty items don't get into result, string parts will not contain leaging
        or trailing spaces.

    .EXAMPLE
        Explode-String "foo;bar  ;  far;;,"
        ------
        Description

        This will return an array of strings: @('foo', 'bar', 'far')
    #>
    [CmdletBinding()]
    [OutputType([string[]])]
    param (
        [Parameter(Position = 0)]
        [string]
        $value,

        [Parameter(Position = 1)]
        [string[]]
        $delimiters = @(';', ',')
    )

    process {
        $value.Split($delimiters, [StringSplitOptions]::RemoveEmptyEntries) | % { $_.Trim() } | ? { $_ } | Sort-Object -Unique
    }
}

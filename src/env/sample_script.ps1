﻿<#
.SYNOPSIS
    This is a posh-script sample generated by provided snippet.
    It produces json-file with greetings to given names.

.PARAMETER name
    Single name or a list of names separated by ';' or ','

.PARAMETER greeting
    Formatting template for a greeting message, e.g. 'Hi {0}!'

.PARAMETER outputFile
    Path to output file where generated greetings should be saved in JSON format.
    If omitted, results will be printed out to Verbose channel.

.EXAMPLE
    ./sample_script.ps1 -name 'Sensei Lee;Jake Green;Samir!!' -greeting 'Good evening, {0}!' -verbose -outputFile ./out.json

    Description
    -----------
    Example of generating JSON-file with greetings to 3 persons.

.NOTES
Version:        1.0
Author:         ivan.v.starostin@gmail.com
Creation Date:  2024-10-29
Original name:  sample_script.ps1
#>
#Requires -Version 5.1
[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $name,

    [Parameter(Mandatory)]
    [string]
    $greeting,

    [Parameter()]
    [string]
    $outputFile
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = 'Stop'
$PSDefaultParameterValues = @{ '*:Encoding' = 'utf8' }
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8


function Main {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $name,

        [Parameter(Mandatory)]
        [string]
        $greeting,

        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]
        $outputFile
    )

    begin {
        . "$PSScriptRoot/../../src/env/common_utils_lib.ps1"

        Write-VerboseParam -invocation $MyInvocation

        $result = @{}

        if ($outputFile -and -not (Test-Path (Split-Path $outputFile -Parent) -PathType Container)) {
            Write-Verbose "Creating folder for $outputFile ..."
            New-Item (Split-Path $outputFile -Parent) -ItemType Directory -Force | Out-Null
        }
    }

    process {
        @(Explode-String $name) | % {
            $result[$_] = $greeting -f $_
        }
    }

    end {
        if ($outputFile) {
            Write-Verbose "Saving to $outputFile ..."
            $result | ConvertTo-Json -Depth 5 -Compress | Out-File $outputFile -Encoding utf8 -Force
        }
        elseif ($VerbosePreference -ne 'SilentlyContinue') {
            Write-Verbose 'Here is the result:'
            $result | Format-Table | Out-String | Write-Verbose
        }
    }

}

Main `
    -name $name `
    -greeting $greeting `
    -outputFile $outputFile

<#
.SYNOPSIS
    Pester test runner

.PARAMETER repositoryPath
    Path to the posh-repository folder with both sources and tests on Pester

.PARAMETER outputFolder
    Path to the folder where testing results should be saved.
    It will be created if it did not exist.

.PARAMETER testResults
    File name for test results output file

.PARAMETER coverageResults
    File name for coverage results output file

.EXAMPLE
    ./run_posh_tests.ps1 -repositoryPath ../../ -outputFolder ../../TestResults

    Description
    -----------
    Run me

.NOTES
Version:        1.0
Author:         ivan.v.starostin@gmail.com
Creation Date:  2024-10-30
Original name:  run_posh_tests.ps1
#>
#Requires -Version 5.1
[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $repositoryPath,

    [Parameter(Mandatory)]
    [string]
    $outputFolder,

    [Parameter()]
    [string]
    $testResults = 'tests.xml',

    [Parameter()]
    [string]
    $coverageResults = 'coverage.xml'
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
        $repositoryPath,

        [Parameter(Mandatory)]
        [string]
        $outputFolder,

        [Parameter(Mandatory)]
        [string]
        $testResults,

        [Parameter(Mandatory)]
        [string]
        $coverageResults
    )

    begin {
        . "$PSScriptRoot/../../src/env/common_utils_lib.ps1"

        Write-VerboseParam -invocation $MyInvocation

        Import-Module Pester

        $repositoryPath = Resolve-Path $repositoryPath

        if (-not (Test-Path $outputFolder -PathType Container)) {
            Write-Verbose "Creating output folder $outputFolder ..."
            New-Item $outputFolder -ItemType Directory -Force | Out-Null
        }

        $outputFolder = Resolve-Path $outputFolder
        $testResults = Join-Path $outputFolder -ChildPath $testResults
        $coverageResults = Join-Path $outputFolder -ChildPath $coverageResults
    }

    process {
        $cfg = New-PesterConfiguration

        $cfg.Run.Path = $repositoryPath
        $cfg.Run.PassThru = $true
        $cfg.Should.ErrorAction = "Continue"
        $cfg.TestResult.OutputFormat = "NUnitXml" # no other option
        $cfg.TestResult.OutputPath = $testResults
        $cfg.TestResult.Enabled = $true
        $cfg.CodeCoverage.Enabled = $true
        $cfg.CodeCoverage.ExcludeTests = $true
        $cfg.CodeCoverage.OutputFormat = "JaCoCo" # no other option
        $cfg.CodeCoverage.OutputPath = $coverageResults

        $res = Invoke-Pester -Configuration $cfg | ConvertTo-NUnitReport
    }
}

Main `
    -repositoryPath $repositoryPath `
    -outputFolder $outputFolder `
    -testResults $testResults `
    -coverageResults $coverageResults

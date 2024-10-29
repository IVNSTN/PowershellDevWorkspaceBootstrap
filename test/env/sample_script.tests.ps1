BeforeAll {
    . "$PSScriptRoot/../../src/testing/test_utils_lib.ps1"

    $cmd = "$PSScriptRoot/../../src/env/sample_script.ps1"
}


Describe 'sample_script facade' {
    BeforeEach {
        $params = @{
            name       = 'foo;bar'
            greeting   = 'hi {0}'
            outputFile = (Get-FullPath 'TestDrive:/out.json')
        }
    }

    It 'Saves result to dedicated file' {
        & $cmd @params

        $params.outputFile | Should -Exist
        Get-Content $params.outputFile | ConvertFrom-Json | Should -Not -BeNullOrEmpty
    }

    It 'Does not save anything if file path not provided' {
        Mock Out-File
        $params.outputFile = ''

        & $cmd @params

        Should -Not -Invoke Out-File
        $params.outputFile | Should -Not -Exist
    }

    AfterEach {
        if (Test-Path $params.outputFile -PathType Leaf) {
            Remove-Item $params.outputFile -Force | Out-Null
        }
    }
}

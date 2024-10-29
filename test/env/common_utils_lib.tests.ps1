BeforeAll {
    . "$PSScriptRoot/../../src/testing/test_utils_lib.ps1"
    . "$PSScriptRoot/../../src/env/common_utils_lib.ps1"
}


Describe 'Explode-String' {
    It 'Respects different separators' {
        $res = Explode-String -value 'xxx--yyy----' -delimiters @('--')

        $res | Should -Not -BeNullOrEmpty
        $res | Should -Contain 'xxx'
        $res | Should -Contain 'yyy'
        $res.Count | Should -Be 2
    }

    It 'Returns string parts as expected' {
        $res = Explode-String 'aaa; BBB  ,ccc;;;,,  '

        $res | Should -Not -BeNullOrEmpty
        $res | Should -Contain 'aaa'
        $res | Should -Contain 'BBB'
        $res | Should -Contain 'ccc'
        $res.Count | Should -Be 3
    }
}

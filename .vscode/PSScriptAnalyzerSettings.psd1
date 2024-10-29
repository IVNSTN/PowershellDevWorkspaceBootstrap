@{
    Rules        = @{
        PSAvoidUsingCmdletAliases          = @{
            Whitelist = @('%', '?')
        }
        PSAvoidSemicolonsAsLineTerminators = @{
            Enable = $true
        }
        PSUseCorrectCasing                 = @{
            Enable = $false # too slow
        }
    }
    ExcludeRules = @(
        'PSAvoidUsingWriteHost',
        'PSAvoidUsingInvokeExpression',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSUseApprovedVerbs',
        'PSReviewUnusedParameter',
        'PSAvoidUsingPlainTextForPassword',
        'PSAvoidUsingConvertToSecureStringWithPlainText')
}
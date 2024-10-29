# PowershellDevWorkspaceBootstrap

Template for Posh-code repositories with recommended extensions and basic code snippets.

These sources are related to [this article on Habr](https://habr.com/ru/articles/854128/).

Repository contains [sample script](./src/env/sample_script.ps1), [unit-tests](./test/env/sample_script.tests.ps1) for it, couple [useful](./src/env/common_utils_lib.ps1) [functions](./src/testing/test_utils_lib.ps1) and Pester [test runner](./src/testing/run_posh_tests.ps1) script.

## References

### Tools

- [Powershell on GitHub](https://github.com/PowerShell/PowerShell)
- [Pester on GitHub](https://github.com/pester/Pester)
- [PSScriptAnalyzer on GitHub](https://github.com/PowerShell/PSScriptAnalyzer)
- [ReportGenerator on GitHub](https://github.com/danielpalme/ReportGenerator)
- [Powershell plugin for SonarQube on GitHub](https://github.com/gretard/sonar-ps-plugin)
- [Powershell extension for VS Code on GitHub](https://github.com/PowerShell/vscode-powershell)

### Guides

- [Using VS Code for Powershell development Guide](https://learn.microsoft.com/en-us/powershell/scripting/dev-cross-plat/vscode/using-vscode)
- [Powershell coding Guidelines by MS](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/required-development-guidelines)
- [PoshCode Best Practice](https://github.com/PoshCode/PowerShellPracticeAndStyle/tree/master)
- [Importing thirdparty reports into SonarQube](https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/importing-external-issues/external-analyzer-reports/)

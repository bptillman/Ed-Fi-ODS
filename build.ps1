# SPDX-License-Identifier: Apache-2.0
# Licensed to the Ed-Fi Alliance under one or more agreements.
# The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
# See the LICENSE and NOTICES files in the project root for more information.

[CmdLetBinding()]
param(
    # Command to execute, defaults to "Build".
    [string]
    [ValidateSet("Clean", "Build", "Test")]
    $Command = "Build",

    [switch] $SelfContained,

    # Informational version number, defaults 1.0
    [string]
    $InformationalVersion = "1.0",

    # Build counter from the automation tool.
    [string]
    $BuildCounter = "1",

    # .NET project build configuration, defaults to "Release". Options are: Debug, Release.
    [string]
    [ValidateSet("Debug", "Release")]
    $Configuration = "Release"
)

$solution = "Application\EdFi.Admin.DataAccess\EdFi.Admin.DataAccess.sln"
$projectFile = "Application\EdFi.Admin.DataAccess\EdFi.Admin.DataAccess.csproj"
$version = "$InformationalVersion.$BuildCounter"
$packageName = "EdFi.Suite3.Admin.DataAccess"

function Invoke-Execute {
    param (
        [ScriptBlock]
        $Command
    )

    $global:lastexitcode = 0
    & $Command

    if ($lastexitcode -ne 0) {
        throw "Error executing command: $Command"
    }
}

function Invoke-Step {
    param (
        [ScriptBlock]
        $block
    )

    $command = $block.ToString().Trim()

    Write-Host
    Write-Host $command -fore CYAN

    &$block
}

function Clean {
    Invoke-Execute { dotnet clean $solution -c $Configuration --nologo -v minimal }
}

function Compile {
    Invoke-Execute {
        dotnet --info
        dotnet build $solution -c $Configuration -p:AssemblyVersion=$version -p:FileVersion=$version -p:InformationalVersion=$InformationalVersion
    }
}

function Pack {
    Invoke-Execute {
        dotnet pack $projectFile -c $Configuration --no-build --verbosity normal -p:VersionPrefix=$version -p:NoWarn=NU5123 -p:PackageId=$packageName
    }
}
function Invoke-Build {
    Write-Host "Building Version $version" -ForegroundColor Cyan
    Invoke-Step { Clean }
    Invoke-Step { Compile }
    Invoke-Step { Test }
}

function Invoke-Tests {
    Invoke-Execute { dotnet test $solution  -c $Configuration --no-build -v normal }
}

function Invoke-Pack {
    Invoke-Step { Pack }
}

Invoke-Main {
    switch ($Command) {
        Clean { Invoke-Clean }
        Build { Invoke-Build }
        Test { Invoke-Tests }
        Pack { Invoke-Pack }
        default { throw "Command '$Command' is not recognized" }
    }
}
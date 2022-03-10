# SPDX-License-Identifier: Apache-2.0
# Licensed to the Ed-Fi Alliance under one or more agreements.
# The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
# See the LICENSE and NOTICES files in the project root for more information.

& dotnet build .\Application\EdFi.Admin.DataAccess\EdFi.Admin.DataAccess.sln --configuration Release -p:AssemblyVersion=$env:informationalVersion.$env:version -p:FileVersion=$env:informationalVersion.$env:version -p:InformationalVersion=$env:informationalVersion
& dotnet test .\Application\EdFi.Admin.DataAccess\EdFi.Admin.DataAccess.sln --configuration Release --no-build --verbosity normal
& dotnet pack .\Application\EdFi.Admin.DataAccess\EdFi.Admin.DataAccess.csproj --configuration Release --no-build --verbosity normal -p:VersionPrefix=$env:informationalVersion.$env:version -p:NoWarn=NU5123 -p:PackageId=EdFi.Suite3.Admin.DataAccess
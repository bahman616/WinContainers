# escape=`
 
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019 AS build
WORKDIR /app

COPY . .
RUN nuget restore;
RUN msbuild /p:Configuration=Debug



FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
WORKDIR /inetpub/wwwroot
COPY --from=build /app/SampleWebsite/. ./

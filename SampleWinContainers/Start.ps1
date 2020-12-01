param(
    # Arbitrary ip addresses for the container. You need to do a "docker inspec nat" and make sure this ip address is valid on the subnet.
    $IP = "172.30.96.2"
)


    Write-Host ''
    Write-Host '---------------Building Docker Image---------------' -f cyan
    Write-Host ''

    docker build --build-arg BuildType='local' -m 4g -t mywincontainer . 
    
    if ($LASTEXITCODE -ne 0) 
    {
        Write-Error -Message "Failed to build docker image"
        exit $LASTEXITCODE
    }

    Write-Host ''
    Write-Host '---------------Removing the container (if there is any)---------------' -f cyan
    Write-Host ''
    docker rm -f MyWinContainer

    Write-Host ''
    Write-Host '---------------Creating the container ---------------' -f cyan
    Write-Host ''

    docker run -dt --name MyWinContainer --ip $IP --network "nat" `
      --env-file .env -v "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\Remote Debugger:C:\remote_debugger:ro" `
      --entrypoint cmd mywincontainer:latest `
      /c "start /B C:\ServiceMonitor.exe w3svc & C:\remote_debugger\x64\msvsmon.exe /noauth /anyuser /silent /nostatus /noclrwarn /nosecuritywarn /nofirewallwarn /nowowwarn /fallbackloadremotemanagedpdbs /timeout:2147483646"

    if ($LASTEXITCODE -ne 0) 
    {
        Write-Error -Message "Failed to run these container" 
        exit $LASTEXITCODE
    }
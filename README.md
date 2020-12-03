# A simple containerized .Net Framework app 
This is a sample project to demonstrate how to work with Windows Containers.

## How to run
1. First install [docker for desktop](https://docs.docker.com/docker-for-windows/install/) and switch to Windows containers.

2. Enable container features by running this in Powershell:
```
Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All
```

3. Go to Docker Desktop settings and add dns settings (if you haven't done it before):
```
  "dns": [
    "8.8.8.8"
  ]
```

4. By default you should be using "nat" network for your local docker. You need to get the range of IP addresses available in that network using this code:

```
docker network inspect nat -f '{{range .IPAM.Config}}{{.Subnet}}{{end}}'
```
If your local docker uses a different network, then you need to mention the name of that network instead of "nat".

5. Using Powershell, navigate to "SampleWinContainers" folder and run Start.ps1 -ip <an arbitrary ip address from the above range>

6. Then you should be able to run the application in the browser using the ip address which you chose.
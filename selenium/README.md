# SELENIUM SERVER DEPLOYMENTS

Hello, this is a quick deployment for selenium server running on docker  
Refer this document for more detail: https://github.com/SeleniumHQ/docker-selenium

## Environments

Create file `[environment_name].env` in the project root folder
```
SELENIUM_NAME=example
SELENIUM_EVENT_BUS_PUBLISH_PORT=4444
DEBUG_PORT=5900
```

### Up/down selenium
```
./up.sh DEPLOY_ENV
./down.sh DEPLOY_ENV
```

### Check if connection working here:

http://localhost:4444/wd/hub

### Debug selenium

- [Install VNC Connect](https://www.realvnc.com/en/connect/download/viewer/)
- Connect to Selenium server using: 
```
localhost:5900
```
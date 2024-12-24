# fcm
Fedora Container Manager

1. **Start the Podman API Server**:

``` sh
podman system service tcp:localhost:8080 --time=0 &
```
> This starts the API service in background(&) under the port 8080

- In order to communicate with Podman, we need use the Podman's RESTful API to access the container informations.
- The above command starts the server, which enables to communicate with Podman using http request to send & receive data.
- This is the first and foremost step complete for API communications.

2. [**Send HTTP Request using Ziglang**](./get/README.md)

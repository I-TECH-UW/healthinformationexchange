# Health Information Exchange Documentation

## Build and Deploy

1. Install `Python3` and `Pip3`.

        sudo apt-get install python3.10
        sudo apt install python3-pip

2. Intall the dependenecies

        pip3 install -r requirements.txt

3. Run the docs in a dev mode

        mkdocs serve

## Dockerized Build and Deploy

1. Build the docker image
        ```sh
        cd healthinformationexchange
        docker build -t itechuw/healthinformationexchange:local .
        ```
2. Run the docker image
        ```sh
        docker run -it --rm -p 8000:80 itechuw/healthinformationexchange:local
        ```

3. Open the browser and navigate to `http://localhost:8000`

**Note:** If you want to rebuild on your host machine and have the results show up in the docker container, you can mount the `./site` directory as a volume in the container. For example:

```sh
docker run -it --rm -p 8000:80 -v $(pwd)/site:/usr/share/nginx/html itechuw/healthinformationexchange:local
```
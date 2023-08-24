### Packaging Hie Implementations

#### References:
- https://github.com/jembi/platform
- https://jembi.gitbook.io/openhim-platform/
- https://jembi.gitbook.io/instant-v2/

#### Steps:

#### 1. Add scripts for downloading Instant OpenHIE V2 CLI and add utilities.
https://github.com/jembi/platform/blob/main/get-cli.sh
https://github.com/jembi/platform/tree/main/utils


#### 2. Add Dockerfile in root directory of the project that inherits from Instant OpenHIE Parent Docker Image

https://github.com/jembi/platform/blob/main/Dockerfile

#### 3. Download CLI
`./get-cli.sh `

#### 4. Build and publish Docker image

##### 4.1. Build Local Docker image

##### 4.2. Publish Docker image

##### 4.3. Update config.yml file

#### 5. Add HIE components

### Migrating HIE Components to instant HIE V2

#### Description of components of instant HIE v2

1. config.yaml - Configuartion file for the project that has a list of the componenet packages and other project configurations

2. Util folder - Contains scripts for bringing up and down the different components.These utilities are used in every packages swarm.sh file

3. build-image.sh file - The file builds a local docker image that packages the instant HIE v2 project and allows it to be run using the instant CLI.
    NOTE: Make sure the image name and tag matches what you have in the config.yaml file.

4.get-cli.sh - It downloads the architecure specific instant CLI executable and saves it in the project root directory.This allows the CLI to be run with the `./instant` command.

5.dockerfile - Packages the openHIE Components into a docker image and allows it to be run using the instant CLI.The image its self is built with the build-image.sh file

6. .env file - Contains the settings for the various components.This file needs to be customised for each implementation.

#### Description of components of instant openHIE V2 package

    1.swarm.sh - Package specific file that controls the life cycle of the HIE components using docker swarm and the utilities from the util folder.This script contains all the intiliazation and tear down logic requried to bring the component up in the right context.

    2.package-metadata.json - Contains default configuarations and settings for the package.

    3.List of docker compose files - Varius services are defined with docker-compose files.Additional settings rquired to bring up these services in dev/cluster mode are separeted into there own docker-compose files.Boot up and control of these docker-compose files is defined in swarm.sh















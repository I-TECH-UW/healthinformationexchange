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


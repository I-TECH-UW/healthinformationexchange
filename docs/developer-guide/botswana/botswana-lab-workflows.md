### Dev Guide: Botsawana Laborabory Workflows

#### Introduction
This guide will go over development, configuration, and debugging the laboratory workflow for Botswana. This 
workflow includes functionality in the SHR and Fhir Converter projects, linked below:

- https://github.com/i-TECH-UW/shared-health-record
- https://github.com/I-TECH-UW/openhim-mediator-fhir-converter

The functionality includes Kafka-managed workflows in the SHR project, and FHIR --> HL7 and HL7 --> FHIR mappings in the Fhir Converter project. 


#### Prerequesites
Before getting started, make sure you complete the following prerequisites:

##### 1. Connect to the Botswana VPN
See the relevant emails and slack messages for instructions.

##### 2. Add the following ssh config to your ~/.ssh/config file:
```
Host hie-pilot.gov.bw
  HostName 10.0.10.111
  User hie
```

##### 3. Connect to the HIE server using remote VS Code
See slack for the password.

##### 4. Set up the relevant VS Code projects by opening the following folders:
```bash
$ cd /u01/code/shared-health-record
$ code .
```

```bash
$ cd /u01/code/openhim-mediator-fhir-converter
$ code .
```

```bash
$ cd /home/hie/hie-botswana
$ code .
```

The first two are used for development of the SHR and the FHIR Converter, respectively. The third is the main
project for running the HIE. We run all the other containers EXCEPT FOR the shr and fhir-converter containers
from that project. 

##### 5. Add remote debugging configurations to the SHR and FHIR Converter projects

Add the following configurations to the .vscode/launch.json files in the SHR and FHIR Converter projects:

You can open the file by clicking the debug icon on the left side of the VS Code window, 
then clicking the gear icon next to the "Run and Debug" dropdown, then clicking "Open launch.json".

###### 5.1. SHR

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Docker: Attach to Node",
            "type": "node",
            "request": "attach",
            "restart": true,
            "port": 9229,
            "address": "localhost",
            "localRoot": "${workspaceFolder}",
            "remoteRoot": "/app",
            "protocol": "inspector",
            "sourceMaps": true
        },
    ]
}
```
###### 5.2 FHIR Converter

```json
{
    "version": "0.2.0",
    "configurations": [
    
        {
            "name": "Docker: Attach to Node",
            "type": "node",
            "request": "attach",
            "restart": true,
            "port": 9230,
            "address": "localhost",
            "localRoot": "${workspaceFolder}",
            "remoteRoot": "/app",
            "protocol": "inspector",
            "sourceMaps": true
        },
    ]
}
```

##### 6. Forward the following ports in VS Code for the SHR and FHIR Converter projects:
- SHR: 9229
- FHIR Converter: 9230 

#### Useful Docker Commands

##### 1. Show logs of shr, shr-fhir, and fhir-converter containers
```bash
docker logs -f -n 100 shr
docker logs -f -n 100 shr-fhir
docker logs -f -n 100 built-fhir-converter
```

##### 2. Rebuild and run SHR or FHIR Converter containers
```bash
cd <respective project directory>
docker-compose -f debug.docker-compose.yml up --build -d
```

##### 3. Rebuild and Reset the FHIR Converter templates after making changes
The templates are stored in a volume, so you need to remove the volume and rebuild the container to update any changes made to the templates.
```bash
cd /u01/code/openhim-mediator-fhir-converter
docker-compose -f debug.docker-compose.yml down -v
docker-compose -f debug.docker-compose.yml up --build -d
```

#### Overview of project structure and code locations

##### 1. SHR

The SHR project contains two main that has all of the Botswana-specific workflows. One focuses on FHIR-based workflows,
and the other manages the incoming HL7 messages. 

The FHIR-based workflows for Botswana are located in `src/workflows/labWorkflowsBw.ts`: https://github.com/I-TECH-UW/shared-health-record/blob/pmanko-lab-workflow-updates/src/workflows/labWorkflowsBw.ts.


The HL7-based workflows are located in `src/workflows/hl7WorkflowsBw.ts`: https://github.com/I-TECH-UW/shared-health-record/blob/pmanko-lab-workflow-updates/src/workflows/hl7WorkflowsBw.ts

The workflows are organized using Kafka topics and picked up by Kafka workers. 

##### 2. FHIR Converter

The FHIR Converter project contains the mappings from FHIR to HL7 and HL7 to FHIR. The mappings are located in the `data/templates` directory:
https://github.com/I-TECH-UW/openhim-mediator-fhir-converter/tree/pmanko-server-update/data/templates

The relevant templates are `ADT_A04_TO_IPMS.hbs` and `ORM_O01_TO_IPMS.hbs` in the fhir subdirectory and `ADT_A04_FROM_IPMS.hbs` and `ORU_R01_FROM_IPMS.hbs` in the hl7 subdirectory.

###### 2.1. HL7 to FHIR
For the HL7-->FHIR templates in the `data/templates/hl7` directory, there are nested handlebar template files that provide variable replacement for references to the HL7 message field names. 

###### 2.2. FHIR to HL7
For the FHIR-->HL7 templates in the `data/templates/fhir` directory, the variable replacement is done using custom mappings defined in the `parseAdt()` and `parseOrm()` functions in the `/src/lib/fhir/fhir.js` file: https://github.com/I-TECH-UW/openhim-mediator-fhir-converter/blob/e1f8085258b95735559c69d5f36eaf5ff0fd272b/src/lib/fhir/fhir.js#L107. The correct variables need to be added to the `res` object, and are then available as variables in the handlebar templates.

#### Turning on Remote Debugging for the projects:

Make sure that the docker-compose entries in the `debug.docker-compose.yml` files for the SHR and FHIR Converter projects have debugging turned on for their respective projects. 

The Fhir Converter project should have the following `entrypoint` entry:
```yaml
  entrypoint: /app/deploy/debug.sh
```

The SHR project should have the following `entrypoint` entry:
```yaml
  entrypoint: node --inspect=0.0.0.0:9230 /app/dist/app.js
```

Make sure that you have the Remote Debugging setup as outlined in the Prerequisites section of this guide.

Make sure that you have the relevant ports forwarded in VS Code for the SHR and FHIR Converter projects.

Finally, make sure that you run `yarn build` on the project you want to debug, and also that you ran `docker-compose -f debug.docker-compose.yml up --build -d` after making any changes to the code to see them reflected in the running container.

#### Postman Overview

The Postman collection for the Botswana HIE Lab Workflows is located here: https://www.postman.com/itechuw/workspace/botswana-hie/collection/1525496-8be9c19c-9e7b-4316-adea-3604884af5d7?action=share&creator=1525496

For IPMS testing, we focus on the following folder: https://www.postman.com/itechuw/workspace/botswana-hie/folder/1525496-0c135557-d6a8-4928-a649-2546a18d075f?ctx=documentation

We also use the `hie-pilot.gov.bw` environment.

The `Add Draft Order Bundle` request sends a draft order that does result in concept and location mappings, but does not send an HL7 message to IPMS. It also generates new patient data as outlined in the `Pre-request Script` tab. 

The `Add Requested Order Bundle` request sends a requested order that does concept and location mappings, and also sends an HL7 message to IPMS. It uses the data generated by the `Add Draft Order Bundle` request, and can be re-run multiple times with the same patient information. 

#### OpenHIE Testing

For quickly testing changes to the Fhir Converter templates, you can re-run the converter request from OpenHIE, which can be accessed here:

[https://hie-pilot.gov.bw/](https://hie-pilot.gov.bw/)

This page loads slowly as it tries to pull external resources that are not available on the network. 


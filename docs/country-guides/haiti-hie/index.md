## Haiti HIE

### Project Overview
This guide provides a starting point for learning about the **Haiti Health Information Exchange (HIE)**. The project is based on the **OpenHIE architecture** and uses the **Instant OpenHIE V2** tooling to for packaging, deployment, and horizontal scalability. Currently, the HIE consists of core components of the HIE architecture customized to the Haiti context, as well as components supporting two target workflows: Patient Identity Management/Roaming Care and Laboratory Order and Result Management. As this project leverages a number of open standards and global goods (OpenHIE, FHIR, HIE IGs, etc.), this documentation contains a number of references to useful external resources.

**[Link to Github Repository](https://github.com/I-TECH-UW/sedish-haiti.org)**

### Architecture

The Haiti HIE is based on the OpenHIE architecture. The following diagram shows the core components of the HIE architecture, and highlights the components currently in scope for implementation as part of the Haiti HIE project.

![Haiti HIE Architecture](././img/SEDISH-May23.png)

### HIE Components Index

#### Interoperability Layer
*[Link to OpenHIE Documentation](https://guides.ohie.org/arch-spec/openhie-component-specifications-1/openhie-interoperability-layer-iol)*

The Interoperability Layer (IOL) is the core component of the OpenHIE architecture responsible for securely routing messages between the various other components of the HIE, and providing the entrypoint interface for external point-of-service clients. This layer is implemented using [OpenHIM](https://openhim.org/).

#### Client Registry (Master Patient Index)
*[Link to OpenHIE Documentation](https://guides.ohie.org/arch-spec/openhie-component-specifications-1/client-registry)*

The Client Registry (CR) is responsible for linking and managing the identities of patients across the health system. This component is iplemented using [OpenCR](https://github.com/intrahealth/client-registry).

#### Shared Health Record 
*[Link to OpenHIE Documentation](https://guides.ohie.org/arch-spec/openhie-component-specifications-1/openhie-shared-health-record-shr)*

The Shared Health Record (SHR) service stores the longitudal health record for each patient from across the health system. This component supports workflows that require access to a shared central repository of patient data, such and laboratory order and result workflows. This component is implemented using [SHR](https://github.com/i-tech-uw/shared-health-record).

### Other OpenHIM Mediators 
The CR and SHR run as OpenHIM mediators. In addition, the following mediators are used to support the HIE workflows:

### Common OpenHIE Instant V2 Components
These components are used across HIE implementations and packaged using Instant OpenHIE V2. A number were based on or inspired by the Jembi platform project: https://github.com/jembi/platform

- **Reverse Proxies**
    * [Nginx](https://github.com/I-TECH-UW/hie-botswana/tree/main/reverse-proxy-nginx)
    * [Traefik](https://github.com/I-TECH-UW/hie-botswana/tree/pilot-3-traefik-v2/reverse-proxy-traefik)
    * [Caddy with WAF](https://github.com/I-TECH-UW/hie-botswana/tree/main/reverse-proxy-caddy)


- **iSantePlus:** This is an OpenMRS-based EMR used in Botswana, and developed by BITRI.

- **SCC:** This is an LIS system used in major facilities in Haiti developed by SCC.

### Developer Guides

1. **[Haiti Laboratory Workflows](../../developer-guide/index.md#dev-guide-botsawana-laborabory-workflows)**


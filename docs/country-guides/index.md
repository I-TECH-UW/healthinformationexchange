# Country-specific Project Index

### Overview
This guide provides a starting point for learning about the Country Specific **Health Information Exchange (HIE)**. These projects are based on the **OpenHIE Architecture** and use the **Instant OpenHIE V2** tooling to for packaging, deployment, and horizontal scalability. Currently, the HIE consists of core components of the HIE architecture customized to each country's context, as well as components supporting the following target workflows: 
- Patient Identity Management 
- Laboratory Order and Result Management
- Data Analytics

As these projects leverage a number of open standards and global goods (OpenHIE, FHIR, HIE IGs, etc.), this documentation contains a number of references to useful external resources.

*****

### HIE Components Index

#### Interoperability Layer
The Interoperability Layer (IOL) is the core component of the OpenHIE architecture responsible for securely routing messages between the various other components of the HIE, and providing the entrypoint interface for external point-of-service clients. *[IOL OpenHIE Documentation](https://guides.ohie.org/arch-spec/openhie-component-specifications-1/openhie-interoperability-layer-iol)*

#### Client Registry (Master Patient Index)
The Client Registry (CR) is responsible for linking and managing the identities of patients across the health system. *[Client Registry OpenHIE Documentation](https://guides.ohie.org/arch-spec/openhie-component-specifications-1/client-registry)*

#### Shared Health Record 
The Shared Health Record (SHR) service stores the longitudal health record for each patient from across the health system. This component supports workflows that require access to a shared central repository of patient data, such and laboratory order and result workflows. *[SHR OpenHIE Documentation](https://guides.ohie.org/arch-spec/openhie-component-specifications-1/openhie-shared-health-record-shr)*

#### Terminology Service
The Terminology Service (TS) is responsible for managing terminology collections from across the health system and their mappings to standard terminologies. *[Terminology Service OpenHIE Documentation](https://guides.ohie.org/arch-spec/openhie-component-specifications-1/openhie-terminology-service-ts)*

#### Facility Registry (Master Facility List):** 
The Facility Registry (FR) or Master Facility List (MFL) is responsible for managing the list of facilities and their health services across the health system.*[Facility Registry OpenHIE Documentation](https://guides.ohie.org/arch-spec/openhie-component-specifications-1/openhie-facility-registry-fr)* 

#### Other OpenHIM Mediators 
The CR and SHR run as OpenHIM mediators. In addition, the following mediators are used to support the HIE workflows:

- **FHIR Converter**: This mediator is responsible for converting FHIR messages to HL7 messages and vice versa. This mediator is implemented here: https://github.com/I-TECH-UW/openhim-mediator-fhir-converter

#### Common OpenHIE Instant V2 Components
These components are used across HIE implementations and packaged using Instant OpenHIE V2. A number were based on or inspired by the Jembi platform project: https://github.com/jembi/platform

#### Point of Service (Externally Managed Services)
These integrations include both point-of-service systems like EMRs and LIMs, as well as HIE components like the Facility Registry. 

### HIE Components Tooling

#### Interoperability Layer ([OpenHIM](https://openhim.org/))

#### Client Registry (Master Patient Index) ([OpenCR](https://github.com/intrahealth/client-registry))

#### Shared Health Record ([SHR](https://github.com/i-tech-uw/shared-health-record))

#### Terminology Service ([Open Concept Lab](https://openconceptlab.org/))

#### Facility Registry (Master Facility List):** ([GoFR](https://www.facilitymatch.net/documentation))


{% include-markdown 'botswana-hie/index.md' %}

{% include-markdown 'zimbabwe-hie/index.md' %}

{% include-markdown 'cote-d-ivoire/index.md' %}

{% include-markdown 'haiti-hie/index.md' %}
### Getting Started
To get started in implementing the EMR-LIS workflow between electronic systems, it is best to understand the full scope of high level steps that will possibly need to be done, depending on your situation in the environment you are implementing in.  In general, these high-level steps may need to be taken.  Details about each of these steps and the possible caveats will follow.

1. Identify the minimum data set to be exchanged between the systems.
2. Use a universally unique identification system (coding) for identifying and mapping lab tests for both systems.
3. Extract or create a laboratory test catalog from both the EMR and LIS.
4. Crosswalk the listing of lab tests between the EMR and LIS to map those lab tests to the unique ID system (coding).
5. Map all other relevant concepts and identifiers needed between EMR and LIS
6. Identify the data exchange method between the systems based on your HIE and infrastructure context. 
7. Build out the technological approach for the workflow within and between the EMR and LIS.
8. Identify and develop mechanisms for handling potential issues and caveats.


### Step #1: Identify a minimum dataset
Working with stakeholders, key partners, and system users, your team will need to identify the minimum data set to be exchanged between the systems.  Resources to inform the minimum data set could be paper forms that are used by providers for clinical orders, lab order and test result forms used by the laboratory, data sets from the EMR and LIS, and input from relevant technical working groups/steering committees, clinical partners and laboratory partners, and system users.  It is critical that the technical stewards / teams of the systems participate in this definition of the minimum data set to help determine what data is available in the systems, identify gaps in data or system abilities in capturing/providing that data, and feasibility in the system utilizing that data from the other system.

**Resources**

### Step #2: Identify a standard coding terminology

Successful communication of laboratory orders can only happen if each system involved is using a 
common language for key concepts like Lab test types. Aa common terminology is critical to correctly 
understand and process the messages sent and recieved. Many EMR and LIS systems have not been built 
using the same terminology for the laboratory orders and results, and therefore, must be mapped to 
an agreed upon common terminology for that exchange.  To do this, your team will need to work with 
stakeholders and key partners to either create a local set of shared terminology that uses unique IDs 
for each term, or your team can utilize an international standard coding system to create this shared terminology set.  
We recommend using the LOINC international standard for that shared terminology set of orders and results needed for your context.

**Resources** 
- [LOINC specification](https://loinc.org/)

### Step #3: Identify the relevant concepts from each system

Each EMR, LIS, or other system that is partificating in the Laboratory Workflows will have a set of 
concepts key for this communication. Some systems use standard terminologies like Loinc, and others have 
custom concepts unique to that system. In both cases, we need identify and catalog the relevant concepts
in each system. 

This exercise can be done manually, using a spreadsheet or similar tool to create a line listing of the supported
laboratory test types, result types, panels, units, and other key concepts from each system. For example, we might 
end up with two lists, one from the EMR and one from the LIS. 
This test catalog will be used to map between the systems in step 4. 

*Note: Alternatively, we can use a terminology management service such as [Open Concept Lab](https://openconceptlab.org/) for 
cataloging, mapping, and managing our concepts. A tutorial for this approach is coming soon!*

**Resources**
- [Example: Haiti OpenELIS Lab System Test Catalog](https://docs.google.com/spreadsheets/d/1y9q42jMB2dTOClxJP3NU0UJ7xnX1qh_kCjlcNqBL49E/edit#gid=0)

### Step #4: Create Mappings between the concept catalogs

We need to crosswalk the listing of lab tests between the EMR and LIS to map those lab tests to the unique ID system (coding)

In step #2, your team identified the shared terminology set that would stand as the source of truth for all terminologies that are exchanged in your HIE and provide unique identifiers for that terminology.  Using your laboratory test catalogs created in step #3, you will need to now map your lab tests and results from both the EMR and the LIS to the shared terminology set.  We recommend the use of LOINC codes as the mapping identifier.

**Problem Solving:** 
In some cases, the EMR may allow ordering tests by panel.  If the order only provides the panel and does not include individual tests, you will need to map panels to individual tests for the order and develop an additional mechanism to handle the translation for the proper exchange to the LIS.

**Resources**
- [Example: Botswana EMR-LIS Terminology Mapping](https://docs.google.com/spreadsheets/d/1jatq2MpMQPIrZvwCKeij6VEiNdPXaRcTTElJJG29dsM/edit#gid=0)
- [Example: Haiti iSantePlus Terminology Mapping to LOINC](https://docs.google.com/spreadsheets/d/1NgFUvbsDldy3N-xvsXntBMQ6CC1FCtqvchwpAjnzAkA/edit#gid=0)


### Step 5: Map all other relevant concepts and identifiers needed between EMR and LIS

Many times in systems that are not based on standards, the technical architectural decisions means the requirements for data fields may be different than the requirements in other systems for those data elements.  In these cases, when messages are exchanged between systems, those data elements that fit the requirements for the sending system do not meet the requirements for that data in the receiving system and will cause an error, and ultimately the transaction fails and the message and its data is not accepted into the receiving system.  To minimize errors of this type, ensure there is mapping of  all other relevant concepts between EMR and LIS.  Some of the most common concepts/data that might have issues do to requirements and algorithms tied to that data include (but are not limited to):

- Patient Identifiers
- Facility Identifiers
- System Identifiers

**Problem Solving**: Frequently, the EMR and LIS have different required formats, lengths, or algorithms for identifiers that can cause errors and mismatches when messaging between systems.  There may be negotiating and workarounds that will need to be discussed and a mechanism for handling developed.  An example of this was in the Haiti iSantePlus (OpenMRS) exchange with a proprietary lab system that had specific algorithms attached to the patient identifiers fields in their database that caused a mismatch with the data sent.  In addition, there were other data elements that needed “massaging” due to character limits that don’t accommodate the full length of the data sent.  These types of issues needed extensive negotiation and custom development of how the data in the message would be constructed, formatted, and consumed in order to reliably exchange data between these systems.*


### Step #6: Identify data exchange patterns based on your HIE and infrastructure context

There are multiple ways to approach the exchange of data, and will be decided by understanding the context in which your exchange will operate, and the requirements for data availability from the exchange.  You will use either a push of data from a system, or a pull of data from a system, or a mixed method approach depending on the implementation, system availability and connectivity, components available in the HIE, and requirements for timeliness and data availability from the exchange.  For example, you can set up your exchange of orders to use any of the following approaches:
- Push data from EMR to central repository (i.e. SHR), the central repository alerts the LIS, and subsequently the data is pulled by the LIS
- The LIS can periodically check for data to be pulled from an EMR or a central repository system (i.e. SHR), conducting the pull with all data with an order status of `ordered`
- An order is pushed by an EMR automatically to the LIS.  In this case, there is no way to know if the order reached the LIS or not.  We do not recommend this approach when using FHIR due to the lack of any receipt acknowledge messaging in the FHIR workflow standard.

### Step #7: Build out the technological approach for the workflow within and between the EMR and LIS

Use the technical artifacts in the Implementation Guide and the detailed technical sections in this SOP to develop and configure the EMR and LIS exchange.  Every EMR-LIS exchange is somewhat unique, and will require customization of these artifacts and approaches to meet the needs of the context you are working in.  For additional support during your build phase, engage with other developers and implementers in the relevant global goods communities of practice, such as OpenHIE LIS COP, OpenMRS FHIR Squad, and LIS software forums (i.e. OpenELIS).  Many folks are eager to share their experience and provide answers for how to use these technical artifacts and tools to achieve this exchange.  In addition, our team is happy to answer questions you may have when setting up your exchange following this guide.

**Resources**
- [OpenMRS FHIR Squad](https://wiki.openmrs.org/display/projects/OpenMRS+HL7+FHIR+Solutions), [FHIR Squad Bi-Weekly Calls](https://wiki.openmrs.org/display/projects/FHIR+Squad+Notes), and [Talk FHIR Forum](https://talk.openmrs.org/c/projects/fhir/52)
[OpenHIE LIS COP](https://wiki.ohie.org/pages/viewpage.action?pageId=36536662) and [Slack](https://ohieliscop.slack.com/)
[OpenELIS Forum](https://talk.openelisci.org/)


### Step #8: Identify and develop mechanisms for handling potential issues and caveats

Exchanges between EMR and LIS are not an easy thing to accomplish due to the many nuances to the workflows and the data collected and exchanged in the process.  Your team will need to identify additional potential issues for the exchange specific to the workflows you are addressing, and develop mechanisms to handle those.  Other problem areas to look for are, but no limited to:
- Canceled and Rejected lab orders
- Corrected Results after report out
- Specialized and interim/intermediate results (e.g., Microbiology)
- Ordering of test panels rather than individual lab tests
- Intermittent connectivity and infrastructure issues

### Communication Overview 

#### Lab Orders

The lab order workflow follows the OpenHIE specification for standard lab ordering between an EMR and LIS. The workflow is detailed in the following sequence diagram:

![screen1](img/laborderseq.png)

| | Interaction | Data| Transaction Options |
|---| ------ | ----------- | ----------- |
|1| Create Lab Order  | Order Save generates a new FHIR Task Bundled Order by creating a Task FHIR R4 Task Resource with a reference to a Service Request with order information |
|2| Send Lab Order | FHIR Task bundled order is sent to the IOL. Task status is aligned with the FHIR workflow communication pattern found [here](https://www.hl7.org/fhir/workflow-communications.html#12.6.2.1)|
|3,4 | Send New Lab Order   | Bundled order is routed through the IOL to both the SHR and the LIS |
|5 | Save Order and Update Order Status  | FHIR R4 Task Resource Status is updated locally to either `rejected` or `accepted`. A FHIR R4 ServiceRequest Resource (example) is created for order processing with a reference to the associated task. EMR test requests and LIS orders are matched based on LOINC codes.|
|6| Send New Lab Order   | Bundled order is routed through the IOL to both the SHR and the LIS |
|7,8| Send Order Update | IOL routes the updated FHIR R4 Tasks to the SHR and the EMR |
|9| Update FHIR Task Status| FHIR task status updated locally|

#### Lab Results
![screen2](img/labresultsseq.png)

| | Interaction | Data| Transaction Options |
|---| ------ | ----------- | ----------- |
|1| Results Saved and FHIR Task Updated | The results save generates a FHIR R4 DiagnosticReport Resource () with referenced FHIR R4 Observation resources () to store the results,  and a reference to the associated Patient and Task Resource. ||
|2| Search for Updated FHIR Tasks || FHIR R4 Search for Tasks based on tasks for which the owner is the EMR, and which have a status ‘completed’ |
|3| Return FHIR Updated Tasks | FHIR R4 Task Resource with status ‘completed’ and reference to FHIR R4 DiagnosticReport | FHIR R4 bundle search response () |
|4| Search for Associated Diagnostic Reports || FHIR R4 Search for DiagnosticReports by UUID |
|5| Return Associated Diagnostic Reports | FHIR R4 DiagnosticReport Resource with ||
|6| Update FHIR Task Status, Store DiagnosticReports and Save Results ||||
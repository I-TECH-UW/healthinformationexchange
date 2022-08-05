# Laboratory Workflows Dev Guide


## Tutorial: Implementing Laboratory Order and Result Communication between an EMR and a LIS. 

In this tutorial, we will use the resources from this documentation - with support from the [Laboratory Workflow Implementation Guide]() and [OpenHIE Architecture Specifications]() - to determine create a pilot implementation of **Lab Test Order and Result Communication** between an **Electronic Medical Record (EMR)** and a **Lab Information System**. We will use validated open-source solutions for each component of our pilot setup, and will use the OpenHIE specifications to guide our approach, the selection and roles of different components, and the language we use for disucssing the various concepts. 

To get a better idea about the concepts and data elements were using, visit the [Laboratory Workflows IG]() to a look at:
1. Our list of key concepts
2. Our logical model

We will focus on the following target architecture for our setup, which you can check out in the [IG]():

![file](diagrams/out/hie-setup-overview.png)
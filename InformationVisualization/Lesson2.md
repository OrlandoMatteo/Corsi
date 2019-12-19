# Lesson 2 (WHY+HOW)

- [Lesson 2 (WHY+HOW)](#lesson-2-whyhow)
  - [Why analyze data abstractly](#why-analyze-data-abstractly)
    - [Actions](#actions)
      - [Analyze](#analyze)
        - [Consume](#consume)
          - [Discover](#discover)
          - [Present](#present)
          - [Enjoy](#enjoy)
        - [Produce](#produce)
          - [Annotate](#annotate)
          - [Record](#record)
          - [Derive](#derive)
      - [Search](#search)
      - [Query](#query)
        - [Identify](#identify)
        - [Compare](#compare)
        - [Summarize](#summarize)
    - [Targets](#targets)
      - [All data](#all-data)
      - [Attributes](#attributes)
      - [Network data](#network-data)
  - [HOW](#how)
    - [First example (Comparative analysis)](#first-example-comparative-analysis)
    - [Second example (Deriving one attribute)](#second-example-deriving-one-attribute)
    - [Third example (derive multiple attributes)](#third-example-derive-multiple-attributes)

## Why analyze data abstractly

Astracting the task helps us to find similarities and diffferences among various fileds and problem. We can see the "why" as the task we've to perform. Verbs describes actions, nouns describes targets.  
Sometimes if the goals are complex we may need to chain a sequence of task to reach them, in these way we ca also better undertand if our data needs to be transformed to derive new one for the visualization.
Both the designer and the end user can make design choices that affects which tools we need to use for visualization: **specific** vs. **general**

### Actions

User goals are described in terms of actions. A task can be of 3 level:

- High evel: **analyze** the data
- Mid Level: **search** the data without knowing may be unknonw
- Low level :**query**

#### Analyze

We can bot consume information already collected or produce new material,data

##### Consume

We can discover something new, understand better something; present something already understood to third party; enjoy a visualization to attract someone to that topic

###### Discover

Use to generate hypotesis and veryfy existing one

###### Present

Use visualization to communicate information ina syntetic way, means vary according to different parameters: audience, live/offline, static/animate.

###### Enjoy

Curiosity to show results, infographics etc.

##### Produce

###### Annotate

Add information to graphical or textual information

###### Record

Save visualization element as existing artifacts

###### Derive

Get new information from already existing data. That is a critical part od the visualization design process: in some cases data cannot be used as they are but needs some transformation. We can either derive new attributes or transform the type of data. Transfomation can be used to find better encoding for the visualization.

#### Search

ALl the analyze case we just saw needs seach for element of interest, search is classified in four alternatives for each combination of identity/location and if they are known/unknown.

- **Lookup** Target and location are known
- **Locate** Target known but location unknonwn
- **Browsing** Target unknow but location unknown
- **Explore** Target and location unknown

#### Query

##### Identify

Single target scope, a search return a target or a list of them and we want to see their characteristics

##### Compare

We may need to highlight the differencecs among different elements

##### Summarize

We may need to see an overview of all the possible targets

### Targets

#### All data

There are three high level targets we can find in our data

- **Trends**, pattern of the data collection
- **Outliers**, element with strange behaviours
- **Features**, exact definition of the data structure

#### Attributes

They are specufic properties that are visually encoded. We can find *indivudual values*, *extremes*, *distributions*.  
We can also analyze multiple attributes and see their *dependencies*, *correlations*, *similarities*

#### Network data

It's importatnt to understand the *topology*  (the structure on the interconnection), or a *path* (sequence of connection)

## HOW

We have different possibilities to encode the data for the visualization but we also need to undertand how the visualization can be mannipulated and how to partionion among views and how to filter and aggregate the data for the visualization

### First example (Comparative analysis)

Examine two different visualization tools to represent path for trees: SapceTree vs. TreeJuxtaposer  
There are elements of similarities buat also differences especiallly in the objective: selection vs. visibility

### Second example (Deriving one attribute)

Tree can be difficult to visualize, one way to summarize it is to calculate a new attribute that measure the **importance** of each node in the graph an use that as a filter. The derived attribute can be used both to enrich the visualization or also as a starting point for the final one.

### Third example (derive multiple attributes)

The operation mentioned before cahn be used to create multiple derive attributes


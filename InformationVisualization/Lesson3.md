# Lesson 3 (Marks and Channels)

## Intro

**Marks** are basic geometric elemtents that depict items or link while **Channels** control the appearance of a mark. The effectivity of the channels to encode the data depends on thair type

### Marks

They're basical element in a image they can be classsified accordig to the dimension they need to be shown: *point*, *line*, *area*, *volume*.

### Channels

A way to control the appeareance of marks is :

- **Position**
- **Color**
- **Shape**
- **Angle**
- **Size**
- **Motion and curvature**

Size and shape channels cannot be used with all the type of marks.

### Channels types

There are 2 main channel type.

-**Identity**, info about what it is and where it is
-**Magnitude**, how much of something there is

### Mark types

Can be either a *link* or a *node* , they can be used for connection or containments

## Using marks and channels

Not all the channels are equals, that is relate to human perception and cognitive processing, the same data represented in the same way can give different result

### Design principle

- **Expressiveness**  
 The visual encoding must express **all of** and **only** ht ein formation in the datasets. For exampleif we have unordered that we need to avoid to create the perception of order  
- **Effectiveness**  
The importance of an attribute should match the salience of the attribute

### Accuracy

The accuracy of the perception depends a lot on human perception.

### Discriminability

When encoding channels using a aprticualr visual channel we must be sure that the difference between the items are preceived correctly

### Separability

The visual channels cannot be treated as completely independend among them

### Poput

Many visual channels can provide *poput* to distinct particualr item among all the others

### Grouping

The effect of perceputal grouping can arise, we can use link marks like containment or connection. Other methods are using proximity or similarity

### Realtive vs absolute judgments

Human perception is done with relative judgments 

## Rules of thumbs

There are some guidelies that can be followed for visualization

- **No unjustified 3D**
- **No unjustified 2D**
- **Eyes beats memory (attention and short term memory have several limitations)**
- **Resolution over immersion**
- **Overview first, details on demand**
- **Resposiveness is required but interactivity has a cost**
- **Function first form next**

## Arrange

The **arrange** design choices covers all aspect.  
There are different design choices to arrange tabular data spatially

### Express

**Quantitative values**  
We can use space to express quantitative attributes: we use the spatial position to visually encode the data. We can use *glyphs* to show multiple attributes at once.

We can use different kind of plot :scatterplot, bar charts and so on , everything depends on the type of data we want to show and which aspect of them we want to enhance

#### One key charts

**StreamGraph**  
It shows the evolution of the stacked bars  
**Dot and line chart**  
It's like a scatterplot in which on eof the axix is a categorical attributes. Line chart is really useful to emphasise trends  

#### Two keys charts



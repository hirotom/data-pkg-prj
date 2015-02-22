---
title       : mtcars data analysis tool
subtitle    : Reproducible Pitch Presentation
author      : Hiroto Miyake
job         : Developing Data Products class project (Feb. 2015)
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

### Introduction

##### This presentation describes a Shiny app developed to help analyze the `mtcars` dataset in R.  

The app first loads the mtcars

```r
data(mtcars)
```

The app has 4 tabs to allow users to:

1. Perform simple exploratory analysis
2. Simulate MPG with a few parameters
3. View and download the mtcars raw dataset
4. View descriptions about the dataset

The Shiny app is available at: http://hmiyake.shinyapps.io/data-pkg-prj/

--- .class #id

### Exploratory Analysis

`Exploratory` tab allows users to make x-y plot on the fly by specifying the variables for each of the axis, along with the ability to specify variables to group by color and bubble size.

The available variables are shown below

```r
colnames(mtcars)
```

```
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"
```

---

### Simulate MPG

`Simulate MPG` tab allows users to specify predictor variables using widgets on the left panel.  A multivariable regression model was used to predict mpg from 4 of the predictor variables (cyl, wt, am, and hp).  The 4 variables were selected following regression model refinement prior to this deployment of Shiny app.

The main panel describes the model, and result, and the detailed contributions from each of the parameters the users have selected.

---

### Raw Data

`Raw Data` tab allows users to view and download the raw data.

The download button on the left panel allows users to download the raw data in CSV format.

The main panel allows users view the data, along with option to filter the data by each of the columns at the bottom.


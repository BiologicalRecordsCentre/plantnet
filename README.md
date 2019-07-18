---
title: "Introduction to plantnet R-package"
author: "Tom August"
date: "18 July, 2019"
output: 
  html_document: 
    keep_md: yes
---



## PlantNet

The R-package interfaces with the PlantNet image classification API. This API is designed to recieve images and return species classifications. You can find out more about the PlantNet project here: https://plantnet.org. To use the API you need to have registered an account and generated an API key. All this can be done here: https://my.plantnet.org/.

## Install the package

To install the development version of this package from Github use this code.


```r
# Install using the devtools package
devtools::install_github(repo = 'BiologicalRecordsCentre/plantnet')
```

```r
library(plantnet)
```

```
## 
## Attaching package: 'plantnet'
```

```
## The following object is masked from 'package:graphics':
## 
##     identify
```

## Using the package to classify images

The images that you want to classify need to have URLs. If the images you have are not online you will need to put them online and then copy all of the URLs. The other information you need is your API key. You can create this after registering here:  https://my.plantnet.org/.

With these we can do a single image classification like this. Here we use this photo of a lavendar

<center><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Single_lavendar_flower02.jpg/800px-Single_lavendar_flower02.jpg"></center>


```r
# Get your key from https://my.plantnet.org/
key <- "YOUR_SUPER_SECRET_KEY"
```

```r
# Get the URL for your image
imageURL <- 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Single_lavendar_flower02.jpg/800px-Single_lavendar_flower02.jpg'
```

```r
classifications <- identify(key, imageURL)
classifications
```

```
##       score     latin_name                 common_name         
##  [1,] 35.92154  "Lavandula dentata"        "French lavender"   
##  [2,] 31.78688  "Lavandula angustifolia"   "Lavender"          
##  [3,] 18.06659  "Lavandula stoechas"       "Topped lavender"   
##  [4,] 6.717049  "Lavandula latifolia"      "Broadleaf lavender"
##  [5,] 1.665378  "Perovskia atriplicifolia" "Russian-sage"      
##  [6,] 1.022022  "Lavandula pinnata"        NA                  
##  [7,] 0.5533172 "Vitex agnus-castus"       "Chasteberry"       
##  [8,] 0.5320209 "Salvia farinacea"         "Mealy sage"        
##  [9,] 0.485067  "Lavandula multifida"      "Fern-leaf lavender"
## [10,] 0.3812005 "Lavandula canariensis"    NA                  
## [11,] 0.2864826 "Nepeta tuberosa"          NA                  
## [12,] 0.1719182 "Lavandula minutolii"      NA                  
## [13,] 0.1427725 "Perovskia abrotanoides"   "Russian Sage"
```

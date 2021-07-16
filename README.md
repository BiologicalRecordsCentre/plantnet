  <!-- badges: start -->
  [![Travis build status](https://travis-ci.org/BiologicalRecordsCentre/plantnet.svg?branch=master)](https://travis-ci.org/BiologicalRecordsCentre/plantnet)
  [![Codecov test coverage](https://codecov.io/gh/BiologicalRecordsCentre/plantnet/branch/master/graph/badge.svg)](https://codecov.io/gh/BiologicalRecordsCentre/plantnet?branch=master)
  [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/BiologicalRecordsCentre/plantnet?branch=master&svg=true)](https://ci.appveyor.com/project/BiologicalRecordsCentre/plantnet)
  <!-- badges: end -->

# PlantNet

### Developed by Tom August
last built 2019-07-23

The R-package interfaces with the PlantNet image classification API. This API is designed to receive images and return species classifications. You can find out more about the PlantNet project here: https://plantnet.org. To use the API you need to have registered an account and generated an API key. All this can be done here: https://my.plantnet.org/.

## Install the package

To install the development version of this package from Github use this code.


```r
# Install using the devtools package
devtools::install_github(repo = 'BiologicalRecordsCentre/plantnet')
```

```r
library(plantnet)
```

## Using the package to classify images

The images that you want to classify need to have URLs. If the images you have are not online you will need to put them online and then copy all of the URLs. The other information you need is your API key. You can create this after registering here:  https://my.plantnet.org/.

### Single image

With these we can do a single image classification like this. Here we use this photo of a lavender
 
<center><img style="max-width: 450px" src="https://warehouse1.indicia.org.uk/upload/o_1ebgpgv221el21b8b1v1b10mgi5je.jpg"></center>
<br> 

```r
# Get your key from https://my.plantnet.org/
key <- "YOUR_SUPER_SECRET_KEY"
```

```r
# Get the URL for your image
imageURL <- 'https://warehouse1.indicia.org.uk/upload/o_1ebgpgv221el21b8b1v1b10mgi5je.jpg'
```

```r
classifications <- identify(key, imageURL)
classifications
```

```
##       score  latin_name               common_name         
##  [1,] 94.981 "Lavandula angustifolia" "Lavender"          
##  [2,] 2.978  "Lavandula latifolia"    "Broadleaf lavender"
##  [3,] 0.797  "Lavandula × intermedia" "Dutch lavender"
```

You can see in the the table returned there are three columns returned. The first gives you a score, this is the likelihood that the species in this row is the correct classification for the image you provided. As you can see in this instance there is a clear winner. The second column gives the Latin names as binomials, and the final column gives the most commonly used common name for the species.

If you want more information, such as a list of all of the common names for each classification, or the full Latin name including authors, you can access all of this information by using `simplify = FALSE`.


```r
classifications <- identify(key, imageURL, simplify = FALSE)
str(classifications,1)
```

```
## List of 4
##  $ query              :List of 3
##  $ language           : chr "en"
##  $ preferedReferential: chr "the-plant-list"
##  $ results            :List of 3
```

The top elements give some information about the call we made to the API, but the results contains what we are usually after. Results has one entry for each species classification, or each row in the table we saw above. Let's look at one.


```r
classifications$results[[1]]
```

```
## $score
## [1] 94.981
## 
## $species
## $species$scientificNameWithoutAuthor
## [1] "Lavandula angustifolia"
## 
## $species$scientificNameAuthorship
## [1] "Mill."
## 
## $species$genus
## $species$genus$scientificNameWithoutAuthor
## [1] "Lavandula"
## 
## $species$genus$scientificNameAuthorship
## [1] ""
## 
## $species$genus$scientificName
## [1] "Lavandula"
## 
## 
## $species$family
## $species$family$scientificNameWithoutAuthor
## [1] "Lamiaceae"
## 
## $species$family$scientificNameAuthorship
## [1] ""
## 
## $species$family$scientificName
## [1] "Lamiaceae"
## 
## 
## $species$commonNames
## $species$commonNames[[1]]
## [1] "Lavender"
## 
## $species$commonNames[[2]]
## [1] "English lavender"
## 
## $species$commonNames[[3]]
## [1] "Common lavender"
## 
## 
## $species$scientificName
## [1] "Lavandula angustifolia Mill."
## 
## 
## $gbif
## $gbif$id
## [1] "2927305"
```

Here we have information on the Latin name, authors, and at the end, a list of the common names.

### Multiple images

You can get a better identification if you provide more than one image of the plant, and of multiple organs of the plant. The organs that PlantNet considers are: leaf, flower, fruit, bark. You can also take images classed as habit (the overall form of the plant), or other, but you can only have an image labeled as one of these if you also have an image labeled as one of the primary organs (i.e. leaf, flower, fruit, bark).

In this example we are going to use three images of Quercus robur from the Encyclopedia of Life.

<center><img style="max-width: 450px" src="https://content.eol.org/data/media/55/2c/a8/509.1003460.jpg"></center>
<br> 
<center><img style="max-width: 450px" src="https://content.eol.org/data/media/89/88/4c/549.BI-image-16054.jpg"></center>
<br> 
<center><img style="max-width: 450px" src="https://content.eol.org/data/media/8a/77/9b/549.BI-image-76488.jpg"></center>
<br> 

```r
# We can search using up to five images
# Here are three picture of Quercus robur
imageURL1 <- 'https://content.eol.org/data/media/55/2c/a8/509.1003460.jpg'
imageURL2 <- 'https://content.eol.org/data/media/89/88/4c/549.BI-image-16054.jpg'
imageURL3 <- 'https://content.eol.org/data/media/8a/77/9b/549.BI-image-76488.jpg'

identify(key, imageURL = c(imageURL1, imageURL2, imageURL3))
```

```
##      score    latin_name           common_name      
## [1,] 68.28053 "Quercus robur"      "Pedunculate oak"
## [2,] 28.3852  "Terminalia catappa" "Indian-almond"  
## [3,] 19.02534 "Quercus petraea"    "Sessile oak"
```
In this case all three images have been used to arrive at one classification. Here we get a few species suggested but the top species is correct, and has a significantly higher score than the second species. In this example we have not told the API what the organs are. The API can use this information to help give a better classification.


```r
# This time I specify the organs in each image
identify(key,
         imageURL = c(imageURL1, imageURL2, imageURL3),
         organs = c('habit','bark','fruit'))
```

```
##      score    latin_name           common_name      
## [1,] 68.28053 "Quercus robur"      "Pedunculate oak"
## [2,] 19.02534 "Quercus petraea"    "Sessile oak"    
## [3,] 18.92347 "Terminalia catappa" "Indian-almond"
```

Notice that now the API knows which organs each image is of, we get slightly different results, the top species is the same but we can have higher confidence that this is the correct answer because the distance between the score of the first and second image is larger than before.

#' Identify plants
#'
#' This function is used to classify images using the PlantNet API.
#'
#' @param key character, your API key (get from https://my.plantnet.org/)
#' @param imageURL character, the URL path top the image you want to identify.
#' You can provide up to 5 images as a vector of URLs. These images must be
#' of the SAME plant. Make sure this URL is correct, if it is wrong and does
#' note link to your image, or if the link cannot be accessed from the API
#' because, for example, a login is needed, you will get a 'Species not found'
#' error.
#' @param simplify logical, if `TRUE` the output will be simplified into a
#' data.frame
#' @param organs character, the organ in the image. Must be one of,
#' leaf, flower, fruit, or bark. Must be the same length as `imageURL`.
#' You can also use the tags habit (the overall form of the plant), or other,
#' but you can only have an image labelled as one of these if you also have
#' an image labelled as one of the primay organs (i.e. leaf, flower, fruit, bark).
#' @param lang can be one of 'en' (English), 'fr' (French), 'de' (German)
#' @details The function uses the PlantNet API. To use this service you need
#' to have registered an account and generated an API key. All this can be
#' done here: https://my.plantnet.org/.
#' @return If `simplify` is set to `FALSE` then a list is returned. The
#' structure of this list can be explored using hte tool at
#' https://my-api.plantnet.org. If `simplify` is set to `TRUE` (default)
#' then a data.frame is with three columns for the score, latin name,
#' and common name. There are as many rows as there are species predictions
#' from the API.
#' @import httr
#' @export
#' @examples
#' \dontrun{
#' # Get your key from https://my.plantnet.org/
#' key <- "YOUR_SUPER_SECRET_KEY"
#' imageURL <- 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Single_lavendar_flower02.jpg/800px-Single_lavendar_flower02.jpg'
#'
#' # A simple search with one image
#' classifications <- identify(key, imageURL)
#' classifications
#'
#' # Turning simplify to FALSE you can get more infomation
#' classifications <- identify(key, imageURL, simplify = FALSE)
#' str(classifications,1)
#' classifications$results[[1]]
#'
#' # We can search using up to five images
#' # Here are three picture of Quercus robur
#' imageURL1 <- 'https://content.eol.org/data/media/55/2c/a8/509.1003460.jpg'
#' imageURL2 <- 'https://content.eol.org/data/media/89/88/4c/549.BI-image-16054.jpg'
#' imageURL3 <- 'https://content.eol.org/data/media/8a/77/9b/549.BI-image-76488.jpg'
#'
#' classifications <- identify(key, imageURL = c(imageURL1, imageURL2, imageURL3))
#' classifications
#'
#' # The classification is better if we assign an organ to each image
#' classifications <- identify(key,
#'                             imageURL = c(imageURL1, imageURL2, imageURL3),
#'                             organs = c('habit','bark','fruit'))
#' classifications
#'}

identify <- function(key, imageURL, simplify = TRUE,
                     organs = rep('leaf', length(imageURL)), lang = 'en'){

  if(!is.character(key)) stop('key should be a character')
  if(!is.character(imageURL)) stop('image should be a character')

  URL <- buildURL(key = key, imageURL = imageURL, organs = organs, lang = lang)

  # Hit the API
  response <- httr::GET(URL)

  # Check the status
  status <- response$status_code

  # If the status is not 200 return a warning and return the
  # error as a string
  if(status != 200){

    HTTPerror <- HTTPstatus(status)
    warning(HTTPerror$warning)
    return(HTTPerror$rtn)

  }

  # the status is 200 so let's parse the content of the response
  prediction <- httr::content(response, as = 'parsed')

  # Simplify to a table if needed
  if(simplify){

    simp <- lapply(prediction$results,
                   FUN = simplifyPN)

    return(do.call(rbind, simp))

  }

  return(prediction)

}

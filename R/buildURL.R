#' API URL builder
#'
#' This function builds a URL for the PlantNet API using the various
#' elements required.
#'
#' @param key character, your API key (get from my-api.plantnet.org)
#' @param imageURL character, the URL path top the image you want to identify
#' @param organs character, the organ in the image. Must be one of,
#' leaf, flower, fruit, or bark. Currently this does not effect the result.
#' You can also use the tags habit (the overall form of the plant), or other,
#' but you can only have an image labelled as one of these if you also have
#' an image labelled as one of the primay organs (i.e. leaf, flower, fruit, bark).
#' @param lang can be one of 'en' (English), 'fr' (French), 'de' (German)
#' @return The URL required, as a character of length 1
#' @importFrom utils URLencode
#' @export

buildURL <- function(key, imageURL, organs = 'leaf', lang = 'en'){

  if(length(imageURL) != length(organs)){
    stop('imageURL and organs must be the same length')
  }

  if(!all(organs %in% c('flower','leaf','fruit','bark','habit','other'))){
    stop("The only allowed values of organs are 'flower','leaf','fruit','bark','habit','other'")
  }

  if(!any(organs %in% c('flower','leaf','fruit','bark'))){
    stop("At leaset one image must be tagged as 'flower','leaf','fruit','bark'")
  }

  if(length(lang) > 1){
    stop("lang must have length 1. You cannot use more than one language at the same time")
  }

  if(!lang %in% c('en', 'fr', 'de')){
    stop("lang must be one of 'en', 'fr', 'de'")
  }

  URLencoded <- sapply(imageURL, FUN = URLencode, reserved = TRUE, repeated = TRUE)

  paste0("https://my-api.plantnet.org/v1/identify/all?",
         "images=", paste(URLencoded, collapse = "&images="),
         "&organs=", paste(organs, collapse = "&organs="),
         "&lang=", lang,
         "&api-key=", key)

}

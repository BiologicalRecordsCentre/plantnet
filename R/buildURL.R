#' API URL builder
#'
#' This function builds a URL for the PlantNet API using the various
#' elements required.
#'
#' @param key character, your API key (get from my-api.plantnet.org)
#' @param imageURL character, the URL path top the image you want to identify
#' @param organs character, the organ in the image. Must be one of,
#' auto, leaf, flower, fruit, or bark. Currently this does not effect the result.
#' You can also use the tags habit (the overall form of the plant), or other,
#' but you can only have an image labelled as one of these if you also have
#' an image labelled as one of the primary organs (i.e. auto, leaf, flower, fruit, bark).
#' @param lang can be one of 'en' (English), 'fr' (French), 'de' (German)
#' @param no_reject character, can be one of 'true' or 'false' (default), 
#' if 'true' 'no results' are disabled in case of reject class match
#' @return The URL required, as a character of length 1
#' @importFrom utils URLencode
#' @export

buildURL <- function(key, imageURL, organs = 'auto', 
                     lang = 'en', no_reject = 'false'){

  if(length(imageURL) != length(organs)){
    stop('imageURL and organs must be the same length')
  }

  if(!all(organs %in% c('auto', 'flower','leaf','fruit','bark','habit','other'))){
    stop("The only allowed values of organs are 'auto', 'flower','leaf','fruit','bark','habit','other'")
  }

  if(!any(organs %in% c('auto', 'flower','leaf','fruit','bark'))){
    stop("At leaset one image must be tagged as 'auto', 'flower','leaf','fruit','bark'")
  }

  if(length(lang) > 1){
    stop("lang must have length 1. You cannot use more than one language at the same time")
  }

  if(!lang %in% c('en', 'fr', 'de')){
    stop("lang must be one of 'en', 'fr', 'de'")
  }
  
  if(!no_reject %in% c('true','false'))
    stop("no_reject must be one of 'true' or 'false'(default)")
  
  URLencoded <- sapply(imageURL, FUN = URLencode, reserved = TRUE, repeated = TRUE)

  url_string <- paste0("https://my-api.plantnet.org/v2/identify/all?",
                       "images=", paste(URLencoded, collapse = "&images="),
                       "&organs=", paste(organs, collapse = "&organs="),
                       "&no-reject=", no_reject,
                       "&lang=", lang,
                       "&api-key=", key)

  print(url_string)
  return(url_string)

  }

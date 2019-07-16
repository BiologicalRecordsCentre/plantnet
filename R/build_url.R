#' API URL builder
#'
#' This function builds a URL for the PlantNet API using the various
#' elements required.
#'
#' @param key character, your API key (get from my-api.plantnet.org)
#' @param imageURL character, the URL path top the image you want to identify
#' @param organs character, the organ in the image. Must be one of,
#' leaf, flower, fruit, or bark. Currently this does not effect the result.
#' @param lang can be one of 'en' (English), 'fr' (French), 'de' (German)
#' @return The URL required, as a character of length 1
#' @export

build_url <- function(key, imageURL, organs = 'leaf', lang = 'en'){

  paste0("https://my-api.plantnet.org/v1/identify/all?",
         "images=", URLencode(imageURL, reserved = TRUE, repeated = TRUE),
         "&organs=", organs,
         "&lang=", lang,
         "&api-key=", key)

}

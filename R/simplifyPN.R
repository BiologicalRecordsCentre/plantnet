#' Simplify PlantNet response
#'
#' This function is used to simplify the response from the PlantNet
#' API into a simple table of the important data that a user is
#' most likely to want.
#'
#' @param sp a single element from the response 'results' section
#' @return A data.frame with three columns for the score, latin name,
#' and common name. There are as many rows as there are species predictions
#' from the API
#' @export

simplifyPN <- function(sp){

  score = sp$score
  latin_name = sp$species$scientificNameWithoutAuthor
  common_name = sp$species$commonNames[[1]]

  return(list(score = score,
              latin_name = latin_name,
              common_name = common_name))

}

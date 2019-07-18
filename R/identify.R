#' HTTP status handler
#'
#' This function interprets the meaning of the HTTP status and returns
#' the elements needed to create an appropriate warning and return
#' something meaningful to the user.
#'
#' @param key character, your API key (get from https://my.plantnet.org/)
#' @param imageURL character, the URL path top the image you want to identify
#' @param simplify logical, if `TRUE` the output will be simplified into a
#' data.frame
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

identify <- function(key, imageURL, simplify = TRUE){

  if(!is.character(key)) stop('key should be a character')
  if(!is.character(imageURL)) stop('image should be a character')

  URL <- build_url(key = key, imageURL = imageURL)

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

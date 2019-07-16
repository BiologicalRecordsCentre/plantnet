#' HTTP status handler
#'
#' This function interprets the meaning of the HTTP status and returns
#' the elements needed to create an appropriate warning and return
#' something meaningful to the user.
#'
#' @param status numeric, the error status
#' @details Code 200 should not be sent to this function as this
#' is only designed to handle the errors (>=400)
#' @return A list of two elements. `warning` is used to create a
#' warning message and `rtn` will be used to return to the user.
#' @examples
#' HTTPstatus(400)
#' @export

HTTPstatus <- function(status){

  if(status == 200) stop('200 status should not come to this function')

  if(status == 400){

    warning <- 'Pl@ntNet returned: Bad request'
    rtn <- 'Bad request'

  } else if(status == 401){

    warning <- 'Pl@ntNet returned: Unauthorized'
    rtn <- 'Unauthorized'

  } else if(status == 404){

    warning <- 'Pl@ntNet returned: Species Not Found'
    rtn <- 'Species Not Found'

  } else if(status == 429){

    warning <- 'Pl@ntNet returned: Too Many Requests'
    rtn <- 'Too Many Requests'

  } else if(status == 500){

    warning <- 'Pl@ntNet returned: Internal Server Error'
    rtn <- 'Internal Server Error'

  } else {

    warning <- paste('Pl@ntNet returned: Unknown error -', status)
    rtn <- paste('Unknown error -', status)

  }

  return(list(warning = warning, rtn = rtn))

}

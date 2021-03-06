% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/buildURL.R
\name{buildURL}
\alias{buildURL}
\title{API URL builder}
\usage{
buildURL(key, imageURL, organs = "leaf", lang = "en")
}
\arguments{
\item{key}{character, your API key (get from my-api.plantnet.org)}

\item{imageURL}{character, the URL path top the image you want to identify}

\item{organs}{character, the organ in the image. Must be one of,
leaf, flower, fruit, or bark. Currently this does not effect the result.
You can also use the tags habit (the overall form of the plant), or other,
but you can only have an image labelled as one of these if you also have
an image labelled as one of the primay organs (i.e. leaf, flower, fruit, bark).}

\item{lang}{can be one of 'en' (English), 'fr' (French), 'de' (German)}
}
\value{
The URL required, as a character of length 1
}
\description{
This function builds a URL for the PlantNet API using the various
elements required.
}

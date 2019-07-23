context("Build URL from parameters")

key <- 'MYKEY'
imageURL <- 'IMAGEURL'
lang <- 'en'
organs <- 'flower'

test_that("test warnings and errors", {

  expect_error(buildURL(key = key,
                        imageURL = imageURL,
                        organs = organs,
                        lang = 'es'),
               "lang must be one of 'en', 'fr', 'de'")
  expect_error(buildURL(key = key,
                        imageURL = imageURL,
                        organs = organs,
                        lang = c('en', 'de')),
               "lang must have length 1. You cannot use more than one language at the same time")
  expect_error(buildURL(key = key,
                        imageURL = imageURL,
                        organs = 'head',
                        lang = lang),
               "The only allowed values of organs are 'flower','leaf','fruit','bark','habit','other'")
  expect_error(buildURL(key = key,
                        imageURL = imageURL,
                        organs = c('flower', 'flower'),
                        lang = lang),
               "imageURL and organs must be the same length")
  expect_error(buildURL(key = key,
                        imageURL = imageURL,
                        organs = c('habit'),
                        lang = lang),
               "At leaset one image must be tagged as 'flower','leaf','fruit','bark'")
  expect_error(buildURL(key = key,
                        imageURL = c(imageURL, imageURL),
                        organs = organs,
                        lang = lang),
               "imageURL and organs must be the same length")

})

test_that("test built URL is as expected", {

  tested <- buildURL(key = key,
                     imageURL = c(imageURL, imageURL),
                     organs = c(organs, organs),
                     lang = lang)
  expected <- "https://my-api.plantnet.org/v1/identify/all?images=IMAGEURL&images=IMAGEURL&organs=flower&organs=flower&lang=en&api-key=MYKEY"
  expect_equal(tested, expected)

})

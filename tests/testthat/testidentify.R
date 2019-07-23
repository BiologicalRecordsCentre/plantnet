# Our testing is a bit limited here as we cannot do
# "real" tests on travis, only on my local machine
# if testing on a local machine you need to have your key
# saved as an object 'key' in the file 'key.rdata' in the
# root of the package. Make sure you add this file to the
# git ignore and build ignore files

context("Test identify queries")

imageURL <- 'https://content.eol.org/data/media/8a/77/9b/549.BI-image-76488.jpg'
lang <- 'en'
organs <- 'flower'

test_that("test with bad key", {

  # This can be run on Travis and Cran and will
  # indecate is the API is down
  skip_if_offline()
  expect_warning(identify(key = 'notmykey', imageURL = imageURL),
                 'Pl@ntNet returned: Unauthorized')

})

test_that("test with real key", {

  skip_on_cran()
  skip_on_travis()
  skip_if_offline()
  skip_if(!file.exists('key.rdata'),
          message = 'No local key file found ("key.rdata"), so identification test is skipped')
  load('key.rdata')
  classification <- identify(key = key, imageURL = imageURL)
  expect_is(classification, 'matrix')
  expect_equal(colnames(classification), c("score", "latin_name", "common_name"))

})

context("HTTP statuses")
library(plantnet)

test_that("test all expected statuses", {

  expect_error(HTTPstatus(200))

  expect_equal(HTTPstatus(400)$warning,
               'Pl@ntNet returned: Bad request')

  expect_equal(HTTPstatus(401)$warning,
               'Pl@ntNet returned: Unauthorized')

  expect_equal(HTTPstatus(404)$warning,
               'Pl@ntNet returned: Species Not Found')

  expect_equal(HTTPstatus(414)$warning,
               'Pl@ntNet returned: URI Too Long')

  expect_equal(HTTPstatus(429)$warning,
               'Pl@ntNet returned: Too Many Requests')

  expect_equal(HTTPstatus(500)$warning,
               'Pl@ntNet returned: Internal Server Error')
})

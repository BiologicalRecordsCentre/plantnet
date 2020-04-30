context("Simplify return from the API")
library(plantnet)

# This is an example of unsimplified output

unformatted <- list(query = list(project = "all", images = list("https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Single_lavendar_flower02.jpg/800px-Single_lavendar_flower02.jpg"),
                  organs = list("leaf")), language = "en", preferedReferential = "florefrance",
     results = list(list(score = 35.9215393066406, species = list(
       scientificNameWithoutAuthor = "Lavandula dentata", scientificNameAuthorship = "L.",
       genus = list(scientificNameWithoutAuthor = "Lavandula",
                    scientificNameAuthorship = "L."), family = list(scientificNameWithoutAuthor = "Lamiaceae",
                                                                    scientificNameAuthorship = ""), commonNames = list(
                                                                      "French lavender", "Spanish Lavender"))), list(score = 31.7868804931641,
                                                                                                                     species = list(scientificNameWithoutAuthor = "Lavandula angustifolia",
                                                                                                                                    scientificNameAuthorship = "Mill.", genus = list(
                                                                                                                                      scientificNameWithoutAuthor = "Lavandula", scientificNameAuthorship = "L."),
                                                                                                                                    family = list(scientificNameWithoutAuthor = "Lamiaceae",
                                                                                                                                                  scientificNameAuthorship = ""), commonNames = list(
                                                                                                                                                    "Lavender", "English lavender", "Bastard Lavender",
                                                                                                                                                    "Common lavender", "English lavendar", "Garden Lavender",
                                                                                                                                                    "Hidcote Lavender", "Jean Davis Lavender", "Lady Lavender",
                                                                                                                                                    "Munstead Lavender", "Rosea Lavender", "True Lavender",
                                                                                                                                                    "Twickle Purple Lavender"))), list(score = 18.066593170166,
                                                                                                                                                                                       species = list(scientificNameWithoutAuthor = "Lavandula stoechas",
                                                                                                                                                                                                      scientificNameAuthorship = "L.", genus = list(scientificNameWithoutAuthor = "Lavandula",
                                                                                                                                                                                                                                                    scientificNameAuthorship = "L."), family = list(
                                                                                                                                                                                                                                                      scientificNameWithoutAuthor = "Lamiaceae", scientificNameAuthorship = ""),
                                                                                                                                                                                                      commonNames = list("Topped lavender", "French lavender",
                                                                                                                                                                                                                         "Spanish lavender", "Italian lavender", "Wild lavender",
                                                                                                                                                                                                                         "Italain Lavender"))), list(score = 6.71704864501953,
                                                                                                                                                                                                                                                     species = list(scientificNameWithoutAuthor = "Lavandula latifolia",
                                                                                                                                                                                                                                                                    scientificNameAuthorship = "Medik.", genus = list(
                                                                                                                                                                                                                                                                      scientificNameWithoutAuthor = "Lavandula", scientificNameAuthorship = "L."),
                                                                                                                                                                                                                                                                    family = list(scientificNameWithoutAuthor = "Lamiaceae",
                                                                                                                                                                                                                                                                                  scientificNameAuthorship = ""), commonNames = list(
                                                                                                                                                                                                                                                                                    "Broadleaf lavender", "Spike lavender", "Broadleaved lavender",
                                                                                                                                                                                                                                                                                    "Spike lavendar"))), list(score = 1.66537761688232,
                                                                                                                                                                                                                                                                                                              species = list(scientificNameWithoutAuthor = "Perovskia atriplicifolia",
                                                                                                                                                                                                                                                                                                                             scientificNameAuthorship = "Benth.", genus = list(
                                                                                                                                                                                                                                                                                                                               scientificNameWithoutAuthor = "Perovskia", scientificNameAuthorship = ""),
                                                                                                                                                                                                                                                                                                                             family = list(scientificNameWithoutAuthor = "Lamiaceae",
                                                                                                                                                                                                                                                                                                                                           scientificNameAuthorship = ""), commonNames = list(
                                                                                                                                                                                                                                                                                                                                             "Russian-sage", "Russian Sage"))), list(score = 1.02202153205872,
                                                                                                                                                                                                                                                                                                                                                                                     species = list(scientificNameWithoutAuthor = "Lavandula pinnata",
                                                                                                                                                                                                                                                                                                                                                                                                    scientificNameAuthorship = "Moench", genus = list(
                                                                                                                                                                                                                                                                                                                                                                                                      scientificNameWithoutAuthor = "Lavandula", scientificNameAuthorship = "L."),
                                                                                                                                                                                                                                                                                                                                                                                                    family = list(scientificNameWithoutAuthor = "Lamiaceae",
                                                                                                                                                                                                                                                                                                                                                                                                                  scientificNameAuthorship = ""), commonNames = list())),
       list(score = 0.553317248821259, species = list(scientificNameWithoutAuthor = "Vitex agnus-castus",
                                                      scientificNameAuthorship = "L.", genus = list(scientificNameWithoutAuthor = "Vitex",
                                                                                                    scientificNameAuthorship = "L."), family = list(
                                                                                                      scientificNameWithoutAuthor = "Lamiaceae", scientificNameAuthorship = "Martinov"),
                                                      commonNames = list("Chasteberry", "Chastetree", "Chaste tree",
                                                                         "Abraham's balm", "Agnus castus", "Hemptree",
                                                                         "Monks' Pepper Tree", "Lilac chastetree", "Vitex"))),
       list(score = 0.532020926475525, species = list(scientificNameWithoutAuthor = "Salvia farinacea",
                                                      scientificNameAuthorship = "Benth.", genus = list(
                                                        scientificNameWithoutAuthor = "Salvia", scientificNameAuthorship = "L."),
                                                      family = list(scientificNameWithoutAuthor = "Lamiaceae",
                                                                    scientificNameAuthorship = ""), commonNames = list(
                                                                      "Mealy sage", "Mealy-cup sage", "Blue sage",
                                                                      "Mealycup sage", "Mealy Cup Sage"))), list(score = 0.48506698012352,
                                                                                                                 species = list(scientificNameWithoutAuthor = "Lavandula multifida",
                                                                                                                                scientificNameAuthorship = "L.", genus = list(
                                                                                                                                  scientificNameWithoutAuthor = "Lavandula",
                                                                                                                                  scientificNameAuthorship = "L."), family = list(
                                                                                                                                    scientificNameWithoutAuthor = "Lamiaceae",
                                                                                                                                    scientificNameAuthorship = ""), commonNames = list(
                                                                                                                                      "Fern-leaf lavender", "Cut-leaf lavender",
                                                                                                                                      "Downy lavender", "French Lace Lavender"))),
       list(score = 0.381200522184372, species = list(scientificNameWithoutAuthor = "Lavandula canariensis",
                                                      scientificNameAuthorship = "Mill.", genus = list(
                                                        scientificNameWithoutAuthor = "Lavandula", scientificNameAuthorship = "L."),
                                                      family = list(scientificNameWithoutAuthor = "Lamiaceae",
                                                                    scientificNameAuthorship = ""), commonNames = list())),
       list(score = 0.286482572555542, species = list(scientificNameWithoutAuthor = "Nepeta tuberosa",
                                                      scientificNameAuthorship = "L.", genus = list(scientificNameWithoutAuthor = "Nepeta",
                                                                                                    scientificNameAuthorship = "L."), family = list(
                                                                                                      scientificNameWithoutAuthor = "Lamiaceae", scientificNameAuthorship = ""),
                                                      commonNames = list())), list(score = 0.17191818356514,
                                                                                   species = list(scientificNameWithoutAuthor = "Lavandula minutolii",
                                                                                                  scientificNameAuthorship = "Bolle", genus = list(
                                                                                                    scientificNameWithoutAuthor = "Lavandula",
                                                                                                    scientificNameAuthorship = "L."), family = list(
                                                                                                      scientificNameWithoutAuthor = "Lamiaceae",
                                                                                                      scientificNameAuthorship = ""), commonNames = list())),
       list(score = 0.142772525548935, species = list(scientificNameWithoutAuthor = "Perovskia abrotanoides",
                                                      scientificNameAuthorship = "Kar.", genus = list(scientificNameWithoutAuthor = "Perovskia",
                                                                                                      scientificNameAuthorship = ""), family = list(
                                                                                                        scientificNameWithoutAuthor = "Lamiaceae", scientificNameAuthorship = ""),
                                                      commonNames = list("Russian Sage")))))

test_that("test simplificaton has the expected result", {

  simp <- lapply(unformatted$results,
                 FUN = simplifyPN)

  expected <- do.call(rbind, simp)

  expect_true('matrix' %in% class(expected))
  expect_equal(colnames(expected), c("score", "latin_name", "common_name"))
  expect_equal(nrow(expected), 13)

})

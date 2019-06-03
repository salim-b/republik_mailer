source(file = knitr::purl(input = 'republik_mailer.Rmd',
                          output = tempfile(),
                          quiet = TRUE),
       encoding = 'UTF-8',
       echo = FALSE)

loop()

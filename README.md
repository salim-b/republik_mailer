# Republik Mailer

Send e-mails spreading recent articles from a certain format of the online newspaper [Republik](https://www.republik.ch/).

<!-- TOC BEGIN -- leave this comment untouched to allow auto update -->

## Table of contents

- [Requirements](#-requirements)
- [Setup](#-setup)
    - [R packages](#-r-packages)
    - [Config](#-config)
- [Customize the script](#-customize-the-script)
- [Run the script](#-run-the-script)
- [E-mail example](#-e-mail-example)

<!-- TOC END -- leave this comment untouched to allow auto update -->

## [🠅](#table-of-contents) Requirements

First of all: This script doesn't allow any unauthenticated access to the online newspaper. You have to be a (paying) [subscriber of Republik](https://www.republik.ch/angebote). This allows you to [log in to the site](https://www.republik.ch/anmelden) in order to have a session cookie created needed for authentication. This cookie is named `connect.sid` and it's recommended to set the `auth_cookie` key in [`config.toml`](#config) to the cookie's value (a cryptographic hash)[^reveal]. Alternatively you can provide the cookie's value directly to the `auth_cookie` argument of the function `get_latest_article_metadata()`.

In addition, the `from` sender address as well as the `to` receiver address and the `salutation`, `greetings` and `credits` for the e-mails being sent should be set in the [`config.toml` file](#config), which must be located in the working directory.


[^reveal]: How you access the locally stored cookies of a specific site in Google Chrome is described [here](https://developers.google.com/web/tools/chrome-devtools/storage/cookies), the same for Firefox [here](https://developer.mozilla.org/docs/Tools/Storage_Inspector).


## [🠅](#table-of-contents) Setup

### [🠅](#table-of-contents) R packages

To install the necessary R packages, run the following:

```r
install.packages(pkgs = c("checkmate",
                          "fs",
                          "glue",
                          "hms",
                          "httr",
                          "keyring",
                          "knitr",
                          "lubridate",
                          "magrittr",
                          "RcppTOML",
                          "remotes",
                          "rlang",
                          "rvest",
                          "tidyverse",
                          "xml2))
                          
remotes::install_github("rich-iannone/blastula")
```

### [🠅](#table-of-contents) Config

1. To create the necessary [TOML](https://github.com/toml-lang/toml#readme) config file, customize and run the following:

    ```r
    readr::write_lines(path = "config.toml",
                       x = c('from = "email@address.domain"',
                             'to = "email@address.domain"',
                             'salutation = "Ladies and gentleman"',
                             'greetings = "Einen schönen Tag wünscht  \\nSalims MailBot \U1F916"',
                             'credits = """Dies ist eine automatisch generierte Nachricht. \\
                             Der zugrundeliegende Code findet sich bei Interesse [hier](https://gitlab.com/salim-b/republik_mailer)."""',
                             'auth_cookie = "s%..."'))
    ```

2. To save your e-mail sender account credentials to file, [customize](https://rich-iannone.github.io/blastula/articles/sending_using_smtp.html#creating-a-credentials-file) and run the following:

    ```r
    blastula::create_email_creds_file(user = "******@address.suffix",
                                      password = "******",
                                      host = "smtp.address.suffix",
                                      port = 587L,
                                      sender = "Your Name (\U1F916)",
                                      use_ssl = FALSE,
                                      use_tls = TRUE,
                                      authenticate = TRUE,
                                      creds_file_name = ".mail_credentials")
    ```

## [🠅](#table-of-contents) Customize the script

It's recommended that you adapt the script to your needs before you run it, particularly customize [the existing functions to spread new articles](republik_mailer.Rmd#spread-new-articles) or create your own ones.

The unique identifier for an article is always its hyperlink (`href`).

The parameters `format` and `formats` of the functions `get_latest_article_metadata()`, `update_article_metadata()` and `spread_new_articles()` respectively can be set to any of the existing Republik formats, including:

- `7-uhr-newsletter`
- `am-gericht`
- `am-wegesrand`
- `an-die-verlagsetage`
- `alles-was-recht-ist`
- `auf-lange-sicht`
- `aus-der-arena`
- `aus-der-redaktion`
- `bergs-nerds`
- `binswanger`
- `blattkritik`
- `briefing-aus-bern`
- `buchclub`
- `ctrl-alt-r`
- `das-leben-spielt`
- `debatte`
- `eidgenoessische-randnotizen`
- `entwicklungslabor`
- `feuilleton-newsletter`
- `film`
- `fotobuch`
- `gedankensplitter`
- `genossenschaftsrat`
- `gift-und-galle`
- `helfen-sie-mit`
- `herd-und-hof`
- `klang`
- `kunst`
- `nahr`
- `operation-nabucco`
- `poesie-prosa`
- `preis-der-republik`
- `raumdeutung`
- `sehfeld`
- `theater`
- `theaterspektakel`
- `theorie-praxis`
- `was-diese-woche-wichtig-war`
- `was-kommt`
- `welt-in-serie`
- `wochenend-newsletter`

Besides, the function `spread_new_articles()` expects a `subject` string, an `intro` phrase and optionally an `image_url` for an embedded symbolic picture. If you want to spread only the very latest article of the chosen format, set `latest_one_only` to `TRUE`.

## [🠅](#table-of-contents) Run the script

To run the script from a shell:

```sh
Rscript --vanilla \
         -e "source(file = knitr::purl(input = 'republik_mailer.Rmd', \
                                       output = tempfile(), \
                                       quiet = TRUE), \
                    encoding = 'UTF-8', \
                    echo = FALSE) ; \
             update_article_metadata() ; \
             mail_am_gericht() ; \
             mail_briefing_aus_bern()"
```

If you plan to run the script regularly, it might be worth to save the purled R script to file:

```sh
Rscript --vanilla \
         -e "source(file = knitr::purl(input = 'republik_mailer.Rmd', \
                                       output = 'republik_mailer-GEN.R', \
                                       quiet = TRUE),
                    encoding = 'UTF-8', \
                    echo = FALSE)"
```

Then you can directly run this file and save some processing time:

```sh
Rscript --vanilla \
        -e "source(file = 'republik_mailer-GEN.R', \
                   encoding = 'UTF-8', \
                   echo = FALSE) ; \
            update_article_metadata() ; \
            mail_am_gericht() ; \
            mail_briefing_aus_bern()"
```

Just remember that you have to `knitr::purl()` again after applying any changes to the `.Rmd` source.

## [🠅](#table-of-contents) E-mail example

An e-mail for a new post in the Republik format [_Am Gericht_](https://www.republik.ch/format/am-gericht/) could look like this:

![](images/mail-am-gericht.png)

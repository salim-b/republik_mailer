# Republik Mailer

Send E-Mails spreading recent articles from a certain format of the online newspaper [Republik](https://www.republik.ch/).

## Requirements

First of all: This script doesn't allow any unauthenticated access to the online newspaper. You have to be a (paying) [subscriber of Republik](https://www.republik.ch/angebote). This allows you to [log in to the site](https://www.republik.ch/anmelden) in order to have a session cookie created needed for authentication. This cookie is named `connect.sid` and you need to provide its value (a cryptographic hash) as the `auth_cookie` argument[^reveal] to the function `get_latest_articles()`. Instead of having to provide an `auth_cookie` argument, the cookie's content can also be stored in a text file named `.auth_cookie` in the same folder as this script.

In addition, the `from` sender address as well as the `to` receiver address and name for the e-mails being sent should be provided in the files `.from`, `.to` and `.to_name` respectively, each located in the working directory.


[^reveal]: How you access the locally stored cookies of a specific site in Google Chrome is described [here](https://developers.google.com/web/tools/chrome-devtools/storage/cookies), the same for Firefox [here](https://developer.mozilla.org/docs/Tools/Storage_Inspector).

## Run the script

It's recommended that you adapt the script to your needs before you run it. For example, change the `format` to any of the existing Republik formats including:

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
- `briefing-aus-bern`
- `buchclub`
- `ctrl-alt-r`
- `das-leben-spielt`
- `eidgenoessische-randnotizen`
- `film`
- `fotobuch`
- `gedankensplitter`
- `helfen-sie-mit`
- `herd-und-hof`
- `klang`
- `nahr`
- `poesie-prosa`
- `preis-der-republik`
- `raumdeutung`
- `sehfeld`
- `theater`
- `theorie-praxis`
- `was-diese-woche-wichtig-war`
- `was-kommt`
- `welt-in-serie`
- `wochenend-newsletter`

Then to run it from a shell:

```sh
Rscript --vanilla \
            -e "source(file = knitr::purl(input = 'republik_mailer.Rmd', \
                                          output = tempfile(), \
                                          quiet = TRUE), \
                       encoding = 'UTF-8', \
                       echo = FALSE)"
```

## E-Mail Example

An E-Mail for a new post in the Republik format [_Am Gericht_](https://www.republik.ch/format/am-gericht) could look like this:

![](am-gericht.png)

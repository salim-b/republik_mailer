# Republik Mailer

Send E-Mails spreading recent articles from a certain format of the online newspaper [Republik](https://www.republik.ch/).

## Requirements

First of all: This script doesn't allow any unauthenticated access to the online newspaper. You have to be a (paying) [subscriber of Republik](https://www.republik.ch/angebote). This allows you to [log in to the site](https://www.republik.ch/anmelden) in order to have a session cookie created needed for authentication. This cookie is named `connect.sid` and you need to provide its value[^reveal] (a cryptographic hash) as the `auth_cookie` argument to the function `get_latest_articles()`.

In addition, the `from` sender address for the e-mails being sent should be provided in a file `.from` in the working directory.


[^reveal]: How you access the locally stored cookies of a specific site in Google Chrome is described [here](https://developers.google.com/web/tools/chrome-devtools/storage/cookies), the same for Firefox [here](https://developer.mozilla.org/docs/Tools/Storage_Inspector). The cookie's content can also be stored in a text file named `.auth_cookie` in the same folder as this script.

## Example

An E-Mail for a new post in the Republik format [Am Gericht](https://www.republik.ch/format/am-gericht) could look like this:

![](am-gericht.png)

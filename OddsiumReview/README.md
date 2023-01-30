# Oddsium iOS technical test

## Description
The technical assignment for the Oddsium iOS developer position consists of creating a small application that uses the Oddsium API and presenting basic data for a football match. The application should be similar to the Oddsium application available in Apple Store (in case you are unable to download the app, sample videos can be provided).

The application should include the following views, as shown in the [pictures](img).
- The user should be able to see a list of matches, similar to the [calendar view](img/calendar_view.png).
- The user should be able to select a match and view the odds for the specific match, as in the [match view](img/match_view.png). For this view, you are **not required** to show the odds available. Focus on presenting the information on the top of part of the view.
- The scores of the matches should be refreshed every 30 seconds, to keep up-to-date.

## API Calls
- To get the football games for a specific date, you can use:
```bash=
curl --location --request GET 'https://psydreus.oddsium.com/matches?date=2022-02-25&sport=1&countrycode=SE&timezone=europe/stockholm'
```
- To get the odds and other information about a specific match, you can use the the id field from the previous call:
```bash=
curl --location --request GET 'https://psydreus.oddsium.com/match?submarket=1&match={id}&countrycode=SE&oddstype=1'
```
This endpoint should include all the information you need for creating the second view (odds).
- The base URL for the images is `zeus.oddsium.com/i`.

## Optional task
- Create one extra view with at least one graph representing some part of the data, e.g. a histogram with the number of matches for different days

## Requirements
1. Use github to submit your code, prepresenting a regular workflow of working with pull requests.
2. It would be appreciated if the MVVM pattern is used when creating the application
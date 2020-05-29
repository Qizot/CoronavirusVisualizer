[![](https://img.shields.io/badge/python-3.7-brightgreen)](https://pl.python.org/)
# Data Scraper :page_facing_up:

Simple flask application serving as a proxy server to multiple covid-19 cases providers.




### Usage :rocket:
You can either run docker container by creating new docker image with supplied `Dockerfile` or just run server from your terminal with:
```
pip install -r requirements.txt
FLASK_APP=scraper flask run
```


### Providers :fax:
At the moment only two providers are available:
 - [The virus tracker](https://thevirustracker.com/api)
 - [Covid19 graphql](https://covid19-graphql.now.sh)

To create your own provider you have to follow `Provider` class structure and implement `fetch_country_timeline` metod.
You should fetch the whole timeline of given country (it's quite optimal for most public API's, at least with those we are using).

Make sure that resulting data looks like this:

```
{
    "code": "PL",
    "country": "Poland",
    "timeline": [
        {
            "date": "Wed, 22 Jan 2020 00:00:00 GMT",
            "new_cases": 0,
            "new_deaths": 0,
            "total_cases": 0,
            "total_deaths": 0,
            "total_recovered": 0
        },
        {
            "date": "Thu, 23 Jan 2020 00:00:00 GMT",
            "new_cases": 0,
            "new_deaths": 0,
            "total_cases": 0,
            "total_deaths": 0,
            "total_recovered": 0
        },
        ...
    ]
}
```

### Available countries :us:
You can chack available countries [here](here goes link)
# Data Scraper

Simple flask application serving as a proxy server to multiple covid-19 cases providers.




### Usage
You can either run docker container by creating new docker image with supplied `Dockerfile` or just run server from your terminal with:
```
pip install -r requirements.txt
FLASK_APP=scraper flask run
```


### Providers
At the moment only two providers are available:
 - [The virus tracker](https://thevirustracker.com/api)
 - [Covid19 graphql](https://covid19-graphql.now.sh)

To create your own provider you have to follow [`Provider`](https://github.com/Qizot/CoronavirusVisualizer/blob/1073158601c29f3ad8ce9112c2156b64eb1f4e43/DataScraper/providers/provider.py#L4) class structure and implement `fetch_country_timeline` metod.
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

### Available countries
You can chack available countries [here](https://github.com/Qizot/CoronavirusVisualizer/blob/1073158601c29f3ad8ce9112c2156b64eb1f4e43/DataScraper/providers/provider.py#L25).

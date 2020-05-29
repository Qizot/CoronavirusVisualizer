[![](https://img.shields.io/badge/nodejs-newest-brightgreen)](https://nodejs.org/en/)
[![](https://img.shields.io/badge/typescript-3.8.3-brightgreen)](https://www.typescriptlang.org/)
[![](https://img.shields.io/badge/express-4.17.1-brightgreen)](https://expressjs.com/)
[![](https://img.shields.io/badge/mongoose-5.9.5-brightgreen)](https://mongoosejs.com/)


## Database :floppy_disk:
As previously mentioned, we use MongoDB document database. It was an easy choice as we operate mainly on json structures
which saves us headaches from parsing data back to json format and above that mongoose library is straightforward
to use and we value simplicity a lot.

Why use database as we can depend on our proxy server you might ask? Well, parsing all countries data takes much longer than
an average app user might want to spend on waiting. Moreover, we value our providers and we don't want to take more of their bandwitdh
than we actually need. Instead we just keep refreshing our database every hour in case new data might come in.

## Architecture :computer:
In MongoDB we keep a single collection which keeps records in [given format](https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/coronavirus-visualizer-api/src/models/timeline.ts):

```
    {
        country: string;
        code: string;
        timeline: {
            date: Date;
            new_cases: number;
            new_deaths: number;
            total_cases: number;
            total_deaths: number;
            total_recovered: number;
        }
    }
```

Our backend exposes 3 different endpoints, you can learn about all of them by inspecting code below, which was written using [swagger](https://swagger.io/).
On every request we perform particular query on database, mainly consisting of aggregate pipeline and then return fetched data
back to the user.

```yaml
swagger: "2.0"
info:
  title: CoronaVirusAPI
  description: API description in Markdown.
  version: 1.0.0
host: http://46.101.198.229:8000
basePath: /api
schemes:
  - https

paths:
  /timelines:
    get:
      summary: Get list of timelines for specific countries.
      parameters:
        - in: query
          name: countries
          schema:
            type: array
            items:
              type: string
          required: true
          description: The array of country code, for which a timelines will be returned.
        - in: query
          name: dateFrom
          schema:
            type: date
          default: 1900-01-01
          required: false
        - in: query
          name: dateTo
          schema:
            type: date
          default: 2100-01-01
          required: false
      responses:
        200:
          description: OK
        400:
          description: Invalid date format, remove date query param or fix format
        400:
          description: Lacking 'countries' query field
        500:
          description: Internal server error
        500:
          description: Aggregation error

  /global-timeline:
    get:
      summary: Get global timeline.
      responses:
        200:
          description: OK
        500:
          description: Aggregation error

  /summary/:countryCode:
    get:
      summary: Get the newest timeline for specific country.
      parameters:
        - in: path
          name: countryCode
          required: true
          schema:
            type: string
      responses:
        200:
          description: OK
        500:
          description: Aggregation error

```
## Test :chart_with_upwards_trend:
We decided to test our backend's performance be utilizing locust tool. The tests have been performed on a very simple VPS with a single core and 1GB of ram.

Single user code can be seen below:

```python
from locust import HttpUser, task, between
import datetime
import random

def get_random_date_range():
    now = datetime.datetime.now()
    date_from = now - datetime.timedelta(days=random.randint(1, 150))
    date_to = min(date_from + datetime.timedelta(days=random.randint(1, 150)), now)

    return date_from.date(), date_to.date()


class CoronaUser(HttpUser):

    @task(10)
    def global_timeline(self):
        self.client.get("/global-timeline")

    @task(20)
    def multiple_country_timeline(self):
        countries = CoronaUser.COUNTRIES 
        date_from, date_to = get_random_date_range()

        params = {
            "countries": ",".join(countries),
            "date_from": date_from,
            "date_to": date_to
        }
        self.client.get(f"/timelines", params=params)


    @task(10)
    def single_country_timeline(self):
        params = {
            "countries": "PL",
        }
        self.client.get(f"/timelines", params=params)

    @task(5)
    def summary(self):
        picked_country = random.choice(CoronaUser.COUNTRIES) 
        self.client.get(f"/summary/{picked_country}")

    wait_time = between(2, 5)

    COUNTRIES = ["PL", "CA", "US", "IT", "CN", "GB"
```


The result of the above tests :

```
|Type|Name|Request Count|Failure Count|Median Response Time|Average Response Time|Min Response Time|Max Response Time|Average Content Size|Requests/s|Failures/s|50%|66%|75%|80%|90%|95%|98% |99% |99.9%|99.99%|99.999%|100%|
|----|--------------------------------------------------------------------------------------------|-------------|-------------|--------------------|---------------------|-----------------|-----------------|--------------------|----------|----------|---|---|---|---|---|---|----|----|-----|------|-------|----|
|GET |/api/global-timeline                                                                        |252          |7            |580                 |586                  |11               |1585             |21142               |4.96      |0.14      |580|700|760|790|900|990|1500|1600|1600 |1600  |1600   |1600|
|GET |/api/summary/CA                                                                             |26           |0            |59                  |114                  |39               |516              |116                 |0.51      |0.00      |82 |110|130|150|240|310|520 |520 |520  |520   |520    |520 |
|GET |/api/summary/CN                                                                             |21           |2            |66                  |97                   |5                |331              |104                 |0.41      |0.04      |66 |74 |88 |140|250|290|330 |330 |330  |330   |330    |330 |
|GET |/api/summary/GB                                                                             |22           |0            |76                  |114                  |35               |490              |124                 |0.43      |0.00      |76 |97 |140|190|210|250|490 |490 |490  |490   |490    |490 |
|GET |/api/summary/IT                                                                             |26           |0            |74                  |116                  |36               |444              |117                 |0.51      |0.00      |76 |96 |110|170|290|320|440 |440 |440  |440   |440    |440 |
|GET |/api/summary/PL                                                                             |24           |0            |64                  |139                  |35               |732              |116                 |0.47      |0.00      |72 |93 |160|170|380|530|730 |730 |730  |730   |730    |730 |
|GET |/api/summary/US                                                                             |30           |0            |62                  |95                   |38               |663              |116                 |0.59      |0.00      |63 |72 |81 |89 |210|240|660 |660 |660  |660   |660    |660 |
|GET |/api/timelines                                                                              |9            |9            |20                  |38                   |4                |148              |0                   |0.18      |0.18      |20 |26 |28 |82 |150|150|150 |150 |150  |150   |150    |150 |
|GET |/api/timelines?countries=PL                                                                 |272          |0            |100                 |148                  |63               |740              |20148               |5.36      |0.00      |100|140|170|200|280|380|580 |710 |740  |740   |740    |740 |
|GET |/api/timelines?countries=PL%2CCA%2CUS%2CIT%2CCN%2CGB&date_from=2019-12-31&date_to=2020-04-05|1            |0            |193                 |193                  |193              |193              |123977              |0.02      |0.00      |190|190|190|190|190|190|190 |190 |190  |190   |190    |190 |

```

<img align="center" height="300" width="1000" src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/test/users.png">
<img align="center" height="300" width="1000" src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/test/delay.png">
<img align="center" height="300" width="1000" src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/test/rps.png">
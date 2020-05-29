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
To test the efficiency of our backend and database, we are using code below.
Our tests measure the database response time for different number of queries :
```
  [1, 2, 5, 10, 20, 30, 40, 50, 100, 200, 300, 500, 1000, 2000, 5000, 10000]
```
Tests were performed for each endpoint:
```
  '/summary/:PL',
  '/timelines',
  '/global-timeline'
```
```python
import requests
import time
import matplotlib.pyplot as plt

api = 'http://0.0.0.0:4000/api/'


def test(number_of_request, path, params):
    res = []
    for req in number_of_request:
        start = time.time()
        for _ in range(req):
            requests.get(api + path, params=params)
        end = time.time()
        res.append(end - start)
    return res


def draw_char(label, x, y):
    font = {'style': 'italic',
            'weight': 'normal',
            'size': 34}
    plt.rc('font', **font)
    fig = plt.figure(figsize=(20, 16))
    plt.plot(x, y, linewidth=6)
    fig.suptitle(label, fontsize=36, weight='bold')
    plt.xlabel('number of request', fontsize=36, weight='bold')
    plt.ylabel('time [s]', fontsize=36, weight='bold')
    fig.savefig('test_{}.png'.format(label.split('/')[1]))
    plt.show()


x = [1, 2, 5, 10, 20, 30, 40, 50, 100, 200, 300, 500, 1000, 2000, 5000, 10000]
params = {'countries': ['PL']}
draw_char('/summary:PL', x, test(x, '/summary/:PL', []))
draw_char('/timelines', x, test(x, '/timelines', params))
draw_char('/global-timeline', x, test(x, '/global-timeline', []))
```

Test results are illustrated in the charts below :       
<img align="center" height="400" width="600" src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/test/test_global_timeline.png">
<img align="center" height="400" width="600" src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/test/test_summary.png">
<img align="center" height="400" width="600" src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/test/test_timelines.png">

Analyzing the above tests, we came to the conclusion that these tests are useless. So we have written new tests using a specialized locust tool:

```python
from locust import HttpUser, TaskSet, task


class MyTaskSet(TaskSet):
    @task
    def test_summary(self):
        self.client.get('/summary/:PL')

    @task
    def test_timelines(self):
        self.client.get('/timelines', params={'countries': ['PL']})

    @task
    def test_global_timelines(self):
        self.client.get('/global-timeline')


class WebUser(HttpUser):
    host = "http://0.0.0.0:4000/api"
    tasks = [MyTaskSet]
    min_wait = 2 * 1000
    max_wait = 6 * 1000
```


The result of the above tests :

```
|Type|Name                       |Request Count|Failure Count|Median Response Time|Average Response Time|Min Response Time|Max Response Time|Average Content Size|Requests/s|Failures/s|50%|66%|75%|80%|90%|95%|98%|99%|99.9%|99.99%|99.999%|100%|
|----|---------------------------|-------------|-------------|--------------------|---------------------|-----------------|-----------------|--------------------|----------|----------|---|---|---|---|---|---|---|---|-----|------|-------|----|
|GET |/api/global-timeline       |950          |0            |70                  |69                   |37               |157              |21747               |2.46      |0.00      |70 |77 |80 |82 |92 |110|130|140|160  |160   |160    |160 |
|GET |/api/summary/:PL           |1001         |0            |10                  |8                    |2                |39               |2                   |2.59      |0.00      |10 |12 |13 |13 |15 |16 |18 |19 |30   |39    |39     |39  |
|GET |/api/timelines?countries=PL|934          |0            |15                  |13                   |3                |36               |20148               |2.42      |0.00      |15 |17 |18 |19 |21 |25 |29 |32 |36   |36    |36     |36  |
|None|Aggregated                 |2885         |0            |15                  |30                   |2                |157              |13684               |7.47      |0.00      |15 |26 |51 |63 |78 |86 |100|120|150  |160   |160    |160 |

```

<img align="center" height="300" width="800" src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/test/number_of_users.png">
<img align="center" height="300" width="800" src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/test/response_times.png">
<img align="center" height="300" width="800" src="https://github.com/Qizot/CoronavirusVisualizer/blob/master/backend/test/total_requests_per_second.png">
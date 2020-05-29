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
          name: countryCodes
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

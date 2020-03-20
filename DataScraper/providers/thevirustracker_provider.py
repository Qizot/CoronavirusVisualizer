from .provider import Provider
import requests
from datetime import datetime
import json
from http import HTTPStatus


class TheVirusTrackerProvider(Provider):
    COUNTRY_TIMELINE_URL = "https://thevirustracker.com/free-api?countryTimeline={}"
    DEFAULT_TIMEOUT = 3

    @classmethod
    def fetch_country_timeline(cls, country_code):
        try:
            result = {}
            req = requests.get(TheVirusTrackerProvider.COUNTRY_TIMELINE_URL.format(country_code),
                               timeout=TheVirusTrackerProvider.DEFAULT_TIMEOUT, headers={'Accept-Encoding': 'identity'})
            data = json.loads(req.text)
            info = data['countrytimelinedata'][0]['info']
            result['country'] = info['title']
            result['code'] = info['code']

            timeline = []
            date_format = "%m/%d/%Y"
            for (date_str, cases) in data['timelineitems'][0].items():
                # me might encounter non-date entry so just let it fail and continue
                try:
                    date = datetime.strptime(date_str, date_format)
                    new_cases = cases['new_daily_cases']
                    new_deaths = cases['new_daily_deaths']
                    total_cases = cases['total_cases']
                    total_recovered = cases['total_recoveries']
                    total_deaths = cases['total_deaths']

                    timeline.append({
                        "date": date,
                        "new_cases": new_cases,
                        "new_deaths": new_deaths,
                        "total_cases": total_cases,
                        "total_recovered": total_recovered,
                        "total_deaths": total_deaths
                    })
                except Exception as e:
                    print("Error while parsing timeline entry: ", e)

            result["timeline"] = timeline
            return result
        except requests.exceptions.RequestException as e:
            print("Error with request has occured: ", e)
            return {"error": "encountered error while connecting with external services",
                    "code": HTTPStatus.BAD_GATEWAY}
        except json.JSONDecodeError as e:
            print("Error while decoding external service data: ", e)
            return {
                "error": "encountered error while parsing external service data, the service is either unavailable or is being under maintenance",
                "code": HTTPStatus.BAD_GATEWAY}
        except Exception as e:
            print("Encountered generic exception: ", e)
            return {"error": "encoutered unknown error, please try again later",
                    "code": HTTPStatus.INTERNAL_SERVER_ERROR}

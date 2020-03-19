from flask import Flask, jsonify
import requests
import json
from datetime import datetime
from http import HTTPStatus

app = Flask(__name__)

COUNTRY_TIMELINE_URL = "https://thevirustracker.com/free-api?countryTimeline={}"
DEFAULT_TIMEOUT = 3

COUNTRIES = [
    ("Albania", "AL"),
    ("Austria", "AT"),
    ("Belarus", "BY"),
    ("Belgium", "BE"),
    ("Bosnia and Herzegovina", "BA"),
    ("Bulgaria", "BG"),
    ("Burkina Faso", "BF"),
    ("Costa Rica", "CR"),
    ("Croatia", "HR"),
    ("Cyprus", "CY"),
    ("Czech Republic", "CZ"),
    ("Denmark", "DK"),
    ("Egypt", "EG"),
    ("Estonia", "EE"),
    ("Finland", "FI"),
    ("France", "FR"),
    ("Germany", "DE"),
    ("Greece", "GR"),
    ("Greenland", "GL"),
    ("Hungary", "HU"),
    ("Iceland", "IS"),
    ("Ireland", "IE"),
    ("Israel", "IL"),
    ("Italy", "IT"),
    ("Latvia", "LV"),
    ("Lithuania", "LT"),
    ("Luxembourg", "LU"),
    ("Macedonia", "MK"),
    ("Moldova", "MD"),
    ("Mongolia", "MN"),
    ("Montenegro", "ME"),
    ("Netherlands", "NL"),
    ("Norway", "NO"),
    ("Poland", "PL"),
    ("Portugal", "PT"),
    ("Puerto Rico", "PR"),
    ("Romania", "RO"),
    ("Russia", "RU"),
    ("Serbia", "RS"),
    ("Slovakia", "SK"),
    ("Slovenia", "SI"),
    ("Spain", "ES"),
    ("Swaziland", "SZ"),
    ("Sweden", "SE"),
    ("Switzerland", "CH"),
    ("Turkey", "TR"),
    ("United Kingdom", "GB"),
    ("Ukraine", "UA")
]


def get_country_timeline(country_code):
    try:
        result = {}
        req = requests.get(COUNTRY_TIMELINE_URL.format(country_code), timeout=DEFAULT_TIMEOUT)
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
        return {"error": "encountered error while connecting with external services", "code": HTTPStatus.BAD_GATEWAY}
    except json.JSONDecodeError as e:
        print("Error while decoding external service data: ", e)
        return {"error": "encountered error while parsing external service data, the service is either unavailable or is being under maintenance", "code": HTTPStatus.BAD_GATEWAY}
    except Exception as e:
        print("Encountered generic exception: ", e)
        return {"error": "encoutered unknown error, please try again later", "code": HTTPStatus.INTERNAL_SERVER_ERROR}


@app.route("/api/timelines/<country_code>", methods=["GET"])
def timelines(country_code):
    result = get_country_timeline(country_code)
    if "error" in result:
        return jsonify(result), result['code']
    return jsonify(result)


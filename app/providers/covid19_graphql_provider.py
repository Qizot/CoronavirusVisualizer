from .provider import Provider
from datetime import datetime
from http import HTTPStatus
from sgqlc.endpoint.http import HTTPEndpoint
import math


class Covid19GraphqlProvider(Provider):

    API_ENDPOINT = "https://covid19-graphql.now.sh"
    QUERY = '''
        query CountryTimeline($country: String!) {
          results(countries: [$country]) {
            date
            confirmed
            recovered
            deaths
            growthRate
          }
        }
    '''

    @classmethod
    def fetch_country_timeline(cls, country_code):
        country = Provider.get_country_by_code(country_code, type="graphql")
        endpoint = HTTPEndpoint(Covid19GraphqlProvider.API_ENDPOINT, {})

        variables = {
            "country": country
        }

        data = endpoint(Covid19GraphqlProvider.QUERY, variables)

        if "errors" in data:
            return {"error": "encountered error while fetching external api data", "code": HTTPStatus.BAD_GATEWAY, "data": data['errors']}

        results = {
            "country": country,
            "code": country_code
        }

        timeline = []
        today_date = datetime.now().date()

        for result in data['data']['results']:
            date_format = "%Y-%m-%d"
            date = datetime.strptime(result['date'], date_format)
            total_cases = result['confirmed']
            total_recovered = result['recovered']
            total_deaths = result['deaths']

            rate = result['growthRate']
            growth = float(rate) if rate else 0
            new_cases = math.ceil(total_cases - total_cases / (1 + growth)) if growth > 0 else 0
            new_deaths = None
            
            if date.date() == today_date:
                continue
            timeline.append({
                "date": date,
                "new_cases": new_cases,
                "new_deaths": new_deaths or 0,
                "total_cases": total_cases,
                "total_recovered": total_recovered,
                "total_deaths": total_deaths
            })
        results['timeline'] = timeline

        for (idx, item) in reversed(list(enumerate(results['timeline']))):
            if idx - 1 >= 0:
                item['new_deaths'] = item['total_deaths'] - results['timeline'][idx-1]['total_deaths']
                item['total_recovered'] = item['total_recovered'] or results['timeline'][idx-1]['total_recovered']

        return results





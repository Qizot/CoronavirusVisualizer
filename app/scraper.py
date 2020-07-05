from flask import Flask, jsonify, request
from .providers.thevirustracker_provider import TheVirusTrackerProvider
from .providers.covid19_graphql_provider import Covid19GraphqlProvider

app = Flask(__name__)


@app.route("/api/timelines/<country_code>", methods=["GET"])
def timelines(country_code):
    api = request.args.get('api')
    if api == "thevirustracker":
        result = TheVirusTrackerProvider.fetch_country_timeline(country_code)
    else:
        result = Covid19GraphqlProvider.fetch_country_timeline(country_code)

    if "error" in result:
        return jsonify(result), result['code']
    return jsonify(result)

if __name__ == "__main__":
    app.run()


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

    COUNTRIES = ["PL", "CA", "US", "IT", "CN", "GB"]
 
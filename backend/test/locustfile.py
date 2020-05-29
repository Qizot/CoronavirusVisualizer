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

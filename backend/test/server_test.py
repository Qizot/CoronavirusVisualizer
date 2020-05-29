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

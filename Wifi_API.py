import requests
import json


url = "https://open.jejudatahub.net/api/proxy/51tt9Daaa6atttDataaa5Dbttattttat/8pcbeee_4tj81o811t4r5ttot5j8ppre?searchDate=20200801"

headers = {}

response = requests.request("GET", url, headers=headers)
data = json.loads(response.content)
datas = data['data']
results = []
# print(data)

for data in datas:
    spots = data['movingPath'].split('|')
    # print(spots)
    results.extend(spots)

print(results)
#
# result_dic = {}
# for result in results:






# print(data['data'])
# for d in data['data']:
    # print(d)
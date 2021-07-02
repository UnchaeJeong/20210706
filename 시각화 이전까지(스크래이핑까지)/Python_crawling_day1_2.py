# import requests
# from lxml import html
#
# url = 'https://pages.coupang.com/p/35042?from=home_C2&traid=home_C2&trcid=11061223'
#
# headers = {'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
# html_req = requests.get(url, headers=headers)
#
# tree = html.fromstring(html_req.content)
#
# hds = tree.xpath('//dd[@class="descriptions"]/div/text()')
#
# results = []
#
# for hd in hds :
#     for hd in hds:
#         hd_clean = hd.replace("\n", " ").replace("\t", " ").replace("\r", " ").strip()
#         results.append(hd_clean)
#
# print(len(results))
# print(results)


# import requests
# from lxml import html
#
# url = 'https://www1.president.go.kr/petitions'
#
# headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (HTML, like Gecko)\
#  Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
# html_req = requests.get(url, headers=headers)
#
# tree = html.fromstring(html_req.content)
#
# hds = tree.xpath('//div[@class="bl_subject"]/a/text()')
#
# results = []
#
# for hd in hds :
#     for hd in hds:
#         hd_clean = hd.replace("\n", " ").replace("\t", " ").replace("\r", " ").strip()
#         results.append(hd_clean)
#
# print(len(results))
# print(results)


# import requests
# from lxml import html
#
# url = 'https://kin.naver.com/'
#
# headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (HTML, like Gecko)\
#  Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
# html_req = requests.get(url, headers=headers)
#
# tree = html.fromstring(html_req.content)
#
# hds = tree.xpath('//div[@class="tit_wrap"]/a/text()')
#
# results = []
#
# for hd in hds :
#     for hd in hds:
#         hd_clean = hd.replace("\n", " ").replace("\t", " ").replace("\r", " ").strip()
#         results.append(hd_clean)
#
# print(len(results))
# print(results)

import requests
from lxml import html

url = 'http://www.paxnet.co.kr/tbbs/list?tbbsType=L&id=005930/'

headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
html_req = requests.get(url, headers=headers)

tree = html.fromstring(html_req.content)

hds = tree.xpath('//div[@class="title"]/p/a/text()')

results = []

for hd in hds :
    for hd in hds:
        hd_clean = hd.replace("\n", " ").replace("\t", " ").replace("\r", " ").strip()
        results.append(hd_clean)

print(len(results))
print(results)
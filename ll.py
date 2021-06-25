import requests
from lxml import html

url ='https://pages.coupang.com/p/32791?from=home_C2&traid=home_C2&trcid=3976922'

headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
html_req = requests.get(url, headers=headers)
tree = html.fromstring(html_req.content)
titles = tree.xpath('//dd[@class="descriptions"]/div[@class="name"]/text()')
result = []
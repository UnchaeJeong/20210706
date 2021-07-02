##########################   마리트 별점후기글 가져오기 ########################################
#   tree.xpath 태그 주소 어떻게 해야 끌어올 수 있을까여?
import requests
from lxml import html

url = "https://www.myrealtrip.com/offers/104078"
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
html_req = requests.get(url, headers=headers)
tree = html.fromstring(html_req.content)
titles = tree.xpath('//div[@class="offer-review"]/@div/#text()')
result = []
print(result)


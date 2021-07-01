#   검색어 키워드 + 페이지 넘버 변수 처리하기
import requests
from lxml import html

keyword = '관광명소'
page_num = 1
url = 'https://search.naver.com/search.naver?where=news&sm=tab_pge''&query='+keyword+'&sort=1'    '&photo=0&field=0&pd=3&ds=2021.01.01&de=2021.05.31&mynews=0'    '&office_type=0&office_section_code=0&news_office_checked=&nso=so:dd,p:from20210101to20210531,a:all&start='+str(page_num)
print(len(url))
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
  AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
html_req = requests.get(url, headers=headers)
#print(html_req.text)
tree = html.fromstring(html_req.content)
bodies = tree.xpath('//ul[@class="list_news"]/li')
results = []
for body in bodies:
    news_title = body.xpath('.//a[@class="news_tit"]/@title')[0]
    try:
        news_url = body.xpath('.//a[@class="info"]/@href')[0]
    except:
        news_url = ''
    news_title_clean = news_title.replace("\n"," ").replace("\t"," ").replace("\r"," ").strip()
    results.append([news_title_clean, news_url])
print(results)
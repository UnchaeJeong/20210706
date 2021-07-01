##########################  naver news 2 HTML 키워드 목록과 본문 수집 ########################################

import requests
from lxml import html
url = 'https://search.naver.com/search.naver?where=news&sm=tab_pge&query=%EC%97%AC%ED%96%89&sort=1&photo=0&field=0&pd=3\
&ds=2021.01.01&de=2021.05.31&mynews=0&office_type=0\
&office_section_code=0&news_office_checked=&nso=so:dd,p:from20210101to20210531,a:all&start=1'
#print(url)
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
#  AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
html_req = requests.get(url, headers=headers)
tree = html.fromstring(html_req.content)
bodies = tree.xpath('//ul[@class="list_news"]/li')
    #   xpath 주소가 왜 이렇게 나오는지 고민해보자.
print(len(bodies))
    #   len 우리가 몇개의 바디를 가져올 건지 확인 가능.
results = []
for body in bodies:
    news_title = body.xpath('.//td[@class="gall_tit ub-word"]/a/text()')[0]
    try:
        news_url = body.xpath('//td[@class="gall_tit ub-word"]/a/@href')[0]
    except:
        news_url=''
    news_title_clean = news_title.replace("\n"," ").replace("\t"," ").replace("\r"," ").strip()
    results.append([news_title_clean, news_url])
    #   for문 안에 try, except문까지 확인. xpath 주소에 왜 //a로 시작했을까?
print(results)
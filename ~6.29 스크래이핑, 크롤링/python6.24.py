import requests
from lxml import html
url = "http://www.paxnet.co.kr/tbbs/list?tbbsType=L&id=005930"

headers ={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
html_req = requests.get(url, headers = headers)

tree = html.fromstring(html_req.content)
titles = tree.xpath('//div[@class="title"]/p/a/text()')
print(titles)
results = []

for title in titles:
    title_clean = title.replace("\n"," ").replace("\t"," ").replace("\r"," ").strip()
    results.append(title_clean)


url = "https://search.naver.com/search.naver?where=news&sm=tab_pge&query=%ED%82%A5%EB%B3%B4%EB%93%9C&sort=1&photo=0&field=0&pd=3&ds=2021.01.01&de=2021.04.30&mynews=0&office_type=0&office_section_code=0&news_office_checked=&nso=so:dd,p:from20210101to20210430,a:all&start=11"
print(url)

headers ={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
html_req = requests.get(url, headers = headers)
tree = html.fromstring(html_req.content)

bodies = tree.xpath('//ul[@class="list_news"]/li')
print(len(bodies))

results = []

for body in bodies:
    news_title = body.xpath('.//a[@class = "news_tit"]/@title')[0]
    try:
        news_url = body.xpath('.//a[@class = "info"]/@href')[0]
    except:
        news_url = ''
    print(news_url)

    news_title_clean = news_title.replace("\n"," ").replace("\t"," ").replace("\r"," ").strip()
    results.append([news_title_clean, news_url])


print(results)
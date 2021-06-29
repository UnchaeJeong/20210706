import requests
from lxml import html
keyword = '관광명소'
page_num = 1

def fcrawl_news():      #url이 함수 안으로 들어온 것 확인.
    url = 'https://search.naver.com/search.naver?where=news&sm=tab_pge'\
    '&query='+keyword+'%EA%B4%80%EA%B4%91%EB%AA%85%EC%86%8C''&sort=1&photo=0&field=0&pd=3&ds=2021.01.01&de=2021.05.31&mynews=0&office_type=0'\
    '&office_section_code=0&news_office_checked=&nso=so:dd,p:from20210101to20210531,a:all&start='+str(page_num)
    print(url)

    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
  AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
    html_req = requests.get(url, headers=headers)
#    print(html_req.text)
    tree = html.fromstring(html_req.content)
    bodies = tree.xpath('//ul[@class="list_news"]/li')

    results = []

    for body in bodies:
        news_title = body.xpath('.//a[@class="news_tit"]/@title')[0]
        try:
            news_url = body.xpath('.//a[@class="info"]/@href')[0]
        except:
            news_url = ''
        news_title_clean = news_title.replace("\n", " ").replace("\t", " ").replace("\r", " ").strip()
        results.append([news_title_clean, news_url])

    return results

def fmain():
    results = fcrawl_news()
    print(results)

fmain()
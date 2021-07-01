# https://search.naver.com/search.naver?where=news&sm=tab_jum&query=%EC%BD%94%EB%A1%9C%EB%82%98


###### https://search.naver.com/search.naver?where=news&sm=tab_pge\
# &query=%EC%BD%94%EB%A1%9C%EB%82%98\ 검색키워드
# &sort=1\관련도순 - 최신순 - 오래된순
####### &photo=0&field=0&pd=3\
# &ds=2021.01.01&de=2021.05.31\ 시작, 끝 날짜
####### &mynews=0&office_type=0&office_section_code=0&news_office_checked=&nso=so:dd,p:from20210101to20210531,a:all&start=1section_code=0&news_office_checked=&nso=so:r,p:all,a:all\
# &start=1

import requests
from lxml import html
import time
keywords = ['킥보드', '자전거']

def fcrawl_news(keyword, page_num):
    url = 'https://search.naver.com/search.naver?where=news&sm=tab_pge&query='+keyword+'\
    &sort=1&photo=0&field=0&pd=3&ds=2021.01.01&de=2021.05.31&mynews=0&office_type=0&office_section_code=0\
    &news_office_checked=&nso=so:dd,p:from20210101to20210531,a:all&start='+str(page_num)
    print(url) #    확인용도
    headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
    html_req = requests.get(url, headers=headers)
    tree = html.fromstring(html_req.content)
    bodies = tree.xpath('//ul[@class="list_news"]/li')
    print(len(bodies))
    results = []
    for body in bodies:
        news_title = body.xpath('.//a[@class="news_tit"]/@title')[0]
        try :
            news_url = body.xpath('.//a[@class="info"]/@href')[0]
        except:
            news_url = ''
        news_title_clean = news_title.replace("\n","").replace("t","").replace("\r","").strip()
        results.append([news_title_clean, news_url])
    return results

def fmain():
    for keyword in keywords:
        for i in range(1,3):
            print(i)
            page_num = (i-1) * 10 + 1
            results = fcrawl_news(keyword, page_num)
            print(results)
            time.sleep(6)
fmain()
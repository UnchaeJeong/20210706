

import requests
from lxml import html
import time
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
    #  AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}

def fcrawl_news(page_num):      #url이 함수 안으로 들어온 것 확인.
    url = 'https://gall.dcinside.com'
    url2 = '/board/lists/?id=hit&page='+str(page_num)
print(url + url2)

    html_req = requests.get(url, headers=headers)
    tree = html.fromstring(html_req.content)
    bodies = tree.xpath('//tr[@class="ub-content us-post"]')
    print(len(bodies))
    results = []
    for body in bodies:
        news_title = body.xpath('.//td[@class="gall_tit ub-word"]/a/text()')[0]
        try:
            news_url = body.xpath('.//td[@class="gall_tit ub-word"]/a/@href')[0]
        except:
            news_url=''
        news_title_clean = news_title.replace("\n"," ").replace("\t"," ").replace("\r"," ").strip()
        url3 = url + news_url
        furl(url3)
        results.append([news_title_clean, news_url])
    return results

def furl(contents_url):
    html_req = requests.get(contents_url, headers=headers)
    tree = html.fromstring(html_req.content)
    bodies = tree.xpath('.//div[@class="write_div"]')

def fmain():
    for page_num in range(1, 4):
        results = fcrawl_news(page_num)
        print(results)
        time.sleep(1)
fmain()

#https://gall.dcinside.com/board/view/?id=hit&no=16350&page=3
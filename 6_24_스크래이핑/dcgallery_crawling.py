
import requests
from lxml import html
import time

keyword = 'hit'

output_file_name = 'dcgallery'+hit+'.txt'
output_file = open(output_file_name, "w", encoding="utf-8")
output_file.write("{}\t{}\t{}\n".format('페이지', '제목', 'URL'))
output_file.close()


def fwrite_news(i, news_title_clean, news_url):
    print([i, news_title_clean, news_url])
    output_file = open(output_file_name, "a", encoding="utf-8")
    output_file.write("{}\t{}\t{}\n".format(i, news_title_clean, news_url))
    output_file.close()
    return


def fcrawl_news(i):
    page_num = i
    url = 'https://gall.dcinside.com/board/lists/?id=hit&page='+str(i)
 # print(url)
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
        #  AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
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
        results.append([news_title_clean, news_url])
        fwrite_news(i, news_title_clean, news_url)
    return results

def fmain():
    for i in range(1, 4):
        print(i)
        results = fcrawl_news(i)
        print(results)
        time.sleep(1)

fmain()
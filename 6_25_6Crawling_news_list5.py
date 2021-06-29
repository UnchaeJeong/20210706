import requests
from lxml import html
import time

keywords = ['부산', '해운대']

output_file_name = 'naver_news_list5.txt'
output_file = open(output_file_name, "w", encoding="utf-8")
output_file.write("{}\t{}\t{}\t{}\n".format('페이지', '키워드', '제목', 'URL'))
output_file.close()


def fwrite_news(i, keyword, news_title_clean, news_url):
    print([i, keyword, news_title_clean, news_url])
    output_file = open(output_file_name, "a", encoding="utf-8")
    output_file.write("{}\t{}\t{}\t{}\n".format(i, keyword, news_title_clean, news_url))
    output_file.close()
    return


def fcrawl_news(keyword, i):
    page_num = (i - 1) * 10 + 1

    url = 'https://search.naver.com/search.naver?where=news&sm=tab_pge'\
    '&query='+keyword+'%EA%B4%80%EA%B4%91%EB%AA%85%EC%86%8C''&sort=1&photo=0&field=0&pd=3&ds=2021.01.01&de=2021.05.31&mynews=0&office_type=0'\
    '&office_section_code=0&news_office_checked=&nso=so:dd,p:from20210101to20210531,a:all&start='+str(page_num)
#    print(url)

    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
          AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
    html_req = requests.get(url, headers=headers)
#       print(html_req.text)

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
        results.append([i, keyword, news_title_clean, news_url])
        fwrite_news(i, keyword, news_title_clean, news_url)

    return results

def fmain():
    for keyword in keywords:
        for i in range(1, 4):
            print(i)
            results = fcrawl_news(keyword, i)
            print(results)
            time.sleep(1)

fmain()


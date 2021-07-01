import requests
from lxml import html
import time

keywords = ['킥보드','자전거']


def fmake_file(keyword):
    output_file_name = 'naver_news' + keyword + "-" + time.strftime("%y%m%d_%H%M%S") + '.txt'
    output_file = open(output_file_name, "w", encoding="utf-8")
    output_file.write("{}\t{}\t{}\t{}\n".format('페이지','키워드','제목','URL'))
    output_file.close()
    return output_file_name


def fwrite_news(i, keyword, news_title_clean, news_url, output_file_name):
    print([i,keyword,news_title_clean, news_url])
    output_file = open(output_file_name, "a", encoding="utf-8")
    output_file.write("{}\t{}\t{}\t{}\n".format(i, keyword, news_title_clean, news_url))
    return


def fcrawl_news(keyword, i, output_file_name):
    page_num = (i - 1) * 10 + 1
    url = 'https://search.naver.com/search.naver' \
          '?where=news&sm=tab_pge' \
          '&query=' + keyword + '&sort=1&photo=0&field=0&pd=3' \
          '&ds=2021.01.01&de=2021.04.30&mynews=0&office_type=0' \
          '&office_section_code=0&news_office_checked=' \
          '&nso=so:dd,p:from20210101to20210430,a:all&start=' + str(page_num)
    print(url)
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
    html_req = requests.get(url, headers=headers)
    tree = html.fromstring(html_req.content)
    bodies = tree.xpath('//ul[@class="list_news"]/li')
    results = []
    for body in bodies:
        news_title = body.xpath('.//a[@class = "news_tit"]/@title')[0]
        try:
            news_url = body.xpath('.//a[@class = "info"]/@href')[0]
        except:
            news_url = '' #응용해보자.

        news_title_clean = news_title.replace("\n", " ").replace("\t", " ").replace("\r", " ").strip()
        results.append([news_title_clean, news_url])
        fwrite_news(i, keyword, news_title_clean, news_url, output_file_name)

    return results


def fmain():
    for keyword in keywords:
        output_file_name = fmake_file(keyword)
        for i in range(1,4):
            print(i)
            results = fcrawl_news(keyword, i, output_file_name)
            print(results)
            time.sleep(6)


fmain()


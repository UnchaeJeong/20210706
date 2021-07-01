import requests
from lxml import html
import time

keywords = ['한국관광공사', '제주관광공사']

def fmake_file(keyword):        #   fmake, 키워드 안에 집어넣음.
    output_file_name = 'naver_news_list6' + "_" + time.strftime("%y%m%d_%H%M%S") + '.txt'       #   string format time 연월일 = 소문자, 시간은 대문자
    output_file = open(output_file_name, "w", encoding="utf-8")
    output_file.close()
    return output_file_name


def fwrite_news(i, keyword, news_title_clean, news_url, output_file_name):          #   fwirte 함수 output_file_name 추가됨.
    print([i, keyword, news_title_clean, news_url])                                 #   여기서는 4개만 프린트
    output_file = open(output_file_name, "a", encoding="utf-8")
    output_file.write("{}\t{}\t{}\t{}\n".format(i, keyword, news_title_clean, news_url))
    output_file.close()
    return


def fcrawl_news(keyword, i, output_file_name):
    page_num = (i - 1) * 10 + 1
    url = 'https://search.naver.com/search.naver?where=news&sm=tab_pge' \
          '&query=' + keyword + '%EA%B4%80%EA%B4%91%EB%AA%85%EC%86%8C''&sort=1&photo=0&field=0&pd=3&ds=2021.01.01&de=2021.05.31&mynews=0&office_type=0' \
                                '&office_section_code=0&news_office_checked=&nso=so:dd,p:from20210101to20210531,a:all&start=' + str(page_num)
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
        fwrite_news(i, keyword, news_title_clean, news_url, output_file_name)

    return results


def fmain():
    for keyword in keywords:
        output_file_name = fmake_file(keyword)                                          #   fmake_file(keyword)
        for i in range(1, 4):
            print(i)
            results = fcrawl_news(keyword, i, output_file_name)                         #   3개로 바뀜.
            print(results)
            time.sleep(1)


fmain()
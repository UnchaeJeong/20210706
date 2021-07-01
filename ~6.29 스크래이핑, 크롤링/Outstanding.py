import requests
from lxml import html
import time

keyword = 'IssueChart'

def file_write(output_file,i, like, article_title, article_author, date, article_url):
    output_file.write("{}\t{}\t{}\t{}\t{}\t{}\n".format(i, like, article_title, article_author, date, article_url))


output_file_name = keyword + "_this_week_" + time.strftime("%y%m%d_%H%M%S") + '.txt'
output_file = open(output_file_name, "w", encoding="utf-8")
# output_file.write("{}\t{}\t{}\t{}\t{}\t{}\n".format('페이지', '좋아요', '제목', '작성자', '날짜', 'URL'))
file_write(output_file,'페이지', '좋아요', '제목', '작성자', '날짜', 'URL')
output_file.close()


def fwrite_news(i, like, article_title, article_author, date, article_url):
    print([i, like, article_title, article_author, date, article_url])
    output_file = open(output_file_name, "a", encoding="utf-8")
    # output_file.write("{}\t{}\t{}\t{}\t{}\t{}\n".format(i, like, article_title, article_author, date, article_url))
    file_write(i, like, article_title, article_author, date, article_url, output_file)
    return


def fcrawl_news(i):
    page_num = i

    url = 'https://outstanding.kr/issue?option=week&page='+str(page_num)
    print(url)

    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
      AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
    html_req = requests.get(url, headers=headers)

    tree = html.fromstring(html_req.text)
    bodies = tree.xpath('//div[@class="issue_list"]/div')
    print(len(bodies))

    results = []

    for body in bodies:

        try:
            like = body.xpath('.//button[@class="vote falsefalse"]/text()')[0]
        except:
            like = ''
        try:
            article_title = body.xpath('.//span[@class="title"]/a/text()')[0]
        except:
            article_title = ''
        try:
            article_author = body.xpath('.//span[@class="author"]/text()')[0]
        except:
            article_author = ''
        try:
            date = body.xpath('.//span[@class="regdate"]/text()')[0]
        except:
            date = ''
        try:
            article_url = body.xpath('.//span[@class="link"]/a/@href')[0]
        except:
            article_url = ''

        if article_title != '':
            article_title_clean = article_title.replace("\n", "").replace("\t", "").replace("\r", "").strip()
            results.append([i, like, article_title_clean, article_author, date, article_url])
            fwrite_news(i, like, article_title_clean, article_author, date, article_url)

    output_file.close()

    return results


def fmain():
    for i in range(1, 5):
        print(i)
        results = fcrawl_news(i)
        print(results)
        time.sleep(3)

fmain()
import requests
from lxml import html
import time

keyword = 'pann'
input_file_name = 'nate_pann_210628_145346.txt'

output_file_main_name = 'nate_' + keyword + "_" + time.strftime("%y%m%d_%H%M%S") + '.txt'
output_file_main = open(output_file_main_name, "w", encoding="utf-8")
output_file_main.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format('글쓴이', '날짜', '조회수', '추천수', '댓글수', '제목', 'URL', '본문'))
output_file_main.close()

headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}


def exp_handle(func):
    def decorated():
        try:
            func()
        except:
            pass
    return decorated


def fget_list():
    input_file = open(input_file_name, "r", encoding="utf-8")
    input_text = input_file.read()
    lines = input_text.splitlines()
    lists = []
    for line in lines[:]:
        elms = line.strip().split("\t")
        page_num = elms[0]
        title = elms[1]
        try:
            url = elms[2]
        except:
            url = ''
        lists.append([page_num, title, url])

    return lists[1:]


def fwrite_article_main(article_media, article_date, view_cnt, thumb_cnt, reply_cnt, article_title, article_url, article_article):
    print([article_media, article_date, view_cnt, thumb_cnt, reply_cnt, article_title, article_url, article_article])
    output_file_main = open(output_file_main_name, "a", encoding="utf-8")
    output_file_main.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format(article_media, article_date, view_cnt, thumb_cnt, reply_cnt, article_title, article_url, article_article))
    return


def fcrawl_article_main(article_title, article_url):
    html_req = requests.get(article_url, headers=headers)
    tree = html.fromstring(html_req.content)
    try:
        article_media = tree.xpath('//a[@class="writer"]/text()')[0]
    except:
        article_media = ''
    try:
        article_date = tree.xpath('//span[@class="date"]/text()')[0]
    except:
        article_date = ''
    try:
        view_cnt = tree.xpath('//span[@class="count"]/tit/text()')[0]
    except:
        view_cnt = 0
    try:
        thumb_cnt = tree.xpath('//span[@class="count"]/text()')[0]
    except:
        thumb_cnt = 0
    try:
        reply_cnt = tree.xpath('//span[@class="num"]/text()')[0].replace('"개의 댓글"', '')
    except:
        reply_cnt = 0
    try:
        article_article = tree.xpath('//div[@id="contentArea"]/descendant-or-self::text()[not(ancestor::script)]')
    except:
        article_article = ''
    article_article = ''.join(article_article)
    article_article = article_article.replace('\n', ' ').replace('\t', ' ').replace('\r', ' ').replace('\xa0', ' ').strip()

    fwrite_article_main(article_media, article_date, view_cnt, thumb_cnt, reply_cnt, article_title, article_url, article_article)

    return
# def getxpath():
#


def fmain():
    lists = fget_list()
    count = 1
    for list in lists[:]:
        print(list)
        article_title = list[1]
        article_url = list[2]
        if len(article_url) == 0:
            continue
        fcrawl_article_main(article_title, article_url)
        time.sleep(6)
        count += 1


fmain()
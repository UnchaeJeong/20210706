import requests
from lxml import html

#. 패키지
# 전역변수
# 함수
#나머지


def totree(url):
    res = requests.get(url, headers=headers)
    trees = html.fromstring(res.content)
    return trees

page = 1
url_root = 'https://gall.dcinside.com'
url_sub = '/board/lists/?id=hit&page='+str(page)
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0'}
url = url_root + url_sub
trees = totree(url)

titles = trees.xpath('//tr[@class="ub-content us-post"]/td[@class="gall_tit ub-word"]/a[not(@class="reply_numbox")]/text()')
links = trees.xpath('//tr[@class="ub-content us-post"]/td[@class="gall_tit ub-word"]/a[not(@class="reply_numbox")]/@href')

results = []
for i in range(len(links)):
    result = [titles[i], url_root+links[i]]
    results.append(result)

for j in range(len(results)):
    contents_url = results[j][1]
    contents_trees = totree(contents_url)

    article = contents_trees.xpath('//div[@class="write_div"]/p/text()')
    content = ''.join(article)
    print(content)
    # content = content.replace('\r','').replace('\t','').replace('\n','').strip()
    # results[j].append(content)
    # print(results[j])


print(results)
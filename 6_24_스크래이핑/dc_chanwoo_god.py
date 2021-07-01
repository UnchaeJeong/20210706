import requests as req
from lxml import html

page = 1
url_root = 'https://gall.dcinside.com'
url_sub = '/board/lists/?id=hit&page='+str(page)
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0'}
url = url_root + url_sub
res = req.get(url, headers = headers)

trees = html.fromstring(res.content)
titles = trees.xpath('//tr[@class="ub-content us-post"]/td[@class="gall_tit ub-word"]/a[not(@class="reply_numbox")]/text()')
links = trees.xpath('//tr[@class="ub-content us-post"]/td[@class="gall_tit ub-word"]/a[not(@class="reply_numbox")]/@href')

results = []
for i in range(len(links)):
    result = [titles[i], url_root+links[i]]
    results.append(result)


for i in range(len(results)):
    url = results[i][1]
    res = req.get(url, headers=headers)
    trees = html.fromstring(res.content)
    article = trees.xpath('//div[@class="write_div"]/p/text()')
    content = ''.join(article)
    content = content.replace('\r','').replace('\t','').replace('\n','').strip()
    results[i].append(content)
    print(results[i])


print(results)
import requests
from lxml import\

    html

url = "https://news.naver.com/"

headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
html_req = requests.get(url, headers=headers)   # headers=headers 통신할때 전달할 바로 위에서 저장한 헤더값을 \
# 헤더라는 속성으로 전달. post방식으로 할 떄는 data라는 속성이 필요

tree = html.fromstring(html_req.content)
#   html.fromstring 문서의 내용을 html 구조로 해석(html_req.content : encoding 하지 않은 상태의 수집 문서)


titles = tree.xpath('//div[@class="hdline_article_tit"]/a/text()')
print(titles)
#   titles 뉴스 제목부분을 추출할 목록을 저장할 변수
#   tree.xpath : tree내용 중에서 ()에 있는 xpath규칙에 맞는 부분 추출.

results = []

for title in titles:
    title_clean = title.replace("\n", " ").replace("\t", " ").replace("\t", " ").replace("\r", " ").strip()
    results.append(title_clean)

print(len(results))
print(results)
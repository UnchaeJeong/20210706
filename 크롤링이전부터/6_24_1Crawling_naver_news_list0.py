##########################   네이버 뉴스 헤드라인 5개 기사 가져오기 ########################################

# import requests
# from lxml import html
#
# url = "https://news.naver.com"
# headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
#  AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
#     #   User-Agent 쓰는 거 까먹지 말고, \로 줄 변경 가능, 구글에서 찾을 수 있음.
# html_req = requests.get(url, headers=headers)
# tree = html.fromstring(html_req.content)
#     #   fromstring 공부**
# titles = tree.xpath('//div[@class="hdline_article_tit"]/a/text()')
#     #   xpath 공부 **
# result = []
#
# for title in titles:
#     title_clean = title.replace("\n", " ").replace("\t", " ").replace("\r", " ").strip()
#     #   \n,\t,\r, strip()은 복붙해놓고 쓰자.
#     result.append(title_clean)
#     #   for문 한 번 더 확인하자.
#
# print(len(result))
#     #   len을 쓴 이유는 길이 확인을 하기 위해서임.
# print(result)
#     #   result 값 생성.

##########################   쿠팡 헤드라인 가져오기 ########################################
# import requests
# from lxml import html
#
# url = "https://www.coupang.com/np/search?component=&q=%EC%9A%B0%EC%9C%A0&channel=user"
# headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
# AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
# html_req = requests.get(url, headers=headers)
#
# tree = html.fromstring(html_req.content)
#
# titles = tree.xpath('//div[@class="name"]/text()')
#
# result = []
#
# for title in titles:
#     title_clean = title.replace("\n", " ").replace("\t", " ").replace("\r", " ").strip()
#     result.append(title_clean)
#
# print(len(result))
# print(result)

##########################   국민청원 가져오기 ########################################
# import requests
# from lxml import html
# url = "https://www1.president.go.kr/petitions"
# headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
# AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
# html_req = requests.get(url, headers=headers)
# tree = html.fromstring(html_req.content)
#
# titles = tree.xpath('//div[@class="bl_subject"]/a/text()')
# result = []
#
# for title in titles:
#     title_clean = title.replace("\n", " ").replace("\t", " ").replace("\r", " ").strip()
#     result.append(title_clean)
#
# print(len(result))
# print(result)

##########################   마리트 별점후기글 가져오기 ########################################
# import requests
# from lxml import html
#
# url = "https://www.myrealtrip.com/offers/104078"
# headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)\
# AppleWebKit/537.36 (HTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
# html_req = requests.get(url, headers=headers)
# tree = html.fromstring(html_req.content)
# titles = tree.xpath('//*[@class="with-more "]/div/text()')
# result = []
# print(result)


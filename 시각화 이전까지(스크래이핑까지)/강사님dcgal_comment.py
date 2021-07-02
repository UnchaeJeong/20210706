import requests
import json

url = "https://gall.dcinside.com/board/comment/"

payload='id=hit&no=16460&cmt_id=hit&cmt_no=16460&e_s_n_o=3eabc219ebdd65f438&comment_page=1&sort=&_GALLTYPE_=G'
headers = {
  'Accept': 'application/json, text/javascript, */*; q=0.01',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7,zh-CN;q=0.6,zh;q=0.5,zh-TW;q=0.4,zh-HK;q=0.3',
  'Connection': 'keep-alive',
  'Content-Length': '100',
  'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  'Cookie': 'adfit_sdk_id=eec94e1d-91fb-4f65-9da5-710cc7b5323d; _ga=GA1.2.347972527.1609481893; dable_uid=42594401.1613183808220; __gads=ID=a6916f7e01a2a1a4-22f7df2766c500c5:T=1609481892:S=ALNI_MZGnm9Rgco36eEHDCumvB03PUemuw; PHPSESSID=60ad31ee43d2c4d313e04781bb8ece65; ci_c=ced3d466d439e3ecaa1e35bfdf4f3d07; remember_secret=jGATcJ05DG; __utmc=118540316; last_notice_no=25612; alarm_popup=1; alarm_new=1; ck_lately_gall=dx%7Cae6%7Cd7%7C3b%7ChK; __utma=118540316.347972527.1609481893.1624844837.1624852381.26; __utmz=118540316.1624852381.26.25.utmcsr=gall.dcinside.com|utmccn=(referral)|utmcmd=referral|utmcct=/board/lists/; __utmt=1; wcs_bt=f92eaecbc22aac:1624852430; __utmb=118540316.6.10.1624852381; last_alarm=1624852650; gallRecom=MjAyMS0wNi0yOCAxMjo1Nzo1Ni8wOWNlNjBlMzdjOWRmYjI5MjgyOGQ5MWYxMDcwMDk5OTY4Mzg5ZTQ0YjMwMmIzMmZlNGM2ZGQxZWE5Mjc1NDk2; service_code=21ac6d96ad152e8f15a05b7350a2475909d19bcedeba9d4face8115e9bc1fd4efc6de6dc3fa2815c459b467e5c9accf65df89cb8bf098221c8d197243fdd35cccfd62f9f24d0f0648697c31ef6d5dbce228b9552f388837372fb15443146f4114be43732036aa3e8c5d7ec2ac0164a2f2074cb5dd34e0c47b9a171c2abba09680d9aa5573d896df91d9bcccd8c457d68cf188fd9b6121211647eca04d6ffeadfa2d89357fcc8fd312221180f0d400c79e120574bd7e2254cc394b85bc88de85b1988d3; sf_ck_tst=test; PHPSESSID=2093ef6c50bff81f1e02ff09d14ea683',
  'Host': 'gall.dcinside.com',
  'Origin': 'https://gall.dcinside.com',
  'Referer': 'https://gall.dcinside.com/board/view/?id=hit&no=16457&page=1',
  'sec-ch-ua': '" Not;A Brand";v="99", "Google Chrome";v="91", "Chromium";v="91"',
  'sec-ch-ua-mobile': '?0',
  'Sec-Fetch-Dest': 'empty',
  'Sec-Fetch-Mode': 'cors',
  'Sec-Fetch-Site': 'same-origin',
  'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36',
  'X-Requested-With': 'XMLHttpRequest'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.content)
print(response.encoding)

elements = json.loads(response.text)['comments']
print(elements)

import requests
import time
import json
class Columns:
    def __init__(self,start,lprice):
        self.start = start
        self.lprice = lprice

    def print_columns(self):
        print(self.start, self.lprice)

column = Columns(10,100)
column.print_columns()
del column
project = 'naver_openapi_Everland'
keyword = '에버랜드 자유이용권'
display = 5
sort = 'sim'

image_path = '../images/'

output_file_name = project + "_list_" + time.strftime("%y%m%d%H%M%S")+'.txt'
output_file = open(output_file_name, "w", encoding="utf-8")
output_file.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format('start', 'display', 'items', 'title', 'link', 'image', 'lprice', 'mallName', 'maker', 'brand'))
output_file.close()


def fwrite_news(start, display, items, title, link, image, lprice, mallName, maker, brand):
    print([start, display, items, title, link, image, lprice, mallName, maker, brand])
    output_file = open(output_file_name, "a", encoding="utf-8")
    output_file.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format('start', 'display', 'items', 'title', 'link', 'image', 'lprice', 'mallName', 'maker', 'brand'))
    output_file.close()

def fcrawl_news(start, display, items, title, link, image, lprice, mallName, maker, brand):

    url = 'https://openapi.naver.com/v1/search/shop.json?query='+keyword+'&display='+str(display)+'&items='+str(items)+'&title='+str(title)+'&link='+str(link)+'&image='+str(image)+'&lprice='+str(lprice)+'&mallName='+str(mallName)+'&maker='+str(maker)+'&brand='+str(brand)

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36',
        'X-Naver-Client-Id': 'E90DzAXCYQXv4Gh5BDkx',
        'X-Naver-Client-Secret': 'WPc00lxRSr'}
    response = requests.get(url, headers=headers)
    elements = json.loads(response.text)['items']
    #elements = tree.iter(tag="items")


    print(len(elements))
    print(elements)


def fmain(start, display, elements):
    for start in range(1, 3):
        print(start)
        fcrawl_news()
        time.sleep(1)

    num = display * (start - 1)

    for element in elements:
        num += 1
        try:
            start = element['start']
            display = element['display']
            items = element['items']
            title = element['title']
            link = element['link']
            image = element['image']
            lprice = element['lprice']
            mallName = element['mallName']
            maker = element['maker']
            brand = element['brand']
            image_file_name = link.split('/')[-1]

            img = requests.get(link).content
            open(image_path+str(start)+'_'+str(num)+'_'+image_file_name+'wb').write(img)
            time.sleep(1)

            fwrite_news(start, display, items, title, link, image, lprice, mallName, maker, brand)
        except:
            continue

    output_file.close()

    return


def fmain():
    for start in range(1, 3):
        print(start)
        fcrawl_news(start)
        time.sleep(1)


fmain()

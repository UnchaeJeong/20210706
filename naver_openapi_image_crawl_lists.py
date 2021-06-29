import requests
import time
import json

project = 'naver_openapi_image'
keyword = '고양이'
display = 5
sort = 'date'

image_path = 'images/'

output_file_name = project + "_list_" + time.strftime("%y%m%d_%H%M%S") + '.txt'
output_file = open(output_file_name, "w", encoding="utf-8")
output_file.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format('start', 'num', 'title', 'link', 'thumbnail', 'sizeheight', 'sizewidth'))
output_file.close()


def fcrawl_news(start):

    url = 'https://openapi.naver.com/v1/search/image?query='+keyword+'&display='+str(display)+'&start='+str(start)+'&sort='+sort
    print(url)

    headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36',
               'X-Naver-Client-Id':'E90DzAXCYQXv4Gh5BDkx',
               'X-Naver-Client-Secret':'WPc00lxRSr'}
    response = requests.get(url, headers=headers)
    elements = json.loads(response.text)['items']
    # elements = tree.iter(tag="items")

    print(len(elements))
    print(elements)

    num = display * (start - 1)

    for element in elements:
        num += 1
        try:
            title = element['title']
            link = element['link']
            thumbnail = element['thumbnail']
            sizeheight = element['sizeheight']
            sizewidth = element['sizewidth']
            image_file_name = link.split('/')[-1]

            img = requests.get(link).content
            open(image_path+str(start)+'_'+str(num)+'_'+image_file_name, 'wb').write(img)
            time.sleep(1)

            fwrite_news(start, num, title, link, thumbnail, sizeheight, sizewidth)
        except:
            continue

    output_file.close()

    return


def fwrite_news(start, num, title, link, thumbnail, sizeheight,sizewidth):
    print([start, num, title, link, thumbnail, sizeheight, sizewidth])
    output_file = open(output_file_name, "a", encoding="utf-8")
    output_file.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format('start', 'num', 'title', 'link', 'thumbnail', 'sizeheight', 'sizewidth'))
    output_file.close()


# def fcrawl_news(start):
#
#     url = 'https://openapi.naver.com/v1/search/image?query='+keyword+'&display='+str(display)+'&start='+str(start)+'&sort='+sort
#     print(url)
#
#     headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36',
#                'X-Naver-Client-Id':'E90DzAXCYQXv4Gh5BDkx',
#                'X-Naver-Client-Secret':'WPc00lxRSr'}
#     response = requests.get(url, headers=headers)
#     elements = json.loads(response.text)['items']
#     # elements = tree.iter(tag="items")
#
#     print(len(elements))
#     print(elements)
#
#     num = display * (start - 1)
#
#     for element in elements:
#         num += 1
#         try:
#             title = element['title']
#             link = element['link']
#             thumbnail = element['thumbnail']
#             sizeheight = element['sizeheight']
#             sizewidth = element['sizewidth']
#             image_file_name = link.split('/')[-1]
#
#             img = requests.get(link).content
#             open(image_path+str(start)+'_'+str(num)+'_'+image_file_name, 'wb').write(img)
#             time.sleep(1)
#
#             fwrite_news(start, num, title, link, thumbnail, sizeheight, sizewidth)
#         except:
#             continue
#
#     output_file.close()
#
#     return


def fmain():
    for start in range(1, 3):
        print(start)
        fcrawl_news(start)
        time.sleep(1)


fmain()
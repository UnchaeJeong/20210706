input_file_name = 'naver_news_킥보드_210624_161926.txt'


def fget_list():
    input_file = open(input_file_name, "r", encoding="utf-8")
    input_text = input_file.read()
    lines = input_text.splitlines()
    lists = []
    for line in lines[:]:
        elms = line.strip().split('\t')
        news_title = elms[2]
        try:
            url = elms[3]
        except:
            url = ''
        lists.append([news_title, url])

    return lists[1:]

results = fget_list()
print(results)
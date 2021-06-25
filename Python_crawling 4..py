import requests #서버 임포트
from lxml import html # 구조 변경
import time # 타임만들어서  스탬프- 파일 중복 방지
keywords = ['킥보드', '자전거']

def fmake_file(keyword):
    output_file_name = 'naver_news_'+keyword+"_"+time.strftime("%y%m%d_%H%M%S") + '.txt' #이름만 정하고
    output_file = open(output_file_name, "w", encoding="utf-8") #파일 생성 'w'
    output_file.write("{}\t{}\t{}\t{}\n".format('페이지','키워드','제목','url')) # 형식, 고정값
    output_file.close()
    return output_file_name #이름만 넘김.

def fwrite_news(i, keyword, news_title_clean, news_url, output_file_name):
    print([i, keyword, news_title_clean, news_url])
    output_file = open(output_file_name, "a", encoding="utf-8")
    output_file.write("{}\t{}\t{}\t{}\n".format(i, keyword, news_title_clean, news_url)) #변수로.
    output_file.close()
    return


def fcrawl_news(keyword, i, output_file_name): #3개 넘겨받음
    page_num = (i - 1) * 10 + 1 #1페이지 넘버
    url = 'https://search.naver.com/search.naver?where=news&sm=tab_pge'\
        '&query='+keyword+'&sort=1&photo=0&field=0&pd=3'\
        '&ds=2021.01.01&de=2021.05.31'\
        '&mynews=0&office_type=0&office_section_code=0&news_office_checked=&nso=so:dd,p:from20210101to20210531,a:all'\
        '&start='+str(page_num) #문자열로 바꿔줌.
    #print(url)
    headers = {'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)\
     Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'} #사이트마다 헤더 요구하는 게 다름. 대부분의 get방식은 user-agent로 가능.
    html_req = requests.get(url, headers=headers)
    tree = html.fromstring(html_req.content)
    bodies = tree.xpath('//ul[@class="list_news"]/li') #전체에서 ul사용한부분중에서 클래스가 []인 애들 중에서 li를 수집. 리스트 형식 저장.
    results = []  #결과값 저장. 빼도 상관은 없음.

    for body in bodies: #하나씩 대입.
        news_title = body.xpath('.//a[@class="news_tit"]/@title')[0] #body에서만 찾기.
        try:
            news_url = body.xpath('.//a[@class="info"]/@href')[0] #네이버뉴스, 구조가 같기 때문에 수집.
        except:
            news_url = '' #오류나는 경우 null값. if문과 다른점은 if문을 사용하면 오류. 값의 길이를 가져오지 못해서?
        news_title_clean = news_title.replace("\n"," ").replace("\t"," ").replace("\r"," ").strip() #공백으로 전환
        results.append([i, keyword, news_title_clean, news_url]) # 생략가능.
        fwrite_news(i, keyword, news_title_clean, news_url, output_file_name) #똑같이 받음. 출력

    return results

def fmain():
    for keyword in keywords:
        output_file_name = fmake_file(keyword)
        for i in range(1,4): #1-3페이지 수집, print해주면 상황정도를 볼 수 있음.
            results = fcrawl_news(keyword, i, output_file_name)
            print(results)
            time.sleep(6) #페이지 당 6초씩 쉬어주는
#   이중반복문 키워드 먼저, 키워드별 문서 작성가능
#   네이버에서 수집시 400개 이상일 경우 제공안함. 조회기간 변경.
fmain()
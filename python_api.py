import requests
import time
from xml.etree import ElementTree
from datetime import date
from dateutil.relativedelta import relativedelta

input_file_name = "region_code5.csv"
secret_key = '2l%2BcnkvPVLvVaX6Oq2YZisy9BHZubFSgtzNOW%2B1Qb0G5BbkwBxuUtZCiacPflWqMsHcFuxDvZaDVegi3965%2Bvg%3D%3D'

date_start = date(2020, 6, 1)
date_end = date(2020, 5, 1)

output_file_name = "trade_apt_api_" + time.strftime("%y%m%d_%H%M%S") + ".txt"
output_file = open(output_file_name, "w", encoding="utf-8")
output_file.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format('기준년월','지역명','지역코드','법정동','아파트',
                                                                            '거래금액','년','월','일','건축년도','전용면적','층'))
output_file.close()

def fget_list():
    input_file = open(input_file_name, "r", encoding="euc-kr")
    input_text = input_file.read()
    lines = input_text.splitlines()
    lists = []
    for line in lines :
        line = line.replace('"','')
        elms = line.strip().split(",")
        region_name = elms[0]
        region_code = elms[1]
        if region_code[:2] == "11":
            lists.append([region_name, region_code])

    return lists

def fget_html(region_name, region_code, this_ym):
    headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.272 Whale/2.9.118.16 Safari/537.36'}
    page_url = "http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade?LAWD_CD=41171&DEAL_YMD=202101&service" \
               "Key=2l%2BcnkvPVLvVaX6Oq2YZisy9BHZubFSgtzNOW%2B1Qb0G5BbkwBxuUtZCiacPflWqMsHcFuxDvZaDVegi3965%2Bvg%3D%3D"
    print(page_url)
    response = requests.get(page_url, headers=headers)
    tree = ElementTree.fromstring(response.content)
    elements = tree.iter(tag="item") #리스트형태로 저장

    for element in elements:
        price = element.find("거래금액").text
        const_year = element.find("건축년도").text
        year = element.find("년").text
        month = element.find("월").text
        day = element.find("일").text
        dong = element.find("법정동").text
        apt_name = element.find("아파트").text
        square = element.find("전용면적").text
        stair = element.find("층").text
        elm_list = [this_ym, region_name, region_code, dong, apt_name,price,year,month,day, const_year, square, stair]
        print(elm_list)
        output_file = open(output_file_name, "a", encoding="utf-8")
        output_file.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format(this_ym, region_name, region_code, dong, apt_name, price, year, month, day,const_year, square, stair))
        output_file.close()
    return

def fmain():
    date_this = date_start
    lists = fget_list()

    while date_this >= date_end:    # while 문은 잘 쓰지 않음.
        print(date_this)
        this_year = str(date_this.year) #date start에서 연도와 월을 구해서 각각 변수에 넣음.
        this_month = str(date_this.month)

        if len(this_month) == 1:
            this_month = "0" + str(this_month)  #자리 수 맞춰주기 위해 0을 넣음.
        this_ym = this_year + this_month

        print(this_ym)
        for list in lists:  #코드, 인증키 3가지 넣기.
            region_name = list[0]
            region_code = list[1]
            print(region_name, region_code)
            fget_html(region_name, region_code, this_ym)

        date_this = date_this - relativedelta(months=1)     #달마다 -1 해주는 것
    return
fmain()

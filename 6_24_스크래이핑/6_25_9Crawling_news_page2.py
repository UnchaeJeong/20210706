import requests
import time
from xml.etree import ElementTree
from datetime import date
from dateutil.relativedelta import relativedelta

input_file_name = "한국관광공사_서비스분류코드_v3.2_160623.csv"
secret_key = '2l%2BcnkvPVLvVaX6Oq2YZisy9BHZubFSgtzNOW%2B1Qb0G5BbkwBxuUtZCiacPflWqMsHcFuxDvZaDVegi3965%2Bvg%3D%3D'
date_start = date(2020, 6, 1)
date_end = date(2021, 5, 1)

output_file_name = "KTO_Tourism_Info_" + time.strftime("%y%m%S%H%M%S") + ".txt"
output_file = open(output_file_name, "w", encoding="utf-8")
output_file.write("{}\t{}\t")

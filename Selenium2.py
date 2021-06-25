import selenium.webdriver as webdriver
import sys

driver = webdriver.Chrome('C://chromedriver/chromedriver.exe')
url_start = 'https://news.naver.com'

if len(sys.argv) == 2:
    keywords = list(sys.argv[1].split('.'))
else:
    keywords = ['NH은행','NH증권']
#coding=utf-8
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from time import sleep

chrome_opt = Options()  # 创建参数设置对象.
chrome_opt.add_argument('--headless')  # 无界面化.
chrome_opt.add_argument('--disable-gpu')  # 配合上面的无界面化.
chrome_opt.add_argument('--window-size=1366,768')  # 设置窗口大小, 窗口大小会有影响.
chrome_opt.add_argument("--no-sandbox") #使用沙盒模式运行
# 创建Chrome对象并传入设置信息.
browser = webdriver.Chrome(chrome_options=chrome_opt)
#url = "https://www.baidu.com/"
#browser.get(url)
#print(browser.page_source)

browser.get("http://10.10.10.52")

sleep(3)

#3.刷新浏览器
browser.refresh()

#4.设置浏览器的大小
#browser.set_window_size(1400,800)

#5.设置链接内容
#element=browser.find_element_by_link_text("用户名")
#element.click()



browser.find_element_by_id("username").send_keys("180917302**")
browser.find_element_by_id("pwd_tip").click()
browser.find_element_by_id("pwd").send_keys("ccit******")

element=browser.find_element_by_id("xiala")
element.click()

sleep(1)


element1=browser.find_element_by_id("_service_0")
element1.click()

element2=browser.find_element_by_id("loginLink")
element2.click()


sleep(1)


browser.close()



browser.quit()

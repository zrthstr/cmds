#!/usr/bin/env python2

from selenium import webdriver
#from selenium.webdriver.common.keys import Keys

xp_table = '//*[@id="proxylisttable"]'
xp_button = '//*[@id="proxylisttable_length"]/label/select/option[3]'

driver = webdriver.Chrome()
driver.get("https://www.xxxxxxx.net/")
driver.find_element_by_xpath(xp_button).click()


#html_obj = driver.find_element_by_xpath(xp_table).get_attribute('outerHTML')
#table = lxml.etree.fromstring("<!DOCTYPE html>" + html_obj + "</html>")
#table = lxml.etree.fromstring(html_obj)
#headers = [header.text_content() for header in table.cssselect("thead tr th")]
#results = [{headers[i]: cell.text_content() for i, cell in enumerate(row.cssselect("td"))} for row in table.cssselect("tbody tr")]


lines = driver.find_element_by_xpath(xp_table).text
lines_split =  [s.strip() for s in lines.splitlines()][1:]

proxys = []
for line in lines_split:
    tl = line.split(" ")
    word_count = len(tl)
    if word_count < 4:
        continue
    del(tl[3:word_count-6])
    del(tl[4])
    del(tl[5:])
    if not "Yes" in tl:
        print "Found potentially non secure proxy: %s" % line
        raise ValueError('A very specific bad thing happened.')
    proxys.append(tl)

print "proxys:", proxys

assert "No results found." not in driver.page_source
driver.close()

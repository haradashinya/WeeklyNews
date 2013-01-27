from BeautifulSoup import BeautifulSoup
import re
from pyquery import PyQuery as pq


import requests


class Link(object):
    def __init__(self):
        # all weekly news title and src
        self.objects = []
        # all link content
        self.weekly_objects = []
    def sort_by(self):
        pass
    # fetch news link's body and take only link tag.

    def is_valid(self,arr):
        for s in arr:
            if s in "title":
                print "found"
                return True
        print "not found"
        return False


    def trim_content(self,content):
        str = content.split(">")
        if len(str) > 1:
            res =  str[1].replace("</a","").strip('"')
            return res

    def trim_href(self,href):
        res = href.replace("title","").strip('"')
        return href

    def format(self,news):
        target_src = news["body"]
        r = requests.get("http://javascriptweekly.com/archive/114.html")
        res = []
        d = pq(r.content)
        links =  str(d("td").find("a")).strip("'").split("href")
        # if title exist then append res
        for link in links:
            if "title" in link:
                dd =  link.split("=")
                res.append({
                    "href":self.trim_href(dd[1]),
                    "content":self.trim_content(dd[2])
                    })
            else:
                continue
                print "not found"
        self.weekly_news = res



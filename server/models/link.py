from BeautifulSoup import BeautifulSoup
from flask import jsonify
import re
import json
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
                return True
        return False


    def trim_content(self,content):
        str = content.split(">")
        if len(str) > 1:
            res =  str[1].replace("</a","").strip('"')
            return res

    def trim_href(self,href):
        res = u'%s' % str(href).strip('\\').replace('title','').encode('utf-8')
        return res

    # get news by article_id
    def format(self,news,article_id):
        target_src = news["body"]
        #r = requests.get("http://javascriptweekly.com/archive/%i.html" % news["number"])
        r = requests.get("http://javascriptweekly.com/archive/%i.html" % article_id)
        res = []
        self.weekly_news  = []
        d = pq(r.content)
        links =  str(d("td").find("a")).strip("'").split("href")
        # if title exist then append res
        # append uniq  data by using idx
        idx = 0
        for link in links:
            idx += 1 
            if "title" in link and idx % 2 != 0:
                dd =  link.split("=")
                res.append({
                    "href":u"%s" % self.trim_href(dd[1]),
                    "content":u"%s" % self.trim_content(dd[2])
                    })
            else:
                continue
                print "not found"

        self.weekly_news = res



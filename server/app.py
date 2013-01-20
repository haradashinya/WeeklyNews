import requests
from flask import Flask
from flask import jsonify
from BeautifulSoup import *
from models.link import Link

import json
import re


app = Flask(__name__)
link = Link()

def is_valid_link(link):
    match = re.match(r'.*\.html',str(link))
    if match:
        return True
    return False

def news_links(dom_content):
    soup = BeautifulSoup(dom_content)
    links = soup.findAll("a")
    res = []
    for link in links:
        if is_valid_link(link):
            res.append(link)
    return sorted_links(links)

## append links to link.objects
def inject_links(links):
    for l in links:
        tmp  =  re.split(r'<a\shref=',str(l))
        number =  re.sub(r'\.*html','',tmp[1]).split(">")[0]
        if re.match(r'"\/"',str(number)):
            pass
        else:
            link.objects.append(
                    {"number": int(number.strip('"')),
                        "body": l}
                    )

## set link.objects order by newest.
def sorted_links(links):
    inject_links(links)
    link.objects = sorted(link.objects,key = lambda link_obj:link_obj["number"])
    return link.objects

def latest_link():
    latest = link.objects.pop()
    return latest

        
    

@app.route("/")
def hello():
    return "hellooo"

@app.route("/news")
def news():
    r = requests.get("http://javascriptweekly.com/archive/")
    print r.status_code
    body = r.content
    links = news_links(body)
    return jsonify(data=["apple","orange","banana"])



if __name__ == "__main__":
    app.debug = True
    app.run()

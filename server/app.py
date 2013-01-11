import requests
from flask import Flask
from flask import jsonify
from BeautifulSoup import *
import json


app = Flask(__name__)

def news_links(dom_content):
    soup = BeautifulSoup(dom_content)
    links = soup.findAll("a")
    return links
    

@app.route("/")
def hello():
    return "hellooo"

@app.route("/news")
def news():
    r = requests.get("http://javascriptweekly.com/archive/1.html")
    # show content
    body = r.content
    links = news_links(body)
    print links
    print r.url
    print r.status_code
    return jsonify(data=["apple","orange","banana"])



if __name__ == "__main__":
    app.debug = True
    app.run()

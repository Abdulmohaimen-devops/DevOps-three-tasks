#!/usr/bin/env python
import requests
import json
# Converts AWS EC2 instance metadata to a dictionary
def load():
    # set the URL that contain the metadata and dict that is append by received data
    metaurl = 'http://169.254.169.254/latest'
    metadict = {'dynamic': {}, 'meta-data': {}, 'user-data': {}}
    for subsect in metadict.keys():
        datacrawl('{0}/{1}/'.format(metaurl, subsect), metadict[subsect])
    return metadict

def datacrawl(url, d):
    r = requests.get(url)
    if r.status_code == 404:
        return
    # split the url to sub urls in a list
    for l in r.text.split('\n'):
        if not l: 
            continue
        newurl = '{0}{1}'.format(url, l)  
        # check if this the final url!
        if l.endswith('/'):
            # remove the "/" from url to be ready for a new request
            newkey = l.split('/')[-2]           
            d[newkey] = {}
            # call datacrawl again to crawl the rest of URL.
            datacrawl(newurl, d[newkey])
        else:
            # it reachs to the final url that have metadata
            r = requests.get(newurl)
            if r.status_code != 404:
                try:
                    # load the data uisng json load
                    d[l] = json.loads(r.text)
                except ValueError:
                    d[l] = r.text
            else:
                d[l] = None
    

print(json.dumps(load()))




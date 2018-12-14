#!/usr/bin/env python

from __future__ import print_function

# https://api.darksky.net/forecast/key/lat,lgt?exclude=minutely,hourly
# https://darksky.net/dev/docs/forecast

import requests
import datetime
import os
import pprint

class DataPoint():
    def __init__(self, d={}):
        self.d = d

        try:
            self.time = datetime.datetime.utcfromtimestamp(int(d['time']))
            self.utime = d['time']
        except:
            pass

    def has(self, name):
        return name in self.d

    def __getattr__(self, name):
        try:
            return self.d[name]
        except KeyError:
            p=pprint.PrettyPrinter(indent=5)
            p.pprint(self.d)
            raise AttributeError("Not available: {}".format(name))


class WeatherAlert():
    def __init__(self, json):
        self.json = json

    def __getattr__(self, name):
        try:
            return self.json[name]
        except KeyError:
            raise AttributeError("Not available: {}".format(name))


def getData(response, json, key):
    keys = ['minutely', 'currently', 'hourly', 'daily']
    try:
        if key == 'currently':
            return DataPoint(json[key])
        else:
            return [DataPoint(datapoint) for datapoint in json[key].get('data', [])]
    except:
        if key == 'currently':
            return None
        else:
            return []

key=""
with open(os.environ.get("ENV_DATA_DIR", "~/.envData") + "/private/api.keys") as keys:
    for line in keys:
        name, value = line.partition("=")[::2]
        if name.strip() == "api.darksky.net":
            key=value.strip()
            break

if key == "":
    print("Couldn't find key for api.darksky.net")
    exit(1)

f=open(os.environ.get("ENV_DATA_DIR", "~/.envData") + "/private/location.txt")
line=f.read()
lat,lgt=line.partition(",")[::2]
lat=lat.strip()
lgt=lgt.strip()
lang="en"
url = 'https://api.darksky.net/forecast/%s/%s,%s?exclude=minutely&units=%s&lang=%s' % (key, lat, lgt, "auto", lang)
response = requests.get(url)
response.raise_for_status()
json = response.json()
headers = response.headers
alerts = []
for alertJSON in json.get('alerts', []):
    alerts.append(WeatherAlert(alertJSON))
data = getData(response, json, "currently")
daily = getData(response, json, "daily")

print(data.time)
print(data.summary)
print(data.icon)
print(data.temperature)
print(data.apparentTemperature)
print(data.humidity)
print(data.precipIntensity)
print(data.precipProbability)

print("_"*80)
for data in daily:
    print(data.time)
    print(data.summary)
    print(data.icon)
    print(data.temperatureMin)
    print(data.temperatureMax)
    print(data.humidity)
    if data.has("precipType"):
        print(data.precipType)
        print(data.precipIntensity)
        print(data.precipProbability)
    print("_"*80)


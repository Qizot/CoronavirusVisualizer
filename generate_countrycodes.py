#!/usr/bin/python3 
# -*- coding: utf-8 -*-
import json

supported = json.load(open("supported_countries.txt", "r"))

graphql_names = [line.strip()[1:-1] for line in open("graphql_countries.txt", "r").readlines()]


graphql = {}

no_name = []

for name in graphql_names:
    if name in supported:
        graphql[name] = supported[name]
    else:
        no_name.append(name)

# manual repair
graphql["US"] = "US"
graphql["Korea, South"] = "KR"
graphql["Czechia"] = "CZ"
graphql["Congo (Brazzaville)"] = "CG" 
graphql["Congo (Kinshasa)"] = "CD"
graphql["Laos"] = "LA"
graphql["Brunei"] = "BN"
graphql["Syria"] = "SY"
graphql["Taiwan*"] = "TW"
graphql["United Arab Emirates"] = "AE"


no_name.remove("US")
no_name.remove("Korea, South")
no_name.remove("Czechia")
no_name.remove("Congo (Brazzaville)")
no_name.remove("Congo (Kinshasa)")
no_name.remove("Laos")
no_name.remove("Brunei")
no_name.remove("Syria")
no_name.remove("Taiwan*")


not_covered = list(set(supported.keys()) - set(graphql.keys())) 
for i in sorted(not_covered):
    print(i, supported[i])

print()
for i in no_name:
    print(i)


json.dump(graphql, fp=open("graphql_countries.json", "w"), indent=4)

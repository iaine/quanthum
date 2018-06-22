'''
  Extract details from the First Folio XML
  files for the QuantHum
'''
import sys
import csv
from lxml import etree

fname = sys.argv[1]

tree = etree.parse(fname)

fn = fname[5:-4]
print(fn)
title = ''
standard_names = []
variant_names = []
ids = []

# extract the standard name
for item in tree.findall(".//{http://www.tei-c.org/ns/1.0}persName[@type='standard']"):
    tm = ''
    if ',' in item.text:
        tm = item.text.split(',')[0]
    else:
        tm = item.text
    standard_names.append(tm)

# extract the variant names
for item in tree.findall(".//{http://www.tei-c.org/ns/1.0}persName[@type='form']"):
    variant_names.append(item.text)



# extract the xml id from the texts
for item in tree.findall(".//{http://www.tei-c.org/ns/1.0}person[@{http://www.w3.org/XML/1998/namespace}id]"):
    _tmp = item.attrib['{http://www.w3.org/XML/1998/namespace}id'].replace(fn+'-', '')
    ids.append(_tmp)

f = open('characters.csv', 'a')
writer = csv.writer(f)
writer.writerow([fn,';'.join(standard_names), ';'.join(variant_names), ';'.join(ids)])
f.close()

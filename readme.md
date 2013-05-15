OpenOnderwijs CSV
-----------------

node.js command line to extract data from the OpenOnderwijs API to CSV

### Installation

Install [Node.js](www.nodejs.org)
```
  git clone https://github.com/markmarijnissen/openonderwijs-csv.git
  cd openonderwijs-csv
  npm install
  npm install LiveScript -g
```

If you are using data-dumps, unzip them to
```
  ./data/duo/vo_board
  ./data/duo/vo_branch
  ./data/duo/vo_school
  ./data/onderwijsinspectie/vo_branch
  ./data/schoolvo/vo_branch
```

### Run
```
  lsc api-to-csv
  lsc json-to-csv
```

See the [API reference](http://openonderwijsdata.staging.dispectu.com/static/documentation/rst/api.html) for the query-string. Example: `q=amsterdam`

See `map.ls` for the document-to-csv mapping. Available data is documented [here](http://openonderwijsdata.staging.dispectu.com/static/documentation/rst/data.html)

### Mapping (map.ls)
  
OpenOnderwijs heeft documenten als volgt geindexeerd:
index: duo, onderwijsinspectie, vensters
type: vo_board (schoolbestuur), vo_school (school), vo_branch (afdeling)
id: document-index

Je kunt per `index/type` combinatie aangeven hoe de data in de CSV moet verschijnen:


#### Copy value to column
```
"duo":
  "vo_board"
    "naam":"name"
```

Schrijft "name" weg onder de "naam" kolom voor alle `duo/vo_board` documenten.

#### Transform a (nested) value to column
```
"duo":
  "vo_board"
    "city": (doc) -> doc.address.city
```

Schrijft de stad weg onder de "city" kolom, deze word uit de geneste address.city gehaald.

Je kunt ook complexere functies gebruiken, b.v.

```
"duo":
  "vo_board":
    "address": (doc) -> doc.address.strees + " " + doc.address.city
```

#### Transform a single document to multiple CSV-rows:
Soms bevat één document meerdere CSV-regels; bijvoorbeeld als je voor één school een lijst met dropouts hebt per jaar. In dat geval wil je niet voor elke school een regel, maar voor elk jaar.

```
"duo":
  "vo_school":
    "dropouts_per_year.total_dropouts": (doc,add) ->
      for i,dropout of doc.dropouts_per_year
        add(dropout.year,dropout.total_dropouts)
```

In dat geval kun je de "add"-functie gebruiken. Deze heeft twee argumenten
- index: dit is de regel-index van het CSV-bestand waarop je splitst, b.v. het jaar
- value: dit is de waarde (b.v. aantal dropouts)
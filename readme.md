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
  ./json/duo/vo_board
  ./json/duo/vo_branch
  ./json/duo/vo_school
  ./json/onderwijsinspectie/vo_branch
  ./json/schoolvo/vo_branch
```

### Run
Interactive prompt:
```
  lsc api-to-csv 
  lsc json-to-csv
```

See the [API reference](http://openonderwijsdata.staging.dispectu.com/static/documentation/rst/api.html) for the query-string. For example: `q=amsterdam`

You can also load a mapping file from the `map` directory:
```
  lsc api-to-csv info.ls
  lsc json-to-csv dropouts.ls
```

### JSON-to-CSV mapping (map/xxx.ls)

OpenOnderwijs has categorized the data sources as follows:

1. **index**: duo, onderwijsinspectie, vensters
2. **type**: vo_board (schoolbestuur), vo_school (school), vo_branch (afdeling)
3. **id**: document-index

Available data is documented [here](http://openonderwijsdata.staging.dispectu.com/static/documentation/rst/data.html)

The `map/xxx.ls` describes for each `index/type` how values are 
extracted.

#### Example 1: Extract a simple value
For example, to extract all "name" field as the "naam" column from all `duo/vo_board`, write this:
```
"duo":
  "vo_board"
    "naam":"name"
```

#### Example 2: Extract and transform a nested value.
Some documents contain nested properties. These can be extracted using a function:
```
"duo":
  "vo_board"
    "city": (doc) -> doc.address.city
```

You can also perform more complex transformations:
```
"duo":
  "vo_board":
    "address": (doc) -> doc.address.strees + " " + doc.address.city
```

#### Example 3: Map a single document to multiple CSV-rows
Sometimes you want to split a single document into multiple rows. For example, when you want to extract the number of dropouts per year.

To split a single document into multiple rows, use the `split` function.
```
"duo":
  "vo_school":
 
    "dropouts_per_year.total_dropouts": (doc,split) ->
      for i,dropout of doc.dropouts_per_year
        split(dropout.year,dropout.total_dropouts)
 
    "dropouts_per_year.total_students": (doc,add) ->
      for i,dropout of doc.dropouts_per_year
        split(dropout.year,dropout.total_students)
```

`split` takes two arguments:

1. `split-index`: the name of your CSV-row, in this case we split a document into years.
2. `value`: the value of that row , in this case number of dropouts or students.

There will be a row for each `split-index`. The split-index (`year`) can be found in the `_split` column. Because both columns (`total_students`, `total_dropouts`) share the same split-index (`year`), the numbers are still valid (and will not get mixed up)
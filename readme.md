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
  lsc api-to-csv # for prompt
  lsc api-to-csv info # to use the "map/dropout" configuration
  lsc json-to-csv # for prompt
  lsc json-to-csv finance # to use the "map/finance" configuration
```

See the [API reference](http://openonderwijsdata.staging.dispectu.com/static/documentation/rst/api.html) for the query-string. Example: `q=amsterdam`

See `map.ls` for the document-to-csv mapping. Available data is documented [here](http://openonderwijsdata.staging.dispectu.com/static/documentation/rst/data.html)

### JSON-to-CSV mapping (map/xxx.ls)

OpenOnderwijs has categorized the data sources as follows:

1. **index**: duo, onderwijsinspectie, vensters
2. **type**: vo_board (schoolbestuur), vo_school (school), vo_branch (afdeling)
3. **id**: document-index

The `map/xxx.ls` configure for each `index/type` combination how values are 
extracted.

For example, to extract all "name" field as the "naam" column from all `duo/vo_board`, write this:
```
"duo":
  "vo_board"
    "naam":"name"
```

#### Extract and transform a nested value.
```
"duo":
  "vo_board"
    "city": (doc) -> doc.address.city
```

Some documents contain nested property. For example, an `address` contains a city. Write a function to extract this value.

You can also use functions for data transormation:
```
"duo":
  "vo_board":
    "address": (doc) -> doc.address.strees + " " + doc.address.city
```

#### Map a single document to multiple CSV-rows
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

`add` takes two arguments:

1. `split-index`: the name of your CSV-row, in this case we split a document into years.
2. `value`: the value of that row , in this case number of dropouts or students.

There will be a row for each `split-index`. The split-index (`year`) can be found in the `_split` column. Because both columns (`total_students`, `total_dropouts`) share the same split-index (`year`), the numbers are still valid (and will not get mixed up)
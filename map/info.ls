module.exports = 
  path: "data"
  query: "q=amsterdam"
  output: "info.csv"
  map:
    "duo":
      "vo_board":
        "name":"name"
        "board_id":"board_id"
        "website":"website"

      "vo_school":
        "name":"name"
        "board_id":"board_id"
        "brin":"brin"

      "vo_branch":
        "name":"name"
        "brin":"brin"
        "board_id":"board_id"
        "brand_id":"brand_id"
        "website":"website"

    "onderwijsinspectie":
      "vo_branch":
        "name":"name"
        "brin":"brin"
        "board":"board"
        "board_id":"board_id"
        "brand_id":"brand_id"
        "website":"website"

    "schoolvo":
      "vo_branch":
        "name":"name"
        "brin":"brin"
        "board":"board"
        "board_id":"board_id"
        "brand_id":"brand_id"
        "website":"website"
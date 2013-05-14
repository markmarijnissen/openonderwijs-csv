/*
  OpenOnderwijs heeft documenten als volgt geindexeerd:
  [index]: duo, onderwijsinspectie, vensters
  [type]: vo_board (schoolbestuur), vo_school (school), vo_branch (afdeling)
  
  elke [index] + [type] combinatie heeft eigen gegevens.

  hieronder staat per index+type een mapping gegeven van kolom-naam naar data.
  deze mapping kan een string of functie zijn.

  "duo":
    "vo_board"
      "name":"name"

  schrijft "name" weg onder de "name" kolom voor alle duo/vo_board documenten.

  "duo":
    "vo_board"
      "city": (doc) -> doc.address.city

  schrijft de stad weg onder de "city" kolom, 
  deze word uit de geneste address.city gehaald.

  Je kunt ook complexere functies gebruiken, b.v.

  "duo":
    "vo_board":
      "address": (doc) -> doc.address.strees + " " + doc.address.city

*/
module.exports = 
  "duo":
    "vo_board":
      "name":"name"
    "vo_school":
      "name":"name"
    "vo_branch":
      "name":"name"
  "onderwijsinspectie":
    "vo_board":
      "name":"name"
    "vo_school":
      "name":"name"
    "vo_branch":
      "name":"name"
  "vensters":
    "vo_board":
      "name":"name"
    "vo_school":
      "name":"name"
    "vo_branch":
      "name":"name"

map = L.map "map",
  center: [33, -20]
  zoom: 2

L.tileLayer("https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png",
  maxZoom: 18
  attribution:
    "Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors,
     <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>,
    Imagery © <a href=\"http://mapbox.com\">Mapbox</a>"
  id: "patbl.hhhi079a"
).addTo(map)

markerData = window.markerData
markers = new L.MarkerClusterGroup()

for currentMarkerData in markerData
  latlng = currentMarkerData.latlng
  popup = currentMarkerData.popup
  icon = L.AwesomeMarkers.icon
    prefix: "fa"
    icon: currentMarkerData.icon
  marker = new L.marker(latlng,
    icon: icon
  ).bindPopup(popup)
  markers.addLayer(marker)

map.addLayer(markers)

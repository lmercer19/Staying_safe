import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import 'package:staying_safe/screens/copyrights_page.dart';

final String apiKey = "RZrPN8h5C4BWs2TaHhBm8akd925h2n0L";
final List<Marker> markers = List.empty(growable: true);

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canterburyCoords =
        LatLng(51.27597, 1.07561); //update this line to be current location

    final marker = Marker(
      width: 50.0,
      height: 55.0,
      point: canterburyCoords,
      builder: (BuildContext context) =>
          const Icon(Icons.location_on, size: 60.0, color: Colors.black),
    );
    markers.add(marker);

    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
        body: Center(
            child: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(center: canterburyCoords, zoom: 13.0),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key={apiKey}",
                  additionalOptions: {"apiKey": apiKey},
                ),
                MarkerLayerOptions(
                  markers: markers,
                ),
              ],
            ),
            Container(
                width: 120.0,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                child: Image.asset("images/tt_logo.png")),
            Container(
                padding: const EdgeInsets.all(30),
                alignment: Alignment.topLeft,
                child: TextField(
                  onSubmitted: (value) {
                    print('$value');
                    getAddresses(value, canterburyCoords.latitude,
                        canterburyCoords.longitude);
                  },
                ))
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.copyright),
          onPressed: () async {
            http.Response response = await getCopyrightsJSONResponse();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CopyrightsPage(
                        copyrightsText: parseCopyrightsResponse(response))));
          },
        ),
      ),
    );
  }
}

/* GET method for copyrights page 
@Return JSON response */
Future<http.Response> getCopyrightsJSONResponse() async {
  var url =
      Uri.parse("https://api.tomtom.com/map/1/copyrights.json?key=$apiKey");
  var response = await http.get(url);
  return response;
}

String parseCopyrightsResponse(http.Response response) {
  if (response.statusCode == 200) {
    StringBuffer stringBuffer = StringBuffer();
    var jsonResponse = convert.jsonDecode(response.body);
    parseGeneralCopyrights(jsonResponse, stringBuffer);
    parseRegionsCopyrights(jsonResponse, stringBuffer);
    return stringBuffer.toString();
  }
  return "Can't get copyrights";
}

void parseRegionsCopyrights(jsonResponse, StringBuffer sb) {
  List<dynamic> copyrightsRegions = jsonResponse["regions"];
  copyrightsRegions.forEach((element) {
    sb.writeln(element["country"]["label"]);
    List<dynamic> cpy = element["copyrights"];
    cpy.forEach((e) {
      sb.writeln(e);
    });
    sb.writeln("");
  });
}

void parseGeneralCopyrights(jsonResponse, StringBuffer sb) {
  List<dynamic> generalCopyrights = jsonResponse["generalCopyrights"];
  generalCopyrights.forEach((element) {
    sb.writeln(element);
    sb.writeln("");
  });
  sb.writeln("");
}

/* GET method for addresses 
@param value, the search term
@param lat, latitude for search bias
@param lon, longitude for search bias
 */
void getAddresses(value, lat, lon) async {
  final Map<String, String> queryParameters = {'key': '$apiKey'};
  queryParameters['lat'] = '$lat';
  queryParameters['lon'] = '$lon';

  var response = await http.get(Uri.https(
      'api.tomtom.com', '/search/2/search/$value.json', queryParameters));
  var jsonData = convert.jsonDecode(response.body);
  print('$jsonData');
  var results = jsonData['results'];
  for (var element in results) {
    var position = element['position'];
    var marker = Marker(
        point: LatLng(position['lat'], position['lon']),
        width: 50.0,
        height: 50.0,
        builder: (BuildContext context) =>
            const Icon(Icons.location_on, size: 40.0, color: Colors.blue));
    markers.add(marker);
  }
}

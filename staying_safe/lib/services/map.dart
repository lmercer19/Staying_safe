import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:staying_safe/screens/auth_screen.dart'; //auth_screen imported to get UID.
import 'package:staying_safe/screens/copyrights_page.dart';

final String apiKey = "RZrPN8h5C4BWs2TaHhBm8akd925h2n0L";
final database = FirebaseDatabase.instance.ref("users/" + user!.uid + "/map/");

final List<String> addresses = List.empty(growable: true);
//final Map<String, String> currentLocation = {'key': '$apiKey'};

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

String latitudedata = '';
String longitudedata = '';

class _MapWidgetState extends State<MapWidget> {
  bool _isVisible = false;
  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitudedata = '${geoposition.latitude}';
    longitudedata = '${geoposition.longitude}';
    setState(() {
      permission;
      print(latitudedata);
      print(longitudedata);
      updateDatabaseUserLocation();
    });
  }

/*
updateDatabaseUserLocation() sends user's lat long coords to database. 
*/
  void updateDatabaseUserLocation() {
    try {
      database.update({"Lat: ": latitudedata, "Long: ": longitudedata}).then(
          (_) => print("database updated"));
    } catch (e) {
      print("You got an error! $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Widget build(BuildContext context) {
    final canterburyCoords = LatLng(double.parse(latitudedata),
        double.parse(longitudedata)); //update this line to be current location

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
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(double.parse(latitudedata),
                          double.parse(longitudedata)),
                      builder: (BuildContext context) => const Icon(
                          Icons.location_on,
                          size: 60.0,
                          color: Colors.blue),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.27754650291323, 1.0848858189432236),
                      builder: (BuildContext context) => const Icon(
                          Icons.person_pin_circle_rounded,
                          size: 50.0,
                          color: Colors.black),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.28016092301291, 1.0659815136477175),
                      builder: (BuildContext context) => const Icon(
                          Icons.person_pin_circle_rounded,
                          size: 50.0,
                          color: Colors.black),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.29549841995869, 1.0743149527322153),
                      builder: (BuildContext context) => const Icon(
                          Icons.person_pin_circle_rounded,
                          size: 50.0,
                          color: Colors.black),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.297837782169836, 1.0576745781358783),
                      builder: (BuildContext context) => const Icon(
                          Icons.person_pin_circle_rounded,
                          size: 50.0,
                          color: Colors.black),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.29609247785077, 1.0872380560292436),
                      builder: (BuildContext context) => const Icon(
                          Icons.add_location_outlined,
                          size: 40.0,
                          color: Colors.red),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.29614366631812, 1.0825111089619404),
                      builder: (BuildContext context) => const Icon(
                          Icons.add_location_outlined,
                          size: 40.0,
                          color: Colors.red),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.28937054045498, 1.0989675972636284),
                      builder: (BuildContext context) => const Icon(
                          Icons.add_location_outlined,
                          size: 40.0,
                          color: Colors.red),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.27344357456131, 1.0717042456296024),
                      builder: (BuildContext context) => const Icon(
                          Icons.pan_tool_rounded,
                          size: 40.0,
                          color: Colors.orange),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.28329803063732, 1.0580725698125895),
                      builder: (BuildContext context) => const Icon(
                          Icons.remove_red_eye,
                          size: 40.0,
                          color: Colors.blue),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.29865872041189, 1.0669460190449243),
                      builder: (BuildContext context) => const Icon(
                          Icons.pan_tool_rounded,
                          size: 40.0,
                          color: Colors.orange),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.28671642968572, 1.0949166745800565),
                      builder: (BuildContext context) => const Icon(
                          Icons.remove_red_eye,
                          size: 40.0,
                          color: Colors.blue),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(51.293512255544755, 1.0933734656854435),
                      builder: (BuildContext context) => const Icon(
                          Icons.remove_red_eye,
                          size: 40.0,
                          color: Colors.blue),
                    ),
                  ],
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
                  onSubmitted: (value) async {
                    print('$value');
                    await getAddresses(value, canterburyCoords.latitude,
                        canterburyCoords.longitude);
                    print("after getAddresses");
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      setState(() {
                        print("inside set state");
                        _isVisible = !_isVisible;
                        print("after visible");
                      });
                      print("after state set");
                    });
                  },
                )),
            Visibility(
              visible: _isVisible,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: addresses.length,
                itemBuilder: (BuildContext context, int index) {
                  print("before address container output");
                  return TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.black,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                      //destinationLatLong = ;
                    },
                    child: Center(child: Text(addresses[index])),
                  );
                },
              ),
            ),
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
getAddresses(value, lat, lon) async {
  final Map<String, String> queryParameters = {'key': '$apiKey'};
  queryParameters['limit'] = '5';
  queryParameters['lat'] = '$lat';
  queryParameters['lon'] = '$lon';

  var response = await http.get(Uri.https(
      'api.tomtom.com', '/search/2/search/$value.json', queryParameters));
  var jsonData = convert.jsonDecode(response.body);
  print('$jsonData');
  var results = jsonData['results'];
  for (var element in results) {
    var address = element['address'];
    var fullAddress = address['freeformAddress'];

    addresses.add(fullAddress);
    //addressesLatLong.add(latLong);
    // var marker = Marker(
    //     point: LatLng(position['lat'], position['lon']),
    //     width: 50.0,
    //     height: 50.0,
    //     builder: (BuildContext context) =>
    //         const Icon(Icons.location_on, size: 40.0, color: Colors.blue));
    // markers.add(marker);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

// OpenSource Routing Machine
// https://project-osrm.org/
// https://map.project-osrm.org/?z=9&center=-6.644147%2C107.858276&loc=-6.921553%2C107.611021&hl=en&alt=0&srv=1

class ApiOSRM {
  requestURI(String longini, String latini, String longend, String latend) {
    String host = 'https://router.project-osrm.org/route/v1/driving/';
    String params = '$longini,$latini;$longend,$latend?geometries=geojson';
    return Uri.parse(host + params);
  }

  Future<List<LatLng>> getRoutes(
      String longini, String latini, String longend, String latend) async {
    try {
      List<LatLng> rPoints = [];
      var res = await http.get(requestURI(longini, latini, longend, latend));
      if (res.statusCode == 200) {
        var rutar =
            jsonDecode(res.body)["routes"][0]["geometry"]["coordinates"];
        for (int i = 0; i < rutar.length; i++) {
          var rFormat = rutar[i].toString();
          rFormat = rFormat.replaceAll("[", "");
          rFormat = rFormat.replaceAll("]", "");
          var lat1 = rFormat.split(',');
          var long1 = rFormat.split(',');
          rPoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
        }
        return rPoints;
      } else {
        throw const FormatException('NO_ROUTE_FOUNDS');
      }
    } on SocketException {
      return [];
    } catch (e) {
      return [];
    }
  }
}

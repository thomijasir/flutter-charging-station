import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charging_station/api_osrm.dart';
import 'package:flutter_charging_station/consts.dart';
import 'package:flutter_charging_station/models/gas_station.dart';
import 'package:flutter_charging_station/models/overviews.dart';
import 'package:flutter_charging_station/screens/near_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:sizer_pro/sizer.dart';

class DetailScreen extends StatefulWidget {
  final GasStation gasStation;
  const DetailScreen({super.key, required this.gasStation});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late final MapController mapController;
  List<Polyline> polyLinesCoordinate = [];

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  void dispose() {
    super.dispose();
    mapController;
  }

  setBound() async {
    final bounds =
        LatLngBounds.fromPoints([currentLocation, widget.gasStation.location]);
    mapController.fitCamera(CameraFit.bounds(
        bounds: bounds,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.w, top: 5.w)));
  }

  getRoutes() async {
    List<LatLng> polyLines = await ApiOSRM().getRoutes(
        currentLocation.longitude.toString(),
        currentLocation.latitude.toString(),
        widget.gasStation.location.longitude.toString(),
        widget.gasStation.location.latitude.toString());

    setState(() {
      if (polyLines.isNotEmpty) {
        var createLine =
            Polyline(points: polyLines, strokeWidth: 3, color: blue);
        polyLinesCoordinate.add(createLine);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final distance = Distance()
        .as(LengthUnit.Meter, currentLocation, widget.gasStation.location);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 165,
        leading: Row(
          children: [
            SizedBox(width: 4.w),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(5.w)),
                child: Row(children: [
                  Icon(
                    Icons.arrow_back,
                    size: 8.f,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    'Detail',
                    style: roboto.copyWith(fontSize: 6.f),
                  )
                ]),
              ),
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: white,
                shape: BoxShape.circle,
                border: Border.all(color: white)),
            child: Icon(
              Icons.favorite_outline_rounded,
              color: black,
              size: 8.f,
            ),
          ),
          SizedBox(width: 2.w),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: white,
                shape: BoxShape.circle,
                border: Border.all(color: white)),
            child: Icon(
              Icons.more_horiz_outlined,
              color: black,
              size: 8.f,
            ),
          ),
          SizedBox(width: 4.w)
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: 100.h,
        width: 100.h,
        child: Stack(
          children: [
            SizedBox(
              height: 40.h,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                    initialCenter: currentLocation,
                    initialZoom: 14.0,
                    onMapReady: () {
                      setBound();
                      getRoutes();
                    }),
                children: [
                  TileLayer(
                    urlTemplate: mapUri,
                  ),
                  PolylineLayer(polylines: polyLinesCoordinate),
                  MarkerLayer(markers: [
                    Marker(
                        width: 60,
                        height: 14.sp,
                        point: currentLocation,
                        alignment: Alignment.topCenter,
                        child: RippleWave(
                          child: CustomMarker(
                            props: ICustomMarker(
                                color: Colors.white,
                                w1: Positioned(
                                    right: 0,
                                    child: Image.asset(
                                      "assets/bmw_i8.png",
                                      width: 14.sp,
                                      height: 14.sp,
                                    )),
                                w2: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Icon(
                                    Icons.radar_rounded,
                                    color: blue,
                                    size: 8.f,
                                  ),
                                )),
                          ),
                        )),
                    Marker(
                        width: 14.sp,
                        height: 14.sp,
                        point: widget.gasStation.location,
                        alignment: Alignment.topCenter,
                        child: CustomMarker(
                          props: ICustomMarker(
                              color: white,
                              w1: ClipOval(
                                child: Image.asset(
                                  widget.gasStation.image,
                                  fit: BoxFit.cover,
                                  width: 23.sp,
                                  height: 23.sp,
                                ),
                              ),
                              w2: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Icon(
                                  Icons.location_on,
                                  color: blue,
                                  size: 8.f,
                                ),
                              )),
                        ))
                  ]),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 61.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: black,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(2.w))),
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_gas_station,
                                color: white,
                                size: 6.f,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Expanded(
                                child: Text(
                                  widget.gasStation.name,
                                  style: roboto.copyWith(
                                      fontSize: 6.f, color: white),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.battery_25,
                                        color: blue,
                                        size: 10.f,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text('14.4%',
                                          style: roboto.copyWith(
                                              fontSize: 9.f, color: white)),
                                    ],
                                  ),
                                  Text('20 Km left',
                                      style: roboto.copyWith(
                                          fontSize: 5.f, color: grey))
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${(distance / 1000).toStringAsFixed(1)} km',
                                    style: roboto.copyWith(
                                        fontSize: 8.f, color: white),
                                  ),
                                  Text(
                                    'Distance',
                                    style: roboto.copyWith(
                                        fontSize: 6.f, color: grey),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '25 Mins',
                                    style: roboto.copyWith(
                                        fontSize: 8.f, color: white),
                                  ),
                                  Text(
                                    'Avg Time',
                                    style: roboto.copyWith(
                                        fontSize: 6.f, color: grey),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100.w,
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(5.w))),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Overviews',
                                  style: roboto.copyWith(
                                    fontSize: 10.f,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.w,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.w, horizontal: 3.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: black.withOpacity(.5)),
                                      borderRadius: BorderRadius.circular(2.w)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: black,
                                        size: 5.f,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.gasStation.address,
                                          style: roboto.copyWith(
                                            fontSize: 5.f,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.w,
                                ),
                                SizedBox(
                                    height: 13.h,
                                    child: ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: overviews.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: index > 0
                                            ? EdgeInsets.only(left: 2.w)
                                            : EdgeInsets.zero,
                                        child: Container(
                                          width: 36.w,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.w, horizontal: 3.w),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: black.withOpacity(.5)),
                                              borderRadius:
                                                  BorderRadius.circular(2.w)),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  overviews[index]['icon'],
                                                  size: 8.f,
                                                ),
                                                SizedBox(
                                                  height: 1.w,
                                                ),
                                                Text(
                                                  overviews[index]['text1'],
                                                  style: roboto.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  overviews[index]['text2'],
                                                  style: roboto.copyWith(
                                                      color:
                                                          black.withOpacity(.5),
                                                      fontSize: 6.f),
                                                )
                                              ]),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: black.withOpacity(.5)),
                                      borderRadius: BorderRadius.circular(2.w),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              widget.gasStation.image),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ]),
                        ),
                        Positioned(
                          right: 2,
                          top: -8.h,
                          child: Image.asset(
                            'assets/bmw_i8.png',
                            width: 50.w,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
        decoration: const BoxDecoration(color: white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(
                    style: roboto.copyWith(
                        color: black, fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                    text: 'Rp.${widget.gasStation.price.toStringAsFixed(1)}',
                    style: roboto.copyWith(fontSize: 12.f),
                  ),
                  TextSpan(
                    text: '/100v',
                    style: roboto.copyWith(
                        fontSize: 6.f, color: black.withOpacity(.5)),
                  ),
                ])),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                    color: blue, borderRadius: BorderRadius.circular(2.w)),
                child: Row(children: [
                  Text(
                    'Direction',
                    style: roboto.copyWith(fontSize: 6.f, color: white),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  const Icon(
                    Icons.directions,
                    color: white,
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

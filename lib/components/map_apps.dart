import 'dart:ui';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';

class MapApps extends StatelessWidget {
  MapApps({
    Key? key,
    required this.coords,
    this.title = '',
  }) : super(key: key);

  final Coords coords;
  final String title;
  var availableMaps = <AvailableMap>[].obs;

  void initState() async {
    availableMaps.value = (await MapLauncher.installedMaps).obs;
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: deepPrimaryColor.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            border: Border.all(color: deepPrimaryColor.withOpacity(0.3)),
          ),
          child: Wrap(
            children: <Widget>[
              Obx(
                () => availableMaps.value.isNotEmpty
                    ? ListView.builder(
                        itemCount: availableMaps.value.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          var map = availableMaps.value[0];
                          return ListTile(
                            onTap: () {
                              map.showDirections(
                                destination: coords,
                                destinationTitle: title,
                              );
                              //   map.showMarker(
                              //     coords: coords,
                              //     title: title,
                              //   );
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => map.showMarker(
                                    coords: coords,
                                    title: title,
                                  ),
                                  icon: const Icon(
                                    FontAwesomeIcons.locationDot,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => map.showDirections(
                                    destination: coords,
                                    destinationTitle: title,
                                  ),
                                  icon: const Icon(
                                    FontAwesomeIcons.locationArrow,
                                    color: Colors.blue,
                                  ),
                                  color: Colors.blue,
                                ),
                                // Icon(
                                //   Icons.navigation,
                                //   color: Colors.blue,
                                // ),
                              ],
                            ),
                            title: Text(
                              map.mapName,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: SvgPicture.asset(
                              map.icon,
                              height: 30.0,
                              width: 30.0,
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

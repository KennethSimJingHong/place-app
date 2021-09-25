import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

Future openMapsSheet(BuildContext ctx, double lat, double lng, String name) async {
  try {
    final coords = Coords(lat, lng);
    final title = name;
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: ctx,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: title,
                      ),
                      title: Text(map.mapName),
                      leading: Image(
                        image: map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  } catch (e) {
    print(e);
  }
}

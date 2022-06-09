import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_group_on/screens/add_activity_screen/blocs/map_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

const kGoogleApiKey = 'AIzaSyBXW44ux6Mw8z_rZY5SSA9ocRxGtzVfleg';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(),
      child: buildScaffold(),
    );
  }

  BlocConsumer<MapCubit, MapState> buildScaffold() {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: context.read<MapCubit>().currentLocation == null
              ? Center(child: CircularProgressIndicator())
              : Column(children: [
                  TextField(
                    decoration: InputDecoration(hintText: "Yer İsmi Giriniz"),
                  ),
                  Expanded(
                    child: Container(
                      child: GoogleMap(
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(41.047867, 28.898272)),
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        onTap: (LatLng latLng) {
                          markersList.clear();
                          markersList.add(Marker(
                              markerId: MarkerId('mark'), position: latLng));
                          setState(() {});
                        },
                        markers: markersList,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context, markersList.first);
                      },
                      icon: Icon(Icons.check)),
                ]),
        );
      },
    );
  }
}

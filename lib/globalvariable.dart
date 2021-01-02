import 'package:cab_rider/data_models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String mapKey = 'AIzaSyBaIAVDQIxwkbGyaOVUC1-SzE8s1Vd-F_w';

final CameraPosition googlePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);
FirebaseUser currentUser;
User currentUserInfo;

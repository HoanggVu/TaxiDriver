import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxibookingdriver/models/driver_data.dart';
import 'package:taxibookingdriver/models/user_models.dart';


final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentUser;

StreamSubscription<Position>? streamSubscriptionPosition;
StreamSubscription<Position>? streamSubscriptionDriverLivePosition;

AssetsAudioPlayer? audioPlayer = AssetsAudioPlayer();

UserModel? userModelCurrentInfo;

Position? driverCurrentPosition;

DriverData onlineDriverData = DriverData();
String? driverVehicleType = "";
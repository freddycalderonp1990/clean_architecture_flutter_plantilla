
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';


import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart' as myGeolocator;

import '../../core/exceptions/exception_helper.dart';
import '../../core/siipne_config.dart';

import '../../core/utils/photo_helper.dart';
import '../../core/exceptions/exceptions.dart';

import '../../data/models/models.dart';
import '../../domain/repositories/domain_repositories.dart';
import '../../domain/request/auth_request.dart';

part 'remote/apis/host.dart';

part 'remote/apis/auth_api_provider.dart';
part 'remote/apis/url_api_provider.dart';
part 'remote/test/ant.dart';

part 'local/local_store_provider.dart';





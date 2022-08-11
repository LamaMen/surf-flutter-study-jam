import 'package:surf_study_jam/surf_study_jam.dart';

/// Data transfer object representing geolocation point.
class ChatGeolocationDto {
  /// Latitude, in degrees.
  final double latitude;

  /// Longitude, in degrees.
  final double longitude;

  /// Constructor for [ChatGeolocationDto].
  ChatGeolocationDto({
    required this.latitude,
    required this.longitude,
  });

  bool get isValid => latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180;

  /// Named constructor for converting DTO from [StudyJamClient].
  ChatGeolocationDto.fromGeoPoint(List<double> geopoint)
      : latitude = geopoint[0],
        longitude = geopoint[1];
  @override
  String toString() => 'ChatGeolocationDto(latitude: $latitude, longitude: $longitude)';

  /// Transforms dto to `List`.
  List<double> toGeopoint() => [latitude, longitude];
}

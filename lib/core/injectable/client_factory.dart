import 'package:injectable/injectable.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

@module
abstract class ClientFactory {
  StudyJamClient get client => StudyJamClient();
}

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_chat_flutter/core/injectable/setup.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(getIt);

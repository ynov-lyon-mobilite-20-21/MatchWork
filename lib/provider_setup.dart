import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/ui/provider/navigation_provider.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependantServices,
  ...uiConsumablesProviders
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: AuthenticationService()),
];
List<SingleChildWidget> dependantServices = [];
List<SingleChildWidget> uiConsumablesProviders = [
  ChangeNotifierProvider(create: (_) => NavigationProvider()),
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  StreamProvider(
      create: (context) =>
          Provider.of<AuthenticationService>(context, listen: false).outUser)
];

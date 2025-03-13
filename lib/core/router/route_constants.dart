class RouteConstants {
  RouteConstants._();

  static const path = _Path();
  static const route = _Route();
}

class _Path {
  const _Path();

  String get splash => '/';
  String get auth => '/auth';
  String get login => '/login';
  String get register => '/register';
  String get pageNotFound => '/pageNotFound';

  String get home => '/home';
  String get settings => '/settings';
  String get profile => '/profile';

  String get wallet => '/wallet';
  String get moneyTransfer => '/money-transfer';
  String get campaign => '/campaign';
  String get campaignDetail => '/campaign/:campaignId';

  String get smart => '/smart';
  String get vehicleList => '/vehicle-list';
  String get vehicleDetails => '/:id';
  String get maintenance => '/maintenance';

  String get counter => '/counter';
  String get counterChild => '/child';

  String get microApp => '/micro-app';
  String get shopMicroApp => '/shop';
}

class _Route {
  const _Route();

  String get splash => '/';
  String get auth => '/auth';
  String get login => '/login';
  String get register => '/register';
  String get pageNotFound => '/pageNotFound';

  String get home => '/home';
  String get settings => '/home/settings';
  String get profile => '/home/profile';

  String get wallet => '/home/wallet';
  String get moneyTransfer => '/home/wallet/money-transfer';
  String get campaign => '/home/campaign';
  String get campaignDeepLink => '/campaign/:campaignId';

  String get smart => '/home/smart';
  String get vehicleList => '/home/vehicle-list';
  String get vehicleDetails => '/home/vehicle-list/:id';
  String get maintenance => '/home/maintenance';

  String get counter => '/home/counter';
  String get counterChild => '/home/counter/child';

  String get microApp => '/home/micro-app';
  String get shopMicroApp => '/home/micro-app/shop';
}

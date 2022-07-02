import 'dart:async';

import 'package:html_scraper/src/apps/base_app.dart';

class BaseAppExample extends BaseApp {
  final String size;
  final int quantity;
  final bool pickup;

  BaseAppExample({
    bool verbose = false,
    bool quiet = false,
    bool dryRun = false,
    required this.size,
    required this.quantity,
    this.pickup = false,
  }) : super(verbose: verbose, dryRun: dryRun, quiet: quiet);

  @override
  Future<void> execute() async {
    print('App will run with the following values');
    print(' - Size: $size');
    print(' - Quantity: $quantity');
    print(' - Pickup: $pickup');
    print(' - Dry Run: $dryRun');
    print(' - Dry Run: $quiet');
    print(' - Verbose: $verbose');
  }
}

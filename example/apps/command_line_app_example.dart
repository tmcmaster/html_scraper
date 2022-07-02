import 'package:args/args.dart';
import 'package:html_scraper/src/apps/command_line_app.dart';

import 'base_app_example.dart';

/// dart command_line_app_example.dart -s small -u 2 -p -n -q -v
void main(List<String> arguments) async {
  await CommandLineApp(
    arguments: arguments,
    parser: ArgParser()
      ..addOption(
        'size',
        abbr: 's',
        mandatory: true,
        allowed: [
          'small',
          'medium',
          'large',
        ],
        help: 'Size of the item',
        allowedHelp: {
          'small': 'Small',
          'medium': 'Medium',
          'large': 'Large',
        },
      )
      ..addOption(
        'quantity',
        abbr: 'u',
        mandatory: true,
        help: 'Number of items',
      )
      ..addFlag(
        'pickup',
        abbr: 'p',
        help: 'Pickup only',
      ),
    app: (options, verbose, quiet, dryRun) async {
      BaseAppExample(
        size: options['size'],
        quantity: int.parse(options['quantity']),
        pickup: options['pickup'],
        quiet: options['quiet'],
        dryRun: options['dry-run'],
        verbose: options['verbose'],
      ).execute();
    },
  ).execute();
}

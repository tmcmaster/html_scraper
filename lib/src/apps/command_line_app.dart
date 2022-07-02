import 'package:args/args.dart';

/// TODO: need to extract to it's own repo as a library
class CommandLineApp {
  static final _OPT_DRY_RUN = 'dry-run';
  static final _OPT_HELP = 'help';
  static final _OPT_VERBOSE = 'verbose';
  static final _OPT_QUIET = 'quiet';

  final ArgParser parser;
  final List<String> arguments;
  final Future<void> Function(ArgResults options, bool verbose, bool quiet, bool dryRun) app;
  final bool verboseDefault;
  final bool quietDefault;
  final bool dryRunDefault;
  CommandLineApp({
    required this.parser,
    required this.arguments,
    required this.app,
    this.verboseDefault = false,
    this.quietDefault = false,
    this.dryRunDefault = false,
  }) {
    parser.addFlag(
      _OPT_HELP,
      abbr: 'h',
      defaultsTo: false,
      negatable: false,
      help: 'Print help message.',
    );
    parser.addFlag(
      _OPT_VERBOSE,
      abbr: 'v',
      defaultsTo: verboseDefault,
      negatable: false,
      help: 'Verbose mode.',
    );
    parser.addFlag(
      _OPT_QUIET,
      abbr: 'q',
      defaultsTo: quietDefault,
      negatable: false,
      help: 'Quiet mode.',
    );
    parser.addFlag(
      _OPT_DRY_RUN,
      abbr: 'n',
      defaultsTo: verboseDefault,
      negatable: false,
      help: 'Print a plan of what is going to be done.',
    );
  }

  void printHelp() {
    print('');
    print(parser.usage);
    print('');
  }

  Future<void> execute() async {
    try {
      final options = parser.parse(arguments);
      bool help = options[_OPT_HELP] ?? false;
      if (help) {
        printHelp();
        return;
      }
      bool verbose = options[_OPT_VERBOSE];
      bool quiet = options[_OPT_QUIET];
      bool dryRun = options[_OPT_DRY_RUN];
      if (verbose) print('verbose = $verbose, quiet = $quiet, dryRun = $dryRun');
      await app(options, verbose, quiet, dryRun);
    } catch (error) {
      print(error);
      printHelp();
    }
  }
}

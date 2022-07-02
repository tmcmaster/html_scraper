abstract class BaseApp {
  final bool quiet;
  final bool verbose;
  final bool dryRun;

  BaseApp({
    this.quiet = false,
    this.verbose = true,
    this.dryRun = false,
  });

  Future<void> execute();
}

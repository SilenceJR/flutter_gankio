class Application {

  static bool get inProduction {return const bool.fromEnvironment("dart.vm.product");}

}
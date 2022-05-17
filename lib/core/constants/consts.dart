class App {
  static ApiAppTexts api = const ApiAppTexts();
  static ErrorAppTexts error = const ErrorAppTexts();
  static UIAppTexts ui = const UIAppTexts();

  App._();
}

class AppRoute {
  AppRoute._();

  static const detailsPageRoute = 'DetailsPageRoute';
  static const homePageRoute = 'HomePageRoute';
}

class ErrorAppTexts {
  const ErrorAppTexts();

  String get serverFailureMessage => 'Server Failure';
  String get notFoundFailureMessage => 'Set your player Tag: #xxxxxxx';
  String get unexpectedError => 'Unexpected error';
  String get unexpectedEvent => 'Unexpected event';
}

class ApiAppTexts {
  const ApiAppTexts();

  String pokemonListApiUrlWithOffset(int offSet) =>
      'https://pokeapi.co/api/v2/pokemon?limit=20&offset=$offSet';
  String get pokemonListApiUrl =>
      'https://pokeapi.co/api/v2/pokemon?limit=20&offset=';
  String get shapesBaseApiUrl => 'https://pokeapi.co/api/v2/pokemon-shape/';
  String get speciesBaseApiUrl => 'https://pokeapi.co/api/v2/pokemon-species/';
  int get itemPrePage => 20;
}

class UIAppTexts {
  const UIAppTexts();

  String get appTitle => 'Pokemon Game';
}

class HomeState {
  final String greeting;

  const HomeState({this.greeting = ''});

  HomeState copyWith({String? greeting}) {
    return HomeState(greeting: greeting ?? this.greeting);
  }
}
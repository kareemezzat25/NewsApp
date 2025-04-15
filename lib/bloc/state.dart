abstract class HomeState {}

class HomeInitState extends HomeState {}

class GetSourcesLoadingState extends HomeState {}

class GetSourcesSuccessState extends HomeState {}

class GetSourcesErrorState extends HomeState {
  String? messageError;
  GetSourcesErrorState({this.messageError});
}

class GetNewsLoadingState extends HomeState {}

class GetNewsSuccessState extends HomeState {}

class GetNewsErrorState extends HomeState {
  String? messageError;
  GetNewsErrorState({this.messageError});
}

class ChangeSelectedIndexState extends HomeState {}

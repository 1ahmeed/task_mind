
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeDataLoadingState extends HomeState {}
class HomeDataSuccessState extends HomeState {}
class HomeDataFailedState extends HomeState {
  final String errorMessage;
  HomeDataFailedState({required this.errorMessage});
}


class SearchSuccessState extends HomeInitial {}

import 'package:bloc/bloc.dart';
import 'package:newsapp/bloc/state.dart';
import 'package:newsapp/models/newsmodel.dart';
import 'package:newsapp/models/sourcemodel.dart';
import 'package:newsapp/repository/repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.repo}) : super(HomeInitState());

  SourceResponse? sourceResponse;
  NewsResponse? newsResponse;
  int selectedIndex = 0;
  HomeRepo repo;

  void changeSelectedIndexTab(int index) async {
    selectedIndex = index;
    await getNewsData();
    emit(ChangeSelectedIndexState());
  }

  getSources(String category) async {
    try {
      emit(GetSourcesLoadingState());
      sourceResponse = await repo.getSources(category);
      if (sourceResponse!.status == "ok") {
        emit(GetSourcesSuccessState());
      } else {
        emit(GetSourcesErrorState(messageError: sourceResponse!.message));
      }
    } catch (e) {
      emit(GetSourcesErrorState(messageError: "SomeThing Went Wrong"));
    }
  }

  Future<void> getNewsData() async {
    try {
      emit(GetNewsLoadingState());
      newsResponse = await repo
          .getNewsData(sourceResponse?.sources?[selectedIndex].id ?? "");
      if (newsResponse!.status == "ok") {
        emit(GetNewsSuccessState());
      } else {
        emit(GetNewsErrorState(messageError: newsResponse!.message));
      }
    } catch (e) {
      emit(GetNewsErrorState(messageError: "SomeThing Went Wrong"));
    }
  }
}

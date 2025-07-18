import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/home/data/models/categories_model.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  final ApiService apiService;
  GetCategoriesCubit(this.apiService) : super(GetCategoriesInitial());
  Future<void> getCategories() async {
    try {
      emit(GetCategoriesLoading());
      final categories = await apiService.getCategories();
      emit(GetCategoriesSuccess(categories: categories));
    } catch (e) {
      emit(GetCategoriesFailure(msg: e.toString()));
    }
  }
}

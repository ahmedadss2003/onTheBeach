import 'package:dio/dio.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/network/api_constant.dart';
import 'package:tourist_website/features/home/data/models/categories_model.dart';
import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';

class ApiService {
  final Dio dio;
  ApiService(this.dio);

  Future<List<TourModel>> getAllTours() async {
    final Response response = await dio.get("${baseUrl}tours");
    final dataList = response.data['data'];
    if (dataList is List) {
      return List<TourModel>.from(
        dataList.map((x) {
          return TourModel.fromJson(x);
        }),
      );
    } else {
      throw Exception('Invalid data format');
    }
  }

  Future<TourModel> getTourById(int id) async {
    try {
      // ✅ جيب كل الـ tours
      final Response response = await dio.get("${baseUrl}tours");

      if (response.statusCode == 200 && response.data['status'] == true) {
        final dataList = response.data['data'] as List;

        // ✅ فلتر بالـ ID
        final tourData = dataList.firstWhere(
          (tour) => tour['id'] == id,
          orElse: () => throw Exception('Tour not found'),
        );

        return TourModel.fromJson(tourData);
      } else {
        throw Exception('Failed to load tours');
      }
    } catch (e) {
      print("❌ Error: $e");
      throw Exception('Failed to fetch tour: $e');
    }
  }

  Future<List<TourModel>> getBestSallerTours() async {
    final Response response = await dio.get("${baseUrl}best-seller-tours");
    final dataList = response.data['data'];

    if (dataList is List) {
      return List<TourModel>.from(
        dataList.map((x) {
          return TourModel.fromJson(x);
        }),
      );
    } else {
      throw Exception('Invalid data format');
    }
  }

  Future<List<TourModel>> searchToursByCategory(String keyword) async {
    final response = await dio.get('$baseUrlForCategory=$keyword');

    final dataList = response.data['data'];

    if (dataList is List) {
      return List<TourModel>.from(dataList.map((x) => TourModel.fromJson(x)));
    } else {
      throw Exception('Invalid data format');
    }
  }

  Future<CategoriesModel> getCategoryById(int id) async {
    try {
      final Response response = await dio.get("${baseUrl}categories/$id");

      if (response.statusCode == 200 && response.data['status'] == true) {
        return CategoriesModel.fromJson(response.data['data']);
      } else {
        throw Exception('Category not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch category: $e');
    }
  }

  Future<void> bookTour(Map<String, dynamic> bookingData) async {
    try {
      final Response response = await dio.post(
        "${baseUrl}book-tour",
        data: bookingData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else if (response.statusCode == 301 || response.statusCode == 302) {
        throw Exception('Redirect error: Check backend configuration');
      } else {
        throw Exception(
          'Booking failed with status ${response.statusCode}: ${response.data}',
        );
      }
    } catch (e) {
      throw Exception('There was an error, please Try later!: $e');
    }
  }

  Future<List<TransportationModel>> getTransportation() async {
    final Response response = await dio.get("${baseUrl}transportations");
    final dataList = response.data['data'];
    if (dataList is List) {
      return List<TransportationModel>.from(
        dataList.map((x) {
          return TransportationModel.fromJson(x);
        }),
      );
    } else {
      throw Exception('Invalid data format');
    }
  }

  Future<void> bookTransportation(Map<String, dynamic> bookingData) async {
    try {
      final Response response = await dio.post(
        "${baseUrl}book-transportation",
        data: bookingData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw Exception('Booking failed , please try again');
      }
    } catch (e) {
      throw Exception('There was an error, Please Try later!: $e');
    }
  }

  Future<List<CategoriesModel>> getCategories() async {
    final Response response = await dio.get("${baseUrl}categories/active");
    final dataList = response.data['data'];
    if (dataList is List) {
      return List<CategoriesModel>.from(
        dataList.map((x) {
          return CategoriesModel.fromJson(x);
        }),
      );
    } else {
      throw Exception('Invalid data format');
    }
  }
}

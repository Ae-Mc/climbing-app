import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/features/update_route/data/datasources/update_route_remote_datasource.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/update_route/domain/entities/route_update.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UpdateRouteRemoteDatasource)
class UpdateRouteRemoteDatasourceImpl implements UpdateRouteRemoteDatasource {
  final Dio dio;

  UpdateRouteRemoteDatasourceImpl(this.dio);

  @override
  Future<Route> updateRoute(String routeId, RouteUpdate route) async {
    final formData = FormData.fromMap({
      'images': route.images.map((image) {
        return MultipartFile.fromBytes(
          image.data,
          filename: image.filename,
          contentType: MediaType.parse(image.filename),
        );
      }).toList(),
    });
    final response = await dio.put<Map<String, dynamic>>(
      '$apiHostUrl/api/v1/routes/$routeId',
      queryParameters: route.toJson(),
      data: formData,
      options: Options(
          receiveTimeout: const Duration(seconds: 5),
          contentType: 'multipart/form-data'),
    );
    final responseRoute = response.data;
    if (responseRoute == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.unknown,
        error: UnimplementedError("Impossible state"),
      );
    }

    return Route.fromJson(responseRoute);
  }
}

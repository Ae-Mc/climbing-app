import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/features/add_route/data/datasources/add_route_remote_datasource.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/add_route/domain/entities/route_create.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

@Singleton(as: AddRouteRemoteDatasource)
class AddRouteRemoteDatasourceImpl implements AddRouteRemoteDatasource {
  final Dio dio;

  AddRouteRemoteDatasourceImpl(this.dio);

  @override
  Future<Route> addRoute(RouteCreate route) async {
    final formData = FormData.fromMap({
      ...route.toJson(),
      'images':
          await Future.wait<MultipartFile>(route.images.map((image) async {
        final contentType = image.mimeType ?? lookupMimeType(image.path);

        return MultipartFile.fromBytes(
          await image.readAsBytes(),
          filename: image.name,
          contentType:
              contentType == null ? null : MediaType.parse(contentType),
        );
      })),
    });
    final response = await dio.post<Map<String, dynamic>>(
      '$apiHostUrl/api/v1/routes',
      data: formData,
      options:
          Options(receiveTimeout: 5000, contentType: 'multipart/form-data'),
    );
    final responseRoute = response.data;
    if (responseRoute == null) {
      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
        type: DioErrorType.other,
        error: UnimplementedError("Impossible state"),
      );
    }

    return Route.fromJson(responseRoute);
  }
}

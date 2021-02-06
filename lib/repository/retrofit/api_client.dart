import 'package:dio/dio.dart';

import 'package:nxgenpro_retrofit_task/repository/model/Comments.dart';
import 'package:nxgenpro_retrofit_task/repository/model/Posts.dart';

import 'package:nxgenpro_retrofit_task/repository/model/data.dart';
import 'package:nxgenpro_retrofit_task/repository/retrofit/apis.dart';
import 'package:retrofit/http.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.users)
  Future<List<User>> getUsers();

  @GET(Apis.comments)
  Future<List<Comments>> getComments();

  @GET(Apis.posts)
  Future<List<Posts>> getPosts();
}

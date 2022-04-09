import 'package:dio/dio.dart' as d;

const api = 'http://192.168.1.132:8000';
d.Dio dio = d.Dio();
d.Options? options;

// ignore: non_constant_identifier_names, constant_identifier_names
const Method GET = Method.GET;
// ignore: non_constant_identifier_names, constant_identifier_names
const Method POST = Method.POST;
// ignore: non_constant_identifier_names, constant_identifier_names
const Method PATCH = Method.PATCH;
// ignore: non_constant_identifier_names, constant_identifier_names
const Method DELETE = Method.DELETE;

enum Method {
  // ignore: constant_identifier_names
  GET,
  // ignore: constant_identifier_names
  POST,
  // ignore: constant_identifier_names
  PATCH,
  // ignore: constant_identifier_names
  DELETE,
}

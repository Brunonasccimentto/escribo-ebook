abstract class Config {
  final String baseUrl = "https://escribo.com/";

  Future<dynamic> getResponse(String url);

}
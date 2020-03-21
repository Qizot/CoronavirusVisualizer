class ApiConfig {

  static ApiConfig _instance;
  String _apiUrl;
 

factory ApiConfig({String apiUrl}){
    if (ApiConfig._instance == null) {
      
    
      ApiConfig._instance = ApiConfig._privateConstructor(apiUrl: apiUrl);
    }
    return ApiConfig._instance;
  }

  ApiConfig._privateConstructor({String apiUrl}): _apiUrl = apiUrl; 


  static ApiConfig get instance => _instance;

  String get apiUrl => _apiUrl;

  void setUrl(String apiUrl) {
    _apiUrl = apiUrl;
  }

}
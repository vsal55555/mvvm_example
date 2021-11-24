


import 'package:mvvm_example/users_list/models/repos_model.dart';
import 'package:mvvm_example/users_list/models/user_profile_model.dart';
import 'package:mvvm_example/users_list/repo/app/data/dio_client.dart';
import 'package:mvvm_example/users_list/repo/app/data/endpoints.dart';

class GithubApi {
  DioClient _client = DioClient();
  
  Future<UserProfile> getUserProfile({String? username}) async {

    try {
      final response = await _client.get('${Endpoints.userProfile}/$username');
      return UserProfile.fromJson(response); //takes response and convert into userprofile obj
    } catch (e) {
      // if (e is DioError) {
      //   if (e.response?.statusCode == 404) {
      //     print("*******");
      //     print(e.response?.statusCode);
      //     print("*******");
      //      print(e.response?.statusMessage);
      //     //handle DioError here by error type or by error code
      //   } else {
      //       //return empty list (you can also return custom error to be handled by Future Builder)
      //   }
        
      // }
      throw e;
    }
  }

    Future<List<Repos>> getRepos({String? username}) async {
    try {
      final List response = await _client
          .get('${Endpoints.userProfile}/$username/${Endpoints.repos}');
        return  response.map((e) => Repos.fromMap(e)).toList();
      //return response.map((item) => Repos.fromMap(item)).toList(); //map basically iterate the functions
    } catch (e) {
      throw e;
    } 
  }
  
}
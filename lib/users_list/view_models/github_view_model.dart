import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_example/routes/app_routes.dart';
import 'package:mvvm_example/users_list/models/repos_model.dart';
import 'package:mvvm_example/users_list/models/user_profile_model.dart';
import 'package:mvvm_example/users_list/repo/app/data/exceptions.dart';
import 'package:mvvm_example/users_list/repo/github_service.dart';
import 'package:mvvm_example/users_list/views/widgets/show_custom_dialog.dart';

class GitHubViewModel extends ChangeNotifier {
  GithubApi _githubApi = GithubApi();
  bool isLoading = false;
  late UserProfile _user;
  List<Repos> _repos = [];


  //setter and getter
  UserProfile get user => _user;
  List<Repos> get repos => _repos;
  
  
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getUserProfile({required String username, required BuildContext ctx}) async {

    setLoading(true);

    try {
      final UserProfile response = await _githubApi.getUserProfile(username: username);
      _user = response;
      print('***Userprofile***');
      print(_user.name);
      setLoading(false);
    // ignore: empty_catches
    } on DioError catch (e) {
      
    final errorMessage =  DioExceptions.fromDioError(e).toString();
    print('***Userprofile***');
    print(errorMessage);
    print('******');
    showCustomDialog(ctx, "Error", errorMessage);
    setLoading(false);
    }
  }

  Future<void> getUserRepos({required String username, required BuildContext ctx}) async {
    setLoading(true);

    try {
      final List<Repos> response = await _githubApi.getRepos(username: username);
      _repos = response;
      print('*************userRepo****************');
      print(_repos);
      setLoading(false);
      Navigator.of(ctx).pushNamed(AppRoutes.user_details);
    } on DioError catch (e) {
    
    print('Im from getUser Repo'); 
    //print(e.message);//Http status error [404]
    final errorMessage =  DioExceptions.fromDioError(e).toString();
    print('***Repo and im not showing dialog ***');
    print(errorMessage);
    print('******');

    setLoading(false);
    }
  }

}

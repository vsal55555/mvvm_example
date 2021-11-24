import 'package:flutter/material.dart';
import 'package:mvvm_example/routes/app_routes.dart';
import 'package:mvvm_example/users_list/models/repos_model.dart';
import 'package:mvvm_example/users_list/view_models/github_view_model.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = context.watch<GitHubViewModel>().user;
    final List<Repos> repoInfo = context.watch<GitHubViewModel>().repos;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 50),
          ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userInfo.avatar_url),
            ),
            title: Text(userInfo.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            subtitle: Text(userInfo.bio, style: TextStyle(color: Colors.white, ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white
                ),
                const SizedBox(height: 20),
                Text(
                  '${userInfo.followers} Followers',
                  style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 20),
                Text(
                  '${userInfo.following} Following',
                  style: TextStyle(color: Colors.white)),
              ],
            )
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Repositories', style: TextStyle(color: Colors.white, fontSize: 25)
            ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count( //gridview didnot know how much space is needed so wrap with expanded
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: repoInfo.map((item) { //map iterate the array and return into ui
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.webview, arguments: item.html_url);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0)
                        ),
                      ),
                      child: Card(
                        color: Colors.black,
                        child: Center(
                          child: Text(item.name,
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                           ),
                        ),
                        
                      ),
                    ),
                  );
                  }).toList(),
                ),
            )
        ],
      ),
    );
  }
}
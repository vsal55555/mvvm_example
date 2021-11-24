import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mvvm_example/users_list/view_models/github_view_model.dart';
import 'package:mvvm_example/users_list/views/localization_service.dart';
import 'package:mvvm_example/users_list/views/widgets/show_Err_Alert_Dialog.dart';
import 'package:mvvm_example/users_list/views/widgets/show_custom_dialog.dart';
import 'package:provider/src/provider.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  const MyHomePage({Key? key}) : super(key: key);

  String lng = "English";
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    lng = LocalizationService().getCurrentLang();
    checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final usernameController = TextEditingController();
    //legacy method of accessing the provider
    //Provider.of(context)
    //stateful(watchful) and stateless(read)
    final model = context.watch<GitHubViewModel>(); //state lye watch

    Future<void> fetchUserInfo() async {
      //watches state, isloading and reflect/show/notify, read simply read and not notify   read is stateless and watch is stateful

      if (usernameController.text.isEmpty == true) {
        model.isLoading = false;
        showCustomDialog(context, "Error", 'Field is empty');
        //setLoading(false);
      } else {
        await context
            .read<GitHubViewModel>()
            .getUserProfile(username: usernameController.text, ctx: context);
        await context
            .read<GitHubViewModel>()
            .getUserRepos(username: usernameController.text, ctx: context);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Column(children: [
          SizedBox(
            height: 150,
            width: 150,
          ),
          SizedBox(
            height: 150,
            width: 150,
            child: FadeInImage(
              height: 150,
              width: 150,
              fadeInDuration: const Duration(milliseconds: 500),
              image: NetworkImage(
                'https://github.githubassets.com/images/modules/logos_page/Octocat.png',),
              placeholder: AssetImage("assets/placeHolder.jpeg"),
              fit: BoxFit.cover,
              imageErrorBuilder: (context, exception, stackTrack) =>
                  Icon(Icons.error),
                  /*
                                    imageErrorBuilder: (context, error, stackTrace) {
                      return Container(child: Image.asset("assets/images/common_screen/ic_default_image.jpg"));
                  },
                   */
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: usernameController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 3.0)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0)),
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: ElevatedButton(
              key: Key('github_login_botton'),
              onPressed: () => fetchUserInfo(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('hello_title'.tr), //Text('Get my profile'),
                  const SizedBox(width: 05),
                  model.isLoading
                      ? CircularProgressIndicator(backgroundColor: Colors.white)
                      : const SizedBox.shrink()
                ]),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Language",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              new DropdownButton<String>(
                items: LocalizationService.langs.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                value: lng,
                focusColor: Colors.white,
                underline: Container(color: Colors.transparent),
                isExpanded: false,
                onChanged: (newVal) {
                  lng = newVal!;
                  LocalizationService().changeLocale(newVal);
                },
              )
            ],
          )
        ]),
      ),
    );
  }

  void checkInternetConnection() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
        this.hasInternet
            ? print('Internet Available')
            : showErrAlertDialog(context);
      });
    });
  }
}

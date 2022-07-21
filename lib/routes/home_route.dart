import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager_app/constants.dart';
import 'package:password_manager_app/engines/engines.dart';
import 'package:password_manager_app/routes.dart';
import 'package:password_manager_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteGenerator.addPasswordRoute);
        },
        backgroundColor: kButtonColor,
        child: const Icon(
          Icons.add,
          size: 40.0,
          color: kMainColor,
        ),
      ),
      backgroundColor: kMainColor,
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => CategoriesEngine(),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            decoration: const BoxDecoration(
              color: kMainColor,
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IosBackButton(onBackButtonPressed: () {
                              Provider.of<UserModel>(context, listen: false)
                                  .resetUser();
                              Provider.of<CredentialsModel>(context,
                                      listen: false)
                                  .resetCredentialsList();
                              Navigator.of(context).pop();
                            }),
                            SingleChildScrollView(
                              child: Text(
                                "Welcome, ${Provider.of<UserModel>(context, listen: false).currentUser!.lastName}!",
                                style: kPrimaryTextStyle,
                              ),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            SearchField(onChangeAction: (newValue) async {
                              await Provider.of<CredentialsModel>(context,
                                      listen: false)
                                  .getCredentialsBySearch(
                                      newValue,
                                      Provider.of<UserModel>(context,
                                              listen: false)
                                          .currentUser!
                                          .userName);
                            }),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CategoriesList(
                              allCategoriesAction: () async {
                                await Provider.of<CredentialsModel>(context,
                                        listen: false)
                                    .getCredentials(Provider.of<UserModel>(
                                            context,
                                            listen: false)
                                        .currentUser!
                                        .userName);
                              },
                              singleCategoriesAction: (index) async {
                                await Provider.of<CredentialsModel>(context,
                                        listen: false)
                                    .getCredentialsByCategory(
                                        Provider.of<UserModel>(context,
                                                listen: false)
                                            .currentUser!
                                            .userName,
                                        kPasswordCategories[index]);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50.0, top: 20.0),
                      child: ListView.builder(
                        itemCount: Provider.of<CredentialsModel>(context)
                            .userCredentials
                            .length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider(
                            create: (context) => CardEngine(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 10.0,
                              ),
                              child: CredentialCard(
                                title: Provider.of<CredentialsModel>(context)
                                    .userCredentials[index]
                                    .title,
                                username: Provider.of<CredentialsModel>(context)
                                    .userCredentials[index]
                                    .email,
                                onCopyPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: Provider.of<CredentialsModel>(
                                              context,
                                              listen: false)
                                          .userCredentials[index]
                                          .password));
                                },
                                onDeletePressed: () {
                                  Provider.of<CredentialsModel>(context,
                                          listen: false)
                                      .deleteCredential(
                                    Provider.of<CredentialsModel>(context,
                                            listen: false)
                                        .userCredentials[index]
                                        .title,
                                    Provider.of<CredentialsModel>(context,
                                            listen: false)
                                        .userCredentials[index]
                                        .email,
                                    Provider.of<UserModel>(context,
                                            listen: false)
                                        .currentUser!
                                        .userName,
                                    Provider.of<CredentialsModel>(context,
                                            listen: false)
                                        .userCredentials[index],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

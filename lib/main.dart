import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //as a precautinary measure do this if u do anything before the actual main function
  await initDependencies();
  runApp(
    //inside the runApp we wrap our app with multiblocprovider
    MultiBlocProvider(
      providers: [
        //inside the providers we list a blocprovider
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //AuthIsUserLoggedIn this is called inside init state because provider events arent automatically called, login and signup gets called whenever the user interacts with widget tree by pressing buttons but we always check the current session when our app runs
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: LoginPage(),
    );
  }
}

//Kinda Notes:
              // (_) => AuthBloc(
              //   //authbloc is the state for authorisation
              //   userSignUp: UserSignUp(
              //     // authorisation state requires a usecase where a user is signed up using information provided and methods from repository implementation "which method to call"
              //     AuthRepositoryImpl(
              //       //handles output of the function called
              //       AuthRemoteDataSourceimpl(
              //         // actually contains the logic to connect to backend
              //         supabase.client,
              //       ),
              //     ),
              //   ),
              // ),
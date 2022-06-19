import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'data/repostories/auth_repostory.dart';
import 'data/repostories/upload_video_repostory.dart';
import 'firebase_options.dart';
import 'logic/blocs/auth/auth_bloc.dart';
import 'views/app_routes.dart';
import 'views/dialogs/upload_image_dailog.dart';
import 'views/loading/loading_screen.dart';
import 'views/screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: AppBlocObserver(),
  );
}

/// Custom [BlocObserver] that observes all bloc and cubit state changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // ignore: avoid_print
    print(transition);
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepostory>(
              create: (_) => AuthRepostory(),
            ),
            RepositoryProvider<UploadVideoRepostory>(
              create: (_) => UploadVideoRepostory(),
            ),
          ],
          child: BlocProvider(
            create: (context) => AuthBloc(
              authRepostory: RepositoryProvider.of<AuthRepostory>(context),
            )..add(
                IntitlizeEvent(),
              ),
            child: MaterialApp(
              onGenerateRoute: onGenerateRoute,
              debugShowCheckedModeBanner: false,
              title: 'TikTok clone',
              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: Colors.white,
              ),
              home: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoadingState) {
                    LoadingScreen.instance().show(
                      context: context,
                      text: 'Loading...',
                    );
                  } else {
                    LoadingScreen.instance().hide();
                  }
                  if (state is AuthErrorState) {
                    showAuthErrorDailog(
                      authError: state.authError,
                      context: context,
                    );
                  }
                },
                builder: (context, authState) {
                  if (authState is AuthanticatedState) {
                    return const MainScreen();
                  } else if (authState is IsInSignUpScreenState) {
                    return const SignUpScreen();
                  } else {
                    return LoginScreen();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

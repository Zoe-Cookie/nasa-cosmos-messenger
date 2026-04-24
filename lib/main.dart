import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_cosmos_messenger/data/repositories/api_service.dart';
import 'package:nasa_cosmos_messenger/data/repositories/favorite_repository.dart';
import 'package:nasa_cosmos_messenger/logic/cubit/apod_cubit.dart';
import 'package:nasa_cosmos_messenger/ui/screens/home_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  
  runApp(const NasaCosmosMessenger());
}

class NasaCosmosMessenger extends StatelessWidget {
  const NasaCosmosMessenger({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiService()),
        RepositoryProvider(create: (context) => FavoriteRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ApodCubit(context.read<ApiService>()),
          ),
        ],
        child: MaterialApp(
          title: 'NASA Cosmos Messenger',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          home: const HomeScreen(), // 指向我們 App 的入口畫面
        ),
      ),
    );
  }
}
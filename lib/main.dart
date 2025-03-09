import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_center/data/model/game.dart';
import 'package:game_center/services/ai_service.dart';
import 'package:game_center/ui/screens/setting_page.dart';
import 'package:game_center/core/utils/empty_space.dart';
import 'package:game_center/core/utils/my_custom_scroll_behavior.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_center/bloc/game_bloc.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GameAdapter());
  final gameBox = await Hive.openBox<Game>('state.games');

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    fullScreen: false,
    windowButtonVisibility: true,
    center: false,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager
        .setMinimumSize(const Size(800, 600)); // Set minimum size
    await windowManager.show();
    await windowManager.focus();
  });

  try {
    AiService.initial();
  } catch (e) {
    if (kDebugMode) {
      print("Error in load Ai: $e");
    }
  }

  runApp(MyApp(gameBox: gameBox));
}

class MyApp extends StatelessWidget {
  final Box<Game> gameBox;
  const MyApp({super.key, required this.gameBox});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(gameBox)..add(LoadGames()),
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        // darkTheme: AppTheme.dark,
        // theme: AppTheme.light,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark().copyWith(
          surface: Colors.grey[900],
        )),
        home: const MyHomePage(),
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  final FocusNode _focusNode = FocusNode();

  void _showContextMenu(BuildContext context, Offset position, int index) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        position & const Size(40, 40), // smaller rect, the touch area
        Offset.zero & overlay.size, // Bigger rect, the entire screen
      ),
      items: [
        PopupMenuItem(
          child: Text('Action 1'),
          onTap: () {
            // Handle Action 1
          },
        ),
        PopupMenuItem(
          child: Text('Action 2'),
          onTap: () {
            // Handle Action 2
          },
        ),
      ],
    );
  }

  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    _timeStream = Stream<DateTime>.periodic(
        const Duration(minutes: 1), (_) => DateTime.now());
  }

  @override
  void dispose() {
    _timeStream.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => SettingPage(),
            ));
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 400,
            height: 36,
            child: SearchBar(
              onSubmitted: (value) {},
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
                _focusNode.requestFocus();
              },
              textInputAction: TextInputAction.search,
              hintText: 'Search for state.games...',
              leading: Icon(Icons.search),
              side: WidgetStatePropertyAll(
                  BorderSide(color: Theme.of(context).colorScheme.onSurface)),
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              textStyle:
                  WidgetStatePropertyAll(Theme.of(context).textTheme.bodySmall),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view_rounded),
            onPressed: () {},
          ),
          12.w,
          StreamBuilder<DateTime>(
            stream: _timeStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  TimeOfDay.fromDateTime(snapshot.data!).format(context),
                  style: TextStyle(fontSize: 16),
                );
              } else {
                return Text(
                  TimeOfDay.now().format(context),
                  style: TextStyle(fontSize: 16),
                );
              }
            },
          ),
          24.w,
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state.games.isEmpty) return SizedBox.shrink();
          return Stack(
            children: [
              Positioned.fill(
                  child: ValueListenableBuilder(
                      valueListenable: selectedIndex,
                      builder: (context, index, _) {
                        return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                            child: Image.file(
                              File(state.games[index].backgroundImage),
                              width: double.infinity,
                              height: double.infinity,
                              key: ValueKey<int>(index),
                              fit: BoxFit.cover,
                              opacity: AlwaysStoppedAnimation(0.5),
                            ));
                      })),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                      valueListenable: selectedIndex,
                      builder: (context, sIndex, _) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.games[sIndex].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  height:
                                      8), // Add some space between title and description
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.sizeOf(context).width * 0.5),
                                child: Text(
                                  state.games[sIndex].description,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  12.h,
                  Focus(
                    focusNode: _focusNode,
                    autofocus: true,
                    onKeyEvent: (FocusNode node, KeyEvent event) {
                      if (event is KeyDownEvent) {
                        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                          _carouselController.previousPage();
                          return KeyEventResult.handled;
                        } else if (event.logicalKey ==
                            LogicalKeyboardKey.arrowRight) {
                          _carouselController.nextPage();
                          return KeyEventResult.handled;
                        }
                        if (event.logicalKey == LogicalKeyboardKey.enter) {
                          if (state.games[selectedIndex.value].exePath
                              .replaceAll(' ', '')
                              .isNotEmpty) {
                            Process.run(
                                state.games[selectedIndex.value].exePath,
                                []).then((ProcessResult results) {
                              // print(results.stdout);
                              // print(results.stderr);
                            });
                          }
                        }
                      }

                      return KeyEventResult.ignored;
                    },
                    child: CarouselSlider.builder(
                        carouselController: _carouselController,
                        itemCount: state.games.length,
                        itemBuilder: (context, index, realIndex) {
                          return GestureDetector(
                            onSecondaryTapDown: (details) {
                              _showContextMenu(
                                  context, details.globalPosition, index);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: AspectRatio(
                                aspectRatio: 3 / 4,
                                child: ValueListenableBuilder(
                                    valueListenable: selectedIndex,
                                    builder: (context, sIndex, _) {
                                      return Stack(
                                        children: [
                                          Positioned.fill(
                                            child: CupertinoContextMenu(
                                              actions: [
                                                CupertinoContextMenuAction(
                                                  child: Text('Hi'),
                                                )
                                              ],
                                              child: Image.file(
                                                File(state.games[index].image),
                                                fit: BoxFit.cover,
                                                color: sIndex != index
                                                    ? Colors.black
                                                        .withAlpha(180)
                                                    : null,
                                                colorBlendMode:
                                                    BlendMode.multiply,
                                              ),
                                            ),
                                          ),
                                          if (sIndex == index)
                                            Positioned(
                                              right: 16,
                                              bottom: 16,
                                              child: ElevatedButton.icon(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8))),
                                                  onPressed: () {
                                                    if (state
                                                        .games[index].exePath
                                                        .replaceAll(' ', '')
                                                        .isNotEmpty) {
                                                      Process.run(
                                                              state.games[index]
                                                                  .exePath,
                                                              [])
                                                          .then((ProcessResult
                                                              results) {
                                                        // print(results.stdout);
                                                        // print(results.stderr);
                                                      });
                                                    }
                                                  },
                                                  icon: Icon(
                                                      Icons.gamepad_rounded),
                                                  label: Text("Play")),
                                            )
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              selectedIndex.value = index;
                            },
                            aspectRatio: 3 / 4,
                            padEnds: false,
                            height: MediaQuery.sizeOf(context).width * 0.2,
                            viewportFraction: 1 / 6,
                            enlargeFactor: 0.1,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true)),
                  ),
                  64.h,
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

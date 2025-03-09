// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_center/bloc/game_bloc.dart';
import 'package:game_center/core/utils/empty_space.dart';
import 'package:game_center/data/model/game.dart';
import 'package:game_center/services/ai_service.dart';
import 'package:game_center/services/image_findd_services.dart';
import 'package:game_center/services/pick_file.dart';
import 'package:game_center/ui/theme/theme.dart';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key});

  @override
  State<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final name = TextEditingController();
  final path = TextEditingController();
  final cover = TextEditingController();
  final backCover = TextEditingController();
  final desc = TextEditingController();
  final cat = TextEditingController();
  final GlobalKey<FormState> _createFormState = GlobalKey<FormState>();

  PlatformFile? selectedCoverArt;
  PlatformFile? selectedBackArt;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createFormState,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: path,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Path or URL is required';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: defaultTextFieldInputDecoration(context).copyWith(
                  labelText: '* Path or URL',
                  hintText:
                      'for Example https://www.epicgames.com/store/en-US/p/god-of-war',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final file = await PickFile.pickExeFile();
                      if (kDebugMode) {
                        print(file?.path);
                      }
                      path.text = file?.path ?? '';
                    },
                    icon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              16.h,
              TextFormField(
                controller: name,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: defaultTextFieldInputDecoration(context).copyWith(
                  labelText: '* Name of Game',
                  hintText: 'for Example God of War',
                ),
              ),
              16.h,
              TextFormField(
                controller: cover,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  return null;
                },
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: defaultTextFieldInputDecoration(context).copyWith(
                  labelText: 'Cover art of Game',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      selectedCoverArt = null;
                      cover.clear();
                      final file = await PickFile.pickImageFile();
                      selectedCoverArt = file;
                      cover.text = file?.path ?? '';
                    },
                    icon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              16.h,
              TextFormField(
                controller: backCover,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  return null;
                },
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: defaultTextFieldInputDecoration(context).copyWith(
                  labelText: 'Cover Background of Game',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      selectedBackArt = null;
                      backCover.clear();
                      final file = await PickFile.pickImageFile();
                      selectedBackArt = file;
                      backCover.text = file?.path ?? '';
                    },
                    icon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              16.h,
              TextFormField(
                controller: desc,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  return null;
                },
                style: Theme.of(context).textTheme.bodyLarge,
                minLines: 4,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: defaultTextFieldInputDecoration(context).copyWith(
                  labelText: 'Description of Game',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        // await ImageFinddServices.getImages('Spiderman');

                        if (!_createFormState.currentState!.validate()) {
                          return;
                        }
                        selectedCoverArt ??=
                            await ImageFinddServices.downloadAndSaveImage(
                                'https://picsum.photos/1500/2000',
                                name: name.text);
                        selectedBackArt ??=
                            await ImageFinddServices.downloadAndSaveImage(
                                'https://picsum.photos/2000/1125',
                                name: name.text);
                        if (desc.text.isEmpty) {
                          final response = await AiService.getResponse(
                              'find a good and interesting Description for Game ${name.text} minimum 6 line and be usefull and just send me the Description not anything else');
                          if (response != null) {
                            desc.text = response.toString().replaceAll(
                                RegExp(r'^\s*[\r\n]', multiLine: true), '');
                          }
                        }
                        context.read<GameBloc>().add(AddGame(Game(
                            title: name.text,
                            image: selectedCoverArt?.path ?? '',
                            backgroundImage: selectedBackArt?.path ?? '',
                            exePath: path.text,
                            description: desc.text)));
                      },
                      child: Text('Create'))),
              16.w,
              Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel')))
            ],
          )
        ],
      ),
    );
  }
}

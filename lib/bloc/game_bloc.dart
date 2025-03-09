import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_center/data/model/game.dart';
import 'package:hive/hive.dart';

class GameEvent {}

class LoadGames extends GameEvent {}

class AddGame extends GameEvent {
  final Game game;
  AddGame(this.game);
}

class DeleteGame extends GameEvent {
  final String id;
  DeleteGame(this.id);
}

class UpdateGame extends GameEvent {
  final Game game;
  UpdateGame(this.game);
}

class GameState {
  final List<Game> games;
  GameState(this.games);
}

class GameBloc extends Bloc<GameEvent, GameState> {
  final Box<Game> gameBox;

  GameBloc(this.gameBox) : super(GameState([])) {
    on<LoadGames>((event, emit) {
      final games = gameBox.values.toList();
      emit(GameState(games));
    });

    on<AddGame>((event, emit) {
      gameBox.put(event.game.id, event.game);
      add(LoadGames());
    });

    on<DeleteGame>((event, emit) {
      gameBox.delete(event.id);
      add(LoadGames());
    });

    on<UpdateGame>((event, emit) {
      gameBox.put(event.game.id, event.game);
      add(LoadGames());
    });
  }
}

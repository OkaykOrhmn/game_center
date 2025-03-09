import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game {
  @HiveField(0)
  late String id; // Generate unique ID
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String backgroundImage;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String exePath;

  Game({
    required this.title,
    required this.image,
    required this.backgroundImage,
    required this.description,
    this.exePath = '',
  }) {
    id = Uuid().v4();
  }
}

List<Game> games = [
  Game(
    title: "The Witcher 3: Wild Hunt",
    image:
        "https://upload.wikimedia.org/wikipedia/en/0/0c/Witcher_3_cover_art.jpg",
    backgroundImage:
        "https://images.hdqwalls.com/download/the-witcher-3-wild-hunt-games-3840x2160.jpg",
    description:
        "An open-world RPG set in a visually stunning fantasy universe full of meaningful choices and impactful consequences. You play as Geralt of Rivia, a monster hunter for hire, on a quest to find his adopted daughter.",
  ),
  Game(
    title: "Cyberpunk 2077",
    image:
        "https://upload.wikimedia.org/wikipedia/en/9/9f/Cyberpunk_2077_box_art.jpg",
    backgroundImage:
        "https://images.hdqwalls.com/download/4k-cyberpunk-2077-2020-4o-3840x2160.jpg",
    description:
        "An open-world, action-adventure story set in Night City, a megalopolis obsessed with power, glamour, and body modification. You play as V, a mercenary outlaw going after a one-of-a-kind implant that is the key to immortality.",
  ),
  Game(
    title: "Red Dead Redemption 2",
    image:
        "https://upload.wikimedia.org/wikipedia/en/4/44/Red_Dead_Redemption_II.jpg",
    backgroundImage:
        "https://images7.alphacoders.com/133/thumb-1920-1332702.png",
    description:
        "An epic tale of life in America’s unforgiving heartland, with a vast and atmospheric world. You play as Arthur Morgan, a member of the Van der Linde gang, as he navigates the decline of the Wild West.",
  ),
  Game(
    title: "God of War",
    image:
        "https://upload.wikimedia.org/wikipedia/en/a/a7/God_of_War_4_cover.jpg",
    backgroundImage:
        "https://images.hdqwalls.com/download/kratos-god-of-war-4k-game-p3-3840x2160.jpg",
    description:
        "A bold new beginning for Kratos, set in the realm of Norse gods and monsters. You embark on a deeply personal quest with your son Atreus, facing powerful enemies and exploring breathtaking landscapes.",
  ),
  Game(
    title: "Grand Theft Auto V",
    image:
        "https://upload.wikimedia.org/wikipedia/en/a/a5/Grand_Theft_Auto_V.png",
    backgroundImage:
        "https://www.hdwallpapers.in/thumbs/2013/grand_theft_auto_v-t2.jpg",
    description:
        "An action-adventure game set in the fictional state of San Andreas, based on Southern California. You switch between three protagonists—Michael, Franklin, and Trevor—as they plan and execute a series of heists.",
  ),
];

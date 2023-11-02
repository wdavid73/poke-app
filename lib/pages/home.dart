import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:poke_app/ui/color_manager.dart';
import 'package:poke_app/utils/navigation_manager.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/utils/styles_manager.dart';
import 'package:poke_app/widgets/search_pokemon.dart';
import 'package:poke_app/widgets/water_mark.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String version = '';

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<String> _getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  void _init() async {
    String ver = await _getVersionInfo();
    setState(() => version = ver);
  }

  closeDrawer() {
    Navigator.pop(context);
  }

  goToAddPokemon() {
    closeDrawer();
    Navigator.pushNamed(context, 'create_pokemon');
  }

  goToListType() {
    closeDrawer();
    Navigator.pushNamed(context, 'list_type_pokemon');
  }

  goToTest() {
    closeDrawer();
    Navigator.pushNamed(context, 'test_page');
  }

  goToListPokemon() {
    closeDrawer();
    NavigationManager.go(context, "list_pokemon");
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    // TODO: Implement update Pokemon

    // TODO: Implement List Types Available
    // TODO: Implement Create type Pokemon
    // TODO: Implement delete Type Of Pokemon
    // TODO: Implement update type of pokemon

    // TODO: Change icon of app
    // TODO: home page implement reload list with scroll vertical

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: responsive.width,
            height: responsive.height,
            color: ColorManager.lightGreyVariationTwo,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: responsive.width,
                  height: responsive.hp(70),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: responsive.wp(60),
                        top: -responsive.hp(15),
                        child: const WaterMark(
                          opacity: 0.2,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: kToolbarHeight,
                            ),
                            Text(
                              "What Pokemon",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ColorManager.textPrimary,
                                fontSize: responsive.dp(4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "are you looking for?",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ColorManager.textPrimary,
                                fontSize: responsive.dp(4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SearchPokemon(
                              responsive: responsive,
                            ),
                            Expanded(
                              child: GridView.count(
                                padding: EdgeInsets.zero,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                childAspectRatio: (1 / 0.5),
                                children: [
                                  ItemMenu(
                                    key: const Key('option_pokedex'),
                                    colorItem: Colors.greenAccent,
                                    title: "Pokedex",
                                    onTap: () => goToListPokemon(),
                                  ),
                                  const ItemMenu(
                                    key: Key('option_abilities'),
                                    colorItem: Colors.blueAccent,
                                    title: "Abilities",
                                  ),
                                  const ItemMenu(
                                    key: Key('option_locations'),
                                    colorItem: Colors.purpleAccent,
                                    title: "Locations",
                                  ),
                                  const ItemMenu(
                                    key: Key('option_moves'),
                                    colorItem: Colors.redAccent,
                                    title: "Moves",
                                  ),
                                  const ItemMenu(
                                    key: Key('option_items'),
                                    colorItem: Colors.amberAccent,
                                    title: "Items",
                                  ),
                                  const ItemMenu(
                                    key: Key('option_type_charts'),
                                    colorItem: Colors.brown,
                                    title: "Type Charts",
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: responsive.width,
                    height: responsive.hp(25),
                    alignment: Alignment.center,
                    child: const PokeNews(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Version $version",
                    style: getMediumStyle(
                      color: Colors.black,
                      fontSize: responsive.dp(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PokeNews extends StatelessWidget {
  const PokeNews({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pokémon News",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.dp(2.5),
                ),
              ),
              Text(
                "View All",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.dp(2),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return NewsItem(height: responsive.hp(12));
            },
          ),
        )
      ],
    );
  }
}

class ItemMenu extends StatelessWidget {
  final Color colorItem;
  final String title;
  final void Function()? onTap;
  const ItemMenu(
      {super.key, required this.colorItem, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double margin = 15;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: responsive.width,
        height: responsive.hp(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: darken(colorItem),
          boxShadow: [
            BoxShadow(
              color: colorItem.withOpacity(0.8),
              blurRadius: 25,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: -responsive.wp(20),
                top: -responsive.hp(14),
                child: WaterMark(
                  opacity: 0.5,
                  size: 15,
                  color: lighten(colorItem),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: margin),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                right: -responsive.wp(7),
                top: -responsive.hp(2),
                child: WaterMark(
                  opacity: 0.5,
                  size: 10,
                  color: lighten(colorItem),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final double height;
  const NewsItem({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Column(
      children: [
        Container(
          height: height,
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: responsive.wp(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pokemon Rumble Rush Arrives Soon",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.dp(1.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "15 may 2023",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: responsive.dp(1.2),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

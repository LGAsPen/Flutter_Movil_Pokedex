import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/provider/provider_selection.dart';
import 'package:pokemon_pokedex/src/api/getData.dart';
import 'package:pokemon_pokedex/src/json/pokemType.dart';
import 'package:pokemon_pokedex/src/pages/Principal/home_generations.dart';
import 'package:pokemon_pokedex/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({Key? key}) : super(key: key);

  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final Widgets _widgets = Widgets();
  final GetData _getData = GetData();
  static int typeView = 0;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ProviderSelection _providerSelection =
        context.watch<ProviderSelection>();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(136, 153, 182, 1),
          title: const Text(
            'POKEMON',
            style: TextStyle(fontFamily: 'RubikDirt-Regular', fontSize: 25),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4.0,
            controller: _tabController,
            tabs: const [
              Tab(text: 'Generations'),
              Tab(text: 'Types'),
            ],
          ),
        ),
        //bottomNavigationBar: _bottomNavigationBar(),
        body: Stack(
          children: [
            TabBarView(
                controller: _tabController,
                children: [_gridGenerations(), _types()]),
          ],
        ));
  }

  Widget _gridGenerations() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          width: double.infinity,
          child: IconButton(
              onPressed: () {
                setState(() {
                  if (typeView == 1) {
                    typeView = 0;
                  } else {
                    typeView = 1;
                  }
                });
              },
              icon: Icon((typeView == 0) ? Icons.grid_view : Icons.list)),
        ),
        Expanded(
          child: FutureBuilder(
            future: _getData.generationsPokemon(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.red));
              } else if (snapshot.connectionState == ConnectionState.done) {
                var convertJson = jsonDecode(snapshot.data.toString()) as List;
                List<JsonPokemon> jsonClass =
                    convertJson.map((e) => JsonPokemon.fromJson(e)).toList();

                return (typeView == 0)
                    ? ListView.separated(
                        itemCount: jsonClass.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 0),
                                  blurRadius: 5.0,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  jsonClass[index].name.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'RampartOne-Regular',
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                                changeImgGeneration(
                                    '${jsonClass[index].url}', size),
                              ],
                            ),
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return Container(
                            // color: Colors.red,
                            height: 20.0,
                          );
                        }),
                      )
                    : GridView.builder(
                        itemCount: jsonClass.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: size.height * 0.14,
                        ),
                        itemBuilder: ((context, index) {
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(
                                    colors: <Color>[
                                      changeColor('${jsonClass[index].url}'),
                                      changeColor('${jsonClass[index].url}')
                                          .withOpacity(0.3),
                                    ],
                                    begin: Alignment.center,
                                    end: Alignment.topCenter),
                                border: Border.all(
                                    color: Colors.black26,
                                    width: 1,
                                    strokeAlign: StrokeAlign.outside)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: size.height * 0.1,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            colorFilter: ColorFilter.mode(
                                                Colors.white24,
                                                BlendMode.modulate),
                                            image: AssetImage(
                                              'assets/icons/pokebola.white.png',
                                            ))),
                                    child: Text(
                                      jsonClass[index].name.toString(),
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontFamily: 'RubikMoonrocks-Regular',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.0),
                                    ),
                                  ),
                                  changeImgGeneration(
                                      jsonClass[index].url.toString(), size),
                                ],
                              ),
                            ),
                          );
                        }));
              } else {
                return Container();
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget _types() {
    final _size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _getData.typesPokemons(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          var convertJson = jsonDecode(snapshot.data.toString()) as List;
          List<JsonPokemon> jsonClass =
              convertJson.map((e) => JsonPokemon.fromJson(e)).toList();

          return ListView.separated(
            itemCount: jsonClass.length,
            itemBuilder: ((context, index) {
              return Container(
                color: Colors.red,
                height: 20,
                child: Text('${jsonClass[index].name}'),
              );
            }),
            separatorBuilder: ((context, index) {
              return Container(
                color: Colors.white,
                height: 2,
              );
            }),
          );
        } else {
          return Text('${snapshot.data}');
        }
      }),
    );
  }

  Widget changeImgGeneration(String url, Size _size) {
    var split = url.split('/');
    if (int.parse(split[6]) > 0 && int.parse(split[6]) <= 5) {
      return SvgPicture.asset(
        'assets/images/${split[6]}.svg',
        height: (typeView == 0) ? _size.height * 0.06 : _size.height * 0.05,
      );
    } else {
      return Image.asset('assets/images/${split[6]}.png',
          height: (typeView == 0) ? _size.height * 0.06 : _size.height * 0.05);
    }
  }

  Color changeColor(String url) {
    var split = url.split('/');
    switch (split[6]) {
      case '1':
        return const Color(0xff629890);

      case '2':
        return const Color(0xffb9c897);

      case '3':
        return const Color(0xff8bc56c);

      case '4':
        return const Color(0xffc0dc96);

      case '5':
        return const Color(0xffddd196);

      case '6':
        return const Color(0xffe6ad78);

      case '7':
        return const Color(0xffeac4a5);

      case '8':
        return const Color(0xff97c25e);

      case '9':
        return const Color(0xffb8caa3);
      default:
        return Colors.white24;
    }
  }
}

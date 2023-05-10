// // ignore_for_file: avoid_function_literals_in_foreach_calls
// import 'dart:convert';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:pokemon_pokedex/src/api/getData.dart';
// import 'package:pokemon_pokedex/src/json/pokemType.dart';
// import 'package:pokemon_pokedex/src/pages/Principal/pokemonGrid.dart';
// import 'package:pokemon_pokedex/src/widgets/textStyles.dart';

// class HomePrincipal extends StatefulWidget {
//   const HomePrincipal({Key? key}) : super(key: key);

//   @override
//   State<HomePrincipal> createState() => _HomePrincipalState();
// }

// class _HomePrincipalState extends State<HomePrincipal> {
//   static List<JsonPokemontype> listGeneraciones = [];
//   static List<JsonPokemontype> listTypes = [];
//   int bandera = 0;

//   Map<String, Color> colorPokemonType = {
//     'normal': const Color(0xFFd49fac),
//     'fighting': const Color(0xFFfb6635),
//     'flying': const Color(0xFF98bad3),
//     'poison': const Color(0xFFa16ae2),
//     'ground': const Color(0xFF724c1f),
//     'rock': const Color(0xFF903f21),
//     'bug': const Color(0xFF3ca153),
//     'ghost': const Color(0xFF946997),
//     'steel': const Color(0xFF49c89d),
//     'fire': const Color(0xFFff4b5c),
//     'water': const Color(0xFF82a9fe),
//     'grass': const Color(0xFF23d750),
//     'electric': const Color.fromARGB(255, 202, 208, 32),
//     'psychic': const Color(0xFFff1990),
//     'ice': const Color(0xFF87daef),
//     'dragon': const Color(0xFF44929e),
//     'dark': const Color(0xFF5b597d),
//     'fairy': const Color(0xFFf71169),
//     'unknown': const Color(0xFFeab676),
//     'shadow': const Color(0xFFC953CB),
//   };

//   @override
//   void initState() {
//     // ignore: todo
//     // TODO: implement initState
//     super.initState();
//     GetData().generationsPokemon();
//     GetData().typesPokemons();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: <Widget>[
//           Column(
//             children: [
//               header(),
//               menu(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget header() {
//     final size = MediaQuery.of(context).size;
//     return Expanded(
//       flex: 0,
//       child: SafeArea(
//         bottom: false,
//         child: Container(
//           alignment: Alignment.bottomCenter,
//           padding: const EdgeInsets.only(bottom: 5.0),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(colors: <Color>[
//               Colors.white.withOpacity(0.2),
//               Colors.white.withOpacity(0.5),
//             ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               FadeInLeft(
//                 delay: const Duration(milliseconds: 300),
//                 child: Image.asset(
//                   'assets/icons/incubadora-de-huevos.png',
//                   height: size.height * 0.14,
//                 ),
//               ),
//               FadeInUp(
//                 delay: const Duration(milliseconds: 300),
//                 child: Image.asset(
//                   'assets/icons/incubadora-de-huevos-2.png',
//                   height: size.height * 0.18,
//                 ),
//               ),
//               FadeInRight(
//                 delay: const Duration(milliseconds: 300),
//                 child: Image.asset(
//                   'assets/icons/incubadora-de-huevos.png',
//                   height: size.height * 0.14,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget menu() {
//     final size = MediaQuery.of(context).size;
//     return Expanded(
//       flex: 2,
//       child: Container(
//         decoration: const BoxDecoration(
//             color: Color.fromARGB(238, 192, 203, 220),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black38,
//                 blurRadius: 70,
//                 spreadRadius: 100,
//               ),
//             ]),
//         child: Stack(
//           children: [
//             FadeInUp(
//                 child: Container(
//               alignment: Alignment.bottomRight,
//               child: SvgPicture.network(
//                 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/311.svg',
//                 height: size.height * 0.27,
//               ),
//             )),
//             Column(
//               verticalDirection: VerticalDirection.down,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   width: double.infinity,
//                   height: size.height * 0.09,
//                   decoration: const BoxDecoration(
//                       border: Border(
//                     bottom: BorderSide(
//                         color: Color.fromARGB(226, 255, 255, 255), width: 1.0),
//                   )),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'POKÉMON ',
//                         textAlign: TextAlign.center,
//                         style: Style().title,
//                       ),
//                       Image.asset(
//                         'assets/icons/pokebola.png',
//                         height: size.height * 0.05,
//                       )
//                     ],
//                   ),
//                 ),
//                 listPokemonGeneration(),
//                 listPoekemonType(),
//                 developerData(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget listPokemonGeneration() {
//     final size = MediaQuery.of(context).size;
//     return FutureBuilder(
//       future: GetData().generationsPokemon(),
//       builder: (context, AsyncSnapshot? snapshot) {
//         if (!snapshot!.hasData) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else {
//           convertirjson(snapshot.data);
//           return SizedBox(
//             height: size.height * 0.18,
//             child: ListView.builder(
//               itemCount: listGeneraciones.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: ((context) => HomepokemonGrid(
//                                     url: '${listGeneraciones[index].url}'))));
//                       },
//                       child: Container(
//                           margin: const EdgeInsets.only(
//                               right: 10.0, left: 7.0, top: 10.0),
//                           height: size.height * 0.1,
//                           width: size.width * 0.3,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: const Color.fromARGB(255, 255, 255, 255),
//                                 width: 0.3),
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: LinearGradient(
//                                 colors: <Color>[
//                                   Colors.white.withOpacity(0.2),
//                                   Colors.white.withOpacity(0.5),
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight),
//                             // ignore: prefer_const_literals_to_create_immutables
//                             boxShadow: [
//                               const BoxShadow(
//                                 color: Colors.white,
//                                 blurRadius: 7.0,
//                                 blurStyle: BlurStyle.outer,
//                               )
//                             ],
//                           ),
//                           child: FutureBuilder(
//                             future: GetData()
//                                 .imgGenrations(listGeneraciones[index].url),
//                             builder: (context, snapshot) {
//                               if (!snapshot.hasData) {
//                                 return const Center(
//                                   child: CircularProgressIndicator(),
//                                 );
//                               } else {
//                                 return Image.network(
//                                   'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data}.png',
//                                   loadingBuilder:
//                                       (context, child, loadingProgress) {
//                                     if (loadingProgress == null) return child;
//                                     return const Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   },
//                                 );
//                               }
//                             },
//                           )),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(
//                           right: 10.0, left: 3.0, top: 4.0),
//                       height: size.height * 0.06,
//                       width: size.width * 0.3,
//                       child: Text(
//                         '${listGeneraciones[index].name}',
//                         style: Style().btnGenration,
//                         textAlign: TextAlign.center,
//                       ),
//                     )
//                   ],
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }

//   convertirjson(dynamic json) {
//     listGeneraciones = [];
//     var tempJson = json
//         .toString()
//         .replaceAll('{', '{"')
//         .replaceAll('}', '"}')
//         .replaceAll(': ', '":"')
//         .replaceAll(', url', '", "url');
//     var tagObjsJson = jsonDecode(tempJson) as List;
//     List<JsonPokemontype> tagObjs = tagObjsJson
//         .map((tagJson) => JsonPokemontype.fromJson(tagJson))
//         .toList();
//     tagObjs.forEach((element) {
//       listGeneraciones
//           .add(JsonPokemontype(name: element.name, url: element.url));
//     });
//   }

//   Widget listPoekemonType() {
//     final size = MediaQuery.of(context).size;
//     return FutureBuilder(
//         future: GetData().typesPokemons(),
//         builder: ((context, snapshot) {
//           if (!snapshot.hasData) {
//             return Container(
//                 margin: EdgeInsets.only(top: size.height * 0.2),
//                 child: const CircularProgressIndicator());
//           } else {
//             pokemonTypeList(snapshot.data.toString());
//             return SizedBox(
//               height: size.height * 0.15,
//               child: ListView.builder(
//                 itemCount: listTypes.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) => Stack(
//                   children: [
//                     Container(
//                       alignment: Alignment.bottomCenter,
//                       margin: EdgeInsets.symmetric(
//                           vertical: size.height * 0.14,
//                           horizontal: size.width * 0.02),
//                       width: size.width * 0.3,
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         border: Border(
//                             bottom: BorderSide(
//                           color: colorPokemonType['${listTypes[index].name}']
//                               as Color,
//                           width: 1.0,
//                         )),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.white.withOpacity(0.3),
//                             blurRadius: 30.0,
//                             spreadRadius: 25.0,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.symmetric(
//                             horizontal: size.width * 0.02,
//                             vertical: size.height * 0.007),
//                         width: size.width * 0.3,
//                         decoration: BoxDecoration(
//                           color: colorPokemonType['${listTypes[index].name}'],
//                           image: const DecorationImage(
//                             image:
//                                 ExactAssetImage('assets/icons/pokebola-3.png'),
//                           ),
//                           borderRadius: BorderRadius.circular(60),
//                           border: Border.all(
//                               color: Colors.white,
//                               width: 2.0,
//                               style: BorderStyle.solid),
//                           boxShadow: [
//                             BoxShadow(
//                                 color:
//                                     colorPokemonType['${listTypes[index].name}']
//                                         as Color,
//                                 blurRadius: 1,
//                                 spreadRadius: 2,
//                                 blurStyle: BlurStyle.normal)
//                           ],
//                         ),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               gradient: LinearGradient(
//                                   colors: <Color>[
//                                     Colors.black26.withOpacity(0.2),
//                                     Colors.white.withOpacity(0.5),
//                                   ],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight)),
//                           child: Text(
//                             '${listTypes[index].name}',
//                             style: Style().textType,
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//             );
//           }
//         }));
//   }

//   pokemonTypeList(String json) {
//     listTypes.clear();
//     var convertJson = jsonDecode(json) as List;
//     List<JsonPokemontype> jsonClass =
//         convertJson.map((e) => JsonPokemontype.fromJson(e)).toList();
//     jsonClass.forEach((element) {
//       listTypes.add(JsonPokemontype(name: element.name, url: element.url));
//     });
//   }

//   Widget developerData() {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       alignment: Alignment.bottomLeft,
//       height: size.height * 0.2,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           TextButton(
//               onPressed: () {
//                 showDialog(
//                     context: context,
//                     builder: (_) => Dialog(
//                           child: Container(
//                             color: Colors.white,
//                             height: 100.0,
//                             width: double.infinity,
//                           ),
//                         ));
//               },
//               child: const Text(
//                 'About',
//                 style: TextStyle(color: Color.fromARGB(255, 109, 54, 32)),
//               )),
//           Container(
//             alignment: Alignment.bottomRight,
//             height: size.height * 0.07,
//             width: size.width * 0.6,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 _iconButton(
//                     context, () {}, 'assets/icons/correo-electronico-2.png'),
//                 _iconButton(context, () {}, 'assets/icons/linkedin.png'),
//                 _iconButton(context, () {}, 'assets/icons/instagram.png'),
//                 _iconButton(context, () {}, 'assets/icons/whatsapp-2.png'),
//               ],
//             ),
//           ),
//           const Text(
//             '© LuisRomanDev',
//             style: TextStyle(color: Color.fromARGB(255, 109, 54, 32)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _iconButton(BuildContext context, VoidCallback onPressed, String img) {
//     final size = MediaQuery.of(context).size;
//     return IconButton(
//         onPressed: onPressed,
//         icon: Image.asset(
//           img,
//           width: size.width * 0.1,
//           color: const Color.fromARGB(255, 109, 54, 32),
//         ));
//   }
// }



// // Widget titulo1() {
// //   final size = MediaQuery.of(context).size;
// //   return Center(
// //     child: Container(
// //         alignment: Alignment.center,
// //         //margin: EdgeInsets.only(top: size.height * 0.05),
// //         // decoration: BoxDecoration(
// //         //   borderRadius: BorderRadius.circular(20),
// //         // gradient: LinearGradient(colors: <Color>[
// //         //   Colors.white.withOpacity(0.2),
// //         //   Colors.white.withOpacity(0.5),
// //         // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
// //         //),
// //         child: Text(
// //           'POKEMON',
// //           textAlign: TextAlign.center,
// //           style: Style().title,
// //         )),
// //   );
// // }



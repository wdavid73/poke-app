import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/dialog_container.dart';
// import 'package:poke_app/widgets/snack_bar_message.dart';

class DialogDeletePokemon extends StatelessWidget {
  final int? id;

  const DialogDeletePokemon({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    // final PokemonBloc pokemonBloc = BlocProvider.of<PokemonBloc>(context);

    onConfirm() {
      if (id != null) {
        /*  pokemonBloc.add(DeletePokemon(id!));
        pokemonBloc.stream.listen((event) {
          if (event.pokemonDeleted) {
            snackBarMessage(context, "Pokemon deleted successfully");
            Navigator.pop(context, true);
            pokemonBloc.add(ClearState());
          }
        }); */
      }
    }

    return DialogContainer(
        child: Stack(
      children: [
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(
              height: responsive.hp(30),
            ),
            child: Container(
              width: responsive.wp(50),
              height: responsive.hp(25),
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
                top: 65,
                bottom: 20,
              ),
              margin: const EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Text(
                      "Are you sure delete this pokemon?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.dp(2)),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /*child: ,
                        ),
                      ),*/
                      ElevatedButton.icon(
                        onPressed: () => onConfirm(),
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                            Colors.lightBlueAccent,
                          ),
                          shape:
                              MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        label: const Text("Confirm"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context, false),
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                            Colors.redAccent,
                          ),
                          shape:
                              MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        label: const Text("Cancel"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 1,
          right: 1,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: IconButton(
              onPressed: () => Navigator.pop(context, false),
              icon: const Icon(Icons.close),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: 5,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: SvgPicture.asset("assets/icons/icon.svg"),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vikings_quiz/blocs/authentication/authentication.dart';
import 'package:vikings_quiz/blocs/token/bloc/token_bloc.dart';
import 'package:vikings_quiz/routes.dart';
import 'package:vikings_quiz/routes/home_page/submission_button.dart';
import 'package:vikings_quiz/routes/utils/vertical_separator.dart';

/// Form that validates the ticked ID of an user before proceeding to the actual
/// quiz game.
class ValidationForm extends StatefulWidget {
  const ValidationForm();

  @override
  _ValidationFormState createState() => _ValidationFormState();
}

class _ValidationFormState extends State<ValidationForm> {
  final codeController = TextEditingController();
  Widget cachedLogo;

  @override
  void initState() {
    super.initState();

    // Keeps in sync the state of the form field with the state of TokenBloc
    codeController.addListener(() {
      final txt = codeController.text;

      // To avoid unnecessary calls and thus potential subsequent rebuilds to
      // other widgets
      if (txt.length > 0) {
        context.read<TokenBloc>().add(txt);
      }
    });

    // Caching the SVG logo since it doesn't change over the time
    cachedLogo = Image.asset("assets/logo.png",
      height: 80,
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The logo
        cachedLogo,

        const VerticalSeparator(size: 30),

        // The input field
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: TextFormField(
            controller: codeController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                hintText: "Ticket code...",
                icon: Icon(Icons.vpn_key)),
          ),
        ),

        const VerticalSeparator(size: 30),

        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is AuthenticationNoQuiz) {
              return const Center(
                child: Text(
                  "You can't play the quiz now!",
                  style: TextStyle(fontSize: 20, fontFamily: 'GrenzeGotisch'),
                ),
              );
            }

            return const _FormButtons();
          },
        ),
      ],
    );
  }
}

/// Buttons for the validation form
class _FormButtons extends StatelessWidget {
  const _FormButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SubmitTicketButton(),

        // Showing information about the context
        RaisedButton(
          key: Key("validation_form_info"),
          child: const Text("Info"),
          onPressed: () =>
              Navigator.of(context).pushNamed(RouteGenerator.infoPage),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';

class Usage extends StatelessWidget {
  const Usage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Using KannadaDisco"),
        centerTitle: true,
        backgroundColor: kannadaRed,
      ),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
        child: Text(
          "\t\tLorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non semper orci. Nam tempor dictum erat. Curabitur ac rutrum nisl. Phasellus sagittis nec quam quis interdum. Suspendisse vel consequat nunc. Etiam faucibus accumsan lacus sed porta. Sed commodo metus sem, ut ullamcorper nulla efficitur nec.\n\n\t\tPhasellus posuere dui id nulla tristique, a sollicitudin magna convallis. Duis tortor lorem, tincidunt vel tincidunt quis, mattis nec est. Pellentesque aliquam leo ac mauris malesuada luctus eu vitae nunc. Maecenas auctor sem a tincidunt tincidunt. Proin luctus mi sed justo pretium, vitae consectetur sem pharetra.",
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }
}

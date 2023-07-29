import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';

class ReferenceEntry extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  const ReferenceEntry(
      {Key? key,
      required this.english,
      required this.kannada,
      required this.transliteration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100.0,
      width: MediaQuery.of(context).size.width,
      // child: Card(
      //   child: Padding(
      //     padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Expanded(
      //           child: Text(
      //             english,
      //             style: const TextStyle(
      //               fontSize: 20.0,
      //             ),
      //           ),
      //         ),
      //         Flexible(
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               Expanded(
      //                 child: Column(
      //                   children: [
      //                     Text(
      //                       kannada,
      //                       style: const TextStyle(
      //                         height: 1,
      //                         fontSize: 20.0,
      //                       ),
      //                     ),
      //                     SizedBox(height: 10,),
      //                     Text(
      //                       transliteration,
      //                       style: const TextStyle(
      //                         height: 1,
      //                         fontSize: 20,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      english,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      kannada,
                      style: const TextStyle(
                          height: 1, fontSize: 20.0, color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      transliteration,
                      style: const TextStyle(
                        height: 1,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.volume_up,
                size: 30,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}

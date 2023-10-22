import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';

class ReferenceEntry extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;
  final String link;

  const ReferenceEntry(
      {Key? key,
      required this.english,
      required this.kannada,
      required this.transliteration, required this.link})
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
              link == "NA" ? SizedBox() : SizedBox(width: 80, height: 80, child: Image.asset(
          link, // this image doesn't exist
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error);
          },
        ),),
             link == "NA" ? SizedBox() : SizedBox(width: 20,),
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
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      kannada,
                      style: const TextStyle(
                        height: 1,
                        fontSize: 20.0,
                        color: Colors.blue
                      ),
                    ),
                    SizedBox(
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
              
             Icon(Icons.volume_up, size: 30, color: Colors.blue,)
            ],
          ),
        ),
      ),
    );
  }
}

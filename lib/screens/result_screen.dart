import 'package:cl_musda_hipmi_2024_mobile/models/registration.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.registration,
    this.showImage = false,
  });

  final Registration registration;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const StyledText(
                  text: 'Welcome',
                  textSize: 20,
                ),
                const SizedBox(height: 10),
                //Participant Name
                StyledText(
                  text: registration.name ?? '-',
                  textColor: const Color(0xff095B96),
                  textWeight: FontWeight.bold,
                  textSize: 30,
                ),
                StyledText(
                  text: registration.office ?? '-',
                  textColor: const Color(0xff095B96),
                  textSize: 24,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: StyledText(
                    text: registration.membership ?? '',
                    textColor: Colors.grey,
                    textWeight: FontWeight.bold,
                    textSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: StyledText(
                    text: "BPC: ${registration.bpc}",
                    textColor: Colors.grey,
                    textWeight: FontWeight.bold,
                    textSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                showImage
                    ? Row(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: registration.imageUrl ?? '',
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                // const SizedBox(height: 10),
                // const Align(
                //   alignment: Alignment.center,
                //   child: StyledText(text: 'to'),
                // ),
                //Event Name
                // Align(
                //   alignment: Alignment.center,
                //   child: StyledText(
                //     text: participant.info,
                //     textColor: Colors.black,
                //   ),
                // ),
                // const Align(
                //   alignment: Alignment.center,
                //   child: StyledText(text: 'Jumlah keluarga yang ikut partisipasi'),
                // ),
                //Participant's attending relatives
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     StyledText(
                //       text: participant.relatives.toString(),
                //       textColor: Color(0xff095B96),
                //       textWeight: FontWeight.bold,
                //     ),
                //     SizedBox(width: 5),
                //     StyledText(text: 'orang'),
                //   ],
                // ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.grey.shade200,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/ic_check.png"),
                      const SizedBox(width: 10),
                      const Text(
                        'Scan Berhasil',
                        style: TextStyle(color: Colors.green, fontSize: 24),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textWeight;

  const StyledText(
      {Key? key,
      required this.text,
      this.textColor = Colors.grey,
      this.textSize = 24,
      this.textWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: textColor, fontSize: textSize, fontWeight: textWeight));
  }
}

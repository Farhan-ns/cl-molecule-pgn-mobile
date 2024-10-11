import 'dart:convert';
import 'dart:developer';

import 'package:cl_musda_hipmi_2024_mobile/models/registration.dart';
import 'package:cl_musda_hipmi_2024_mobile/network/api.dart';
import 'package:cl_musda_hipmi_2024_mobile/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  final String endpoint = '/api/scan';
  final String endpointSecondScan = '/api/second-scan';
  bool dialogIsOpen = false;
  bool successful = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (controller != null && mounted) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Acara 1'),
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: const Text(
              'Arahkan kamera Anda ke kode QR',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: _buildQrView(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  _postCode(Barcode scannedData) async {
    var data = {
      'qr_value': scannedData.code,
    };

    try {
      var response = await Network().postData(data, endpoint);
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Registration registration = Registration.fromJson(responseBody['data']);

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                registration: registration,
              ),
            ),
          ).then(
            (value) => setState(
              () {
                controller?.resumeCamera();
              },
            ),
          );
        }
        return;
      }

      if (response.statusCode == 400) {
        _showAlert(responseBody['message']);
        return;
      }

      if (response.statusCode != 200) {
        _showAlert(responseBody['message'] ?? 'Unknown Error');
        return;
      }
    } catch (e) {
      _showAlert(e.toString());
    }

    // successful = true;
    // Participant participant = Participant.fromJson(responseBody['data']);

    // Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => ResultScreen(participant)))
    //     .then((value) => setState(() {
    //           controller?.resumeCamera();
    //           successful = false;
    //         }));
    // hasScanned = false;
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen(
      (scannedData) {
        // if (!hasScanned) {
        // hasScanned = true;

        if (!dialogIsOpen) {
          setState(() {
            controller.pauseCamera();
          });

          print('Scan');
          print(scannedData);
          print(scannedData.code);

          // showSucccessAlert(scannedData.code);
          _postCode(scannedData);
        }
        // }
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void showSucccessAlert(msg) {
    setState(() {
      dialogIsOpen = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  dialogIsOpen = false;
                  controller?.resumeCamera();
                });

                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAlert(msg) {
    setState(() {
      dialogIsOpen = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Failed'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  dialogIsOpen = false;
                  controller?.resumeCamera();
                });

                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

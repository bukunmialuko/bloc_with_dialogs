import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'bloc/details_bloc.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailsBloc, DetailsState>(
      listener: (context, state) {
        switch (state.processingStatus) {
          case DetailProcessingStatus.loading:
            print("===> Processing");
            EasyLoading.show(status: "Processing");
            break;
          case DetailProcessingStatus.success:
            EasyLoading.showSuccess("Success").then((value) {
              Future.delayed(Duration(seconds: 2), () async {
                Navigator.of(context).pop();
              });
            });

            print("===> Complete");
            break;
          case DetailProcessingStatus.complete:
            // EasyLoading.dismiss();
            print("===> Dismiss");
            break;
          default:
            // EasyLoading.dismiss();
            print("===> Default");
            break;
        }
        // if (state.processingStatus == DetailProcessingStatus.loading) {
        //   // EasyLoading.show();
        //   print("Processing");
        //   // EasyLoading.show(status: "Processing");
        // }
        //
        // if (state.processingStatus == DetailProcessingStatus.success) {
        //   print("Success");
        //   // EasyLoading.showSuccess("Success");
        // }
        //
        // if (state.processingStatus == DetailProcessingStatus.complete) {
        //   print("Dismiss");
        //   // EasyLoading.dismiss();
        // }
        //
        // print("bypass");
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Detail")),
        body: Center(
          child: BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, state) {
              return Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      context.read<DetailsBloc>().add(ProcessDetails());
                    },
                    child: Text("Process Information"),
                  ),
                  (state.processingStatus == DetailProcessingStatus.loading) ? Text("Loading") : Container(),
                  (state.processingStatus == DetailProcessingStatus.success) ? Text("Success") : Container()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

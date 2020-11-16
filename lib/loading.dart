import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class GlobalLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loadingLabel(),
        loadingCard(),
        loadingCard(),
        loadingCard(),
        loadingCard(),
        loadingCard(),
      ],
    );
  }

  Widget loadingCard() {
    return Card(
      elevation: 1,
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(
            children: <Widget>[
              
              Expanded(
                child: Container(),
              ),
              Container(
                width: double.infinity,
                height: 90,
                color: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              // Container(
              //   width: double.infinity,
              //   height: 30,
              //   color: Colors.white,
              // ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.blue[300],
        highlightColor: Colors.blue[600],
        child: Column(
          children: <Widget>[
            Container(
              width: 200,
              height: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

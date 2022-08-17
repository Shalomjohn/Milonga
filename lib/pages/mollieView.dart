import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:milonga/utils/appColors.dart';
import 'package:milonga/utils/components.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/mollie_service.dart';

class MolliePaymentPage extends StatefulWidget {
  MolliePaymentPage({
    required this.onFinish,
  });
  final Function(String id) onFinish;

  @override
  State<StatefulWidget> createState() {
    return MolliePaymentPageState();
  }
}

class MolliePaymentPageState extends State<MolliePaymentPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  String? executeUrl;
  String accessToken = "test_rEAQNrCtuUdhj96HcGc5Tj9Dz8986v";
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'http://return.example.com';
  String cancelURL = 'http://cancel.example.com';

  @override
  void initState() {
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        print("ENTERED PAYPAL");
        // accessToken = await services.getAccessToken();
        // print('ACCESS TOKEN:');
        // print(accessToken);
        final transactions = getOrderParams();
        print('Transactions: ');
        print(transactions);
        final res =
            await services.createMolliePayment(transactions, accessToken);
        print('Response: ');
        print(res);
        if (res != null) {
          setState(() {
            checkoutUrl = res;
          });
        } else {
          print("RES IS NULL broo");
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        // ignore: deprecated_member_use
        _scaffoldKey.currentState!.showSnackBar(snackBar);
      }
    });
  }

  Map<String, dynamic> getOrderParams() {
    return {
      'amount': {'currency': 'EUR', 'value': '10.00'},
      'description': 'Order #12345',
      'redirectUrl': returnURL,
      'metadata': {'order_id': '12345'}
    };
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: scaffoldColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              print("IT CONTAINS RETURN URL BROOO");
              // final uri = Uri.parse(request.url);
              // print(uri.queryParameters);
              // final payerID = uri.queryParameters['PayerID'];
              // if (payerID != null) {
              //   services
              //       .executePayment(executeUrl, payerID, accessToken)
              //       .then((id) {
              //     if (id != null) {
              //       widget.onFinish(id);
              //     }
              //     Navigator.of(context).pop();
              //   });
              // }
              Navigator.of(context).pop();
              customScaffoldMessage(context,
                  "Transaction successful! You have been granted access to all our videos. Enjoy!");
            } else {
              Navigator.of(context).pop();
              customScaffoldMessage(
                  context, "Error completing transaction. Please try again");
            }
            // if (request.url.contains(cancelURL)) {
            //   Navigator.of(context).pop();
            // }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}

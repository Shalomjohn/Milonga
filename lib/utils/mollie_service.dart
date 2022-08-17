import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {
  // String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
  String domain = "https://api.mollie.com/v2/payments"; // for production mode

  // change clientId and secret with your own, provided by paypal
  // String clientId =
  //     'AV5r7X8G5KBIbLpsFN441G9DU-5meYyCOWBmiJbqYVJEdNMs3ZiI4voSLJPZWt1ViGneHaZVVCL72VFk';
  // String secret =
  //     'EFuo2Sj_Lb-IRP43mOfWxyXilFIDecJkTfwPr_ZqYSia08bDLWViN8S8dCX7O7LYZaukXxMjTROazird';

  // for getting the access token from Paypal
  // Future<String?> getAccessToken() async {
  //   try {
  //     var client = BasicAuthClient(clientId, secret);
  //     Uri uri =
  //         Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials');
  //     print(uri);
  //     var response = await client.post(uri);
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       final body = convert.jsonDecode(response.body);
  //       return body["access_token"];
  //     } else {
  //       print(response.body);
  //     }
  //     return null;
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }

  // for creating the payment request with Paypal
  Future<String?> createMolliePayment(transactions, accessToken) async {
    try {
      Uri uri = Uri.parse(domain);
      var response = await http.post(uri,
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': "Bearer $accessToken"
          });
      print(response.headers);
      final body = convert.jsonDecode(response.body);
      print(body);
      if (response.statusCode == 201) {
        if (body["_links"] != null && body["_links"].length > 0) {
          return body["_links"]["checkout"]["href"];
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String?> executePayment(url, payerId, accessToken) async {
    try {
      url = Uri.parse(url);
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}

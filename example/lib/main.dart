import 'package:flutter/material.dart';
import 'package:flutter_wayforpay_package/flutter_wayforpay_package.dart';
import 'package:flutter_wayforpay_package/model/card_model.dart';
import 'package:flutter_wayforpay_package/model/wayforpay_response.dart';
import 'package:flutter_wayforpay_package/utils/types.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter WayForPay Package'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///Create wayForPay object
  WayForPay wayForPay = WayForPay();

  @override
  void initState() {
    super.initState();

    /// Set your merchantAccount
    wayForPay.merchantAccount = 'test_merch_n1';

    /// Set your merchantSecretKey
    wayForPay.merchantSecretKey = 'flk3409refn54t54t*FNJRET';

    /// Set products counts list
    wayForPay.productCount = [1];

    /// Set products names list
    wayForPay.productName = ['Test product'];

    /// Set products prices list
    wayForPay.productPrice = [0.1];
  }

  void payWithPackageScreen() {
    /// Open card enter screen
    wayForPay
        .openCardEnterScreen(context,
            orderDate: DateTime.now(),
            merchantTransactionSecureType: MerchantTransactionSecureType.AUTO,
            orderReference: 'testReference',
            amount: 0.1)

        /// Get payment status
        .then((value) {
      /// Check if _wayForPayResponse is not null
      if (value != null) {
        print(
            'transactionStatus: ${value.transactionStatus!}, reasonCode: ${value.reasonCode}, reason: ${value.reason!}');
      }
    });
  }

  void payManually() {
    ///Set card user data
    final cardModel = CardModel(
        card: '4242424242424242',
        cardCvv: '111',
        cardHolder: 'Ivanov Ivan',
        expMonth: '01',
        expYear: '2030');

    /// Start payment process
    wayForPay
        .makePayment(context,
            cardModel: cardModel,
            amount: 0.1,
            merchantTransactionSecureType: MerchantTransactionSecureType.AUTO,
            orderReference:
                'testReference${DateTime.now().microsecondsSinceEpoch}',
            orderDate: DateTime.now())

        /// Get payment status
        .then((WayForPayResponse? value) {
      /// Check if _wayForPayResponse is not null
      if (value != null) {
        print('reasonCode: ${value.reasonCode}, reason: ${value.reason!}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: payWithPackageScreen,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Pay with package screen',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: payManually,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Pay manually',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

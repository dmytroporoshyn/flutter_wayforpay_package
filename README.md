# Flutter Wayforpay Package
[![pub package](https://img.shields.io/pub/v/flutter_local_notifications.svg)](https://pub.dartlang.org/packages/flutter_local_notifications)

A package to simplify work with the WayForPay payment system. Is a wrapper over WayForPay API.

## ✨ Features

* Card data entry screen
* 3D Secure verification
* Ability to create a custom data entry screen
* Comments :)

## 📷 Screenshots

<img height="400" src="https://github.com/dmytroporoshyn/flutter_wayforpay_package/blob/master/images/screen1.png"> |  <img height="400" src="https://github.com/dmytroporoshyn/flutter_wayforpay_package/blob/master/images/screen2.png"> |  <img height="400" src="https://github.com/dmytroporoshyn/flutter_wayforpay_package/blob/master/images/screen3.png">


## ⚙️ Getting Started  
  
Create WayForPay object  
```dart  
WayForPay wayForPay = WayForPay();
 ```  
  
Set your merchantAccount and merchantSecretKey  
```dart  
wayForPay.merchantAccount = "test_merch_n1";
wayForPay.merchantSecretKey = "flk3409refn54t54t*FNJRET";
 ```  
  
Set your products list  
```dart  
wayForPay.productCount = [1]; 
wayForPay.productName = ["Test product"];
wayForPay.productPrice = [0.1];
 ```  
  
Open card enter screen and be ready to get payment status. Check if wayForPayResponse is not null  
```dart  
wayForPay  
    .openCardEnterScreen(context,  
        orderDate: DateTime.now(),  
        merchantTransactionSecureType: MerchantTransactionSecureType.AUTO,  
        orderReference: "testReference",  
        amount: 0.1)  
  
  .then((value) {  
  if (value != null) {  
  print("transactionStatus: " +  
  value.transactionStatus +  
  ", reasonCode: " +  
  value.reasonCode.toString() +  
  ", reason: " +  
  value.reason);  
  }  
});
 ```  
### Or

Create card user data model  
```dart  
CardModel cardModel = CardModel(  
  card: "0000000000000000",  
    cardCvv: "111",  
    cardHolder: "Ivanov Ivan",  
    expMonth: "01",  
    expYear: "2030");
 ```  
  
And start payment manually  
```dart  
wayForPay  
    .makePayment(context,  
        cardModel: cardModel,  
        amount: 0.1,  
        merchantTransactionSecureType: MerchantTransactionSecureType.AUTO,  
        orderReference: "testReference",  
        orderDate: DateTime.now())  
  .then((value) {  
  if (value != null) {  
  print("reasonCode: " +  
  value.reasonCode.toString() +  
  ", reason: " +  
  value.reason);  
  }  
});
 ```

## ❓ Usage
Before going on to copy-paste the code snippets in this section, double-check you have configured your application correctly.
If you encounter any issues please refer to the API docs and the sample code in the `example` directory before opening a request on Github.

### Example app
The `example` directory has a sample application that demonstrates the features of this package.

### API reference
Checkout the lovely [API documentation]() generated by pub. 

### 👨‍💻 Creator
[Dmytro Poroshyn](https://www.linkedin.com/in/dmytro-poroshyn-b3b456173/) in [Squadra](http://squadra.company/)

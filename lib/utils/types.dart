abstract class MerchantTransactionSecureType {
  static const String AUTO = "AUTO";
  static const String e3DS = "3DS";
  static const String NON3DS = "NON3DS";
}

abstract class CurrencyType {
  static const String UAH = "UAH";
  static const String USD = "USD";
  static const String EUR = "EUR";
}

abstract class TransactionType {
  static const String CHARGE = "CHARGE";
  static const String COMPLETE_3DS = "COMPLETE_3DS";
}

class TransactionStatus {
  static const String InProcessing = "InProcessing";
  static const String Approved = "Approved";
  static const String Declined = "Declined";
}

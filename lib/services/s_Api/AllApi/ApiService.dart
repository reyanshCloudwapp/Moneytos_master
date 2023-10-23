class AllApiService {
  /// development
  static String bashurl = 'https://dev.moneytos.com/api/';
  static String personabashurl = 'https://dev.moneytos.com/';

  /// production
  // static String bashurl = "https://moneytos.com/api/";
  // static String bashurl = "https://itmates.digital/moneytos/api/";
  static String x_client = 'e0271afd8a3b8257af70deacee4';
  static String AllrecipientProImageBaseUrl =
      'https://itmates.digital/moneytos/public/recipientProfileImages/';
  static String magicpayBaseUrlBaseUrl = '';

  //All Api

  static String Countries_List_URL = '${bashurl}coutries';
  static String SignupCountries_List_URL = '${bashurl}getSignUpCountries';
  static String statelistbycountryid_List_URL =
      '${bashurl}statelistbycountryid';
  static String all_RecipintList_URl = '${bashurl}recipientlist';
  static String accountSetting_URl = '${bashurl}profile';
  static String latesttransferapi = '${bashurl}userTxnHistrory';
  static String recentRecipientByTxnapi = '${bashurl}recentRecipientByTxn';
  static String createMagicpayTxnapi = '${bashurl}createMagicpayTxn';
  static String addMagicpayCustomerIdapi = '${bashurl}addMagicpayCustomerId';
  static String submitPaymentapi = '${bashurl}submitPayment';
  static String operatorListApi = '${bashurl}mfsMobileoperatorsBycountryiso2';
  static String addRecipientMobileApi = '${bashurl}addRecipientMobile';

  static String client_id = '';

  //All Api

  // static const Countries_List_URL = bashurl + "coutries";

  //All Api readyremit
  static String tokenGet_URL =
      'https://sandbox-api.readyremit.com/v1/OAuth/Token';
  static String Quote_new_recpi_URL =
      'https://sandbox-api.readyremit.com/v1/Quote?';
  static String select_Banks_URL =
      'https://sandbox-api.readyremit.com/v1/banks?';
  static String recipient_banAccount_fields =
      'https://sandbox-api.readyremit.com/v1/recipient-account-fields?';
  static String add_banAccount_fields =
      'https://sandbox-api.readyremit.com/v1/recipients/ab16ab0c-1d0f-407d-8463-8b1f95e23b78/accounts';
  static String get_txn_status_URL =
      'https://sandbox-api.readyremit.com/v1//transfers/';

  //All Api readyremit  (Punit Apis)
  static String transactions_verifyURL =
      '${magicpayBaseUrlBaseUrl}transactions/verify';
  static String payment_methods = '${bashurl}addMagicpaySenderCard';
  static String AddMagicSenderBank = '${bashurl}addMagicpaySenderBank';
  static String magicpayPaymentMethods = '${bashurl}magicpayPaymentMethods';
  static String transaction_chargeURL =
      '${magicpayBaseUrlBaseUrl}transactions/charge';
  static String createcustomersURL = '${bashurl}createCustomerOnMagicpay';
  static String EditBankURL = '${bashurl}editMagicpaySenderBank';
  static String DeleteBankCardURL =
      '${bashurl}deleteMagicpaySenderPaymentMethod';
  static String EditDebitCardURL = '${bashurl}editMagicpaySenderCard';
  static String TransfersURL =
      'https://sandbox-api.readyremit.com/v1/Transfers';
  static String isFaceEnableDisableURL = '${bashurl}isFaceEnableDisable';
  static String chkpinURL = '${bashurl}chkpin';
  static String updateNotificatinsURL = '${bashurl}updateNotificatins';
  static String deleteRecipientBankAccountURL =
      '${bashurl}deleteRecipientBankAccount';
  static String mfsbanklistBycountryiso2URL =
      '${bashurl}mfsbanklistBycountryiso2';
  static String chkStateStatusByIpURL = '${bashurl}chkStateStatusByIp';
  static String pickuplocationsbycountryiso3URL =
      '${bashurl}pickup-locations-by-country-iso3';
  static String homeExchangeRateURL = '${bashurl}home-exchange-rate';

  static String isNotification = '';

//All Api readyremit
/* static String tokenGet_URL = "https://sandbox-api.readyremit.com/v1/OAuth/Token";
  static String Quote_new_recpi_URL = "https://sandbox-api.readyremit.com/v1/Quote?";
  static String select_Banks_URL = "https://sandbox-api.readyremit.com/v1/banks?";
  static String recipient_banAccount_fields = "https://sandbox-api.readyremit.com/v1/recipient-account-fields?";
  static String add_banAccount_fields = "https://sandbox-api.readyremit.com/v1/recipients/ab16ab0c-1d0f-407d-8463-8b1f95e23b78/accounts";*/
}

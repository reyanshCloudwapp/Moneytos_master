import 'package:moneytos/services/s_Api/AllApi/ApiService.dart';

class Apiservices {
  static String client_key = '';
  static String client_secret = '';
  static String x_client_id = '';

  //nium payout value ------------------------
  static String nium_source_account = '';
  static String nium_identification_number = '';
  static String nium_request_id = '';
  static String nium_contact_number = '';
  static String nium_identification_type = '';
  //------------------------------------------

  // static  String base_url = "https://dev.moneytos.com/api/";
  static String nium_base_url = '';
  static String nium_base_url_v2 = '';
  // static String base_url = "https://itmates.digital/moneytos/api/";
  static String submitContactNumber =
      '${AllApiService.bashurl}submitContactNumber';
  static String verifyOtpWithRegister =
      '${AllApiService.bashurl}verifyOtpWithRegister';
  static String sendLoginOtp = '${AllApiService.bashurl}sendLoginOtp';
  static String submitStepSec = '${AllApiService.bashurl}submitStepSec';
  static String login = '${AllApiService.bashurl}login';
  static String logout = '${AllApiService.bashurl}logout';
  static String forgotPassword = '${AllApiService.bashurl}forgotPassword';
  static String verifyForgotPasswordOtp =
      '${AllApiService.bashurl}verifyForgotPasswordOtp';
  static String resetPassword = '${AllApiService.bashurl}resetPassword';
  static String createRecipient = '${AllApiService.bashurl}createRecipient';
  static String editRecipient = '${AllApiService.bashurl}editRecipient';

  static String profile = '${AllApiService.bashurl}profile';
  static String changepassword = '${AllApiService.bashurl}changepassword';
  static String setpin = '${AllApiService.bashurl}setpin';
  static String uploadDocuments = '${AllApiService.bashurl}uploadDocuments';
  static String uploadedDocumentDetail =
      '${AllApiService.bashurl}uploadedDocumentDetail';
  static String addrecipientfield =
      'https://sandbox-api.readyremit.com/v1/recipients';
  static String accountDetailapi =
      'https://sandbox-api.readyremit.com/v1/recipients/';
  static String chartRecipientapi = '${AllApiService.bashurl}graphTxn';
  static String createRTxnbyMtxnidapi =
      '${AllApiService.bashurl}createRTxnbyMtxnid';
  static String updateProfileapi = '${AllApiService.bashurl}updateProfile';
  static String saveScheduleapi = '${AllApiService.bashurl}saveSchedule';
  static String favouriteRecipientapi =
      '${AllApiService.bashurl}favouriteRecipient';
  static String scheduleTransferListapi =
      '${AllApiService.bashurl}scheduleTransferList';
  static String changeScheduleStatusapi =
      '${AllApiService.bashurl}changeScheduleStatus';
  static String favouriteRecipientListapi =
      '${AllApiService.bashurl}favouriteRecipientList';
  static String chkEmailAndRefferalCodeapi =
      '${AllApiService.bashurl}chkEmailAndRefferalCode';
  static String notificationlistapi =
      '${AllApiService.bashurl}notificationlist';
  static String addreferralapi = '${AllApiService.bashurl}addreferral';
  static String referral_listapi = '${AllApiService.bashurl}showreferral';
  static String addhelpcenterapi = '${AllApiService.bashurl}addhelpcenter';
  static String feesbuyapi = '${AllApiService.bashurl}feesbuy';
  static String txnminmaxlimitapi = '${AllApiService.bashurl}txnminmaxlimit';
  static String termsconditionapi = '${AllApiService.bashurl}termscondition';
  static String privacypolicyapi = '${AllApiService.bashurl}privacypolicy';
  static String updateNotificatinsapi =
      '${AllApiService.bashurl}updateNotificatins';
  static String editScheduleapi = '${AllApiService.bashurl}editSchedule';
  static String deleteScheduleapi = '${AllApiService.bashurl}deleteSchedule';
  static String delete_userapi = '${AllApiService.bashurl}delete_user';
  static String scheduleDetailapi = '${AllApiService.bashurl}scheduleDetail';
  static String deleteRecipientapi = '${AllApiService.bashurl}deleteRecipient';
  static String updateRediremitTxnStatusapi =
      '${AllApiService.bashurl}updateRediremitTxnStatus';
  static String cancelScheduleapi = '${AllApiService.bashurl}cancelSchedule';
  static String addRecipientBankAccountapi =
      '${AllApiService.bashurl}addRecipientBankAccount';
  static String editrecipientBankAccountapi =
      '${AllApiService.bashurl}editrecipientBankAccount';
  static String recipientBankAccountsapi =
      '${AllApiService.bashurl}recipientBankAccounts';
  static String txnDetailapi = '${AllApiService.bashurl}txnDetail';
  static String countryWiseExchangeRateapi =
      '${AllApiService.bashurl}countryWiseExchangeRate';
  static String niumPurposeCodesapi =
      '${AllApiService.bashurl}niumPurposeCodes';
  static String countryDetailByIso3api =
      '${AllApiService.bashurl}country-detail-by-iso3';

  // ------------------------ nium base url --------------------------
  static String authenticationapi = '${nium_base_url}authentication';
  static String bookfxapi = '${nium_base_url}bookfx';
  static String niumRoutingCodeTypesapi =
      '${AllApiService.bashurl}niumRoutingCodeTypes';
  static String niumpayoutsapi = '${nium_base_url_v2}payouts';
  static String searchbanknamebyifscapi =
      '${AllApiService.bashurl}niumRoutingCodeSearch';
  static String commonsettingURL = '${AllApiService.bashurl}commonsettinglist';
}

/*
static const client_key = "624101Hyii9yvCs494721rkejscJPRs";
static const client_secret = "85a7da40-b4af-11ed-97d2-e12a367dc4c5";
static const x_client_id = "63f96aa36dfe00525eb73111";
static const commonsettingURL = "https://dev.moneytos.com/api/commonsettinglist";

static const String base_url = "https://dev.moneytos.com/api/";
static const String nium_base_url = "https://api-test.instarem.com:4803/api/v1/";
static const String nium_base_url_v2 = "https://api-test.instarem.com:4803/api/v2/";

static const bashurl = "https://dev.moneytos.com/api/";
// static const bashurl = "https://moneytos.com/api/";
// static const bashurl = "https://itmates.digital/moneytos/api/";
static const x_client = "e0271afd8a3b8257af70deacee4";
static const AllrecipientProImageBaseUrl = "https://itmates.digital/moneytos/public/recipientProfileImages/";
static const magicpayBaseUrlBaseUrl = "https://api.sandbox.magicpaysecure.com/api/v2/";
static String client_id = "Basic cm1MRVBjNHlpUDFLcVZXZ0YxWk9TTncwZmtjcm9ZUGM6MTIzNDU2";
*/

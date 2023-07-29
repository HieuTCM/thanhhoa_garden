// ignore_for_file: file_names

Map<String, String> getheader(String token) {
  Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Accept-Charset': 'UTF-8',
    'Authorization': 'Bearer $token'
  };
  return header;
}

Map<String, String> headerLogin = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json',
  'Accept-Charset': 'UTF-8',
};

//Main URL API
const mainURL = 'https://thanhhoagarden.herokuapp.com';

//User
const loginWithUsernamePasswordURL = '/user/login?';
const loginWithGGorPhoneURL = '/user/loginWithEmailOrPhone?';
const registerURL = '/user/register';
const updatefcmTokenURL = '/user/createFcmToken';
const getUserInfoURL = '/user/getByToken';

//Bonsai
const getPlantByIDURL = '/plant/';
const getListPlantURL = '/plant/plantFilter?';

//category
const getAllCategoryURL = '/category';

//service
const getServiceURL = '/service?pageNo=0&pageSize=100&sortBy=ID&sortAsc=true';

//Service Patck
const getServicePackURL = '/servicePack';

//cart
const cartURL = '/cart';

//store
const storeURL = '/store';

//Distance Price
const distanceURL = '/distancePrice';

//order
const orderURL = '/order';
const getOrderURL = '/order/getAllOrderByUsername?';
const getOrderDetailURL = '/order/orderDetail/';
const cancelOrderURL = '/order/rejectOrder?';
const getOrderDetaiByFeedbackStatuslURL = '/order/getOrderDetailByIsFeedback?';

//feedback
const getFeedbackByPlantIDURL = '/feedback/orderFeedback/byPlantID?';
const getFeedbackURL = '/feedback/orderFeedback?';
const createFeedbackDURL = '/feedback/createOrderFB';

//rating
const getRatingURL = '/feedback/getRating';

//contact
const createContactURL = '/contract/createContractCustomer';

//enum
const orderStatus = '/enum/order';

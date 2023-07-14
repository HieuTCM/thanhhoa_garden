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

//cart
const CartURL = '/cart';

//store
const StoreURL = '/store';

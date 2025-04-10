import 'package:crypto_pricing/components/constants/urls.dart';
import 'package:crypto_pricing/models/crypto_model.dart';
import 'package:dio/dio.dart';

class DioServices {
  Future<List<CryptoModel>> fetchCryptoList() async {
    Response response = await Dio().get(ApiUrl.url);
    List<CryptoModel> cryptoList =
        response.data['data']
            .map<CryptoModel>((e) => CryptoModel.fromJsonObject(e))
            .toList();
    return cryptoList;
  }
}

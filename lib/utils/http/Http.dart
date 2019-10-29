import 'package:dio/dio.dart';

import '../configuration/Configuration.dart';

class HTTP {
    static Future<String> post(String theXML) async {
        FormData formData = new FormData.fromMap({
            "data": theXML,
        });

        var response = await Dio().post(Configurations.POST_URL, data: formData);

        return Uri.decodeFull(response.toString()).trim();
    }
}
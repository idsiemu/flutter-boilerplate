# 플러터 개발을 위한 기본 아키텍쳐 세팅입니다.

### DIO를 통한 API CALL

* 주요 파일 위치
    * lib/utils/SendData.dart

* API Header Setting
```
static Future<Options> _abstractHeader(Map<String, String>? headers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sessAuthKey = prefs.get(KEYS.SESSION_TOKEN).toString(); // JWT 토큰 세팅

    var options = Options(
        headers: Map()
    );
    options.headers![KEYS.SESSION_TOKEN] = sessAuthKey;
    options.contentType = 'application/json';
    options.responseType = ResponseType.json;
    options.receiveDataWhenStatusError = true;
    return options;
}

```

* GET TYPE
```
    // 쿼리스트링에 현재 디바이스 타입을 답아 넘긴다.
    static Map<String, String> isQueryString(queryString){
        if(queryString == null) queryString = Map<String, String>();
        queryString[KEYS.SESSION_TYPE] = Device.get().isAndroid ? "W" : "I";
        return queryString;
    }

    static Future<ResponseData> doGet(BuildContext context, String url, {Map<String, String>? headers, Map<String, String>? queryString}) async {
        try{
            var options = await _abstractHeader(headers);
            Response response = await Dio().get('${APIS.DOMAIN}' + url, options: options, queryParameters: isQueryString(queryString));
            return ResponseData(response: response);
        }on DioError catch(e){
            deleteSharedPreferences(context, e);
            return ResponseData(e: e);
        }
    }
```

    * 사용 예제
```
        Map<String, dynamic> data = {};
        data['something'] = 'something';
        Future<ResponseData> response = SendData.doGet(context, '/api/get-something', queryString: data);
```

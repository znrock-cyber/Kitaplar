import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ProxyServer {
  static HttpServer? _server;
  static int _port = 8081;

  static Future<void> start() async {
    if (_server != null) return;

    try {
      // Web platformunda proxy server başlatmaya gerek yok
      if (kIsWeb) {
        print('Web platformunda proxy server simüle ediliyor');
        return;
      }
      
      _server = await HttpServer.bind(InternetAddress.loopbackIPv4, _port);
      print('Proxy sunucusu başlatıldı: http://localhost:$_port');
      
      await for (HttpRequest request in _server!) {
        _handleRequest(request);
      }
    } catch (e) {
      print('Proxy sunucusu başlatılamadı: $e');
    }
  }

  static void _handleRequest(HttpRequest request) async {
    try {
      // CORS başlıklarını ekle
      request.response.headers.add('Access-Control-Allow-Origin', '*');
      request.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
      request.response.headers.add('Access-Control-Allow-Headers', 'Content-Type, Authorization');

      if (request.method == 'OPTIONS') {
        request.response.statusCode = 200;
        await request.response.close();
        return;
      }

      // URL parametresini al
      String? targetUrl = request.uri.queryParameters['url'];
      if (targetUrl == null) {
        request.response.statusCode = 400;
        request.response.write('URL parametresi gerekli');
        await request.response.close();
        return;
      }

      // Hedef URL'ye istek gönder
      HttpClient client = HttpClient();
      HttpClientRequest proxyRequest = await client.getUrl(Uri.parse(targetUrl));
      
      // Orijinal başlıkları kopyala (User-Agent hariç)
      request.headers.forEach((name, values) {
        if (name.toLowerCase() != 'host' && 
            name.toLowerCase() != 'connection' &&
            name.toLowerCase() != 'content-length') {
          for (String value in values) {
            proxyRequest.headers.add(name, value);
          }
        }
      });

      // User-Agent ekle
      proxyRequest.headers.set('User-Agent', 
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36');

      HttpClientResponse proxyResponse = await proxyRequest.close();

      // Yanıt başlıklarını kopyala (X-Frame-Options hariç)
      proxyResponse.headers.forEach((name, values) {
        if (name.toLowerCase() != 'x-frame-options' && 
            name.toLowerCase() != 'content-security-policy' &&
            name.toLowerCase() != 'transfer-encoding') {
          for (String value in values) {
            request.response.headers.add(name, value);
          }
        }
      });

      // Yanıt kodunu ayarla
      request.response.statusCode = proxyResponse.statusCode;

      // Yanıt içeriğini aktar
      await proxyResponse.pipe(request.response);
      
      client.close();
    } catch (e) {
      print('Proxy hatası: $e');
      request.response.statusCode = 500;
      request.response.write('Proxy hatası: $e');
      await request.response.close();
    }
  }

  static Future<void> stop() async {
    if (_server != null) {
      await _server!.close();
      _server = null;
      print('Proxy sunucusu durduruldu');
    }
  }

  static String getProxyUrl(String targetUrl) {
    // Web platformunda doğrudan URL'yi döndür
    if (kIsWeb) {
      return targetUrl;
    }
    return 'http://localhost:$_port?url=${Uri.encodeComponent(targetUrl)}';
  }
}
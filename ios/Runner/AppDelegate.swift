import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // iOS özel konfigürasyonlar
    if #available(iOS 13.0, *) {
        // iOS 13+ için dark mode desteği
        window?.overrideUserInterfaceStyle = .light
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func applicationDidEnterBackground(_ application: UIApplication) {
    // Uygulama arka plana geçtiğinde güvenlik için ekranı gizle
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = window?.frame ?? CGRect.zero
    blurEffectView.tag = 999
    window?.addSubview(blurEffectView)
  }
  
  override func applicationWillEnterForeground(_ application: UIApplication) {
    // Uygulama ön plana geçtiğinde blur efektini kaldır
    window?.viewWithTag(999)?.removeFromSuperview()
  }
}
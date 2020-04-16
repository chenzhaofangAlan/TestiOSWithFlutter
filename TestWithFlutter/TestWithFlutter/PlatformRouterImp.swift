//
//  PlatformRouterImp.swift
//  TestWithFlutter
//
//  Created by Alan on 2020/4/7.
//  Copyright © 2020 Alan. All rights reserved.
//

import Foundation

class PlatformRouterImp: NSObject, FLBPlatform {
    
    func openNative(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        var animated = false
        if exts["animated"] != nil{
            animated = exts["animated"] as! Bool
        }
        //与flutter端约定跳转原生的url为三段式结构native_method_name
        let urlArr = url.components(separatedBy: "_")
        if urlArr.count == 3 {
            let cls : AnyClass? = NSClassFromString("TestWithFlutter." + urlArr[2])
            if let clsType = cls as? BaseViewController.Type {
                let targetVC = clsType.init()
                targetVC.params = urlParams
                if urlArr[1] == "push" {
                    self.navigationController().pushViewController(targetVC, animated: animated)
                    completion(true)
                } else if urlArr[1] == "present" {
                    let navVC = UINavigationController(rootViewController: targetVC)
                    self.navigationController().present(navVC, animated: animated) {
                        completion(true)
                    }
                }
            }
        }
    }
    
    func open(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        if url.prefix(6) == "native" {//约定前面字符为native时跳转原生页面
            openNative(url, urlParams: urlParams, exts: exts, completion: completion)
        } else {
            var animated = false
            if exts["animated"] != nil{
                animated = exts["animated"] as! Bool
            }
            let vc = FLBFlutterViewContainer.init()
            vc.setName(url, params: urlParams)
            self.navigationController().pushViewController(vc, animated: animated)
            completion(true)
        }
    }
    
    func present(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        //直接present出的navVC，会导致flutter路由中uniqueid混乱，有待研究
//        var animated = false
//        if exts["animated"] != nil{
//            animated = exts["animated"] as! Bool
//        }
        let vc = FLBFlutterViewContainer.init()
        vc.setName(url, params: urlParams)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = navVC
//        navigationController().present(navVC, animated: animated) {
//            completion(true)
//        }
    }
    
    func close(_ uid: String, result: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        var animated = false;
        if exts["animated"] != nil{
            animated = exts["animated"] as! Bool
        }
        let presentedVC = self.navigationController().presentedViewController
        let vc = presentedVC as? FLBFlutterViewContainer
        if vc?.uniqueIDString() == uid {
            vc?.dismiss(animated: animated, completion: {
                completion(true)
            })
        }else{
            self.navigationController().popViewController(animated: animated)
        }
    }
    
    func navigationController() -> UINavigationController {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let navigationController = delegate.window?.rootViewController as! UINavigationController
        return navigationController
    }
}


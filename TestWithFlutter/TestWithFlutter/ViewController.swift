//
//  ViewController.swift
//  TestWithFlutter
//
//  Created by Alan on 2020/4/7.
//  Copyright © 2020 Alan. All rights reserved.
//

import UIKit
import Flutter

class ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "native_home"
        
        let button1 = UIButton()
        button1.addTarget(self, action: #selector(pushFlutter), for: .touchUpInside)
        button1.setTitle("push flutter", for: .normal)
        button1.frame = CGRect(x: 100, y: 200, width: 160.0, height: 40.0)
        button1.layer.cornerRadius = 10
        button1.backgroundColor = .cyan
        self.view.addSubview(button1)

        let button2 = UIButton()
        button2.addTarget(self, action: #selector(presentFlutter), for: .touchUpInside)
        button2.setTitle("present flutter", for: .normal)
        button2.frame = CGRect(x: 100, y: 280, width: 160.0, height: 40.0)
        button2.layer.cornerRadius = 10
        button2.backgroundColor = .cyan
        self.view.addSubview(button2)
    }

    @objc func pushFlutter() {
        FlutterBoostPlugin.open("flutterPage", urlParams:[kPageCallBackId:"MycallbackId#5", "query":"aaa"], exts: ["animated":true], onPageFinished: { (_ result:Any?) in
            print(String(format:"call me when page finished, and your result is:%@", result as! CVarArg));
        }) { (f:Bool) in
            print(String(format:"page is opened"));
        }
    }
    
    @objc func presentFlutter() {
        FlutterBoostPlugin.present("flutterPage", urlParams:[kPageCallBackId:"MycallbackId#10", "query":"bbb"], exts: ["animated":true], onPageFinished: { (_ result:Any?) in
          print(String(format:"call me when page finished, and your result is:%@", result as! CVarArg));
        }) { (f:Bool) in
          print(String(format:"page is opened"));
        }
    }
}

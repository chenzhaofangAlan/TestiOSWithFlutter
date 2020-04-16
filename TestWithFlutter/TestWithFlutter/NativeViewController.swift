//
//  NativeViewController.swift
//  TestWithFlutter
//
//  Created by Alan on 2020/4/16.
//  Copyright © 2020 Alan. All rights reserved.
//

import UIKit

class NativeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "native_page"
        
        let label = UILabel(frame: CGRect(x: 100, y: 150, width: 200.0, height: 30.0))
        label.text = "flutter传参：" + (params?["query"] as? String ?? "")
        self.view.addSubview(label)
        
        let button = UIButton()
        button.addTarget(self, action: #selector(pushHome), for: .touchUpInside)
        button.setTitle("push Home", for: .normal)
        button.frame = CGRect(x: 100, y: 200, width: 160.0, height: 40.0)
        button.layer.cornerRadius = 10
        button.backgroundColor = .cyan
        self.view.addSubview(button)
    }
    
    @objc func pushHome() {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

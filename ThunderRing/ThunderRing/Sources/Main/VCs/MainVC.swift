//
//  ViewController.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

class MainVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var cardView: CardView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    private var name = "파링"
    private var thunderCount = 1
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "ThundeRing", backBtnIsHidden: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    
}

// MARK: - Custom Methods

extension MainVC {
    func initUI() {
        
        userNameLabel.text = "\(name)님"
        userNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userNameLabel.textColor = .white
        
        attendanceLabel.attributedText = NSMutableAttributedString()
            .regular(string: "번개 ", fontSize: 14)
            .bold("\(thunderCount)", fontSize: 14)
            .regular(string: "개가 진행 중입니다.", fontSize: 14)
        attendanceLabel.textColor = .white
        
    }
}

extension NSMutableAttributedString {
    func bold(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
      }
    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
            let font = UIFont.systemFont(ofSize: fontSize)
            let attributes: [NSAttributedString.Key: Any] = [.font: font]
            self.append(NSAttributedString(string: string, attributes: attributes))
            return self
        }
      
}

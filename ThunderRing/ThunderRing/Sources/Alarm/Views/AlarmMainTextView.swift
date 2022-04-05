//
//  AlarmMainTextView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/06.
//

import UIKit

import SnapKit
import Then

final class AlarmMainTextView: UIView {
    
    // MARK: - Properties
    
    private var textLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    var text: String = "" {
        didSet { textLabel.text = "\(text)" }
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func configUI() {
        backgroundColor = .background
    }
    
    private func setLayout() {
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
    
}

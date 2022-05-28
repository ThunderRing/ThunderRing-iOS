//
//  ChatMainTableViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/19.
//

import UIKit

class ChatMainTableViewCell: UITableViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    private lazy var cellView = ChatMainTableViewCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        contentView.backgroundColor = .background
    }
    
    private func setLayout() {
        contentView.addSubview(cellView)
        
        cellView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview()
        }
    }
    
    func initCell(chatList: ChatListDataModel) {
        cellView.chatImageView.image = UIImage(named: chatList.imageName!)
        
        cellView.subTitleLabel.text = chatList.groupName
        cellView.subTitleLabel.setTextSpacingBy(value: -0.6)
        
        cellView.titleLabel.text = chatList.thunderName
        cellView.titleLabel.setTextSpacingBy(value: -0.6)
        
        cellView.memberCountLabel.text = "\(chatList.countUsers!)"
        cellView.memberCountLabel.setTextSpacingBy(value: -0.6)
        
        cellView.contentLabel.text = chatList.contentLabel
        cellView.contentLabel.setTextSpacingBy(value: -0.6)
        
        cellView.timeLabel.text = chatList.timeStamp?.toRelativeTime
        cellView.timeLabel.setTextSpacingBy(value: -0.6)
        
        cellView.messageCountView.messageCount = chatList.chatCount!
    }
}

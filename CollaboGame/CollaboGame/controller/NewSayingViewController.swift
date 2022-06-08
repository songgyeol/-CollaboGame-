//
//  NewSayingViewController.swift
//  CollaboGame
//
//  Created by 송결 on 2022/05/08.
//

import UIKit

class NewSayingViewController: UIViewController {
    
    private let mainImageView = UIImageView(image: UIImage(named: "배경"))
    private let titleImage = UIImageView(image: UIImage(named: "빨강"))
    private var newSayingView = UIView()
    private var titleLabel = CustomLabel(title: "신조어", size: 25)
    private var newSayingLabel = CustomLabel(title: "신조어 맞추기", size: 30)
    private var answerButton = CustomButton(title: "시작하기", size: 20)
    private var qAndAText = ""
    private var unSelected = ""
    private let qaTitle = ["문제", "정답"]
    private var playButton = CustomButton(frame: .zero)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor.backGroundColor
        self.navigationItem.title = "그 말 뭐니"
        setUI()
    }
}

//MARK: - Selector
extension NewSayingViewController {
    
    @objc
    func answerButton(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "시작하기") {
            playButton.setImage(UIImage(named: "정답확인"), for: .normal)
            qAndAText = NewSaying.shared.newSayingQ["\(qaTitle[0])"]?.randomElement() ?? ""
            newSayingLabel.text = qAndAText
            newSayingView.isHidden = true
        } else if sender.currentImage == UIImage(named: "정답확인") {
            playButton.setImage(UIImage(named: "다음문제"), for: .normal)
            titleLabel.text = qAndAText
            titleLabel.textColor = .yellow
            newSayingLabel.textColor = CustomColor.mainTintColor
            let selected =  NewSaying.shared.newSayingA[qAndAText] ?? ""
            unSelected = selected
            newSayingLabel.text = "\(unSelected)"
        } else if sender.currentImage == UIImage(named: "다음문제") {
            playButton.setImage(UIImage(named: "정답확인"), for: .normal)
            titleLabel.text = "신조어"
            titleLabel.textColor = CustomColor.mainTintColor
            newSayingLabel.textColor = CustomColor.mainTintColor
            qAndAText = NewSaying.shared.newSayingQ["\(qaTitle[0])"]?.randomElement() ?? ""
            newSayingLabel.text = qAndAText
            newSayingView.isHidden = true
        }
    }
}
//MARK: - UI
extension NewSayingViewController {
    func setUI() {
        setBasic()
        setConstraints()
    }
    
    func setBasic() {
        [mainImageView,titleImage, titleLabel,newSayingLabel,answerButton,playButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        playButton.addTarget(self, action: #selector(answerButton(_:)), for: .touchUpInside)
        newSayingLabel.numberOfLines = 0
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            mainImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),
            
            newSayingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newSayingLabel.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            newSayingLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 120),
            newSayingLabel.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 40),
            newSayingLabel.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -40),
            newSayingLabel.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -20),
            
            titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImage.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 60),
            titleImage.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 40),
            titleImage.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -40),
            titleImage.bottomAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 100),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -40),
            titleLabel.bottomAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 100),
            
            answerButton.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 30),
            answerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            answerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerButton.widthAnchor.constraint(equalToConstant: 250),
            
            playButton.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 30),
            playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 250),
            

        ])
    }
    
}

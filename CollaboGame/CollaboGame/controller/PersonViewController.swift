//
//  PersonViewController.swift
//  CollaboGame
//
//  Created by 송결 on 2022/05/08.
//

import UIKit

class PersonViewController: UIViewController {
    
    private let mainImageView = UIImageView(image: UIImage(named: "배경"))
    private let hintLabel = UILabel()
    private let hintButton = UIButton()
    private let mainLabel = CustomLabel(title: "인물게임")
    private var quizImageView = UIImageView()
    private var playButton = CustomButton(frame: .zero)
    private let startBtn = CustomButton()
    private let rightAnswerBtn = CustomPassButton()
    private var answerbButton = CustomPassButton(frame: .zero)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "그 사람 누구지"
        view.backgroundColor = myColor.backGroundColor
        configureUI()
    }
    
}
//MARK: - ButtonAction
extension PersonViewController {
    @objc func hintButtonTapped(_ sender: UIButton) {
        hintLabel.text = Person.shared.randomPerson.getInitialLetter()
    }
    @objc func startBtnTapped(_ sender: UIButton) {
        hintButton.isHidden = false
        sender.setTitle("다음 문제", for: .normal)
        Person.shared.getRandomPerson()
        quizImageView.image = UIImage(named: Person.shared.randomPerson)
        hintLabel.text = "힌트가 필요할 때는 ➡️"
    }
    @objc func rightButtonTapped(_ sender: UIButton) {
        hintButton.isHidden = true
        hintLabel.text = Person.shared.randomPerson
    }
}

//MARK: -UI
extension PersonViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        quizImageView.backgroundColor = .clear
        quizImageView.contentMode = .scaleAspectFit
        mainImageView.clipsToBounds = true
        mainLabel.backgroundColor = .clear
        
        [hintButton].forEach {
            $0.tintColor = CustomColor.mainTintColor
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 2
            $0.layer.borderColor = CustomColor.mainTintColor.cgColor
            $0.setTitle("힌 트", for: .normal)
            $0.setTitleColor(CustomColor.btnTextColor, for: .normal)
        }
        [hintLabel].forEach {
            $0.text = ""
            $0.font = UIFont.Pretandard(type: .Light, size: 20)
            $0.textAlignment = .center
        }
    }
    final private func addTarget() {
        playButton.addTarget(self, action: #selector(startBtnTapped(_:)), for: .touchUpInside)
        hintButton.addTarget(self, action: #selector(hintButtonTapped(_:)), for: .touchUpInside)
        answerbButton.addTarget(self, action: #selector(rightButtonTapped(_:)), for: .touchUpInside)
    }
    
    final private func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [hintLabel, hintButton])
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        [startBtn, playButton, rightAnswerBtn, answerbButton, mainImageView, mainLabel, quizImageView, stackView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            
            mainImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainImageView.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -50),
            mainImageView.heightAnchor.constraint(equalToConstant: 450),
            
            stackView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 45),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 45),
            
            hintButton.widthAnchor.constraint(equalToConstant: 50),
            
            mainLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mainLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 90),
            mainLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            mainLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 300),
            
            quizImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quizImageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:20),
            quizImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            quizImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            quizImageView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -10),
            
           
            startBtn.topAnchor.constraint(equalTo: rightAnswerBtn.topAnchor, constant: -70),
            startBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),        startBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            startBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            startBtn.bottomAnchor.constraint(equalTo: rightAnswerBtn.topAnchor, constant: -30),
            
            playButton.topAnchor.constraint(equalTo: rightAnswerBtn.topAnchor, constant: -70),
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),   playButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            playButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            playButton.bottomAnchor.constraint(equalTo: rightAnswerBtn.topAnchor, constant: -30),
            
            
            rightAnswerBtn.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            rightAnswerBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),        rightAnswerBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            rightAnswerBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            rightAnswerBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            answerbButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            answerbButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),        answerbButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            answerbButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            answerbButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
        ])
    }
}


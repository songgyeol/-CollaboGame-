//
//  InitialLetterViewController.swift
//  CollaboGame
//
//  Created by 송결 on 2022/05/08.
//

import UIKit

class InitialLetterViewController: UIViewController {
    private let initialQuizManager = InitialQuiz.shared
    private let mainImageView = UIImageView(image: UIImage(named: "배경"))
    private let categoryButton = UISegmentedControl(items: ["과자", "라면", "아이스크림"])
    private var quizLabel = CustomLabel(title: "초성게임")
    
    private var playButton = CustomButton(frame: .zero)
    private let startButton = CustomButton()
    private var timerLabel = UILabel()
    private let progressBar = CustomProgressBar()
    private var answerButton = CustomPassButton(frame: .zero)
    private let rightAnswerButton = CustomPassButton()
    
    private var timer = Timer()
    private var secondRemaining: Int = 0
    
    private let limitTime = 30 // 게임 시간 = 타이머 시간
    
    private var currentCategory = "과자"
    private var currentAnswer = ""
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "초성 게임"
        configureUI()
        view.backgroundColor = myColor.backGroundColor
    }
    
    
    @objc func update() {
        if secondRemaining < limitTime {
            secondRemaining += 1
            let percentage = Float(secondRemaining) / Float(limitTime)
            progressBar.setProgress(Float(percentage), animated: true)
            print(secondRemaining)
        } else {
            showAlert()
            timer.invalidate()
        }
    }
}
//MARK: - InitialLetterViewController
extension InitialLetterViewController {
    
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentCategory = "과자"
            initialQuizManager.resultArray = []
        case 1:
            currentCategory = "라면"
            initialQuizManager.resultArray = []
        case 2:
            currentCategory = "아이스크림"
            initialQuizManager.resultArray = []
        default:
            break
        }
    }
//MARK: - Selector
    @objc private func buttonTapped(_ sender: UIButton) {
        
        switch sender.currentImage {
        case UIImage(named: "시작하기"):
            playButton.setImage(UIImage(named: "다음문제"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            timerLabel.isHidden = true
            progressBar.isHidden = false
            quizLabel.text = getInitialLetter()
        case UIImage(named: "다음문제"):
            quizLabel.text = getInitialLetter()
            //timer.invalidate()
        case UIImage(named: "정답확인"):
            quizLabel.text = currentAnswer
        default:
            break
            
        }
        
    }
    
    func getInitialLetter() -> String {
        guard let randomWord = initialQuizManager.quiz[currentCategory]?.randomElement() else { fatalError() }
        currentAnswer = randomWord
        if !initialQuizManager.resultArray.contains(randomWord) {
            initialQuizManager.resultArray.append(randomWord)
        }
        print(randomWord)
        print(initialQuizManager.resultArray)
        return randomWord.getInitialLetter()
    }
    
    
//MARK: - Alert
    func showAlert() {
        print("alert")
        let alert = UIAlertController(title: "게임 종료", message: "결과를 확인하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "결과보기", style: .default) { [weak self] _ in
            let nextVC = InitialResultViewController()
            self?.navigationController?.navigationItem.title = "정답확인"
            self?.navigationController?.pushViewController(nextVC, animated: true)
            nextVC.resultArray = self?.initialQuizManager.resultArray ?? [""]
            self?.playButton.setImage(UIImage(named: "시작하기"), for: .normal) //("시작하기", for: .normal)
            self?.quizLabel.text = "초성게임"
            self?.secondRemaining = 0
            self?.progressBar.progress = 0.0
            self?.currentAnswer = "초성게임"
        }
        let cancelAction = UIAlertAction(title: "다시하기", style: .cancel) { [weak self] _ in
            self?.playButton.setImage(UIImage(named: "시작하기"), for: .normal)
            self?.timer.invalidate()
            self?.quizLabel.text = "초성게임"
            self?.secondRemaining = 0
            self?.playButton.setImage(UIImage(named: "시작하기"), for: .normal)
            self?.progressBar.progress = 0.0
            self?.currentAnswer = "초성게임"
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

//MARK: -UI
extension InitialLetterViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        mainImageView.clipsToBounds = true
        
        [categoryButton].forEach {
            $0.backgroundColor = UIColor.white
            $0.selectedSegmentTintColor = CustomColor.mainTintColor
            $0.selectedSegmentIndex = 0
        }
        
        
        
        [timerLabel].forEach {
            $0.text = "제한 시간 : 30초"
            $0.textAlignment = .center
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 20)
        }
        
        
        [progressBar].forEach {
            $0.isHidden = true
            $0.progressViewStyle = .default
            $0.progress = 0.0
        }
        
    }
//MARK: - AddTarget
    final private func addTarget() {
        playButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        answerButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
//MARK: - setConstraints
    final private func setConstraints() {
        
        
        [mainImageView,categoryButton, quizLabel, timerLabel, startButton, playButton, rightAnswerButton,answerButton ,progressBar].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        
        NSLayoutConstraint.activate([
            
            mainImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainImageView.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -50),
            
            categoryButton.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 45),
            categoryButton.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 20),
            categoryButton.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -20),
            categoryButton.bottomAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 70),
            
            quizLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            quizLabel.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 10),
            quizLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            quizLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            quizLabel.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            quizLabel.heightAnchor.constraint(equalToConstant: 250),
            
            
            
            timerLabel.topAnchor.constraint(equalTo: progressBar.topAnchor, constant: -30),
            timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            progressBar.topAnchor.constraint(equalTo: startButton.topAnchor, constant: -35),
            progressBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            progressBar.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -30),
            
            startButton.topAnchor.constraint(equalTo: rightAnswerButton.topAnchor, constant: -70),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),        startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            startButton.bottomAnchor.constraint(equalTo: rightAnswerButton.topAnchor, constant: -30),
            
            playButton.topAnchor.constraint(equalTo: rightAnswerButton.topAnchor, constant: -70),
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),   playButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            playButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            playButton.bottomAnchor.constraint(equalTo: rightAnswerButton.topAnchor, constant: -30),
            
            
            rightAnswerButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            rightAnswerButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),        rightAnswerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            rightAnswerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            rightAnswerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            answerButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            answerButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),        answerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            answerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            answerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
        ])
    }
}

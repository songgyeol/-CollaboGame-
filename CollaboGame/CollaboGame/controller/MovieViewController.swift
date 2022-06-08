//
//  MovieViewController.swift
//  CollaboGame
//
//  Created by 송결 on 2022/05/08.
//

import UIKit

class MovieViewController: UIViewController {
    
    private let mainImageView = UIImageView(image: UIImage(named: "배경"))
    private let titleImage = UIImageView(image: UIImage(named: "빨강"))
    private var mainLabel = CustomLabel(title: "대사로 영화 맞추기", size: 30)
    private let movieImageView = UIImageView()
    private var answerButton = CustomButton()
    private var qAndAText = ""
    private var year = 0
    private var answerLabel = CustomLabel(title: "영화 명대사", size: 25)
    private var playButton = CustomButton(frame: .zero)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor.backGroundColor
        self.navigationItem.title = "그 영화 뭐니"
        movieImageView.isHidden = true
        setUI()
    }
    //MARK: - Data
    private func loadImage(imageUrl: String) {
        let urlString = imageUrl
        guard let url = URL(string: urlString) else { return }
        
        // 오래걸리는 작업을 동시성 처리 (다른 쓰레드에서 일시킴)
        DispatchQueue.global().async {
            // URL을 가지고 데이터를 만드는 메서드 (오래걸리는데 동기적인 실행)
            // (일반적으로 이미지를 가져올때 많이 사용)
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlString == url.absoluteString else { return }
            
            // 작업의 결과물을 이미로 표시 (메인큐)
            DispatchQueue.main.async {
                self.movieImageView.image = UIImage(data: data)
            }
        }
    }
}

//MARK: - Selector
extension MovieViewController {
    @objc
    func answerButton(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "시작하기") {
            qAndAText = MovieLine.shared.movieA.keys.randomElement() ?? ""
            mainLabel.text = MovieLine.shared.movieA[qAndAText]
            playButton.setImage(UIImage(named: "정답확인"), for: .normal)
            movieImageView.isHidden = true
        } else if sender.currentImage == UIImage(named: "정답확인") {
            year = MovieLine.shared.yearMovie[qAndAText] ?? 2000
            answerLabel.text = qAndAText
            answerLabel.textColor = .yellow
            mainLabel.textColor = .clear
            playButton.setImage(UIImage(named: "다음문제"), for: .normal)
            movieImageView.isHidden = false
            
            APIManager.shared.requestMovie(word: qAndAText, year: year) { response in
                switch response {
                case .success(let data):
                    self.loadImage(imageUrl: data.items[0].image)
                    print(data.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else if sender.currentImage == UIImage(named: "다음문제") {
            answerLabel.textColor = CustomColor.mainTintColor
            answerLabel.text = "영화 명대사"
            playButton.setImage(UIImage(named: "정답확인"), for: .normal)
            qAndAText = MovieLine.shared.movieA.keys.randomElement() ?? ""
            mainLabel.textColor = CustomColor.mainTintColor
            mainLabel.text = MovieLine.shared.movieA[qAndAText]
            year = MovieLine.shared.yearMovie[qAndAText] ?? 2000
            movieImageView.isHidden = true
            
            APIManager.shared.requestMovie(word: qAndAText, year: year) { response in
                switch response {
                case .success(let data):
                    self.loadImage(imageUrl: data.items[0].image)
                    print(data.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

//MARK: - UI
extension MovieViewController {
    func setUI() {
        setBasic()
        setConstraints()
    }
    
    func setBasic() {
        [mainImageView,titleImage,answerLabel,mainLabel,answerButton,playButton,movieImageView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        playButton.addTarget(self, action: #selector(answerButton(_:)), for: .touchUpInside)
        mainLabel.numberOfLines = 0
        answerLabel.numberOfLines = 0
        
        mainLabel.backgroundColor = .clear
        
        movieImageView.layer.cornerRadius = 3.0//테두리가 라운드가 된다.
        movieImageView.layer.borderColor = UIColor.yellow.cgColor
        movieImageView.layer.borderWidth = 5.0 //테두리의 두께
        movieImageView.layer.masksToBounds = true //테두리의 배경을 투명하게
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),
            
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 120),
            movieImageView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 80),
            movieImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -80),
            movieImageView.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -50),
            
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 120),
            mainLabel.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 40),
            mainLabel.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -40),
            mainLabel.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -20),
            
            titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImage.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 60),
            titleImage.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 40),
            titleImage.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -40),
            titleImage.bottomAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 100),
            
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 60),
            answerLabel.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 40),
            answerLabel.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -40),
            answerLabel.bottomAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 100),
          
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


//
//  MainViewController.swift
//  CollaboGame
//
//  Created by 송결 on 2022/05/08.
//

import UIKit

import UIKit
//face.dashed.fill, bold.underline, brain.head.profile, film
class MainViewController: UIViewController {
    
    let model = [
        Model(gameTitle: "그 사람 누구지", imageName: "person.fill.questionmark", subTitle: "인물게임"),
        Model(gameTitle: "그 단어 뭐지", imageName: "bold.underline", subTitle: "초성게임"),
        Model(gameTitle: "그 말 뭐지", imageName: "brain.head.profile", subTitle: "신조어 게임"),
        Model(gameTitle: "그 영화 뭐지", imageName: "film", subTitle: "영화명대사게임"),
    ]
    
    let subImageView = UIImageView(image: UIImage(named: "서브배경"))
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.navigationItem.title = "콜라보 게임"
        collectionView.backgroundColor = myColor.backGroundColor
        view.backgroundColor = myColor.backGroundColor
    }
    
}
//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWitdh * (CVCell.cellColumns - 1)-60) / CVCell.cellColumns
        let size = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
    }
}
//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            navigationController?.pushViewController(PersonViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(InitialLetterViewController(), animated: true)
        case 2:
            navigationController?.pushViewController(NewSayingViewController(), animated: true)
        case 3:
            navigationController?.pushViewController(MovieViewController(), animated: true)
        default:
            break
        }
    }
}
//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { fatalError() }
        cell.iconImageView.image = UIImage(systemName: model[indexPath.item].imageName)
        cell.gameTitle.text = model[indexPath.item].gameTitle
        cell.subTitle.text = model[indexPath.item].subTitle
        return cell
    }
    
}


//MARK: -UI
extension MainViewController {
    final private func configureUI() {
        configureCollectionView()
        setConstraints()
    }
    
    
    final private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    
    final private func setConstraints() {
        [collectionView,subImageView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 700),
            
            subImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            subImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            //subImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
    }
}

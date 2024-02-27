//
//  ViewController.swift
//  task9
//
//  Created by Alexander Zhuchkov on 27.02.2024.
//

import UIKit

class ViewController: UIViewController {

    struct Constants {
        static let itemWidth: CGFloat = 300
        static let spacing: CGFloat = 10
    }

    // MARK: - Subviews
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<String, String> = {
        let dataSource = UICollectionViewDiffableDataSource<String, String>(collectionView: collectionView) { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .tertiaryLabel
            cell.layer.cornerRadius = 10
            return cell
        }
        
        return dataSource
    }()
    
    
    // MARK: - Methods
    private func setupView() {
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        // Update Data Source
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        
        snapshot.appendSections([""])
        snapshot.appendItems(["1", "2", "3", "4", "5", "6", "7", "8"])
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
     
        let normalizedOffset = targetContentOffset.pointee.x + scrollView.contentInset.left
        let page = Int((normalizedOffset + (Constants.itemWidth + Constants.spacing) / 2) / (Constants.itemWidth + Constants.spacing))
        
        let xOffset = CGFloat(page) * (Constants.itemWidth + Constants.spacing) - scrollView.contentInset.left

        // Tell the scroll view to land on our page
        targetContentOffset.pointee.x = xOffset
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: Constants.itemWidth, height: collectionView.bounds.height)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return Constants.spacing
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 0
     }
    
}

extension ViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

    
}

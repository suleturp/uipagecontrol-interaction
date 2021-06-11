//
//  ViewController.swift
//  uipagecontrol
//
//  Created by Şule Turp on 19.03.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    private let imageNames = [
        "image1",
        "image2",
        "image3",
        "image4",
        "image2",
        "image3",
        "image4",
        "image2",
        "image3",
        "image4"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        preparePageControl()
    }
    
    private func prepareCollectionView() {
        collectionView.isPagingEnabled = true
        
    }
    
    private func preparePageControl() {
        pageControl.numberOfPages = imageNames.count
        if #available(iOS 14.0, *) {
            pageControl.addTarget(self,
                                  action: #selector(pageControlValueChanged),
                                  for: .valueChanged)
            pageControl.allowsContinuousInteraction = true
            pageControl.backgroundStyle = .prominent
        }
    }
}

extension ViewController {
    @objc private func pageControlValueChanged() {
        collectionView.scrollToItem(at: .init(row: pageControl.currentPage, section: .zero),
                                    at: .centeredHorizontally,
                                    animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ImageCell,
              let image = UIImage(named: imageNames[indexPath.row])
        else
        { return UICollectionViewCell() }
        
        cell.setup(with: image)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

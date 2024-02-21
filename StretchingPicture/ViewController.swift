//
//  ViewController.swift
//  StretchingPicture
//
//  Created by Иван Дроботов on 21.02.2024.
//

import UIKit

final class ViewController: UIViewController {

    private let imageView = UIImageView(image: UIImage(named: "image"))
    private let scrollView = UIScrollView()
    private let mainView = UIView()
    
    private let imageHeight: CGFloat = 270
    
    private var imageHeightConstraint = NSLayoutConstraint()
    private var imageTopConstraint = NSLayoutConstraint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    private func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
          
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height + imageHeight)
            
        ])
        
        
        imageTopConstraint = imageView.topAnchor.constraint(equalTo: view.topAnchor)
        imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        NSLayoutConstraint.activate([
            
            imageTopConstraint,
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageHeightConstraint,
            
        ])
        print(UIScreen.main.bounds.width)
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let newImageHeight = imageHeight - scrollView.contentOffset.y - view.safeAreaInsets.top
        imageHeightConstraint.constant = max(imageHeight, newImageHeight)
        

        let topPadding = -scrollView.contentOffset.y - view.safeAreaInsets.top
        imageTopConstraint.constant = min(topPadding, 0)
        
        let topInset = max(newImageHeight, imageHeight) - view.safeAreaInsets.top
        scrollView.verticalScrollIndicatorInsets = .init(top: topInset, left: 0, bottom: 0, right: 0)
    }
}

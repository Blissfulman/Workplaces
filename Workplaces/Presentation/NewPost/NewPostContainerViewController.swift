//
//  NewPostContainerViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 13.06.2021.
//

import UIKit

// MARK: - Protocols

protocol NewPostContainerViewControllerDelegate: AnyObject {
    func back()
}

final class NewPostContainerViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private let newPostService: NewPostService
    private let newPostModel = NewPostModel()
    private var progressList = [Progress]()
    private weak var delegate: NewPostContainerViewControllerDelegate?
    private lazy var newPostVC = NewPostViewController(newPostModel: newPostModel, delegate: self)
    
    // MARK: - Initializers
    
    init(
        newPostService: NewPostService = ServiceLayer.shared.newPostService,
        delegate: NewPostContainerViewControllerDelegate?
    ) {
        self.newPostService = newPostService
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    
    deinit {
        progressList.forEach { $0.cancel() }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tabBarController?.tabBar.isHidden = true
        addFullover(newPostVC)
    }
    
    private func publishPost() {
//        let progress = newPostService.publishPost(post: post) { result in
//            switch result {
//            case let .success(post):
//                print(post)
//
//                if let imageURL = post.imageURL,
//                   let data = try? Data(contentsOf: imageURL),
//                   let imageData = Data(base64Encoded: data) {
//                    self.imageView.image = UIImage(data: imageData)
//                }
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
//        progressList.append(progress)
    }
}

// MARK: - NewPostViewControllerDelegate

extension NewPostContainerViewController: NewPostViewControllerDelegate {
    
    func didTapAddLocationButton() {
        // Необходимо доработать
    }
    
    func didTapAddImageButton() {
        
    }
    
    func didTapPublishButton() {
        delegate?.back()
    }
}

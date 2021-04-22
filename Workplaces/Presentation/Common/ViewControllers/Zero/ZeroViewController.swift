//
//  ZeroViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 18.04.2021.
//

import UIKit

// MARK: - Protocols

protocol ZeroScreenCoordinable {
    var didTapButton: VoidBlock { get set }
}

final class ZeroViewController: UIViewController, ZeroScreenCoordinable {
    
    // MARK: - Nested types
    
    public enum ViewType {
        case error
        case noData
    }
    
    // MARK: - Public properties
    
    var didTapButton: VoidBlock
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    // MARK: - Private properties
    
    private let viewType: ViewType
    
    // MARK: - Initializers
    
    init(viewType: ViewType, didTapButton: @escaping VoidBlock) {
        self.viewType = viewType
        self.didTapButton = didTapButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func buttonTapped() {
        didTapButton()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        switch viewType {
        case .error:
            // Т.к. экран изначально настроен под данный тип, нет необходимости обновлять интерфейс
            break
        case .noData:
            imageView.image = Images.noDataScreen
            titleLabel.text = "Пустота"
            subtitleLabel.text = "Если молчать, люди никогда не узнают о вас"
            button.setTitle("Создать пост", for: .normal)
        }
    }
}

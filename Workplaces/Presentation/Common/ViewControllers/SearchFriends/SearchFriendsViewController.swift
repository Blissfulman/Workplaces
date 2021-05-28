//
//  SearchFriendsViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol SearchFriendsViewControllerDelegate: AnyObject {
    func didTapSearchButton(query: String)
}

final class SearchFriendsViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var searchBar: UISearchBar!
    
    // MARK: - Private properties
    
    private weak var delegate: SearchFriendsViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(delegate: SearchFriendsViewControllerDelegate) {
        self.delegate = delegate
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        searchBar.setImage(Icons.search, for: .search, state: .normal)
        searchBar.setImage(Icons.close, for: .clear, state: .normal)
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.tintColor = Palette.orange
        let attributedString = NSAttributedString(
            string: "Name or nickname".localized(),
            attributes: [.foregroundColor: Palette.middleGrey]
        )
        searchBar.searchTextField.attributedPlaceholder = attributedString
    }
}

// MARK: - UISearchBarDelegate

extension SearchFriendsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didTapSearchButton(query: searchBar.text ?? "")
    }
}

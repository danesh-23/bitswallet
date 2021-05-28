//
//  ViewController.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-25.
//

import UIKit

class CardTableVC: UIViewController {

    weak var coordinator: MainCoordinator?
    var tableView: UITableView! = UITableView()
    var cardViewModel: CardTableViewModel = CardTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        configureTableView()
        setupViews()
        configureViewModel()
    }
    
    private func configureViewModel() {
        cardViewModel.refreshClosure = { [weak self] in self?.tableView.reloadData() }
        cardViewModel.loadData()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.selectionFollowsFocus = false
        tableView.register(CardTableCell.self, forCellReuseIdentifier: CardTableCell.identifier)
        tableView.accessibilityIdentifier = "cardTable"
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .white
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        addBarButtonItem.accessibilityIdentifier = "addBarButtonItem"
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .black

        let leadingTableAnchor = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingTableAnchor = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let topTableAnchor = tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        let bottomTableAnchor = tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([leadingTableAnchor, trailingTableAnchor, topTableAnchor, bottomTableAnchor])
    }
    
    @objc func addTapped() {
        coordinator?.addCard(controller: self)
    }
}

extension CardTableVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableCell.identifier, for: indexPath) as? CardTableCell else { return UITableViewCell() }
        let cardCellVM = cardViewModel.cardCell(at: indexPath.row)
        cell.selectionStyle = .none
        cell.configureCell(card: cardCellVM)
        cell.accessibilityIdentifier = "cardTable_\(indexPath.row)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cardViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cardViewModel.cardDetails(at: indexPath.row)
        coordinator?.openCardDetails(card: card)
    }
}

extension CardTableVC: AddCardDelegate {
    func addNewCard(card: AddCardViewModel) {
        cardViewModel.addCard(card: card.cardDetails)
    }
}

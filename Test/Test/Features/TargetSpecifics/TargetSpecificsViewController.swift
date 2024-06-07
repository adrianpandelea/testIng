//
//  TargetSpecificsViewController.swift
//  Test
//
//  Created by Adrian Pandelea on 27.05.2024.
//

import UIKit

class TargetSpecificsViewController: UIViewController {
   
    private let viewModel: TargetSpecificsViewModel

    @IBOutlet weak var targetSpecificsTableView: UITableView!

    init(viewModel: TargetSpecificsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Text.targetSpecifics
        setupNavigationItem()
        setupTableView()
        loadData()
    }
    
    private func loadData() {
        viewModel.fetchTargetSpecifics { [weak self] error in
            if let error {
                self?.presentAlert(title: Text.Alert.error, message: error.localizedDescription, buttonTitle: Text.Alert.ok)
            } else {
                self?.targetSpecificsTableView.reloadData()
            }
        }
    }
    
    @objc private func nextTapped() {
        viewModel.selectSpecifics()
    }

    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Text.next, style: .plain, target: self, action: #selector(nextTapped))
    }
    
    private func setupTableView() {
        targetSpecificsTableView.register(UINib(nibName: TargetSpecificCell.identifier, bundle: nil), forCellReuseIdentifier: TargetSpecificCell.identifier)
    }
}

extension TargetSpecificsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TargetSpecificCell.identifier, for: indexPath) as? TargetSpecificCell else {
            return UITableViewCell()
        }
        cell.configureWith(viewModel: viewModel.cellViewModel(at: indexPath))
        return cell
    }
}

extension TargetSpecificsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        viewModel.selectSpecific(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.deselectSpecific(at: indexPath)
    }
}


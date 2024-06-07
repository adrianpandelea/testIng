//
//  ReviewViewController.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import UIKit
import MessageUI

class ReviewViewController: UIViewController {
    private let viewModel: ReviewViewModel
    @IBOutlet weak var campaignsTableView: UITableView!
    
    init(viewModel: ReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Text.review
        setupNavigationItem()
        setupTableView()
        loadData()
    }
    
    private func loadData() {
        viewModel.makeCampaignCellViewModels()
        campaignsTableView.reloadData()
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Text.sendEmail, style: .plain, target: self, action: #selector(sendEmailTapped))
    }
        
    private func setupTableView() {
        campaignsTableView.register(UINib(nibName: CampaignCell.identifier, bundle: nil), forCellReuseIdentifier: CampaignCell.identifier)
    }
    
    private func sendEmailTo(address: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([address])
            mail.setMessageBody(viewModel.emailBody, isHTML: false)
            present(mail, animated: true)
        } else {
            presentAlert(title: Text.Alert.error, message: Text.emailError, buttonTitle: Text.Alert.ok)
        }
    }
    
    private func showSendEmailAlert() {
        let alert = UIAlertController(title: Text.sendEmail, message: Text.enterEmailAddress, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = Text.defaultEmailAddress
        }
        alert.addAction(UIAlertAction(title: Text.send, style: .default, handler: { action in
            let textField = alert.textFields?.first
            self.sendEmailTo(address: textField?.text ?? Text.defaultEmailAddress)
        }))
        alert.addAction(UIAlertAction(title: Text.Alert.cancel, style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func sendEmailTapped() {
        showSendEmailAlert()
    }
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CampaignCell.identifier, for: indexPath) as? CampaignCell else {
            return UITableViewCell()
        }
        cell.configureWith(viewModel: viewModel.cellViewModel(at: indexPath))
        return cell
    }
}

extension ReviewViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
        controller.dismiss(animated: true)
    }
}

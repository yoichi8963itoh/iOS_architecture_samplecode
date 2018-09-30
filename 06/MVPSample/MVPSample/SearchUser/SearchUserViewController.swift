//
//  SearchUserViewController.swift
//  MVPSample
//
//  Created by Kenji Tanaka on 2018/09/23.
//  Copyright © 2018年 Kenji Tanaka. All rights reserved.
//

import UIKit

protocol SearchUserViewProtocol: class {
    func reloadTableView()
    func transitionToUserDetail(userName: String)
}

final class SearchUserViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private var presenter: SearchUserPresenterProtocol!
    func inject(presenter: SearchUserPresenterProtocol) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            presenter.didTapSearchButton(text: text)
        }
    }
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell

        if let user = presenter.user(forRow: indexPath.row) {
            cell.configure(user: user)
        }

        return cell
    }
}

extension SearchUserViewController: SearchUserViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }

    func transitionToUserDetail(userName: String) {
        let userDetailVC = UIStoryboard(name: "UserDetail", bundle: nil).instantiateInitialViewController() as! UserDetailViewController
        let model = UserDetailModel(userName: userName)
        let presenter = UserDetailPresenter(userName: userName, view: userDetailVC, model: model)
        userDetailVC.inject(presenter: presenter)

        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

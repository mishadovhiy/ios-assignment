//
//  UITableViewDelegate_RepoListViewController.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

extension RepoListViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = viewModel.repoList.count
        return data == 0 ? (apiError != nil ? 1 : 0) : data
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if apiError != nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageTableViewCell.self)) as? MessageTableViewCell else { return UITableViewCell() }
            cell.set(message: apiError?.message ?? .init(title: "No data found in \(viewModel.username)"))
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as? RepoTableViewCell else { return UITableViewCell() }
            let repo = viewModel.repoList[indexPath.row]
            cell.setCell(repo)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return apiError != nil ? tableView.frame.height : UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 && viewModel.repoList.count != 0 {
            return UITableView.automaticDimension
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 && viewModel.repoList.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SectionHeaderTableCell.self)) as! SectionHeaderTableCell
            cell.set(title: viewModel.sectionTitle)
            return cell.contentView
        } else {
            return nil
        }
    }

}

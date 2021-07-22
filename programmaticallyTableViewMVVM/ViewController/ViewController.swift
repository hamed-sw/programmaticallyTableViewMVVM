//
//  ViewController.swift
//  programmaticallyTableViewMVVM
//
//  Created by Hamed Amiry on 22.07.2021.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    lazy var viewModel = NewsViewModel()
    

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        title = "News"
        view.backgroundColor = .systemBackground
        viewModel.getData()
    }
    
    //tableView frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension ViewController: UITableViewDelegate,UITableViewDataSource, RefreshTableViewDelegate {
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.viewModelArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
                for: indexPath) as? NewsTableViewCell else { fatalError() }
        cell.configuer(with: viewModel.viewModelArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = viewModel.articleArray[indexPath.row]
        guard let url = URL(string: article.url ?? "") else {return}
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

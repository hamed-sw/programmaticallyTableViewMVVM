//
//  ViewModel.swift
//  programmaticallyTableViewMVVM
//
//  Created by Hamed Amiry on 22.07.2021.
//

import Foundation

protocol RefreshTableViewDelegate: AnyObject {
    func update()
}

class NewsViewModel {
    
    var apiModel: APIResponse?
    weak var delegate: RefreshTableViewDelegate?
     var viewModelArray = [ViewModelCell]()
    // for next page go for detail need to create array of artical
     var articleArray = [Article]()
    
    func getData() {
        
        ParsingJson.shared.getNews { [weak self] result in
            switch result {
            case .success(let article):
                self?.articleArray = article
                self?.viewModelArray = article.compactMap({
                    ViewModelCell(title: $0.title,
                                  subtitle: $0.description ?? "No Description",
                                  imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                self?.delegate?.update()
            case .failure(let error):
                print(error)
    
            }
        }
    }
}

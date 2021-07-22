//
//  ViewModelCell.swift
//  programmaticallyTableViewMVVM
//
//  Created by Hamed Amiry on 22.07.2021.
//

import Foundation

class ViewModelCell {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title:String,
         subtitle: String,
         imageURL:URL?
    ){
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

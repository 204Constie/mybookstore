//
//  BookDetailController.swift
//  newcommerce
//
//  Created by Kat Bana on 17.06.2017.
//  Copyright © 2017 Kat Bana. All rights reserved.
//

import UIKit

class BookDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let headerId = "headerId"
    
    var book: Book? {
        didSet {
            UINavigationItem.init(title: (book?.title)!)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(BookDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! BookDetailHeader
        header.book = book
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
}


class BookDetailHeader: BaseCell {
    
    var book: Book? {
        didSet {
            print("book \(String(describing: book))")
            if let imageName = book?.image_name {
                imageView.image = UIImage(named: imageName)
            }
            authorLabel.text = book?.author
            nameLabel.text = book?.title
            
            if let price = book?.price {
                buyButton.setTitle("$\(price)", for: .normal)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["details", "reviews"])
        sc.tintColor = UIColor.darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY", for: .normal)
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
//        backgroundColor = UIColor.red
        
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(authorLabel)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(dividerLineView)
        
        
        addConstrainsWithFormat(format: "H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstrainsWithFormat(format: "V:|-14-[v0(100)]", views: imageView)
        
        addConstrainsWithFormat(format: "H:|-128-[v0]|", views: authorLabel)
        addConstrainsWithFormat(format: "V:|-14-[v0(20)]", views: authorLabel)
        addConstrainsWithFormat(format: "V:|-44-[v0(20)]", views: nameLabel)
        
        addConstrainsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentedControl)
        addConstrainsWithFormat(format: "V:[v0(34)]-8-|", views: segmentedControl)
        
        addConstrainsWithFormat(format: "H:[v0(60)]-14-|", views: buyButton)
        addConstrainsWithFormat(format: "V:[v0(34)]-56-|", views: buyButton)
        
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        addConstrainsWithFormat(format: "V:[v0(2)]|", views: dividerLineView)
    }
    
}

extension UIView {
    func addConstrainsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }
}

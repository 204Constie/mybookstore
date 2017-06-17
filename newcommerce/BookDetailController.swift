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
    private let cellId = "cellId"
    
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
        collectionView?.register(BookDetailDescription.self, forCellWithReuseIdentifier: cellId)
      
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! BookDetailHeader
        header.book = book
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookDetailDescription
        
        cell.book = book
        
        cell.textView.attributedText = descriptionAttributedText()
        
        return cell
    }
    
    private func descriptionAttributedText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "Description\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range  = NSMakeRange(0, attributedString.string.characters.count)
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        if let desc = book?.description_text {
            print("desc \(desc)")
            attributedString.append(NSMutableAttributedString(string: desc, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.darkGray]))
        }
        
        return attributedString
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
}


class BookDetailDescription: BaseCell {
    
    var book: Book? {
        didSet {
            if let desc = book?.description_text {
                print("desc \(desc)")
                textView.text = desc
            }
        }
    }
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "sample"
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        addSubview(dividerLineView)
        
        addConstrainsWithFormat(format: "H:|-8-[v0]-8-|", views: textView)
        addConstrainsWithFormat(format: "V:|-4-[v0]-4-[v1(1)]|", views: textView, dividerLineView)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        
    }
}

class Responser: NSObject {
    func action(){
        print("clickk")
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
    
//    let buyButton: UIButton = UIButton(type: .system)
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    func handleClick(_ sender: UIButton!){
        print("click")
    }
    
    override func setupViews() {
        super.setupViews()
        
        buyButton.addTarget(self, action: #selector(handleClick(_:)), for: .touchUpInside)
        
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

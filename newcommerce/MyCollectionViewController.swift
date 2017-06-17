//
//  CollectionViewController.swift
//  mcommerce
//
//  Created by Kat Bana on 21.05.2017.
//  Copyright © 2017 Kat Bana. All rights reserved.
//

import Foundation

import UIKit

class MyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let cellId = "cell"
    
    
    
    var bookCategories: [BookCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("kupa")
//        BookCategory.fetchBooks(completionHandler: {_ in (([BookCategory]) -> ()).self})
        BookCategory.fetchBooks{(bookCategories) -> () in
            print("jhsdjds", bookCategories)
            self.bookCategories = bookCategories
            self.collectionView?.reloadData()
        }
//        bookCategories = BookCategory.sampleBookCategories()
        
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    

    func showBookDetails(book: Book){
        
        let layout = UICollectionViewFlowLayout()
        let bookDetailController = BookDetailController(collectionViewLayout: layout)
        bookDetailController.book = book
        navigationController?.pushViewController(bookDetailController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        
        cell.bookCategory = bookCategories?[indexPath.item]
        cell.booksController = self
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = bookCategories?.count {
            print(count)
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
}


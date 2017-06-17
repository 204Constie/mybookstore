//
//  Models.swift
//  mcommerce
//
//  Created by Kat Bana on 21.05.2017.
//  Copyright © 2017 Kat Bana. All rights reserved.
//

import Foundation




import UIKit

class BookCategory: NSObject {
    
    var name: String?
    var books: [Book]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "str"{
            books = [Book]()
            for dict in value as! [[String: Any]]{
                let book = Book()
                book.setValuesForKeys(dict)
                books?.append(book)
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchBooks(completionHandler: @escaping ([BookCategory]) -> ()) {
        print("any")
        let urlString = "http://localhost:8080/products"
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data, respose, error) -> Void  in
            
            if error != nil {
                print("error hh")
                return
            }
                        
            do{
                
                if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    
                    var bookCategories = [BookCategory]()
                    for dict in json?["cateories"] as! [[String: Any]]{
                        
                        let bookCategory = BookCategory()
                        bookCategory.setValuesForKeys(dict)
                        bookCategories.append(bookCategory)
                    }
                    print(bookCategories)
                    DispatchQueue.main.async {
                        completionHandler(bookCategories)
                    }
                    
                    
                }
            } catch let err {
                print(err)
            }

            
            
        }).resume()
        

        
        
    }
    
    static func sampleBookCategories() -> [BookCategory] {
        let popularCategory = BookCategory()
        popularCategory.name = "popular books"
        
        var books = [Book]()
        
        let shantaramBook = Book()
        shantaramBook.title = "Shantaram"
        shantaramBook.image_name = "shantaram"
        shantaramBook.category_id = 1
        shantaramBook.price = "7.99"
//            NSNumber(value: 7.99)
        books.append(shantaramBook)
        
        popularCategory.books = books
        
        let newestCategory = BookCategory()
        newestCategory.name = "newest books"
        
        var newestBooks = [Book]()
        let cabreBook = Book()
        cabreBook.title = "Jo confesso"
        cabreBook.image_name = "joconfesso"
        cabreBook.category_id = 1
        cabreBook.price = "8.99"
//            NSNumber(value: 8.99)
        newestBooks.append(cabreBook)
        
        newestCategory.books = newestBooks
        
        return [popularCategory, newestCategory]
    }
    
}

class Book: NSObject {
    
    var product_id: NSNumber?
    var title: String?
    var category_id: NSNumber?
    var image_name: String?
    var price: String?
    var description_text: String?
    var author: String?

}

//
//  AllBooksViewController.swift
//  LibraryManagementSystem
//
//  Created by Ram Kumar T on 20/01/20.
//  Copyright © 2020 Ram Kumar T. All rights reserved.
//

import UIKit

struct BooksRead
{
    var bookName : String
    var authorName : String
    var publicationName : String

    func getDict() -> NSMutableDictionary {
      let dictionary = NSMutableDictionary()

        dictionary.setValue(bookName, forKey: "bookName")
        dictionary.setValue(authorName, forKey: "authorName")
        dictionary.setValue(publicationName, forKey: "publicationName")
        return dictionary
    }
}

struct OriginalBook
{
    var bookId : String
    var bookDetails : BooksRead
}


class AllBooksViewController : UITableViewController
{
    
    var jsonResult : NSArray = [];
    
    
    var keys : [String] = []
    
    
    func populateDataRepository()
    {
        if(ViewController.wholeDataRepository.isEmpty)
        {
            
            
        var fileManager = FileManager.default
        
        do
        {
       let directory =  try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("OriginalFile").appendingPathExtension("json")
            let sampleData = try? Data(contentsOf: directory!, options: .alwaysMapped)
            let json = try! JSONSerialization.jsonObject(with: sampleData!, options: .fragmentsAllowed) as! [String : [String : Any]]
            
            
            keys = Array(json.keys)
            
            
            for key in keys
            {
                
                ViewController.wholeDataRepository.updateValue(json[key]!, forKey: key)
            }
            
        }
        catch let error as NSError
        {
            print("Error in reading file to populateWholeDataRepository - dictionary")
        }
        
        }
        
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        //tableView.isEditing = true
        
        populateDataRepository()
        
       print("Is EMpty:: \(ViewController.wholeDataRepository.isEmpty)")
        
        print("AllBooks - wholedata : \(ViewController.wholeDataRepository)")

//
//        view.backgroundColor = .white
       tableView.register(MyAllBooksCell.self, forCellReuseIdentifier: "CellId")
        keys = Array(ViewController.wholeDataRepository.keys)
//        do
//        {
//            var fileManager = FileManager.default
//
//            var directory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//
//            directory = directory.appendingPathComponent("NewBooks").appendingPathExtension("json")
//
//            print("Directory:: \(directory)")
//
//            let file = FileHandle.init(forReadingAtPath: directory.path)
//
//            if !fileManager.fileExists(atPath: directory.path)
//                {
//                    print("Resource JSON file is missing! please check it out!")
//                }
//
//            else
//                {
//                   print("File found & yet to read!")
//
//
//
//                   let sampleData1 = try? Data(contentsOf: directory, options: .mappedRead)
//
//                    //jsonObjects from jsondata
//                     jsonResult =  try JSONSerialization.jsonObject(with: sampleData1!, options: .fragmentsAllowed) as! NSArray
//
//                    print("Sample JSON Result : \(jsonResult)")
//                    print("Sample json result count : \(jsonResult.count)")
//
//                    for result in jsonResult
//                    {
//                        print("JsonresultArrays: \(result)")
//                    }
//
//                   // print("Count: \(jsonResult.count)")
////                    print("Bookname: \(jsonResult.bookName)")
////                    print("Authorname : \(jsonResult.authorName)")
////
//                } //else
//        }     //do
//        catch let error as NSError
//        {
//            print("Error in reading contents of file! \(error)")
//        }
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return keys.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("I'm clicking cell no: \(indexPath)")
        
        
        let alertController = UIAlertController(title: "OKAY", message: "OKAY", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OKAY", style: .default, handler:
        { (action) in
            
            
           
        let bookname = alertController.textFields![0].text
        let authorname = alertController.textFields![1].text
        let publicationname = alertController.textFields![2].text
        
            
        print(bookname)
        print(authorname)
        print(publicationname)
            
            let sampleDictionary = ["BookName" : bookname,"AuthorName" : authorname,
                                    "PublicationName" : publicationname]
            ViewController.wholeDataRepository.updateValue(sampleDictionary, forKey: self.keys[indexPath.row])
            print(ViewController.wholeDataRepository)
            
            
            
            self.dismiss(animated: true,completion: {
                self.populateDataRepository()
            })
        })
         let values = ViewController.wholeDataRepository[self.keys[indexPath.row]]!
        
        alertController.addAction(alertAction)
        
       
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        
        alertController.textFields![0].placeholder = "Enter bookname"
        alertController.textFields![1].placeholder = "Enter AuthorName"
        alertController.textFields![2].placeholder = "Enter PublicationName"
  
        alertController.textFields![0].text = values["BookName"] as! String
                   alertController.textFields![1].text = values["AuthorName"] as! String
                   alertController.textFields![2].text = values["PublicationName"] as! String
                   
         self.present(alertController, animated: true)
        
         // self.navigationController?.popViewController(animated: true)
        
        
        
        
        
        
        
        
        
        
        
      
        
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! MyAllBooksCell
        
        print("Indexpath.row :: \(indexPath.row)")                
        
        
    
        
        let values = ViewController.wholeDataRepository[keys[indexPath.row]]!
        

        cell.bookIdLabel.text = "Book ID:    " + (keys[indexPath.row])
        
        cell.bookLabel.text = "Book:    " + (values["BookName"] as! String)//bb.bookDetails.bookName
        //
          
        cell.authorLabel.text = "Author:   " + (values["AuthorName"] as! String)//bb.bookDetails.authorName
          
        cell.publicationLabel.text  = "Publication: " + (values["PublicationName"] as! String)//bb.bookDetails.publicationName
          

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
            {
            
           ViewController.wholeDataRepository.removeValue(forKey: keys[indexPath.row])
                keys.remove(at: indexPath.row)
        
                let fileManager = FileManager.default
                 
            var directory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("OriginalFile").appendingPathExtension("json")
            
                do
                {
                let file = try FileHandle.init(forWritingTo: directory!)
                       
                if fileManager.fileExists(atPath: directory!.path)
                           {
                            
                            let jsonObject =  try? JSONSerialization.data(withJSONObject: ViewController.wholeDataRepository, options: .prettyPrinted)
                                           
                            let jsonString = NSString(data: jsonObject!, encoding: String.Encoding.utf8.rawValue)
                            
                            try jsonString?.write(to: directory!, atomically: true, encoding: String.Encoding.utf8.rawValue)
                           
                            }
                    
                        else
                            {
                        print("File not found")
                            }
                
                }
                catch let error as NSError
                    {
                        print("Couldn't overwrite file!")
                    }
        
            tableView.reloadData()
        }
    }
}


class MyAllBooksCell : UITableViewCell
{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style : style, reuseIdentifier :  reuseIdentifier)
       print(" super.init() called")
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let bookLabel : UILabel =
    {
        let bookLabel : UILabel = UILabel()
        bookLabel.translatesAutoresizingMaskIntoConstraints = false
        bookLabel.text = "Book Names"
        bookLabel.backgroundColor = UIColor.red
        return bookLabel
    }()
    
    let authorLabel : UILabel =
    {
        let authorLabel : UILabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.backgroundColor = UIColor.yellow
        authorLabel.text = "Author Names"
        return authorLabel
        
    }()
    
    let publicationLabel : UILabel =
    {
        let publicationLabel : UILabel = UILabel()
        publicationLabel.translatesAutoresizingMaskIntoConstraints = false
        publicationLabel.backgroundColor = UIColor.green
        publicationLabel.text = "Publication Name"
        return publicationLabel
        
    }()
    
    let bookIdLabel : UILabel =
    {
        let bookId : UILabel = UILabel()
        bookId.translatesAutoresizingMaskIntoConstraints = false
        bookId.backgroundColor = UIColor.red
        bookId.text = "Book ID"
        return bookId
    }()
    
    
    let bookDetailDisplayView :  UIView =
    {
        let bookDetailDisplayView : UIView = UIView()
        bookDetailDisplayView.translatesAutoresizingMaskIntoConstraints = false
        bookDetailDisplayView.backgroundColor = UIColor.blue
        return bookDetailDisplayView
    }()
    
    func setUpViews()
    {
        print("set Up Views")
        
        contentView.addSubview(bookDetailDisplayView)
        bookDetailDisplayView.backgroundColor = UIColor.blue
        bookDetailDisplayView.widthAnchor.constraint(equalTo : contentView.safeAreaLayoutGuide.widthAnchor).isActive = true
        bookDetailDisplayView.heightAnchor.constraint(equalTo : contentView.safeAreaLayoutGuide.heightAnchor).isActive = true
        bookDetailDisplayView.leadingAnchor.constraint(equalTo : contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bookDetailDisplayView.trailingAnchor.constraint(equalTo : contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bookDetailDisplayView.bottomAnchor.constraint(equalTo : contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        
     
        bookDetailDisplayView.addSubview(bookLabel)
        bookLabel.widthAnchor.constraint(equalTo : bookDetailDisplayView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        bookLabel.heightAnchor.constraint(equalTo: bookDetailDisplayView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        bookLabel.leadingAnchor.constraint(equalTo :  bookDetailDisplayView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        
        
        bookDetailDisplayView.addSubview(bookIdLabel)
        bookIdLabel.widthAnchor.constraint(equalTo : bookDetailDisplayView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
             bookIdLabel.heightAnchor.constraint(equalTo : bookDetailDisplayView.safeAreaLayoutGuide.heightAnchor,multiplier: 0.5).isActive = true
        bookIdLabel.leadingAnchor.constraint(equalTo : bookLabel.safeAreaLayoutGuide.trailingAnchor).isActive = true
       
        //bookIdLabel.bottomAnchor.constraint(, multiplier: <#T##CGFloat#>)
             
        
        
        
        bookDetailDisplayView.addSubview(authorLabel)
         authorLabel.bottomAnchor.constraint(equalTo : bookDetailDisplayView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        authorLabel.widthAnchor.constraint(equalTo :  bookDetailDisplayView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        authorLabel.heightAnchor.constraint(equalTo : bookDetailDisplayView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true

        authorLabel.leadingAnchor.constraint(equalTo : bookDetailDisplayView.safeAreaLayoutGuide.leadingAnchor).isActive = true


        bookDetailDisplayView.addSubview(publicationLabel)

        publicationLabel.widthAnchor.constraint(equalTo :  bookDetailDisplayView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        publicationLabel.heightAnchor.constraint(equalTo : bookDetailDisplayView.safeAreaLayoutGuide.heightAnchor, multiplier :0.5).isActive = true
        publicationLabel.leadingAnchor.constraint(equalTo : authorLabel.safeAreaLayoutGuide.trailingAnchor).isActive = true
        publicationLabel.bottomAnchor.constraint(equalTo : bookDetailDisplayView.safeAreaLayoutGuide.bottomAnchor).isActive = true

     
    }
    

    
}

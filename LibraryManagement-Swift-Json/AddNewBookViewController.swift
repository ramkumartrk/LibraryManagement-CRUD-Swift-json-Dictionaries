
//
//  AddNewBookViewController.swift
//  LibraryManagementSystem
//
//  Created by Ram Kumar T on 21/01/20.
//  Copyright © 2020 Ram Kumar T. All rights reserved.
//
import UIKit

class AddNewBookViewController : UITableViewController
{
    var cell : MyAddNewBookViewControllerCell?;
    
    var delegate : NewBookDelegate?;

    @objc func saveBookDetailsButton()
    {
        var bookName : String? = nil
        var authorName : String? = nil
        var publicationName : String? = nil
        
        /*First Cell BookName*/
        var indexPath : IndexPath = IndexPath(row: 0, section: 0)
        let cell1 =  self.tableView.cellForRow(at: indexPath) as? MyAddNewBookViewControllerCell
        bookName = cell1?.sampleTextField.text
        //print(bookName!)

        if(bookName! == "" || (bookName!.contains(";")))
        {
            let alertController = UIAlertController(title: "Nil/Semicolon error", message: "Book Name shouldn't contain ; or shouldn't be empty", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Non-empty", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion:
                {
                    cell1!.sampleTextField.text = ""
            })
        }
        
        
        /*Second Cell AuthorName*/
        indexPath = IndexPath(row : 1, section : 0)
        let cell2 = self.tableView.cellForRow(at: indexPath) as? MyAddNewBookViewControllerCell
        authorName = cell2?.sampleTextField.text
        //print(authorName!)

        if(authorName == "" || (authorName!.contains(";")))
        {
            let alertController = UIAlertController(title: "Nil/Semicolon error", message: "Author Name shouldn't contain ; or shouldn't be empty", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Non-empty", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion:
                {
                    cell2!.sampleTextField.text = ""
            })
        }
        
        /*Third Cell PublicationName*/
        indexPath = IndexPath(row : 2, section : 0)
        let cell3 = self.tableView.cellForRow(at: indexPath) as? MyAddNewBookViewControllerCell
        publicationName = cell3?.sampleTextField.text
        //print(publicationName!)
        if(publicationName == "" || (publicationName!.contains(";")))
               {
                   let alertController = UIAlertController(title: "Nil/Semicolon error", message: "Publication Name shouldn't contain ; or shouldn't be empty", preferredStyle: .alert)
                   let alertAction = UIAlertAction(title: "Non-empty", style: .default, handler: nil)
                   alertController.addAction(alertAction)
                   self.present(alertController, animated: true, completion:
                       {
                           cell3!.sampleTextField.text = ""
                   })
               }
        
        var booksWriteDict : [String : Any] = [ : ]
        booksWriteDict = ["BookName" : bookName, "AuthorName" : authorName, "PublicationName" : publicationName]
        delegate?.addNewBook(booksWriteDict)
        self.navigationController?.popViewController(animated: true)
       
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        delegate =  ViewController.init()
              
        view.backgroundColor = .red
        
        //NavigationBaritem ->  done to saveBookDetails
        let saveBookDetail = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveBookDetailsButton))
        self.navigationItem.rightBarButtonItem = saveBookDetail
        
        self.tableView.register(MyAddNewBookViewControllerCell.self, forCellReuseIdentifier: "Cell1")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! MyAddNewBookViewControllerCell?

        if(indexPath == [0,0] || indexPath == [0,1] || indexPath == [0,2])
                    {
                        cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! MyAddNewBookViewControllerCell?
                        
                    }

        if(cell == nil && (indexPath == [0,0] || indexPath == [0,1] || indexPath == [0,2]))
        {
            cell = MyAddNewBookViewControllerCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell1")

            if(indexPath == [0,0])
            {
                
                cell?.sampleTextField.placeholder = "Book Name..."
            }

            else if(indexPath == [0,1])
            {
                cell?.sampleTextField.placeholder = "Author Name..."
            }

            else if(indexPath == [0,2])
            {
                cell?.sampleTextField.placeholder = "Publication Name..."
            }
        }
      return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

class MyAddNewBookViewControllerCell : UITableViewCell
{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style : style, reuseIdentifier : reuseIdentifier)

        if(reuseIdentifier == "Cell1")
            {
           
            contentView.addSubview(sampleTextField)
            sampleTextField.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
            sampleTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            sampleTextField.heightAnchor.constraint(equalTo : contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75).isActive = true
            sampleTextField.widthAnchor.constraint(equalTo :  contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
            }
    }
    
    let sampleTextField : UITextField =
       {
          
           let sampleTextField : UITextField = UITextField()
           sampleTextField.placeholder = "sample text fild"
           sampleTextField.translatesAutoresizingMaskIntoConstraints = false
           sampleTextField.textColor = UIColor.black
           sampleTextField.font = UIFont.systemFont(ofSize: 16)
           return sampleTextField
       }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


















//  ViewController.swift
//  LibraryManagement-Swift-Json
//  Created by Ram Kumar T on 28/01/20.
//  Copyright © 2020 Ram Kumar T. All rights reserved.
import UIKit

protocol NewBookDelegate : class {
    func addNewBook(_ book: Dictionary<String,Any>)
}

class ViewController: UITableViewController, NewBookDelegate
{
    static var wholeDataRepository : [String : [String : Any]] = [ : ]
  
    static var  dataId : Int = 1;
     
    var sampleDictss  =  [Dictionary<String,Any>]()
    
    func sendingDictionaryBack() -> Dictionary<String, Dictionary<String,Any>>{
        print("sendingDictionaryBack as response : \(ViewController.wholeDataRepository)")
        return ViewController.wholeDataRepository
    }
    
    func addNewBook(_ book: Dictionary<String,Any>){
      
        print("after called in @addnewBook Whole data repository from source b4 writing new : \(book)")
        
        //print("Count: \(ViewController.wholeDataRepository.count)")
              
        for repo in ViewController.wholeDataRepository
            {
                print("Repository data: \(repo)")
            }
        
       do
        {
            let fileManager : FileManager = FileManager.default
            
            let directory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("OriginalFile").appendingPathExtension("json")
                    
              print(directory)
            if(!fileManager.fileExists(atPath: directory.path))
            {
                print("Creating new file")
                let didCreate = fileManager.createFile(atPath: directory.path, contents : nil, attributes: nil)
           
                ViewController.wholeDataRepository.updateValue(book, forKey: String(ViewController.dataId))
                ViewController.dataId += 1
                
                print("WholeData Repository from source after writing new: \(ViewController.wholeDataRepository)")
                print("Count: \(ViewController.wholeDataRepository.count)")
                
                //get json object from foundataion object
                let jsonObject =  try JSONSerialization.data(withJSONObject: ViewController.wholeDataRepository, options: .prettyPrinted)
                
                let jsonString = NSString(data: jsonObject, encoding: String.Encoding.utf8.rawValue)
                
                try jsonString?.write(to: directory, atomically: true, encoding: String.Encoding.utf8.rawValue)
            }
            
            else
              {
                
                print("Already we've file")
                    
                 let sampleData = try? Data(contentsOf: directory, options: .alwaysMapped)
                 
                    let json = try? (JSONSerialization.jsonObject(with: sampleData!, options: .fragmentsAllowed) as! [String : [String : Any]])
                
                    let keys = Array(json!.keys)
                 
                    let sort = keys.sorted()
                
                    for key in keys
                        {
                            ViewController.wholeDataRepository.updateValue(json![key]!, forKey: key)
                        }
                
                print("Sorted array of keys: \(sort)")
                
                print("Array of keyysssss: \(Array(json!.keys))")
                
                print("Int last + 1 \(ViewController.dataId)")
                
                print("Data read from file: \(json)")
                    
                print("Json count:\(json!.count)")

                
                ViewController.wholeDataRepository.updateValue(book, forKey: String(ViewController.dataId))
                
                print("WholeData Repository from source after writing new: \(ViewController.wholeDataRepository)")
                
                ViewController.dataId += 1
                
                print("Count: \(ViewController.wholeDataRepository.count)")
                             
                for repo in ViewController.wholeDataRepository
                    {
                        print("Repository data: \(repo)")
                    }
              }
            //get json object from foundataion object
            let jsonObject =  try JSONSerialization.data(withJSONObject: ViewController.wholeDataRepository, options: .prettyPrinted)
        
            let jsonString = NSString(data: jsonObject, encoding: String.Encoding.utf8.rawValue)
           
           
            print("Directory path: \(directory)")
            
                
            //  jsonString = "[" + (jsonString as String) + "]" as NSString
            try jsonString?.write(to: directory, atomically: true, encoding: String.Encoding.utf8.rawValue)
            
        }
        catch let error as NSError
        {
            print("Coudlnt save Whole data dictionary repository!")
        }

        
        print("Whole data repository from source after updating new book object in file")
        
        print("Count: \(ViewController.wholeDataRepository.count)")
               
               for repo in ViewController.wholeDataRepository
                                               {
                                                   print("Repository data: \(repo)")
                                               }
    }
    

    
    let menus = ["All Books", "Books for Lent", "Favourites"]
    
    @objc func addNewBookButton()
    {
        
        
        self.navigationController?.pushViewController(AddNewBookViewController.init(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewBookButton))
        
        self.navigationItem.rightBarButtonItem  = add
        
        tableView.register(MenuCustomCell.self, forCellReuseIdentifier: "CellId")

    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? MenuCustomCell
        
        cell!.textLabel!.text = menus[indexPath.row]
        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
               if(indexPath == [0,0])
               {
                   self.navigationController?.pushViewController(AllBooksViewController.init(), animated: true)
               }
    }
    
    
    

}

class MenuCustomCell : UITableViewCell
{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style : style, reuseIdentifier : reuseIdentifier)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}


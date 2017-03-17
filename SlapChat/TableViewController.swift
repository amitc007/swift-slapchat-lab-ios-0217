//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    let store = DataStore.sharedInstance
    
    
    @IBAction func sortData(_ sender: UIButton) {
        store.messages.sort { (x, y) -> Bool in
           return (x.createdAt?.compare(y.createdAt as! Date) == ComparisonResult.orderedDescending )
        }
        
        print("\n\n********Sorted data:\n\(store.messages)")
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        

        //store.fetchData()    //get data from core data
        
        /*if store.messages.count == 0 {
           generateTestData()
           print("count==0. messages:\(store.messages))")
        }*/
        //print("\n****\nOuside if block. messages:\(store.messages))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("In viewWillAppear")
        store.fetchData()
        
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        cell.textLabel?.text = store.messages[indexPath.row].content
        return cell
    }
    
    func generateTestData() {
        
        let context = store.persistentContainer.viewContext  //get context
        
        let message1 = Message(context: context)     //create entity/obj
        message1.content = "One"
        message1.createdAt = Date() as NSDate?
        store.messages.append(message1)
        
        let message2 = Message(context: context)
        message2.content = "Two"
        message2.createdAt = NSDate(timeIntervalSinceNow: 120)
        DataStore.sharedInstance.messages.append(message2)
        
        
        let message3 = Message(context: context)
        message3.content = "Three"
        message3.createdAt = NSDate(timeIntervalSinceNow: 180)
        DataStore.sharedInstance.messages.append(message2)
        
        //print("msg1:\(message1.createdAt) msg2:\(message2.createdAt) msg3:\(message3.createdAt)")
        
        DataStore.sharedInstance.saveContext()    //save messages in core data
        
        DataStore.sharedInstance.fetchData()    //get messages from core data
    }
    

    
}

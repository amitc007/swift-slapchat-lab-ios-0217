//
//  AddMessageViewController.swift
//  SlapChat
//
//  Created by ac on 3/16/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class AddMessageViewController: UIViewController {

    let store = DataStore.sharedInstance
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        let context = store.persistentContainer.viewContext
        let messageObj = Message(context: context)
        messageObj.content = textField.text
        messageObj.createdAt = NSDate()
        
        store.saveContext()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

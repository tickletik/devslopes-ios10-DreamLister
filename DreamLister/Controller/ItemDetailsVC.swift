//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by ronny abraham on 10/31/17.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var PriceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!

    // array to hold stores extracted from datacore
    var stores = [Store]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // get rid of the ugly color on the back nav button
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style:
                UIBarButtonItemStyle.plain, target:nil, action: nil)
        }

        // set this class as the storePickers' delegate and datasource
        storePicker.delegate = self
        storePicker.dataSource = self

        // generateTestData()
        getStores()
    }
    
    func generateTestData() {
        createTestStore(name: "Best Buy")
        createTestStore(name: "Target")
        createTestStore(name: "iDigital")
        createTestStore(name: "Bug")
        createTestStore(name: "Costco")
        
        /*
         all the store test items were created using a global context constant
         this context was updated each time a store was created.  So when we call
         ad.saveContext, there is no need to pass the context over directly
         
         (not a good practice btw)
         */
        ad.saveContext()
    }

    func createTestStore(name:String) {
        // "context" is a global constant found in AppDelegate.swift
        // "ad" is a global constant found in AppDelegate.swift
        let store = Store(context: context)
        store.name = name
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update when selected
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // number of columns
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }

    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            // handle error
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
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

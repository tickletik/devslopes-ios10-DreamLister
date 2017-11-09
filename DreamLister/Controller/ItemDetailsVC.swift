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
    @IBOutlet weak var priceField: CustomTextField!
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
        // insert an item into the context
        let item = Item(context: context)
        
        // assign text fields to Item attributes
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            // convert the text value from pricefield to a double
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            item.details = details
        }
        
        /*
            we need to pick out the Store value in the array "stores", this
            value can be referred to by the current SelectedRow in storePicker
 
            however to get the selected row, we need to tell storePicker which component
            we are looking at (storePicker can have multiple components).
 
            In this case, "component" is teh equivalent of columns, and since we specified
            that storePIcker has only one column (which defaults to index 0), we ask
            storePicker to give us the selected row at that component.
        */
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        // now save the context with the new Item information
        ad.saveContext()
        
        // take us back to the main view
        navigationController?.popViewController(animated: true)
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

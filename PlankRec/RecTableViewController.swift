//
//  RecTableViewController.swift
//  PlankRec
//
//  Created by Apple on 4/16/23.
//

import UIKit
import CoreData

class RecTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request :NSFetchRequest<Record> = Record.fetchRequest()
    var recArray = [Record]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       recArray = try! context.fetch(request)
        
           }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = String(recArray[indexPath.row].rec)
        //cell.textLabel?.text =  String(recArray[indexPath.row].date!.formatted())
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

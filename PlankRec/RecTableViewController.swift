//
//  RecTableViewController.swift
//  PlankRec
//
//  Created by Sab  on 4/16/23.
//

import UIKit
import CoreData
import SwipeCellKit

class RecTableViewController: UITableViewController, UISearchBarDelegate ,SwipeTableViewCellDelegate {
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recArray = [Record]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.systemMint
        title = "Records"
      loadRecs()
      tableView.rowHeight = 80
           }

    func loadRecs(from request:NSFetchRequest<Record> = Record.fetchRequest()) {
        do { recArray = try context.fetch(request)
            tableView.reloadData()
            
        }catch{}
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = "\(recArray[indexPath.row].rec) s at \(recArray[indexPath.row].date!.formatted())"
        cell.delegate = self
        cell.backgroundColor = UIColor.systemMint
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request :NSFetchRequest<Record> = Record.fetchRequest()
        request.predicate = NSPredicate(format: "rec == %@", searchBar.text! )
        request.sortDescriptors = [NSSortDescriptor(key: "rec", ascending: true)]
        loadRecs(from: request)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadRecs()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
            // handle action by updating model with deletion
            context.delete(recArray[indexPath.row])
            recArray.remove(at: indexPath.row)
            try! context.save()
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "Delete")

        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}

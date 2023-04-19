//
//  PlankViewController.swift
//  PlankRec
//
//  Created by Sab on 4/16/23.
//

import UIKit
import CoreData
import CoreLocation

class PlankViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var plankImageView: UIImageView!
    
   
    @IBOutlet weak var timerLabel: UILabel!
    
    var counter : Int = 0
    var timer = Timer()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let currentDateTime = Date()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateMovement()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] timer in
            counter+=1
            timerLabel.text = String(counter)
        })
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        timer.invalidate()
        
        let alert = UIAlertController(title: "" , message: PlankTime().generateMsg(counter) , preferredStyle: .alert)
        let action = UIAlertAction(title: "Save", style: .default) { [self] action in
            let newRec = Record(context: context)
            newRec.rec = Int16(counter)
            newRec.date = currentDateTime
            
            do{ try context.save() }catch{print(error)}
            performSegue(withIdentifier: "goToRec", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Discard", style: .default)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func animateMovement(){
       
        plankImageView.layer.borderWidth = 2
        plankImageView.layer.cornerRadius = plankImageView.frame.size.width/2
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        plankImageView.layer.add(animation, forKey: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    
}

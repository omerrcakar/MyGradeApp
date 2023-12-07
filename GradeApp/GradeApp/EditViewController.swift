//
//  EditViewController.swift
//  GradeApp
//
//  Created by ÖMER  on 6.12.2023.
//

import UIKit

class EditViewController: UIViewController {

    
    @IBOutlet weak var dersTextField: UITextField!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var finalTextField: UITextField!
    
    var not:Notlar?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let n = not{
            dersTextField.text = n.ders_adi
            vizeTextField.text = String(n.vize!)
            finalTextField.text = String(n.final!)
        }
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        // öncelikle alandaki verileri almamız lazım
        
        if let n = not , let ad = dersTextField.text , let vize = vizeTextField.text , let final = finalTextField.text{
            if let v1 = Int(vize), let f1 = Int(final){
                Notlardao().notGuncelle(not_id: n.not_id!, ders_adi: ad, vize: v1, final: f1)
            }
        }
    }
    
    @IBAction func trashButtonClicked(_ sender: Any) {
        if let n = not{
            Notlardao().notSil(not_id: n.not_id!)
        }
    }
    

}

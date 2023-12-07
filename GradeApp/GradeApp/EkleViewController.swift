//
//  EkleViewController.swift
//  GradeApp
//
//  Created by ÖMER  on 6.12.2023.
//

import UIKit

class EkleViewController: UIViewController {

    @IBOutlet weak var dersTextField: UITextField!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var finalTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ekleButton(_ sender: Any) {
        
        if dersTextField.text == "" || vizeTextField.text == "" || finalTextField.text == ""{
            alertMessage(message: "Boş alan bırakma!")
        }else{
            if let ad = dersTextField.text , let vize = vizeTextField.text , let final = finalTextField.text{
                if let v1 = Int(vize), let f1 = Int(final){
                    // Eğer vize ve final sayısal değerlere dönüştürülebiliyorsa işlemi gerçekleştir
                    Notlardao().notEkle(ders_adi: ad, vize: v1, final: f1)
                }else{
                    // Harf varsa hata mesajı göster
                    alertMessage(message: "Vize ve final notları sayısal olmalıdır.")
                }
            }
        }
        
    }
    
    
    func alertMessage(message:String){
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel){ action in
            //print("Cancel button tapped")
        }
        
        let okButton = UIAlertAction(title: "Ok", style: .destructive){ action in
            //print("Ok button tapped")
        }
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        
        self.present(alert, animated: true)
    }
    
   

}

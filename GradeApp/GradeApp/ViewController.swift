//
//  ViewController.swift
//  GradeApp
//
//  Created by ÖMER  on 6.12.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewNotlar: UITableView!
    
    
    var notlarListe = [Notlar]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        veritabaniKopyala()
        
        tableViewNotlar.dataSource = self
        tableViewNotlar.delegate = self
        
        searchBar.delegate = self
        
       
        
        
    }
    
    
    @IBAction func descOrder(_ sender: Any) {
        
        notlarListe = Notlardao().siralamaliAlma()
        
        tableViewNotlar.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        notlarListe = Notlardao().tumNotlarAl()
        
        var toplam = 0
        
        for n in notlarListe{
            toplam = toplam + (n.vize! + n.final!)/2
        }
        
        
        if notlarListe.count != 0 {
            navigationItem.prompt = "Ortalama : \(toplam / notlarListe.count)"
        }else{
            navigationItem.prompt = "Ortalama : YOK"
        }
        
        tableViewNotlar.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        
        if segue.identifier == "notDetay"{
            let gidilecekVC = segue.destination as! EditViewController
            gidilecekVC.not = notlarListe[indeks!]
        }
        
        
        
    }
    
    func veritabaniKopyala(){
        
        // öncelikle veritabanimiza erişmemiz lazım , ismi ve uzantısı ile
        let bundleYolu = Bundle.main.path(forResource: "notlar", ofType: ".sqlite")
        
        // şimdi telefon içinde kopyalayacağım dosyayı belirtcez
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        // kopyalama için file manager sınıfından nesneye ihtiyacımız var
        let fileManager = FileManager.default
        
        
        // nereye kopyalayacağımızı belirticez ve o hedef yola notlar.sqlite uzantılı dosya oluştur dedik
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("notlar.sqlite")
        
        
        // kopyalama alanı
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabani zaten var kopyalamaya gerek yok")
        }else{
            
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{
                print(error)
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notlarListe.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let not = notlarListe[indexPath.row]
        
        let cell = tableViewNotlar.dequeueReusableCell(withIdentifier: "notlarCell", for: indexPath) as! NotlarTableViewCell
        cell.dersAdi.text = not.ders_adi
        cell.vizeNotu.text = "\(not.vize!)"
        cell.finalNotu.text = "\(not.final!)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "notDetay", sender: indexPath.row)
        
    }
    
    
}

extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == ""{
            
            notlarListe = Notlardao().tumNotlarAl()
            tableViewNotlar.reloadData()
            
        }else{
            notlarListe = Notlardao().aramaYap(ders_adi: searchText)
            
            // notlar listesi table view güncellicek yeni kelimeler geldikçe
            tableViewNotlar.reloadData()
        }
        
        
    }
    
}

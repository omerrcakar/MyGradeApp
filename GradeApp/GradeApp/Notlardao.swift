//
//  Notlardao.swift
//  GradeApp
//
//  Created by ÖMER  on 6.12.2023.
//

import Foundation


class Notlardao{
    
    // database i temsil eden db oluşturcaz ve bununla işlemler yapıcaz
    
    let db:FMDatabase?
    
    init() { // bu kısım Notlardao dan nesne oluşunca çalışcak yer
        // kopyaladığımız yerden veritabnını bulucaz
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("notlar.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
        // db ile veritabanina erişmiş olucaz  , bu sınıftan bir nesne oluşunca init çalışcak
        // ilgili veritabanina bağlanıcak ve db nesnesi ile veritabanı üzerinde işlemler yapmam için yetki vericek
    }
    
    
    func tumNotlarAl() -> [Notlar]{
        var liste = [Notlar]()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM notlar", values: nil)
            // notlar satır satır bekliyor
            
            while rs.next(){
                let not = Notlar(not_id: Int(rs.string(forColumn: "not_id"))!, ders_adi: rs.string(forColumn: "ders_adi"), vize: Int(rs.string(forColumn: "vize"))!, final: Int(rs.string(forColumn: "final"))!)
                // satır satır kayıt
                liste.append(not)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
    
        db?.close()
        
        return liste
        
        
    }
    
    func siralamaliAlma() -> [Notlar]{
        
        var liste = [Notlar]()
        
        db?.open()
        
        do{
            // sorgu için executequery (veri çekme)
            let rs = try db!.executeQuery("SELECT * FROM notlar ORDER BY ders_adi DESC", values: nil)
            
            // tek tek( satır satır alma)  notları aldığımız kısım , veritabanındaki her bir alandan verileri alcaz
            while rs.next(){
                let not = Notlar(not_id: Int(rs.string(forColumn: "not_id"))!
                                 , ders_adi: rs.string(forColumn: "ders_adi")
                                 , vize: Int(rs.string(forColumn: "vize"))!
                                 , final: Int(rs.string(forColumn: "final"))!)
                
                liste.append(not)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        
        db?.close()
        
        return liste
        
    }
    
    
    
    func notEkle(ders_adi:String, vize:Int, final:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO notlar (ders_adi, vize, final) VALUES (?,?,?)", values: [ders_adi,vize,final])
        }catch{
            print(error.localizedDescription)
        }
        
    
        db?.close()
    }
    
    func notGuncelle(not_id:Int, ders_adi:String, vize:Int, final:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE notlar SET ders_adi = ? , vize = ?, final = ? WHERE not_id = ?", values: [ders_adi,vize,final,not_id])
        }catch{
            print(error.localizedDescription)
        }
        
    
        db?.close()
    }
    
    
    func notSil(not_id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM notlar WHERE not_id = ?", values: [not_id])
        }catch{
            print(error.localizedDescription)
        }
        
    
        db?.close()
    }
    
    func aramaYap(ders_adi:String) -> [Notlar]{
        var liste = [Notlar]()
        
        db?.open()
        
        // ders_adi kısmında arama yapılacak girilen ders_adi kısmına göre like lı arama yapılıyor
        // like kısmı : benziyor mu , arama yapılan şeyin içine var mı ( ders_adi , tek tırnaklı olan yere ne yazarsak o veriyi getirir. Mesela a yazdık a ile başlayanları getirir
        do{
            let rs = try db!.executeQuery("SELECT * FROM notlar WHERE ders_adi like '%\(ders_adi)%'", values: nil)
            
            while rs.next(){
                let not = Notlar(not_id: Int(rs.string(forColumn: "not_id"))!, ders_adi: rs.string(forColumn: "ders_adi")
                                       , vize: Int(rs.string(forColumn: "vize"))!
                                       , final: Int(rs.string(forColumn: "final"))!)
                
                liste.append(not)
    
            }

        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
    
    
    
}

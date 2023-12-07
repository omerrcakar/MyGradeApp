//
//  Notlar.swift
//  GradeApp
//
//  Created by ÖMER  on 6.12.2023.
//

import Foundation


class Notlar{
    var not_id:Int?
    var ders_adi:String?
    var vize:Int?
    var final:Int?
    
    init(not_id: Int, ders_adi: String, vize: Int, final: Int) {
        self.not_id = not_id
        self.ders_adi = ders_adi
        self.vize = vize
        self.final = final
    }
    
    init(){
        
    }
    
}

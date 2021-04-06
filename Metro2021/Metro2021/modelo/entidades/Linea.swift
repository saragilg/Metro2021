//
//  Linea.swift
//  Metro2021
//
//  Created by Sara Gil González on 21/2/21.
//

import UIKit

class Linea: NSObject {
    
    var id:Int32 = Int32()
    var nombre: String = String()
    var color: String = String()
    var inicioFin: String = String()

    func toString() -> String {
        return "id:\(id), nombre:\(nombre), color: \(color), inifin: \(inicioFin)"
    }
}

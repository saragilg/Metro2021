//
//  DaoManager.swift
//  MetroSwift4
//
//  Created by Paco Pulido on 25/1/18.
//  Copyright © 2018 Paco Pulido. All rights reserved.
//

import UIKit
import SQLite3

let sharedInstance = DaoManager()

class DaoManager: NSObject {

    var database: OpaquePointer? = nil
    
    class func getInstance() -> DaoManager {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("metro.bd.sqlite")
        
        if sqlite3_open(fileURL.path, &sharedInstance.database) != SQLITE_OK {
            print("error opening database")
        }

        return sharedInstance
    }
    
    func getLineas() -> [Linea] {
        
        var stmt:OpaquePointer?
        var stmtinifin:OpaquePointer?
        
        var queryString = "select id, n, c from l"
        if sqlite3_prepare(database, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(database)!)
            print("error preparing insert: \(errmsg)")
        }
        var lineas : [Linea] = [Linea]()
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let linea : Linea = Linea()
            linea.id = sqlite3_column_int(stmt, 0)
            linea.nombre = String(cString: sqlite3_column_text(stmt, 1))
            linea.color = String(cString: sqlite3_column_text(stmt, 2))
            queryString = "select inicio, fin from (select nb inicio from e where ne=(SELECT min(ne) FROM e where l1=\(linea.id))),(select nb fin from e where ne=(SELECT max(ne) FROM e where l1=\(linea.id)))"
            if sqlite3_prepare(database, queryString, -1, &stmtinifin, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(database)!)
                print("error preparing insert: \(errmsg)")
            }
            if(sqlite3_step(stmtinifin) == SQLITE_ROW){
                let inicio = String(cString: sqlite3_column_text(stmtinifin, 0))
                let fin = String(cString: sqlite3_column_text(stmtinifin, 1))
                linea.inicioFin = "\(inicio) - \(fin)"
            }
            lineas.append(linea)
        }
        return lineas
    }
    
    func getEstaciones(with linea:Int32) -> [Estacion] {
        var stmt:OpaquePointer?
        var stmte:OpaquePointer?
        
        var queryString = "select ne, nb from e where l1=\(linea)"
        if sqlite3_prepare(database, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(database)!)
            print("error preparing insert: \(errmsg)")
        }
        var estaciones : [Estacion] = [Estacion]()
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let estacion : Estacion = Estacion()
            estacion.id = sqlite3_column_int(stmt, 0)
            estacion.nombre = String(cString: sqlite3_column_text(stmt, 1))
            queryString = "select l1 from e where nb='\(estacion.nombre)' and l1!=\(linea)"
            if sqlite3_prepare(database, queryString, -1, &stmte, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(database)!)
                print("error preparing insert: \(errmsg)")
            }
            var correspondencias = [Int32]()
            while(sqlite3_step(stmte) == SQLITE_ROW){
                let cor = sqlite3_column_int(stmte, 0)
                correspondencias.append(cor)
            }
        
            estacion.correspondencias=correspondencias
            estaciones.append(estacion)
        }
        
        return estaciones
    }
}

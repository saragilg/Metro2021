//
//  TVCLineas.swift
//  Metro2021
//
//  Created by Sara Gil González on 21/2/21.
//

import UIKit

class TVCLineas: UITableViewController {

    var lineas:[Linea]=[Linea]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineas = DaoManager.getInstance().getLineas();

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lineas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowLinea", for: indexPath) as! CeldaLinea
        let linea = lineas[indexPath.row]
        cell.ivNLinea.image = UIImage(named: "icono_linea_\(linea.id)")
        cell.lblLinea.text = linea.nombre
        cell.lblIniFin.text = linea.inicioFin
        cell.backgroundColor = hextoUIColor(linea.color)
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowEstacion" {
            // Accedemos al objeto donde nos han pulsado
            let indexPath = self.tableView.indexPathForSelectedRow!
            let linea = lineas[indexPath.row]
            // accedemos al controller detalle
            let controllerEstaciones = segue.destination as! VCEstaciones
            // Le anotamos desde aquí la línea en una variable que allí preparamos
            controllerEstaciones.linea = linea
        }
    }
    // Funcion que convierte color en Hex a UIColor.
    func hextoUIColor (_ hex:String) -> UIColor {
        var cString:String = hex
        
        if (cString.hasPrefix("#")) {
            cString = ((cString as NSString).substring(from: 3) as NSString).substring(to: 6)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}

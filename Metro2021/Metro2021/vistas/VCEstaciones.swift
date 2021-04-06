//
//  VCEstaciones.swift
//  Metro2021
//
//  Created by Sara Gil González on 21/2/21.
//

import UIKit

class VCEstaciones: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var linea = Linea()
    var estaciones:[Estacion]=[Estacion]()
    
    @IBOutlet weak var ivLinea: UIImageView!
    @IBOutlet weak var lblNlinea: UILabel!
    @IBOutlet weak var lblIniFin: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ivLinea.image = UIImage(named: "icono_linea_\(linea.id)")
        lblNlinea.text = linea.nombre
        lblIniFin.text = linea.inicioFin
        
        getEstaciones()
    }
    
    func getEstaciones(){
        estaciones = DaoManager.getInstance().getEstaciones(with: linea.id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return estaciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "RowEstacion", for: indexPath) as! CeldaEstacion
        
        let estacion = estaciones[indexPath.row]
        
        celda.lblEstacion.text = estacion.nombre
        
        for id in estacion.correspondencias {
            var i = 0
            let imageView = UIImageView(frame: CGRect(x: 200+(40*i), y: 0, width: 40, height: 40))
            let image = UIImage(named: "icono_linea_\(id)")
            imageView.image = image
            imageView.tag = 1
            celda.contentView.addSubview(imageView)
            i+=1
        }

        return celda
    }

}

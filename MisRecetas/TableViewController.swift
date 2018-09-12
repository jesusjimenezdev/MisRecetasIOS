import UIKit

class TableViewController: UITableViewController {

    var listaRecetas: [Receta] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        var receta = Receta(name: "Tortilla", image: UIImage(named: "tortilla")!, time: 60, ingredients: ["Patatas", "cebolla", "huevos"], steps: ["Pochamos las patatas y hechamos los huevos"])
        listaRecetas.append(receta)
        
        receta = Receta(name: "Hamburguesa", image: UIImage(named: "hamburguesa")!, time: 20, ingredients: ["Pan", "cebolla", "carne"], steps: ["Juntamos todo"])
        listaRecetas.append(receta)
        
        receta = Receta(name: "Pizza", image: UIImage(named: "pizza")!, time: 60, ingredients: ["Pan", "Queso", "Tomate"], steps: ["Juntamos todo"])
        listaRecetas.append(receta)
        
        receta = Receta(name: "Macarrones", image: UIImage(named: "macarrones")!, time: 60, ingredients: ["Macarrones", "cebolla", "Tomate frito"], steps: ["Juntamos todo"])
        listaRecetas.append(receta)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaRecetas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let receta = self.listaRecetas[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nombreLabel.text = receta.name
        cell.imagenReceta.image = receta.image
        cell.tiempoLabel.text = "\(receta.time!) min"
        cell.ingredientesLabel.text = "Ingredientes: \(self.listaRecetas.count)"
        cell.imagenReceta.layer.cornerRadius = 42
        
        if receta.favorita {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.listaRecetas.remove(at: indexPath.row)
        }
        
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }*/
    
    // Versiones anteriores a IOS 11
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let compartirAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            let compartirTextoDefecto = "Me encanta esta receta! \(self.listaRecetas[indexPath.row].name!)"
            let activityController = UIActivityViewController(activityItems: [compartirTextoDefecto, self.listaRecetas[indexPath.row].image], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
        
        compartirAction.backgroundColor = UIColor(displayP3Red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        let eliminarAction = UITableViewRowAction(style: .default, title: "Borrar") { (action, indexPath) in
            self.listaRecetas.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        eliminarAction.backgroundColor = UIColor(displayP3Red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        return [compartirAction, eliminarAction]
    }
    
    // Versiones superiores a IOS 11
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionShare =  UIContextualAction(style: .normal, title: nil, handler: { (action,view,completionHandler ) in
            let compartirTextoDefecto = "Me encanta esta receta! \(self.listaRecetas[indexPath.row].name!)"
            let activityController = UIActivityViewController(activityItems: [compartirTextoDefecto, self.listaRecetas[indexPath.row].image], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        })
        actionShare.image = UIImage(named: "share.png")
        actionShare.backgroundColor = .blue
        
        let actionDelete =  UIContextualAction(style: .normal, title: nil, handler: { (action,view,completionHandler ) in
            self.listaRecetas.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        })
        actionDelete.image = UIImage(named: "delete.png")
        actionDelete.backgroundColor = .red
        
        
        
        let configuration = UISwipeActionsConfiguration(actions: [actionShare, actionDelete])
        
        return configuration
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let receta = self.listaRecetas[indexPath.row]
        let alertController = UIAlertController(title: receta.name, message: "Valora este plato", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        var recetaFavoritaTitulo = "Favorita"
        var recetaFavoritaStile: UIAlertAction.Style = .default
        if receta.favorita {
            recetaFavoritaTitulo = "No favorita"
            recetaFavoritaStile = UIAlertAction.Style.destructive
        }
        
        let favoritoAction = UIAlertAction(title: recetaFavoritaTitulo, style: recetaFavoritaStile) { (accion) in
            let receta = self.listaRecetas[indexPath.row]
            receta.favorita = !receta.favorita
            self.tableView.reloadData()
        }
        alertController.addAction(favoritoAction)
        self.present(alertController, animated: true, completion: nil)*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarDetalleReceta" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let recetaSeleccionada = self.listaRecetas[indexPath.row]
                let destinationVC = segue.destination as! DetalleUIViewController
                destinationVC.receta = recetaSeleccionada
            }
        }
    }
    
}

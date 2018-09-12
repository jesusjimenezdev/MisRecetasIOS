import UIKit

class DetalleUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recetaImagenDetalle: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var valoracionButton: UIButton!
    
    var receta: Receta!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = receta.name
        self.recetaImagenDetalle.image = self.receta.image
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return self.receta.ingredients.count
        case 2:
            return self.receta.steps.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detalleCelda", for: indexPath) as! RecetaDetalleTableViewCell
        cell.backgroundColor = UIColor.clear
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    cell.keyLabel.text = "Nombre:"
                    cell.valueLabel.text = self.receta.name
                case 1:
                    cell.keyLabel.text = "Tiempo:"
                    cell.valueLabel.text = "\(self.receta.time!) min"
                    /*case 2:
                     cell.keyLabel.text = "Favorita: "
                     if self.recipe.isFavourite {
                     cell.valueLabel.text = "Si"
                     } else {
                     cell.valueLabel.text = "No"
                     }*/
                default:
                    break
                }
            case 1:
                if indexPath.row == 0 {
                    cell.keyLabel.text = "Ingredientes:"
                } else {
                    cell.keyLabel.text = ""
                }
                cell.valueLabel.text = self.receta.ingredients[indexPath.row]
            case 2:
                if indexPath.row == 0 {
                    cell.keyLabel.text = "Pasos:"
                } else {
                    cell.keyLabel.text = ""
                }
                cell.valueLabel.text = self.receta.steps[indexPath.row]
            default:
                break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 1:
            title = "Ingredientes"
        case 2:
            title = "Pasos"
        default:
            break
        }
        return title
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        if let valoracionVC = segue.source as? ValoracionViewController {
            if let valoracion = valoracionVC.ratingSelected {
                self.valoracionButton.setImage(UIImage(named: valoracion), for: .normal)            }
        }
    }
}

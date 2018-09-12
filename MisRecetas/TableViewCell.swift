import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagenReceta: UIImageView!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var tiempoLabel: UILabel!
    @IBOutlet weak var ingredientesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

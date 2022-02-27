//
//  TaskTableViewCell.swift
//  ToDo
//
//  Created by Chellaprabu V on 26/02/22.
//

import UIKit

protocol TaskTableViewCellDelegate{
    func didClickCheckBox(cell: UITableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!
    @IBOutlet weak var check: UIButton!
    
    var delegate: TaskTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tabLabel.frame.size = tabLabel.intrinsicContentSize
        tabLabel.layer.cornerRadius = 5
        tabLabel.layer.masksToBounds = true
        borderView.layer.borderColor = UIColor.lightGray.cgColor
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = 30
        borderView.clipsToBounds = true
    }

    @IBAction func checkAction(_ sender: Any) {
        delegate?.didClickCheckBox(cell: self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

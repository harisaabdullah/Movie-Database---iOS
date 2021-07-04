//
//  PopularMovieTableViewCell.swift
//  Job Interview Project
//
//  Created by Haris Abdullah on 6/30/21.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var popularMovieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

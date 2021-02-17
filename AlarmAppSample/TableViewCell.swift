//
//  TableViewCell.swift
//  AlarmAppSample
//
//  Created by Kentaro Abe on 2021/02/18.
//

import UIKit
import RealmSwift

class TableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    
    var job: AlarmJob!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func display(){
        guard let job = job else{
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 HH:mm"
        
        self.timeLabel.text = formatter.string(from: job.time)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

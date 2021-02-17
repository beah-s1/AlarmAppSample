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
    @IBOutlet weak var availableSwitch: UISwitch!
    
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
        formatter.dateFormat = "HH:mm"
        
        self.timeLabel.text = formatter.string(from: job.time)
        self.availableSwitch.isOn = job.isOn
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

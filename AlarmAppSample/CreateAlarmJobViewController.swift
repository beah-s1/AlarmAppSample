//
//  CreateAlarmJobViewController.swift
//  AlarmAppSample
//
//  Created by Kentaro Abe on 2021/02/18.
//

import UIKit
import RealmSwift

class CreateAlarmJobViewController: UIViewController{
    let database = try! Realm()
    @IBOutlet weak var awakeTimePicker: UIDatePicker!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func addJob(_ sender: Any) {
        // 新しくアラームのジョブを作る
        let job = AlarmJob()
        job.id = database.objects(AlarmJob.self).count
        job.time = awakeTimePicker.date
        
        try! database.write{
            database.add(job)
        }
        
        // 登録が完了したら元の画面に戻る
        // 戻る直前に、元の画面のViewControllerのTableViewを再読み込みする
        if let presentingViewController = self.presentingViewController as? ViewController{
            presentingViewController.alarmTableView.reloadData()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

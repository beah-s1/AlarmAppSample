//
//  CreateAlarmJobViewController.swift
//  AlarmAppSample
//
//  Created by Kentaro Abe on 2021/02/18.
//

import UIKit
import RealmSwift
import UserNotifications

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
        if let newestJob = database.objects(AlarmJob.self).last {
            job.id = newestJob.id + 1
        }else{
            job.id = 0
        }
        
        job.time = awakeTimePicker.date
        
        try! database.write{
            database.add(job)
        }
        
        // ローカル通知を予約する
        let content = UNMutableNotificationContent()
        content.title = "目覚まし" // 通知に表示されます
        content.body = "おはよう！朝だよ！"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: job.time.timeIntervalSinceNow, repeats: false)
        
        // identifierは、ユニークである必要がある
        let request = UNNotificationRequest(identifier: "Alarm-\(job.id)", content: content, trigger: trigger)
        
        // 通知のエンキュー
        UNUserNotificationCenter.current().add(request)
        
        // 登録が完了したら元の画面に戻る
        // 戻る直前に、元の画面のViewControllerのTableViewを再読み込みする
        if let presentingViewController = self.presentingViewController as? ViewController{
            presentingViewController.alarmTableView.reloadData()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

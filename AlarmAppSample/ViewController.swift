//
//  ViewController.swift
//  AlarmAppSample
//
//  Created by Kentaro Abe on 2021/02/18.
//

import UIKit
import RealmSwift
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {
    let database = try! Realm()
    var alarmJobArray: Results<AlarmJob>!
    
    // 通知などの管理用
    let notificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet weak var alarmTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // ascendingをtrueにすると昇順に、falseにすると降順にソートします
        // filterは、文字列の条件式でソートします、数字や文字の定数はそのまま入りますが、変数を使う場合は 「%@」 を使い、2番目以降の引数に、順番に入れます。
        self.alarmJobArray = database.objects(AlarmJob.self).filter("time > %@", Date()).sorted(byKeyPath: "id", ascending: true)
        
        self.alarmTableView.delegate = self
        self.alarmTableView.dataSource = self
        
        self.alarmTableView.rowHeight = 85
        
        notificationCenter.requestAuthorization(options: [.sound, .badge, .alert]) { (granted, _) in
            if granted{
                self.notificationCenter.delegate = self
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alarmJobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarm") as! TableViewCell
        cell.job = alarmJobArray[indexPath.row]
        cell.display()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // スワイプで削除を実現するために、編集可能にする
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 何かの形で編集されようとしているときに呼ばれる
        
        if editingStyle == .delete{
            // セルを削除する場合
            // 通知の削除
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["Alarm-\(alarmJobArray[indexPath.row].id)"])
            
            // データの削除
            try! database.write{
                database.delete(alarmJobArray[indexPath.row])
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

class AlarmJob: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var time: Date = Date()
}

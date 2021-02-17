//
//  ViewController.swift
//  AlarmAppSample
//
//  Created by Kentaro Abe on 2021/02/18.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let database = try! Realm()
    var alarmJobArray: Results<AlarmJob>!
    
    @IBOutlet weak var alarmTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // ascendingをtrueにすると昇順に、falseにすると降順にソートします
        self.alarmJobArray = database.objects(AlarmJob.self).sorted(byKeyPath: "id", ascending: true)
        
        self.alarmTableView.delegate = self
        self.alarmTableView.dataSource = self
        
        self.alarmTableView.rowHeight = 85
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
    
}

class AlarmJob: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var time: Date = Date()
    @objc dynamic var isOn: Bool = true
}

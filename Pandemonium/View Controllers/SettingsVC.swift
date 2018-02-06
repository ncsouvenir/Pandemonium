//
//  SettingsVC.swift
//  Pandemonium
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    let settings = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        constrainView()
        settings.colorTableView.dataSource = self
        settings.colorTableView.delegate = self
        buttonSetup()
        settings.colorTableView.reloadData()
    }

    private func constrainView () {
        view.addSubview(settings)
        
        settings.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func buttonSetup() {
        settings.colorButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    @objc private func buttonPressed() {
        settings.colorTableView.isHidden = false
        settings.colorTableView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view.snp.height).multipliedBy(0.5)
        }
        
    }
    

}
extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.manager.schemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath)
        let color = Settings.manager.schemes[indexPath.row]
        cell.textLabel?.text = color
        cell.textLabel?.textColor = Settings.manager.textColor
        cell.backgroundColor = Settings.manager.background
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let buttonText = settings.colorButton
        buttonText.setTitle(Settings.manager.schemes[indexPath.row], for: .normal)
        Settings.manager.colorSetting(buttonText.titleLabel!.text!)
        settings.colorTableView.isHidden = true
//        view.backgroundColor =
        self.viewDidLoad()
        self.viewWillAppear(true)
    }
    
}

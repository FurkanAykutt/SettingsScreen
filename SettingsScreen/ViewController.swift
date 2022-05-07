//
//  ViewController.swift
//  SettingsScreen
//
//  Created by Furkan Aykut on 6.05.2022.
//

import UIKit

struct Section {
    let title : String
    let options : [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title : String
    let icon : UIImage?
    let iconBackgroundColor : UIColor
    let handler : (() -> Void)
    var isOn : Bool
}

struct SettingsOption {
    let title : String
    let icon : UIImage?
    let iconBackgroundColor : UIColor
    let handler : (() -> Void)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self,
                       forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func configure() {
        //MARK: SWİTCH
        models.append(Section(title: "General", options: [
            .switchCell(model: SettingsSwitchOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemRed, handler: {
                //Switch action code is here
            }, isOn: false))
        ]))
        
        //MARK: SECTION ONE
        models.append(Section(title: "General", options: [
            .staticCell(model: SettingsOption(title: "Wifi", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink, handler: {
                //Hücrenin yapacağı işlev buraya ...
                print("İlk Hücreye tıklandı")
            })),
            .staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "bluetooth"), iconBackgroundColor: .link, handler: {
                //Hücrenin yapacağı işlev buraya ...
            })),
            .staticCell(model: SettingsOption(title: "Airplane mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemGreen, handler: {
                //Hücrenin yapacağı işlev buraya ...
            })),
            .staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemOrange, handler: {
                //Hücrenin yapacağı işlev buraya ...
            }))
        ]))
        
        //MARK: SECTION TWO
        models.append(Section(title: "Information", options: [
            .staticCell(model: SettingsOption(title: "Wifi", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink, handler: {
                //Hücrenin yapacağı işlev buraya ...
                print("İlk Hücreye tıklandı")
            })),
            .staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "bluetooth"), iconBackgroundColor: .link, handler: {
                //Hücrenin yapacağı işlev buraya ...
            })),
            .staticCell(model: SettingsOption(title: "Airplane mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemGreen, handler: {
                //Hücrenin yapacağı işlev buraya ...
            })),
            .staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemOrange, handler: {
                //Hücrenin yapacağı işlev buraya ...
            }))
        ]))
        
        //MARK: SECTION THREE
        models.append(Section(title: "Apps", options: [
            .staticCell(model: SettingsOption(title: "Wifi", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink, handler: {
                //Hücrenin yapacağı işlev buraya ...
                print("İlk Hücreye tıklandı")
            })),
            .staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "bluetooth"), iconBackgroundColor: .link, handler: {
                //Hücrenin yapacağı işlev buraya ...
            })),
            .staticCell(model: SettingsOption(title: "Airplane mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemGreen, handler: {
                //Hücrenin yapacağı işlev buraya ...
            })),
            .staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemOrange, handler: {
                //Hücrenin yapacağı işlev buraya ...
            }))
        ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.frame = CGRect(x: 0, y: 0, width: 540, height: 55)
          
        if (section == models.count - 1){
            footer.backgroundColor = .clear
            let lbl = UILabel()
            lbl.frame = CGRect(x: 10, y: 0, width: 540, height: 40)
            lbl.backgroundColor = .clear
            lbl.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            lbl.text = "Created By Furkan Aykut"
            lbl.numberOfLines = 1
            footer.addSubview(lbl)
            let lbl2 = UILabel()
            lbl2.frame = CGRect(x: 10, y: 12, width: 540, height: 40)
            lbl2.backgroundColor = .clear
            lbl2.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            lbl2.text = "Version 1.0.0"
            lbl2.numberOfLines = 1
            footer.addSubview(lbl2)
            self.tableView.tableFooterView = footer

        }
            return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == models.count - 1) {
            return 60.0
        } else {
            return 0.0
        }
    }
}


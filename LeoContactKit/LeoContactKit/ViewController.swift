//
//  ViewController.swift
//  iSpy
//
//  Created by tecH on 13/03/19.
//  Copyright © 2019 tecH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBAr: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("dadas")
        searchBAr.delegate = self
        
        tableView.delegate = self
        self.tableView.dataSource = self
        
        LeoContacts.share.requestForAccess { (isGranded) in
            if isGranded {
                LeoContacts.share.getContacts()
                    .withMustKeys([.any  ])
                    .withSearchOn([.any])
                    .run({
                        self.tableView.reloadData()
                    })
                
                
                
                
            }
            
        }
    }
}
extension ViewController : UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool{
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print("fswdf " , searchText)
        LeoContacts.share.searchText(searchText)
        self.tableView.reloadData()
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeoContacts.share.contacts.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as! ContactTableViewCell
        
        if let some = LeoContacts.share.contacts[indexPath.row] as?  LeoContactable {
            cell.configure(leoContactsProtocols :  some)
            cell.callBackTap = { object in
            }
        }
        return cell
    }
}
class ContactTableViewCell : UITableViewCell {
    @IBOutlet weak var imgvUser: UIImageView?
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var lblEmail: UILabel?
    @IBOutlet weak var lblPhone: UILabel?
    var leoContactsProtocols : LeoContactable?
    var callBackTap : ((LeoContactable) -> Void)?
    func configure(leoContactsProtocols : LeoContactable ) {
        self.leoContactsProtocols = leoContactsProtocols
        lblName?.text = leoContactsProtocols.leoFullName.leoSafe()
        lblEmail?.text = leoContactsProtocols.leoEmail.leoSafe()
        lblPhone?.text = leoContactsProtocols.leoPhoneNumber.leoSafe()
        imgvUser?.image = leoContactsProtocols.leoImage ?? nil
        
        // if  let url = URL(string: leoContactsProtocols.user.leoSafe()) {
        // if imgvUser != nil {
        // Nuke.loadImage(with: url, into: imgvUser!)
        // }
        //}
        
        
    }
    @IBAction func actionTap(_ UIButton: Any) {
        if self.leoContactsProtocols  != nil {
            callBackTap?(self.leoContactsProtocols!)
        }
    }
}

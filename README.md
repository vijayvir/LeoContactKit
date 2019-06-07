#  LeoContacts
This class access the user contacts from Contact kit. it has used four keys *given blow*  for every contact. and these  variable can access in any class by   `LeoContactable` protocols. 
Main purpose of this class is for to get the basic contact informatiions from contact kit.  It do have following features 
1.  `mustKeys` : these are those key that the contact should have for example. by default value is `.any` means filter not implemented on any three field

  ```
   .withMustKeys([.any  ])
   // or 
    .withMustKeys([.fullName , .phoneNumber])
    // or
    .withMustKeys([.fullName , .email])
    or 
    .withMustKeys([.fullName , .email ,.phoneNumber ])
    .withMustKeys([.all ])
 ```
 1.  `searchOn` : it also have filter features, You can restrict the search based on this array 
 ```
 .withSearchOn([.any  ])
 // or 
 .withSearchOn([.fullName , .phoneNumber])
 // or
 .withSearchOn([.fullName , .email])
 or 
 .withSearchOn([.fullName , .email ,.phoneNumber ])
 .withSearchOn([.all ])
 ```

** 
```
CNContactEmailAddressesKey,
CNContactPhoneNumbersKey, 
CNContactImageDataKey,
CNContactFormatter.descriptorForRequiredKeysForStyle(CNContactFormatterStyle.FullName)]

```
   In this class have following features 
   1 . 

### Keys 

```
enum Keys : Int {
case fullName = 1
case phoneNumber = 2
case email = 3
case any = 4
case all

}
```
## Use of functions 

```swift 
// work only if used allowed to acces the contacts
LeoContacts.share.requestForAccess { (isGranded) in 
if isGranded {
// here it feches contact from contact list 
LeoContacts.share.getContacts()
.withMustKeys([.any  ])  //  This add  validations only to get those contacts which have particular keys 
.withSearchOn([.any]) //     This add  validations only to search on  those contacts which have particular keys 
.run({
DispatchQueue.main.async {
self.tableView.reloadData()
}
})
}
}

```

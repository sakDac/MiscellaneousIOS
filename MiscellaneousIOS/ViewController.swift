//
//  ViewController.swift
//  MiscellaneousIOS
//
//  Created by saket bhushan on 26/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit


class sak: NSObject, NSCopying {
    
    @objc var name: String?
    init(name: String) {
        self.name = name
    }
    func copy(with zone: NSZone? = nil) -> Any {
        return sak(name: self.name ?? "default")
    }
    
    func test()  {
        self.setValue("some text is chan?ged kvo text setting", forKey: "name")
    }
    
    
}
/*
 https://medium.freecodecamp.org/deep-copy-vs-shallow-copy-and-how-you-can-use-them-in-swift-c623833f5ad3
 https://stackoverflow.com/questions/34042774/how-to-get-a-mutable-copy-of-a-class-in-swift
 
 https://stackoverflow.com/questions/31515805/difference-between-computed-property-and-property-set-with-closure
 https://learnappmaking.com/lazy-computed-properties-swift/
 
 Exilient Technologies - 10 nov 2018
 =====================
 Codable
 Thread vs dispatch
 Sync using thread
 What is gcd
 What is generics
 What is kvc and kvo  -> done
 What are size classes -> done
 What is autolayout -> done
 States of the app
 Why is swift protocol oriented language
 Why use core data in place in of sqlite
 Difference b/w swift 4 and 4.2 -> done (enumation in enums, random int generator takes a range)
 Push notifications
 Submitting app to store
 Svn vs git -> done https://stackoverflow.com/questions/871/why-is-git-better-than-subversion
 */

class saket {
    var name = ""
}

class saket1 {
    var name = ""
}

protocol AnotherJustADelegate {
    
    //MARK: There are only 3 ways of initialization 1. ? , 2. ! , 3 var someVar = " " (i mean with a value)
    // var name: String {get} -> In protocol you can initialize like , coz compiler knows that in class later you have to initialize like shown in 3. above.
    var name: String? {get}
    
}

protocol aView: JustADelegate, AnotherJustADelegate {
//    func test()
    //MARK: it is possible in swift that : one class can implement two protocols, that has exact same functions.
}

extension aView where Self: UIView {
    
}

class ViewController: UIViewController, JustADelegate, aView {
    
    var name: String?
    
    func test() {
    }
    
   
    @objc var testStr = "some text"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mark: Multiple inheritance from classes 'UIViewController' and 'saket'
        // you can't extend classes 2 classes , swift doen't support Multiple inheritance.
        // you can implement as many protocols as you want. shown above
        
        
        //MARK: Coping object NScoping...
        let sak1 = sak(name: "saket")
        let sak2 = sak1.copy() as! sak
        sak2.name = "new saket"
        
        //MARK: KVO Key value complaint.
        self.addObserver(self, forKeyPath: #keyPath(ViewController.testStr), options: [.new, .old], context: nil)
        
        //MARK: KVC Key value complaint.
        self.setValue(" some kvc test .... ", forKey: #keyPath(ViewController.testStr))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        print("\(keyPath, object, change, context)", separator: "  ::::  ", terminator: "======== ENDED")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         var sak1 = sak(name: "saket")
//         sak1.value(forKeyPath: #keyPath(sak.name)) // 0
         sak1.setValue("saket has set a new name", forKeyPath: #keyPath(sak.name))
    }
    
    //MARK: LAYOUT SUBVIEWS
    /*
     Lays out the subviews immediately, if layout updates are pending.
     self.view.layoutIfNeeded()
     Discussion
     Use this method to force the view to update its layout immediately. When using Auto Layout, the layout engine updates the position of views as needed to satisfy changes in constraints. Using the view that receives the message as the root view, this method lays out the view subtree starting at the root. If no layout updates are pending, this method exits without modifying the layout or calling any layout-related callbacks.
     */
    /*
     self.view.setNeedsLayout()
     This method makes a note of the request and returns immediately. Because this method does not force an immediate update, but instead waits for the next update cycle, you can use it to invalidate the layout of multiple views before any of those views are updated. This behavior allows you to consolidate all of your layout updates to one update cycle, which is usually better for performance.
     */
    //Note:- BOTH THESE METHODS INTERNALLY CALL " layoutSubviews() ".
    
    
    //MARK: LAZY INTIALISATION
    /*
     // Property set with closure
     1.They are called just ONCE, hence it WILL BE called at the very first instance when the class is loaded by default.
     2. By making this lazy , you can remove the default Intializatoin , as then it will be called when you will "FIRST ACCESS IT" ( Needless to say will be called only once ).
     */
     var pushBehavior: UIPushBehavior = {
        print(" called .... Property set with closure")
        let lazilyCreatedPush = UIPushBehavior()
        lazilyCreatedPush.setAngle(50, magnitude: 50)
        return lazilyCreatedPush
    }()
    
    /*
     // Computed Properties
     1.Computed properties are re-calculated every time they are called, hence it will not be called at the very first instance when the class is loaded. (it will be called every time you try to access it.)
     2. You can't make it "Lazy" - Compilation error.
     */
    
    var pushBehavior1: UIPushBehavior {
        print(" called .... computed")
            let lazilyCreatedPush = UIPushBehavior()
            lazilyCreatedPush.setAngle(50, magnitude: 50)
            return lazilyCreatedPush
        
    }
    
    //MARK: INOUT
    var num1: Int = 1
    var char1: Character = "a"
    
    func dispatchInOut( char: inout Character) {
        DispatchQueue.main.async { [weak self] in
//            char = "b"
//            print(char) // b
//            print(self?.char1) // b
        }
    }
    
    func changeNumber( num: Int) {
        print(num) // 2
        print(num1) // 1
    }
    
    
    func changeChar( char: inout Character) {
        char = "b"
        print(char) // b
        print(char1) // b
    }
    
    
    
    //MARK: Threads
    
    func sleeping() {
    let thread =    Thread {
            print("sleep stared....")
            Thread.sleep(forTimeInterval: 5)
            print("sleep stared.... ended")
        }
        thread.qualityOfService = .background
        thread.start()
    }
    
    
    
    
    @IBAction func click(_ sender: UIButton) {
//        self.sleeping()
//        self.changeNumber(num: num1)
//        self.changeChar(char: &char1)
        self.performSegue(withIdentifier: "secondVC", sender: nil)
        
//        let push = self.pushBehavior
//        let push1 = self.pushBehavior1
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier , let destination = segue.destination as? ViewControllerSecond else { return }
        destination.firstVC = self
        destination.delegate = self
    }
    
    func dataCommunication(msg: String?) {
        print(" printing from first vc :: \(msg)")
    }
}

class someView: UIView {
    
    /*
     You should override this method only if the autoresizing and constraint-based behaviors of the subviews do not offer the behavior you want. You can use your implementation to set the frame rectangles of your subviews directly.
     
     You should not call this method directly. If you want to force a layout update, call the setNeedsLayout() method instead to do so prior to the next drawing update. If you want to update the layout of your views immediately, call the layoutIfNeeded() method.
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        for aSubView in self.subviews as [UIView] {
            if String(describing: aSubView.classForCoder).range(of: "UITableViewCellDeleteConfirmationView") != nil {
                aSubView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    aSubView.widthAnchor.constraint(equalToConstant: 50),
                    aSubView.heightAnchor.constraint(equalToConstant: 50),
                    ])
            }
        }
    }
}

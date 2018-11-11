//
//  ViewController.swift
//  MiscellaneousIOS
//
//  Created by saket bhushan on 26/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit


class sak: NSCopying {
    
    var name: String?
    init(name: String) {
        self.name = name
    }
    func copy(with zone: NSZone? = nil) -> Any {
        return sak(name: self.name ?? "default")
    }
}
/*
 https://medium.freecodecamp.org/deep-copy-vs-shallow-copy-and-how-you-can-use-them-in-swift-c623833f5ad3
 https://stackoverflow.com/questions/34042774/how-to-get-a-mutable-copy-of-a-class-in-swift
 
 https://stackoverflow.com/questions/31515805/difference-between-computed-property-and-property-set-with-closure
 https://learnappmaking.com/lazy-computed-properties-swift/
 */

class ViewController: UIViewController {

//    let testStr = "some text"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sak1 = sak(name: "saket")
        let sak2 = sak1.copy() as! sak
        sak2.name = "new saket"
        
        print(sak1.name, sak2.name)
        
        
        
        
        
//        self.setValue("some text is chan?ged kvo text setting", forKey: "some text")
        
//        print(" \(self.testStr)")
        
        print("============== V1   viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("============== V1   viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
     print("============== V1   viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        print("============== V1   viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        print("============== V1   viewDidLayoutSubviews")
    }
    
    
    // =================
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("============== V1   viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("============== V1   viewDidDisappear")
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
//        self.performSegue(withIdentifier: "secondVC", sender: nil)
//        let push = self.pushBehavior
//        let push1 = self.pushBehavior1
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

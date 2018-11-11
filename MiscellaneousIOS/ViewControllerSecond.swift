//
//  ViewControllerSecond.swift
//  MiscellaneousIOS
//
//  Created by saket bhushan on 04/11/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit

class ViewControllerSecond: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("============== v2   viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("============== v2   viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("============== v2   viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        print("============== v2   viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        print("============== v2   viewDidLayoutSubviews")
    }
    
    
    // =================
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("============== v2   viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("============== v2   viewDidDisappear")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

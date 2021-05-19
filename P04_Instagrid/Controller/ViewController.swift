//
//  ViewController.swift
//  P04_Instagrid
//
//  Created by Dems on 11/05/2021.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var viewPhoto: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for family : String in UIFont.familyNames
        {
            print(family)
            for names : String in UIFont.fontNames(forFamilyName: family)
            {
                print("==\(names)")
            }
        }
        
    }
    
    
    @IBAction func buttonLayout1(_ sender: Any)
    {
        button1.isHidden = true
        button3.isHidden = false
    }
    
    
    @IBAction func buttonLayout2(_ sender: Any)
    {
        button3.isHidden = true
        button1.isHidden = false
    }
    
    
    @IBAction func buttonLayout3(_ sender: Any)
    {
        button3.isHidden = false
        button1.isHidden = false
    }
    
    
}


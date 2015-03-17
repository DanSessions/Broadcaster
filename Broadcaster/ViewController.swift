//
//  ViewController.swift
//  Broadcaster
//
//  Created by Dan on 17/03/2015.
//  Copyright (c) 2015 Daniel Sessions. All rights reserved.
//

import UIKit
import NotificationCenter

class ViewController: UIViewController, UITextFieldDelegate {

    var externalScreen: UIScreen?
    var externalWindow: UIWindow?
    var externalViewController: ExternalScreenViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        checkForExternalScreenAndInitializeIfPresent()
        registerForScreenConnectionNotifications()
        
    }
    
    @IBAction func textChanged(sender: UITextField) {
        
        externalViewController?.displayText(sender.text)
        
    }
    
    func checkForExternalScreenAndInitializeIfPresent() {

        let screens: NSArray = UIScreen.screens()
        
        if screens.count > 1 {
            externalScreen = screens[1] as? UIScreen
            
            setupExternalScreen(&externalScreen!)
            
            externalWindow = UIWindow(frame: externalScreen!.bounds)
            externalWindow!.screen = externalScreen!
            externalWindow!.hidden = false;
            
            updateExternalScreen()
        }
        
    }
    
    func updateExternalScreen() {
        
        externalViewController = ExternalScreenViewController(nibName: "ExternalScreenViewController", bundle: nil)

        externalWindow?.rootViewController = externalViewController
        externalWindow?.addSubview(externalViewController!.view)
        externalWindow?.makeKeyAndVisible()

    }
    
    func setupExternalScreen(inout screen: UIScreen) {

        let availableModes: NSArray	= screen.availableModes
        let screenMode = availableModes.lastObject as UIScreenMode
        screen.currentMode = screenMode
        
        screen.overscanCompensation = UIScreenOverscanCompensation.InsetApplicationFrame

    }
    
    func screenDidConnectNotification(notification: NSNotification) {
        
        println("screenDidConnectNotification")
        
        var externalScreen: UIScreen = notification.object as UIScreen
        
        setupExternalScreen(&externalScreen)
        
        externalWindow = UIWindow(frame: externalScreen.bounds)
        externalWindow!.screen = externalScreen
        externalWindow!.hidden = false;
        
        updateExternalScreen()
    }

    func screenDidDisconnectNotification(notification: NSNotification) {
        
        println("screenDidDisconnectNotification")
        
        if externalWindow != nil {
            externalWindow!.hidden = true;
            externalWindow = nil;
        }
        
    }
    
    func registerForScreenConnectionNotifications() {

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "screenDidConnectNotification:",
            name: UIScreenDidConnectNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "screenDidDisconnectNotification:",
            name: UIScreenDidDisconnectNotification,
            object: nil)
        
    }
    
}


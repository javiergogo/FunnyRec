//
//  PlaySoundsViewController.swift
//  FunnyRec
//
//  Created by Javier Gomez on 4/9/16.
//  Copyright © 2016 JDev. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    var recordedAudioURL: NSURL!
    
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int
    {
        case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb
    }
    
    @IBAction func playSoundForButton(sender: UIButton)
    {
        print ("play sound")
        print (recordedAudioURL)
        
        switch(ButtonType(rawValue: sender.tag)!)
        {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 3.5)
        case .Chipmunk:
            playSound(rate: 200)
        case .Vader:
            playSound(rate: -10)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
        
    }
    
    @IBAction func stopButtonPressed(sender: UIButton)
    {
        print ("stop pressed")
        stopAudio()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Cargado playSounds")
        
        setupAudio()

    }

    override func viewWillAppear(animated: Bool) {
        
        configureUI(.NotPlaying)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    

}

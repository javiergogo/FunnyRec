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

    var recordedAudioURL: URL!
    
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int
    {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton)
    {
        print ("play sound")
        print (recordedAudioURL)
        
        switch(ButtonType(rawValue: sender.tag)!)
        {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 3.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton)
    {
        print ("stop pressed")
        stopAudio()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Cargado playSounds")
        
        setupAudio()

    }

    override func viewWillAppear(_ animated: Bool) {
        
        configureUI(.notPlaying)
    }

    

}

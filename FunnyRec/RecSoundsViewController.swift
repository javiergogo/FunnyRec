//
//  RecSoundsViewController.swift
//  FunnyRec
//
//  Created by Javier Gomez on 4/8/16.
//  Copyright © 2016 JDev. All rights reserved.
//

import UIKit
import AVFoundation

class RecSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        stopButton.isEnabled = false
    }

    var audioRecorder:AVAudioRecorder!


    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
  
    @IBAction func recordAudio(_ sender: AnyObject) {
        recordingLabel.text = "Recording .....!"
        stopButton.isEnabled = true
        recordingButton.isEnabled = false
        
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let recordingName = dirPath.appendingPathComponent("recordedVoice.wav")

        //let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        //let recordingName = "recordedVoice.wav"
        
        let pathArray = [dirPath, recordingName]
        //let filePath = URL.fileURL(withPathComponents: pathArray)
        //let filePath = NSURL.fileURLWithPathComponents(pathArray)

        print(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: recordingName, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        recordingButton.isEnabled = true
        stopButton.isEnabled = false
        recordingLabel.text = "Tap to record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag //if flag is true
        {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else
        {
            print ("Saving audio failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"
        {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
        
    }
}


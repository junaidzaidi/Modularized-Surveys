//
//  RecordTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 10/03/2022.
//

import UIKit
import Speech
import AVKit

protocol VoiceTVCDelegate : AnyObject {
    func voiceTextValueChanged(newValue: String)
}

class VoiceTVC: UITableViewCell {
    
    //MARK:_ IBOutlets
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var playImgView: UIImageView!
    
    @IBOutlet weak var voiceLbl: UILabel!
    //MARK:- Helper Variables
    var textFldValue = "Voice: "
    let speechRecognizer        = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))

    var recognitionRequest      : SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask         : SFSpeechRecognitionTask?
    let audioEngine             = AVAudioEngine()
    
    weak var delegate : VoiceTVCDelegate?

    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        voiceLbl.text = "Start Recording"
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("nextBtnTapped"), object: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        if audioEngine.isRunning {
            
            self.playImgView.image = UIImage(systemName: "mic.circle")
            playImgView.image = playImgView.image?.withRenderingMode(.alwaysTemplate)
            playImgView.tintColor = UIColor.systemBlue
            if let delegate = delegate {
                delegate.voiceTextValueChanged(newValue: "Voice: \(textFldValue)")
            }
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            self.btnStart.isEnabled = false
            voiceLbl.text = "Done Recording"

            //self.btnStart.setTitle("Start Recording", for: .normal)
        }
    }
    
    //MARK:- IBActions
    @IBAction func btnTapped(_ sender: UIButton) {
        if audioEngine.isRunning {
            
            self.playImgView.image = UIImage(systemName: "mic.circle")
            playImgView.image = playImgView.image?.withRenderingMode(.alwaysTemplate)
            playImgView.tintColor = UIColor.systemBlue
            if let delegate = delegate {
                delegate.voiceTextValueChanged(newValue: "Voice: \(textFldValue)")
            }
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            self.btnStart.isEnabled = false
            voiceLbl.text = "Done Recording"

            //self.btnStart.setTitle("Start Recording", for: .normal)
        } else {
            self.startRecording()
            //self.btnStart.setTitle("Stop Recording", for: .normal)
            self.playImgView.image = UIImage(systemName: "stop.circle.fill")
            playImgView.image = playImgView.image?.withRenderingMode(.alwaysTemplate)
            playImgView.tintColor = UIColor.red
            voiceLbl.text = "Recording...."
        }
    }
    
    func setupSpeech() {

        self.btnStart.isEnabled = false
        self.speechRecognizer?.delegate = self

        SFSpeechRecognizer.requestAuthorization { (authStatus) in

            var isButtonEnabled = false

            switch authStatus {
            case .authorized:
                isButtonEnabled = true

            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")

            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")

            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }

            OperationQueue.main.addOperation() {
                self.btnStart.isEnabled = isButtonEnabled
            }
        }
    }

    //------------------------------------------------------------------------------

    func startRecording() {

        // Clear all previous session data and cancel task
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        // Create instance of audio session to record voice
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.measurement, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode

        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }

        recognitionRequest.shouldReportPartialResults = true

        self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in

            var isFinal = false

            if result != nil {

                self.textFldValue = result?.bestTranscription.formattedString ?? ""
                isFinal = (result?.isFinal)!
            }

            if error != nil || isFinal {

                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.btnStart.isEnabled = true
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        self.audioEngine.prepare()

        do {
            try self.audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
}

//------------------------------------------------------------------------------
// MARK:-
// MARK:- SFSpeechRecognizerDelegate Methods
//------------------------------------------------------------------------------

extension VoiceTVC: SFSpeechRecognizerDelegate {

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.btnStart.isEnabled = true
        } else {
            self.btnStart.isEnabled = false
        }
    }

}

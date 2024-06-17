//
//  ViewController.swift
//  TabularDataML
//
//  Created by Atul Kumar on 07/02/24.
//

import UIKit
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var hoursStudiesStepper: UIStepper!
        
        @IBOutlet weak var hoursStudiesLabel: UILabel!
        
        @IBOutlet weak var previousScoreTextField: UITextField!
        @IBOutlet weak var ECActivitiesSwitch: UISwitch!
        
        @IBOutlet weak var sleepHoursLabel: UILabel!
        
        @IBOutlet weak var sleepHoursStepper: UIStepper!
        
        @IBOutlet weak var QPSolvedLabel: UILabel!
        var ECActivites : String = "No"
        
        @IBOutlet weak var QPsolvedStepper: UIStepper!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numberOfHourStudiedChanged(_ sender: Any) {
           hoursStudiesLabel.text = String(Int64(hoursStudiesStepper.value))
        }
        @IBAction func numberOfHoursSleptChanged(_ sender: Any) {
            sleepHoursLabel.text =  String(Int64(sleepHoursStepper.value))
        }
        @IBAction func numberOfQPSolvedChanged(_ sender: Any) {
           QPSolvedLabel.text =   String(Int64(QPsolvedStepper.value))
        }
        @IBAction func calculateButtonTapped(_ sender: Any) {
            guard let previousScore = previousScoreTextField.text else {
                print("Previous score invalid")
                return
            }
            let previousScoreInt = Int64(previousScore) ?? 0
            let hoursStudy = hoursStudiesStepper.value
            let sleepHours = sleepHoursStepper.value
            let QPPapers = QPsolvedStepper.value
            let ECA = ECActivites
            print(previousScoreInt , hoursStudy , sleepHours , QPPapers , ECA)
            let message : String
            
            let modelConfig = MLModelConfiguration()
            let model = try? StudentPerformanceModel(configuration: modelConfig)
          
            do {
             
                let prediction  = try model?.prediction(Hours_Studied: Int64(hoursStudy), Previous_Scores: Int64(Double(previousScoreInt)), Extracurricular_Activities: ECA, Sleep_Hours: Int64(sleepHours), Sample_Question_Papers_Practiced: Int64(QPPapers))
                
                if let performancePredicted = prediction?.Performance_Index {
                    message = "Estimated Performace index \(floor(performancePredicted))"
                    print(message)
                }
                
            } catch {
                message = "No estimation"
                print(message)
            }
            
        }
        
        @IBAction func ECactivitiesSwitchChanged(_ sender: Any) {
            if ECActivitiesSwitch.isOn {
                ECActivites = "Yes"
            } else {
                ECActivites = "No"
            }
        }
    

}


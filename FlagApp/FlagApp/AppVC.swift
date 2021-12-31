//
//  AppVC.swift
//  FlagApp
//
//  Created by ArdaSisli on 31.12.2021.
//

import UIKit

class AppVC: UIViewController {
    
    
    @IBOutlet weak var TrueLabel: UILabel!
    @IBOutlet weak var FalseLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var ButtonA: UIButton!
    @IBOutlet weak var ButtonB: UIButton!
    @IBOutlet weak var ButtonC: UIButton!
    @IBOutlet weak var ButtonD: UIButton!
    
    var questions = [Flags]()
    var falseAnswer = [Flags]()
    var trueQuestion = Flags()
    
    var questionCounter = 0
    var trueCounter = 0
    var falseCounter = 0
    
    var Answers = [Flags]()
    var allAnswerlist = Set <Flags>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        questions = Flagsdao().RandomBring5()
        
        UploadQuestion()
       
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let GoToVC = segue.destination as! ResultVC
        GoToVC.mesaj = trueCounter
    }
                
    func UploadQuestion() {
        QuestionLabel.text = "\(questionCounter+1). Question"
        TrueLabel.text = "True: \(trueCounter)"
        FalseLabel.text = "False: \(falseCounter)"
        
        trueQuestion = questions[questionCounter]
        
        Image.image = UIImage(named: trueQuestion.bayrak_resim!)
        
      
        
        allAnswerlist.removeAll()
        
        falseAnswer = Flagsdao().RandomBring3(bayrak_id: trueQuestion.bayrak_id!)
        
        allAnswerlist.insert(trueQuestion)
        allAnswerlist.insert(falseAnswer[0])
        allAnswerlist.insert(falseAnswer[1])
        allAnswerlist.insert(falseAnswer[2])
        
        Answers.removeAll()
        
        for s in allAnswerlist {
            Answers.append(s)
        }
        
        ButtonA.setTitle(Answers[0].bayrak_ad , for: .normal)
        ButtonB.setTitle(Answers[1].bayrak_ad , for: .normal)
        ButtonC.setTitle(Answers[2].bayrak_ad , for: .normal)
        ButtonD.setTitle(Answers[3].bayrak_ad , for: .normal)
        
    }
    
    func trueAnswer(button:UIButton) {
        let DogruCevap = trueQuestion.bayrak_ad
        let TrueButton = button.titleLabel?.text
        
        if DogruCevap == TrueButton {
            trueCounter += 1
        }else{
            falseCounter += 1
        }
        
        TrueLabel.text = "True: \(trueCounter)"
        FalseLabel.text = "False: \(falseCounter)"
    }
    
    func questionReplay() {
        questionCounter += 1
        
        if questionCounter != 5 {
            UploadQuestion()
            
        }else{
           performSegue(withIdentifier: "2To3", sender: nil)
        }
    }
    
    @IBAction func ButtonA(_ sender: Any) {
        trueAnswer(button: ButtonA)
        questionReplay()
    }
    @IBAction func ButtonB(_ sender: Any) {
        trueAnswer(button: ButtonB)
        questionReplay()
    }
    
    @IBAction func ButtonC(_ sender: Any) {
        trueAnswer(button: ButtonC)
        questionReplay()
    }
    
    @IBAction func ButtonD(_ sender: Any) {
        trueAnswer(button: ButtonD)
        questionReplay()
    }
    
}

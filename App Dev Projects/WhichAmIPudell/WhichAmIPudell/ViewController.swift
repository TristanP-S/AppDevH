//
//  ViewController.swift
//  WhichAmIPudell
//
//  Created by Tristan Pudell-Spatscheck on 10/21/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
//INITIALIZER GRADING COMMENTS
//KNOWN PROBLEM WITH SOME ANSWERS BEING CUT OFF (my solution is just having the answer repeated at the start of the description.
//Also, the 3 types of user interaction are the main selection method, and the two other types included in settings. (Mr.Horner said this counts as long as I made a comment about it)
//Please note this app only uses 2 screens (1 for quiz, 1 for settings)
//Also, I know valve is the company, not steam, and gman's head being cut off was intentional
import UIKit
//structure that holds the info for each question
struct Question{
    var question : String
    var opt1 : String
    var description1 : String
    var opt2 : String
    var description2 : String
    var opt3 : String
    var description3 : String
    var opt4 : String
    var description4 : String
}
//GLOBAL VARAIBLES
var questions : [Question] = []
var problem = 0
var points = 0
var red : Float = 1
var green : Float = 1
var blue : Float = 1
var storedRed : Float = 1
var storedGreen : Float = 1
var storedBlue : Float = 1
var backEnabled = true

class ViewController: UIViewController {
    //connected variables
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var boxOptions: UISegmentedControl!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var finalImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        points=0
        addQuestions()
        //sets up problem one
        boxOptions.selectedSegmentIndex = 0
        questionLbl.text = questions[problem].question
        descriptionLbl.text = questions[problem].description1
        boxOptions.setTitle(questions[problem].opt1, forSegmentAt: 0)
        boxOptions.setTitle(questions[problem].opt2, forSegmentAt: 1)
        boxOptions.setTitle(questions[problem].opt3, forSegmentAt: 2)
        boxOptions.setTitle(questions[problem].opt4, forSegmentAt: 3)
        finalImg.isHidden = true
    }
    //sets next question + answers
    @IBAction func nextClicked(_ sender: Any) {
        problem = problem + 1
        //if button is clicked from end screen
        if(nextBtn.currentTitle == "Retry"){
            points=0
            nextBtn.setTitle("Next", for: .normal)
            finalImg.isHidden = true
            boxOptions.isHidden = false
            descriptionLbl.isHidden = false
            boxOptions.selectedSegmentIndex = 0
            questionLbl.text = questions[problem].question
            descriptionLbl.text = questions[problem].description1
            boxOptions.setTitle(questions[problem].opt1, forSegmentAt: 0)
            boxOptions.setTitle(questions[problem].opt2, forSegmentAt: 1)
            boxOptions.setTitle(questions[problem].opt3, forSegmentAt: 2)
            boxOptions.setTitle(questions[problem].opt4, forSegmentAt: 3)
        } else { //if button is clicked normally
        //adds points from 1-4 based on answer
        points = points + boxOptions.selectedSegmentIndex + 1
        //if at last problem, display end and reset
        if(problem>=questions.count){
            problem = -1
            displayEnd()
        } else { // if not at last problem
        boxOptions.selectedSegmentIndex = 0
        questionLbl.text = questions[problem].question
        descriptionLbl.text = questions[problem].description1
        boxOptions.setTitle(questions[problem].opt1, forSegmentAt: 0)
        boxOptions.setTitle(questions[problem].opt2, forSegmentAt: 1)
        boxOptions.setTitle(questions[problem].opt3, forSegmentAt: 2)
        boxOptions.setTitle(questions[problem].opt4, forSegmentAt: 3)
        }
        }
    }
    //function triggered when answer is changed
    @IBAction func answerChanged(_ sender: Any) {
        //sets the description to the selected option
        let selected = boxOptions.selectedSegmentIndex
        if(selected == 0){
            descriptionLbl.text = questions[problem].description1
        } else if (selected == 1){
            descriptionLbl.text = questions[problem].description2
        } else if (selected == 2){
            descriptionLbl.text = questions[problem].description3
        } else {
            descriptionLbl.text = questions[problem].description4
        }
    }
    //adds all questions to the questions array (added manually)
    func addQuestions(){
        //5 questions added here, as required by the rubric
        questions.append(Question(question: "Out of the options, what's your favorite Color?", opt1: "Red", description1: "The Color of Blood, Mario, and The Subscribe Button.", opt2: "Yellow", description2: "The Color of the Sun, Sunkern, and Wario.", opt3: "Blue", description3: "The Color of Mike Sullivan, The Smurfs, and The Sky." , opt4: "Green", description4: "The Color of Grass, Trees, and Broccoli"))
        questions.append(Question(question: "Out of the options, what's your favorite gaming console?", opt1: "Nintendo Switch", description1: "The Nintendo Switch is a video game console developed by Nintendo, released on March 3, 2017. It is a hybrid console that can be used as a stationary and portable device.", opt2: "PC", description2: "A personal computer (PC) is a multi-purpose computer whose size, capabilities, and price make it feasible for individual use. Personal computers are intended to be operated directly by an end user, rather than by a computer expert or technician.It is known for being stationary or portable depending on the type, and being able to play the most games with the best graphics, controls, and framerate.", opt3: "PS4", description3: "The PlayStation 4 (officially abbreviated as PS4) is an eighth-generation home video game console developed by Sony Interactive Entertainment. Announced as the successor to the PlayStation 3 in February 2013, it was launched on November 15 in North America, November 29 in Europe, South America and Australia, and on February 22, 2014, in Japan. It is well known for having the best graphics on a console and games like Gears of War.", opt4: "Xbox One", description4: "The Xbox One is an eighth-generation home video game console developed by Microsoft. Announced in May 2013, it is the successor to Xbox 360 and the third console in the Xbox Family. It is a stationary only device that is known for its several console exclusive games and the ability to do things such as email and watch Netflix, otherwise only possible on PCs."))
        questions.append(Question(question: "Out of the options, who is your favorite person?", opt1: "Reggie Fils-Aimé", description1: "Reginald Fils-Aimé is an American businessman, most recognized as the former president and chief operating officer of Nintendo of America, the North American division of the Japanese video game company Nintendo, from 2006 to 2019", opt2: "Gaben", description2: "Gabe Logan Newell (bornNovember 3, 1962), commonly known by his nickname Gaben (ˈɡeɪbˈɛn), is an American computer programmer and businessman best known as the co-founder of the video game development and digital distribution company Valve Corporation.", opt3: "Cliff Bleszinski", description3: "Cliff Bleszinski (bləˈzɪnski; born 1975), popularly known as CliffyB, is an American video game designer. Former design director for the game development company Epic Games and the co-founder of Boss Key Productions, he is known for his role in the development of the Unreal and Gears of War series.", opt4: "Alex Seropian", description4: "Alexander Seropian (born 1969) is an American video game developer, one of the initial founders and later president of Bungie, the developer of the Marathon, Myth, and Halo video game series."))
        questions.append(Question(question: "Out of the options, what is your favorite video game company?", opt1: "Retro Studios", description1: "Retro Studios, Inc. is an American video game developer and subsidiary of Nintendo based in Austin, Texas. The studio is best known for its work on the Metroid Prime and Donkey Kong Country series, and has contributed to several other Nintendo-developed projects, such as Metroid Prime Hunters and Mario Kart 7.", opt2: "Steam", description2: "Steam is a video game digital distribution service platform developed by Valve Corporation. It was launched in September 2003 as a way for Valve to provide automatic updates for their games, but eventually expanded to include games from third-party publishers.", opt3: "Naughty Dog", description3: "Naughty Dog, LLC is an American first-party video game developer based in Santa Monica, California. Founded by Andy Gavin and Jason Rubin in 1984 as an independent developer, the studio was acquired by Sony Computer Entertainment in 2001. It is well known for developing the uncharted series.", opt4: "Bungie Inc.", description4: "Bungie, Inc. is an American video game developer based in Bellevue, Washington. The company was established in May 1991 by Alex Seropian, who later brought in programmer Jason Jones after publishing Jones' game Minotaur: The Labyrinths of Crete. It is well known for making Halo, Destiny,Oni, and other commonly praised games."))
        questions.append(Question(question: "Out of the options, who is your favoirte video game character?", opt1: "Charizard", description1: "Charizard, known in Japan as Lizardon, is a Pokémon in Nintendo and Game Freak's Pokémon franchise. Created by Atsuko Nishida, Charizard first appeared in the video games Pokémon Red and Blue and subsequent sequels. It is well known for being one of, if not the most, expensive pokemon cards", opt2: "Gordon Freeman", description2: "Gordon Freeman is a fictional character who is the main protagonist of the Half-Life video game series, created by Gabe Newell and designed by Newell and Marc Laidlaw of Valve Corporation. His first appearance is in Half-Life.", opt3: "Kratos", description3: "Kratos is a video game character from SIE Santa Monica Studio's God of War series, which was based on Greek mythology, before shifting to Norse mythology.", opt4: "Master Chief", description4: "Master Chief Petty Officer John-117, or Master Chief, is a fictional character and the protagonist of the Halo multimedia franchise. Master Chief is a playable character in the series of science fiction first-person shooter video games Halo: Combat Evolved, Halo 2, Halo 3, Halo 4, and Halo 5: Guardians."))
    }
    
    //displays end screen (will show what you are instead of points in final verison)
    func displayEnd(){
        boxOptions.isHidden = true
        descriptionLbl.isHidden = true
        finalImg.isHidden = false
        nextBtn.setTitle("Retry", for: .normal)
        //Says what you are based on your points (5-20 points possible)
        if(points<=8){
        questionLbl.text = "You are a Mimikyu"
            finalImg.image = UIImage(named: "mimikyu")
        } else if(points <= 12){
        questionLbl.text = "You are the G-Man"
            finalImg.image = UIImage(named: "gman")
        } else if(points <= 16){
        questionLbl.text = "You are Spider Man"
            finalImg.image = UIImage(named: "spiderman")
        } else {
        questionLbl.text = "You are Master Chief"
            finalImg.image = UIImage(named: "masterchief")
        }
    }
    func setBckg(){
        self.view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
}


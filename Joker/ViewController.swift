//
//  ViewController.swift
//  Joker
//
//  Created by anna on 16.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var joke: Joke?
    
    @IBOutlet weak var setupLabel: UILabel!
    @IBOutlet weak var punchlineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()

    }
    
    @IBAction func generateNewJoke(_ sender: UIButton) {
        parseJSON()
    }
    
    private func parseJSON() {
        let urlString = "https://v2.jokeapi.dev/joke/Any?safe-mode"
        guard let url = URL(string: urlString) else {
            fatalError("fail")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { /*[self]*/ data, response, error in
            guard data != nil && error == nil else { return }
            
            do {
                let jokeData = try Data(contentsOf: url)
                self.joke = try JSONDecoder().decode(Joke.self, from: jokeData)
                DispatchQueue.main.async {
                    self.setupLabel.text = self.joke?.setup
                    self.punchlineLabel.text = self.joke?.delivery
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}

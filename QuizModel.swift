

import Foundation


struct QuizItem: Codable { //se puede poner Identificabe para poder diferenciarlos por el id sin necesidad de decirlo
    let id: Int
    let question: String
    let answer: String
    let author: Author?
    let attachment: Attachment?
    let favourite: Bool
    
    struct Author: Codable {
        let isAdmin: Bool?
        let username: String
        let photo: Attachment?
    }
    
    struct Attachment: Codable {
        let filename: String
        let mime: String
        let url: URL?
    }
}


class QuizModel {
       
    private(set) static var shared = QuizModel()
    
    private(set) var quizzes = [QuizItem]()
    
    private init() {
       load()
    }
    
    private func load() {
        
        guard let jsonURL = Bundle.main.url(forResource: "p1_quizzes", withExtension: "json") else {
            print("Internal error: No encuentro p1_quizzes.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            
            // let str = String(data: data, encoding: String.Encoding.utf8)
            // print("Quizzes ==>", str!)
            
            let quizzes = try decoder.decode([QuizItem].self, from: data)
            
            // print("Quizzes cargados")
            
            self.quizzes = quizzes
        } catch {
            print("Algo chungo ha pasado: \(error)")
        }
    }
}


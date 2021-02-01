

import Foundation

class ScoreModel: ObservableObject{
	
	@Published var acertadas: Set<Int>=[]
	var quizzes: [QuizItem]=[]
	
	func check(respuesta: String, quiz: QuizItem){
		let r1 = respuesta.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
		let r2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
		
		if r1==r2,
		   !acertadas.contains(quiz.id){
			acertadas.insert(quiz.id)
			quizzes.append(quiz)
		}
	}
	
	func respondidos()->[QuizItem]{
		return quizzes
	}

	
}

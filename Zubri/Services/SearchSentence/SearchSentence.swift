//  SearchSentence.swift
//  Zubri
//
//  Created by Павел Сивак on 11/05/2025.
//

import Foundation

class SearchSentence {
    
    let baseURL = "https://tatoeba.org/eng/api_v0/search?from=eng&query="
    
    func getSentence(for word: String) async -> String? {
        let fullURL = baseURL + word.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        guard let url = URL(string: fullURL) else {
            print("Invalid URL")
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(TatoebaResponse.self, from: data)
            
            let filtered = decoded.results.filter { sentence in
                let words = sentence.text.lowercased().components(separatedBy: .whitespacesAndNewlines)
                let cleanWords = words.map { $0.trimmingCharacters(in: .punctuationCharacters)}
                
                return cleanWords.contains { $0 == word.lowercased() } && (cleanWords.count <= 25 && cleanWords.count >= 3)
            }
            
            return filtered.randomElement()?.text
            
        } catch {
            print("Async error: \(error)")
            return nil
        }
    }

}

struct TatoebaResponse: Decodable {
    let results: [SentenceModel]
}

//
//  CurseWordFilter.swift
//  Busamigo
//
//  Created by Nick Askari on 13/07/2022.
//

import Foundation

struct CursewordFilter {
    let cursewords: Array<String>
    
    func cleanText(_ text: String) -> String {
        if !isClean(text) {
            var cleaned = text
            for word in words(text) {
                if cursewords.contains(lowercaseFormate(word)) {
                    let cencored = censor(wordLength: word.count)
                    cleaned = cleaned.replacingOccurrences(of: word, with: cencored)
                }
            }
            print(cleaned)
            return cleaned.trimmingCharacters(in: .whitespaces)
        } else {
            return text.trimmingCharacters(in: .whitespaces)
        }
    }
    
    private func isClean(_ text: String) -> Bool {
        for word in words(text) {
            if cursewords.contains(lowercaseFormate(word)) {
                return false
            }
        }
        return true
    }
    
    private func formatString(_ text: String) -> String {
        let flushChars: Set<Character> = [",", ".", "_", "@", "/", "?", "!", "#", "$", "%", "(", ")", "=", "<", ">"]
        var text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        text.removeAll {
            flushChars.contains($0)
        }
        return text
    }
    
    private func lowercaseFormate(_ text: String) -> String {
        return formatString(text).lowercased()
    }
    
    private func words(_ text: String) -> Array<String> {
        return formatString(text).components(separatedBy: .whitespacesAndNewlines)
    }
    
    private func censor(wordLength: Int) -> String {
        var cencored = ""
        for _ in 1...wordLength {
            cencored += "*"
        }
        return cencored
    }
}

//
//  MushroomMock.swift
//  Micelio
//
//  Created by Davide Aliti on 11/10/23.
//

import Foundation

func generateMockMushroomArray(length: Int) -> [Mushroom] {
    var mushroomArray: [Mushroom] = []
    for _ in 0..<length {
        let mushroom = generateMockMushroom()
        mushroomArray.append(mushroom)
    }
    return mushroomArray
}

private func generateMockMushroom() -> Mushroom {
    let name = generateRandomString(length: 12)
    let shortDescription = generateParagraph(numberOfWords: 20)
    let image = generateRandomString(length: 8)
    let edibility = generateRandomEdibility()
    let environments = generateRandomEnvironments()
    let seasons = generateRandomSeasons()
    let description = generateParagraph(numberOfWords: 100)
    let environmentDescription = generateParagraph(numberOfWords: 40)
    let edibilityDescription = generateParagraph(numberOfWords: 50)
    let trivia = generateParagraph(numberOfWords: 80)
    
    return Mushroom(name: name, shortDescription: shortDescription, image: image, edibility: edibility, environments: environments, seasons: seasons, description: description, environmentDescription: environmentDescription, edibilityDescription: edibilityDescription, trivia: trivia, additionalImages: [])
}

private func generateRandomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      return String((0..<length).map{ _ in letters.randomElement()! })
}

private func generateRandomEdibility() -> Edibility {
    return Edibility.allCases.randomElement()!
}

private func generateRandomEnvironments() -> [Environment] {
    var environments: [Environment] = []
    for _ in 1...Int.random(in: 1...Environment.allCases.count) {
        let environment = Environment.allCases.randomElement()!
        if (!environments.contains(environment)) {
            environments.append(environment)
        }
    }
    return environments
}

private func generateRandomSeasons() -> [Season] {
    var seasons: [Season] = []
    for _ in 1...Int.random(in: 1...Season.allCases.count) {
        let season = Season.allCases.randomElement()!
        if (!seasons.contains(season)) {
            seasons.append(season)
        }
    }
    return seasons
}

private func generateParagraph(numberOfWords: Int) -> String {
    var paragraph = ""
    for _ in 0..<numberOfWords {
        let word = generateRandomString(length: Int.random(in: 1...14))
        paragraph.append("\(word) ")
    }
    return paragraph
}

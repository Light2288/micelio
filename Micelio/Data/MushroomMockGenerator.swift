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

func generateMockMushroom(mushroomScientificName: String? = nil, mushroomCommonName: String? = nil) -> Mushroom {
    let scientificName = mushroomScientificName ?? generateRandomString(length: 12)
    let commonName = mushroomCommonName ?? generateRandomString(length: 12)
    let veryShortDescription = generateParagraph(numberOfWords: 5)
    let shortDescription = generateParagraph(numberOfWords: 10)
    let edibility = generateRandomEdibility()
    let environments = generateRandomEnvironments()
    let seasons = generateRandomSeasons()
    let description = generateParagraph(numberOfWords: 100)
    let environmentDescription = generateParagraph(numberOfWords: 40)
    let edibilityDescription = generateParagraph(numberOfWords: 50)
    let trivia = generateParagraph(numberOfWords: 80)
    let images = (0...9).map { "\(commonName)_\($0)" }
    
    return Mushroom(scientificName: scientificName, commonName: commonName, veryShortDescription: veryShortDescription, shortDescription: shortDescription, edibility: edibility, environments: environments, seasons: seasons, description: description, environmentDescription: environmentDescription, edibilityDescription: edibilityDescription, trivia: trivia, images: images)
}

private func generateRandomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      return String((0..<length).map{ _ in letters.randomElement()! })
}

private func generateRandomEdibility() -> Edibility {
    return Edibility.allCases.randomElement()!
}

private func generateRandomEnvironments() -> [MushroomEnvironment] {
    var environments: [MushroomEnvironment] = []
    for _ in 1...Int.random(in: 1...MushroomEnvironment.allCases.count) {
        let environment = MushroomEnvironment.allCases.randomElement()!
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

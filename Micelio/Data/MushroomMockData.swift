//
//  MushroomData.swift
//  Micelio
//
//  Created by Davide Aliti on 11/10/23.
//

import Foundation

var mushroomMockData: [Mushroom] {
    var data: [Mushroom] = []
    let porcino = generateMockMushroom(mushroomScientificName: "boletus edulis", mushroomCommonName: "porcino")
    data.append(porcino)
    data.append(amanitaGemmata)
    data.append(amanitaMuscaria)
    data.append(amanitaPhalloides)
    data.append(amanitaVerna)
    data.append(amanitaVirosa)
    data.append(boletusSatanas)
    data.append(cortinariusRubellus)
    data.append(entolomaSinuatum)
    data.append(gyromitraEsculenta)
    data.append(hypholomaFasciculare)
    data.append(lactariusScrobiculatus)
    data.append(omphalotusOlearius)
    data.append(paxillusInvolutus)
    data.append(ramariaFormosa)
    data.append(ramariaPallida)
    data.append(russulaEmetica)
    data.append(russulaFœtens)
    data.append(sclerodermaCitrinum)
    data.append(lepiotaCristata)
    data.append(contentsOf: generateMockMushroomArray(length: 20))
    
    return data
}

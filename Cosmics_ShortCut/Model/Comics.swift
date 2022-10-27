//
//  Comics.swift
//  Cosmics_ShortCut
//
//  Created by Caroline Klakegg on 21/10/2022.
//

import Foundation

// MARK: - ComicsItem
 struct Comics: Codable {
    let month: String
    let num: Int
    let link, year, news, safeTitle: String
    let transcript, alt: String
    let img: String
    let title, day: String

    enum CodingKeys: String, CodingKey {
        case month, num, link, year, news
        case safeTitle = "safe_title"
        case transcript, alt, img, title, day
    }
}



//DummyData
extension Comics {
    static var dummyComics: Comics? {
        let dummyComicsString = """
        {"month": "10",
        "num": 2689,
        "link": "",
        "year": "2022",
        "news": "",
        "safe_title": "Fermat's First Theorem", "transcript": "",
        "alt": "Mathematicians quickly determined that it spells ANT BNECN, an unusual theoretical dish which was not successfully cooked until Andrew Wiles made it for breakfast in the 1990s.",
        "img": "https://imgs.xkcd.com/comics/fermats_first_theorem.png",
        "title": "Fermat's First Theorem",
        "day": "24"}
        """
        if let jsonData = dummyComicsString.data(using: .utf8, allowLossyConversion: false) {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(Comics.self, from: jsonData)
                return response
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}

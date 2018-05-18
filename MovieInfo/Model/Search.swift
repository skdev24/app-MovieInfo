//
//  Search.swift
//  MovieInfo
//
//  Created by Shivam Dev on 15/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import Foundation


class SearchMovies: Decodable {
    var Search: [MovieDetail]
}

class MovieDetail: Decodable {
    var Title: String!
    var imdbID: String!
    var Poster: String!
}

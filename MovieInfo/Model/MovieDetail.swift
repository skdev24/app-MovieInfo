//
//  MovieDetail.swift
//  MovieInfo
//
//  Created by Shivam Dev on 15/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import Foundation


class MovieDetails: Decodable {
    var Title: String!
    var Genre: String!
    var Language: String!
    var Plot: String!
}

/*
 
 {
 Title: "The Social Network",
 Year: "2010",
 Rated: "PG-13",
 Released: "01 Oct 2010",
 Runtime: "120 min",
 Genre: "Biography, Drama",
 Director: "David Fincher",
 Writer: "Aaron Sorkin (screenplay), Ben Mezrich (book)",
 Actors: "Jesse Eisenberg, Rooney Mara, Bryan Barter, Dustin Fitzsimons",
 Plot: "Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, but is later sued by two brothers who claimed he stole their idea, and the co-founder who was later squeezed out of the business.",
 Language: "English, French",
 Country: "USA",
 Awards: "Won 3 Oscars. Another 165 wins & 168 nominations.",
 Poster: "https://ia.media-imdb.com/images/M/MV5BMTM2ODk0NDAwMF5BMl5BanBnXkFtZTcwNTM1MDc2Mw@@._V1_SX300.jpg",
 Ratings: [
 {
 Source: "Internet Movie Database",
 Value: "7.7/10"
 },
 {
 Source: "Rotten Tomatoes",
 Value: "96%"
 },
 {
 Source: "Metacritic",
 Value: "95/100"
 }
 ],
 Metascore: "95",
 imdbRating: "7.7",
 imdbVotes: "537,084",
 imdbID: "tt1285016",
 Type: "movie",
 DVD: "11 Jan 2011",
 BoxOffice: "$96,400,000",
 Production: "Columbia Pictures",
 Website: "http://www.thesocialnetwork-movie.com/",
 Response: "True"
 }
 
 */

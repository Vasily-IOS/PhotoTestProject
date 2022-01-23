//
//  Provider.swift
//  PhotoTestProject
//
//  Created by Василий on 23.01.2022.
//

import Foundation

final class FavouriteProvider {

    private init(){}

    static let shared = FavouriteProvider()

    var favourite: [Photo] = []

}

//
//  Intro.swift
//  010_Onboarding
//
//  Created by nikita on 17.10.2022.
//

import Foundation

struct Intro: Identifiable {
	var id: String = UUID().uuidString
	var imageName: String
	var title: String	
}

var intros: [Intro] = [
	.init(imageName: "Image 1", title: "Relax"),
	.init(imageName: "Image 2", title: "Cate"),
	.init(imageName: "Image 3", title: "Mood Dairy")
]

let sansBold = "WorkSans-Bold"
let sansSemiBold = "WorkSans-SemiBold"
let sansRegular = "WorkSans-Regular"

let dummyText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa."

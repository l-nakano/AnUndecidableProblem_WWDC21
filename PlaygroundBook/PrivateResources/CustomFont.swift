//
//  CustomFont.swift
//  PlaygroundBook
//
//  Created by Lucas Yoshio Nakano on 11/04/21.
//

import Foundation
import UIKit

let fontURL = Bundle.main.url(forResource: "Bangers-Regular", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
let font = UIFont(name: "Bangers-Regular", size: 30)!

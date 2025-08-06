//
//  File.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2025/08/06.
//

import Foundation

extension Bundle {
    public static var versionBuildString: (version: String, build: String)? {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
            let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            return (version, build)
        }
        return nil
    }
}

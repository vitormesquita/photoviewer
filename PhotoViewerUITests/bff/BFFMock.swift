//
//  BFFMock.swift
//  PhotoViewerUITests
//
//  Created by mano on 13/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import Swifter
@testable import PhotoViewer

class BFFMock {
   
   let server = HttpServer()
   let sleepTime: UInt32 = 2
   
   private func readJsonFile(name: String) throws -> Any {
      let path = Bundle(for: BFFMock.self).path(forResource: name, ofType: "json")
      
      let data = try Data(contentsOf: URL(fileURLWithPath: path ?? ""))
      let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
      
      return jsonResult
   }
   
   func start() {
      do {
         try server.start(3333)
      } catch {
         print("Failed to start server")
      }
   }
   
   func stop() {
      server.stop()
   }
}

extension BFFMock {
   
   @discardableResult
   func mockPhotosToNavigateToPhotosList() -> [[String: Any]]? {
      guard let jsonResponse = try? readJsonFile(name: "photos") else {
         return nil
      }
      
      let response: ((HttpRequest) -> HttpResponse) = { [weak self] _ in
         sleep((self?.sleepTime)!)
         return HttpResponse.ok(.json(jsonResponse as AnyObject))
      }
      
      server.GET["/photos?page=1"] = response
      return jsonResponse as? [[String: Any]]
   }
   
   @discardableResult
   func mockSearchPhotosSuccessResponse() -> [String: Any]? {
      guard let jsonResponse = try? readJsonFile(name: "searchPhotos") else {
         return nil
      }
      
      let response: ((HttpRequest) -> HttpResponse) = { [weak self] _ in
         sleep((self?.sleepTime)!)
         return HttpResponse.ok(.json(jsonResponse as AnyObject))
      }
      
      server.GET["/search/photos?page=1&query=Sky"] = response
      
      return jsonResponse as? [String: Any]
   }
   
   func mockSearchPhotosEmptyResponse() {
      guard let jsonResponse = try? readJsonFile(name: "searchPhotosEmpty") else { return }
      
      let response: ((HttpRequest) -> HttpResponse) = { [weak self] _ in
         sleep((self?.sleepTime)!)
         return HttpResponse.ok(.json(jsonResponse as AnyObject))
      }
      
      server.GET["/search/photos?page=1&query=lalalala"] = response
   }
}

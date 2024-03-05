//
//  APIService.swift
//  cuncurrency
//
//  Created by admin on 2024/02/25.
//

import Foundation


struct APIService {
  let urlString: String

  func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                             keyDecodingStrategy:JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws -> T {
    guard let url = URL(string: urlString) else {
      throw APIError.invalidURL
    }

    do {
      let (data, response) = try await URLSession.shared.data(from: url)
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw APIError.invalidResponseStatus("response status error")
      }
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = dateDecodingStrategy
      decoder.keyDecodingStrategy = keyDecodingStrategy
      do {
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
      } catch {
        throw APIError.decodingError(error.localizedDescription)
      }
    } catch {
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
}



enum APIError: Error, LocalizedError {
  case invalidURL
  case invalidResponseStatus(String)
  case dataTaskError(String)
  case corruptData
  case decodingError(String)

  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return NSLocalizedString("엔드포인트 이상함", comment: "")
    case .invalidResponseStatus(let string):
      return NSLocalizedString("호스트를 찾을수없음 - \(string)", comment: "")
    case .dataTaskError(let string):
      return string
    case .corruptData:
      return NSLocalizedString("데이터를 가져오는데 실패함", comment: "")
    case .decodingError(let string):
      return string
    }
  }
}




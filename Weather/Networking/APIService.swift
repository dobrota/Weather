//
//  APIService.swift
//  Weather
//
//  Created by Srdjan Dobrota on 16.3.25..
//

import Foundation

protocol DataFetcher {
    var session: URLSession { get }
    func request<T: Codable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void)
}

enum APIError: LocalizedError {
    case badRequest
    case decodingError
    case invalidData
    case invalidURLResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Bad request"
        case .decodingError:
            return "Check your response and model types"
        case .invalidData:
            return "Failed to get data"
        case .invalidURLResponse(url: let url):
            return "Invalid response from URL: \(url)"
        case .unknown:
            return "Unknown error occured"
        }
    }
}

struct APIClient: DataFetcher {
    let session: URLSession
    let baseURL = "https://api.openweathermap.org/data/2.5/group"
    let apiKey = "APIKey" //Please enter you API key here
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.badRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(APIError.invalidURLResponse(url: url)))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }.resume()
    }
    
    func urlBuilder(cityIds: String) -> URL {
        let queryItems = [URLQueryItem(name: "id", value: cityIds), URLQueryItem(name: "appid", value: apiKey), URLQueryItem(name: "units", value: "metric")]
        var urlComps = URLComponents(string: baseURL)!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
        print(result)
        return result
    }
}


import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let list: [CityWeather]
}

// MARK: - CityWeather
struct CityWeather: Codable {
    let sys: Sys
    let weather: [Weather]
    let main: Main
    let id: Int
    let name: String
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    var iconURL: String {
      "https://openweathermap.org/img/wn/\(icon).png"
    }
    var iconURL2x: String {
      "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

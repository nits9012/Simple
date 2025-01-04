// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class WebServiceRequest {
    
    public func request(path: String, onSuccess: @escaping ((_ data: Data,_ isSuccess: Bool) ->())) {
        guard let components = URLComponents(string: path) else {
            return
        }
        
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let res = response as? HTTPURLResponse else {
                return
            }
            
            guard 200..<300 ~= res.statusCode else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            onSuccess(data, true)
            
        }).resume()
    }
}

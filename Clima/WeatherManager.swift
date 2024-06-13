import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func updatedWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func failedWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c12537c72ca968a83216e1c8b042b327&units=imperial"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let stringURL = "\(weatherURL)&q=\(cityName)"
        performRequest(with: stringURL)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let stringURL = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: stringURL)
    }
    
    func performRequest(with stringURL: String) {
        if let url = URL(string: stringURL) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.failedWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.updatedWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let city = decodedData.name
            
            let weather = WeatherModel(conditionID: id, temperature: temp, cityName: city)
            return weather
        } catch {
            delegate?.failedWithError(error: error)
            return nil
        }
    }
    
}

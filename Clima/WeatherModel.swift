import Foundation

struct WeatherModel {
    
    let conditionID: Int
    let temperature: Double
    let cityName: String
    
    var conditionName: String {
        switch conditionID {
        case 200...202:
            return "cloud.bolt.rain"
        case 210...221:
            return "cloud.bolt"
        case 230...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...501:
            return "cloud.rain"
        case 502...504:
            return "cloud.heavyrain"
        case 511:
            return "cloud.sleet"
        case 520...521:
            return "cloud.rain"
        case 522...531:
            return "cloud.heavyrain"
        case 600...602:
            return "cloud.snow"
        case 611...613:
            return "cloud.sleet"
        case 615...622:
            return "cloud.snow"
        case 701...711:
            return "smoke"
        case 721...771:
            return "cloud.fog"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud.sun"
        }
    }
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
}

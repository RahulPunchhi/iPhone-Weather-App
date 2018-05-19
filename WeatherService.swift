import Foundation

protocol WeatherServiceDelegate {
    func setWeather(weather: Weather)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func getWeatherForCity(city: String){
        
        
        let cityEscaped = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        let path = "###"
        let url = URL(string: path)
        let session = URLSession.shared
        let task = session.dataTask(with: url!){(data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            let json =  JSON(data)
            
            let lon = json["coord"]["lon"].double
            let lat = json["coord"]["lat"].double
            let temp = json["main"]["temp"].double
            let name = json["name"].string
            let desc = json["weather"][0]["description"].string
            
            let weatherVal = Weather(cityName: name!, temp: (temp!-273).rounded(), description: desc!)
            
            if self.delegate != nil {
                
                DispatchQueue.main.async{
                    
                    self.delegate?.setWeather(weather: weatherVal)
                }
            }
            
            print("Lat: \(lat) lon: \(lon) temp: \(temp)")
        }
        
        task.resume()
        
    }
    
}

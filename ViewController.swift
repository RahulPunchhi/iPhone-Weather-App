import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {
    
    let weatherService = WeatherService()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBAction func setCityTapped(_ sender: UIButton) {
    
        print("city button tapped")
        openCityAlert()
    }
    
    func openCityAlert(){
        let alertVal = UIAlertController(title: "City",
                                      message: "Enter City Name",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertVal.addAction(cancel)
        
        let ok = UIAlertAction(title: "ok", style: UIAlertActionStyle.default) { (alert: UIAlertAction) in
            //print("ok")
            let textField = alertVal.textFields?[0]
            
            let cityName = textField?.text!
            self.cityLabel.text = cityName
            self.weatherService.getWeatherForCity(city: cityName!)
        }
        
        alertVal.addAction(ok)
        
        alertVal.addTextField { (textField) in
            textField.placeholder = "city name"
            
        }
        
        self.present(alertVal, animated: true, completion: nil)
    }
    
    
    func setWeather(weather: Weather) {
        
        cityLabel.text = weather.cityName
        tempLabel.text = "\(weather.temp)"
        descriptionLabel.text = weather.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherService.delegate = self
        
        let cityNameInitial = "Toronto"
        self.cityLabel.text = cityNameInitial
        self.weatherService.getWeatherForCity(city: cityNameInitial)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


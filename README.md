# ![Ambrosio logo](https://raw.githubusercontent.com/jchavarri/Ambrosio/master/Ambrosio/Assets.xcassets/knot%20tie.imageset/knot%20tie%402x.png) Ambrosio 
With Ambrosio, you can set up physical reminders for the tasks that you have available in your Redbooth account. These physical reminders are sent automatically, whenever you arrive or leave home. No more excuses!

## Installing Ambrosio

- Clone the repo
- Run `carthage update`
- Add the file `AuthDataManager.Config` to folder `Classes/Common/Services/Auth` with this content (replace the tags <> with your API configuration):
```
extension AuthDataManager {
    internal struct Config {
        internal static let redirectUri = "ambrosio://return-uri"
        internal static let clientId = "<your_redbooth_client_id>"
        internal static let clientSecret = "<your_redbooth_client_secret>"
    }
}
```
- Run the project

## How to test iBeacons

Once you have Ambrosio installed, you can simulate the iBeacon events by following these steps:

- Install the app [Locate Beacon](https://itunes.apple.com/es/app/locate-beacon/id738709014?mt=8) (from Radius Software) on one [compatible device](https://en.wikipedia.org/wiki/IBeacon#Compatible_devices). This device will simulate the real iBeacon that could be placed in the user’s house.
- Open Locate Beacon and enable the “Null Beacon” device, the one with all zeros as UDID. There’s no need of entering major and minor. You can trigger “Getting home” and “Leaving home” by using the switch. The change is applied immediately, so no need to press Save after changes


# ![Ambrosio logo](https://raw.githubusercontent.com/jchavarri/Ambrosio/master/Ambrosio/Assets.xcassets/knot%20tie.imageset/knot%20tie%402x.png) Ambrosio 
Ambrosio is an iOS app built with Swift, that uses iBeacons to help you set up "physical reminders" for your Redbooth tasks. 

##Features

- The "physical reminders" are iOS notifications, and they can be activated when you arrive or when you leave
- You can set them up individually for each task
- They are triggers automatically, even if the app is not opened, whenever you arrive or leave home. So no more excuses that you forgot that important document at home!

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

## Technical details

Ambrosio is my first Swift app. Some inner details about it:

- For Ambrosio, "home" means every iBeacon in the "Null Beacon" region, i.e. the UDID is all zeros
- Ambrosio adds a specific tag to the Redbooth description field to contain the alarm information. This tag looks like `[ambrosio]WhenArriving[/ambrosio]`
- The app architecture is very influenced by the VIPER principles. There are plenty of resources online but the ones I've visited more are:
  - Blog posts: [This one](https://www.objc.io/issues/13-architecture/viper/) from objc.io and [this other](https://medium.com/brigade-engineering/brigades-experience-using-an-mvc-alternative-36ef1601a41f) from Brigade
  - Github examples: [This one](https://github.com/objcio/issue-13-viper-swift/) (companion to the previous blog post) and [this other](https://github.com/mutualmobile/Counter). Both from Mutual Mobile
  - Helper: [Boa](https://github.com/team-supercharge/boa) is a simple gem to initialize VIPER projects and add modules to them. It helps you avoid all the boilerplate files and code
  - Video: [This video](https://www.youtube.com/watch?v=OX4rLAJC7lw) by the Redbooth Mobile Team

### TODO

- User can configure her specific beacons
- Better task management (complete tasks, filter, search)
- Add persistent storage
- i18n support
- Remove the dependency from RootWireframe
# Ambrosio
An iOS butler app that relies on Redbooth API

## Getting started

- Clone the repo
- Run `carthage update`
- Add the file `Redbooth.Config.swift` to folder `Classes/Common/Services/Redbooth` with this content (replace with your API configuration):
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

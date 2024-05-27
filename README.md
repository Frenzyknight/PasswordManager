# PasswordManager
A simple password manger written in Swift using Swift Data for storing data on device, AES encryption for password storage and Keychain to store relevant encryption keys.
To run the application you must install the following packages using SPM (Swift Package Manager): 

1. KeychainSwift - https://github.com/evgenyneu/keychain-swift.git
2. CustomTextField - https://github.com/esatgozcu/SwiftUI-Custom-TextField.git

After installing them simply build and run the above project in Xcode, the deployment target is set to 17.5, so change that according to your needs.
The app requires Face ID to unlock itself, following which you can add, delete, or edit your account passwords which are stored on device using Swift Data. Passwords are encrypted using AES encryption and the keys are stored securely in Apple's secure kechain storage using the package KeychainSwift and its helper functions.

import SwiftUI
import XiaomiBluetooth

struct ContentView: View {
    
    @EnvironmentObject
    var store: Store
    
    var body: some View {
        NavigationView {
            NearbyDevicesView()
        }
    }
}

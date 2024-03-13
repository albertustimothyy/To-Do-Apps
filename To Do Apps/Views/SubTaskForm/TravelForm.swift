//
//  TravelForm.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 04/03/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct TravelForm: View {
    @StateObject var locationManager: LocationManager = .init()
    @State private var showSheet = false
    
    @Binding var travelToDo: TravelToDo?
    @State var inputDestination : CLLocationCoordinate2D?
    @State private var locationName: String = ""

    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("Select location") {
                    self.showSheet.toggle()
                }
                
                Spacer()
                
                VStack {
                    if inputDestination != nil {
                            Text(locationName)
                        } else {
                            Text("")
                        }
                }
                .onAppear {
                    if let location = inputDestination {
                        convertLatLongToAddress(latitude: location.latitude, longitude: location.longitude)
                    }
                }
                .onChange(of: inputDestination) {
                    if let location = inputDestination {
                            convertLatLongToAddress(latitude: location.latitude, longitude: location.longitude)
                        }
                    }
                
            }
            .sheet(isPresented: $showSheet) {
                SearchLocation(inputDestination: $inputDestination, showSheet: $showSheet).environmentObject(locationManager)
                    .onChange(of: inputDestination) { newValue, _ in
                        travelToDo?.destination.latitude = newValue?.latitude ?? 120
                        travelToDo?.destination.longitude = newValue?.longitude ?? 120
                    }

            }
            
            HStack {
                DatePicker(
                    selection: Binding<Date>(
                        get: { travelToDo?.startDate ?? Date() },
                        set: { newStartDate in
                            if let endDate = travelToDo?.endDate, newStartDate > endDate {
                                travelToDo?.endDate = newStartDate
                            }
                            travelToDo?.startDate = newStartDate
                        }
                    ),
                    in: Date.now...,
                    displayedComponents: .date,
                    label: { Text("Start:") }
                )
                .font(.title3)
                .labelsHidden()
                
                Text("-").font(.title3)
                
                DatePicker(
                    selection: Binding<Date>(
                        get: { travelToDo?.endDate ?? Date(timeIntervalSinceNow: 86400) },
                        set: { newEndDate in
                            if let startDate = travelToDo?.startDate, newEndDate < startDate {
                                travelToDo?.startDate = newEndDate
                            }
                            travelToDo?.endDate = newEndDate
                        }
                    ),
                    in: Date()...,

                    displayedComponents: .date,
                    label: { Text("End:") }
                )
                .font(.title3)
                .labelsHidden()
            }


        }
    }
    
    func convertLatLongToAddress(latitude: Double, longitude: Double) {
         let geoCoder = CLGeocoder()
         let location = CLLocation(latitude: latitude, longitude: longitude)
         geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
             guard let placeMark = placemarks?.first, error == nil else {
                 print("Error: \(error?.localizedDescription ?? "Unknown Error")")
                 return
             }
             
             if let locationName = placeMark.name {
                 self.locationName = locationName
             } else {
                 self.locationName = "Unnamed Location"
             }
         }
     }
    
}

#Preview {
    @State var travelToDo: TravelToDo? = TravelToDo(name: "", description: "", done: false, destination: TravelToDo.Coordinates(latitude: 0, longitude: 0), startDate: Date(), endDate: Date(timeIntervalSinceNow: 86400))
    @State var inputDestination : CLLocationCoordinate2D?
    
    return Group {
        TravelForm(travelToDo: $travelToDo)

    }
}

//
//  SearchLocation.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 03/03/24.
//

import SwiftUI
import MapKit

struct SearchLocation: View {
    @EnvironmentObject var locationManager: LocationManager
    @State var showMap: Bool = false
    @Binding var inputDestination: CLLocationCoordinate2D?
    @Binding var showSheet: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName:  "magnifyingglass")
                    .foregroundStyle(Color.gray)
                
                TextField("Find Location", text: $locationManager.searchText)
            }
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(.gray)
            }
            
            if let places = locationManager.fetchedPlaces, !places.isEmpty {
                List {
                    ForEach(places, id: \.self) { place in
                        HStack (spacing: 15) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.gray)
                            Button {
                                if let coordinate = place.location?.coordinate {
                                    self.inputDestination = coordinate

                                    locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                    locationManager.mapView.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                    
                                    locationManager.addDraggablePin(coordinate: coordinate)
                                    locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                }
                                self.showMap.toggle()
                            } label: {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(place.name ?? "")
                                        .font(.title3.bold())
                                        .foregroundStyle(.primary)
                                    
                                    Text(place.locality ?? "")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                }.sheet(isPresented: $showMap, content: {
                    MapViewSelect(showMap: $showMap, inputDestination: $inputDestination, showSheet: $showSheet).environmentObject(locationManager)
                })
            } else {
                VStack {
                    Button {
                        if let coordinate = locationManager.manager.location?.coordinate {
                            
                            self.inputDestination = coordinate
                            locationManager.mapView.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                            
                            locationManager.addDraggablePin(coordinate: coordinate)
                            locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                        }
                        self.showMap.toggle()
                    } label: {
                        Label("Current Location", systemImage: "mappin.and.ellipse.circle.fill")
                            .font(.callout)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }.sheet(isPresented: $showMap, content: {
                    MapViewSelect(showMap: $showMap, inputDestination: $inputDestination, showSheet: $showSheet).environmentObject(locationManager)
                })
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    @StateObject var locationManager: LocationManager = .init()
    @State var inputDestination : CLLocationCoordinate2D?
    return Group {
        SearchLocation(inputDestination: $inputDestination, showSheet: .constant(true)).environmentObject(locationManager)
    }
}

struct MapViewSelect: View {
    @EnvironmentObject var locationManager: LocationManager
    @Binding var showMap: Bool
    @Binding var inputDestination: CLLocationCoordinate2D?
    @Binding var showSheet: Bool
    
    var body: some View {
        ZStack {
            MapViewHelper()
                .environmentObject(locationManager)
            if let place = locationManager.pickedPlaceMark {
                VStack {
                    Text("Confirm Location")
                        .font(.title2.bold())
                        .padding(.bottom, 12)
                    
                    HStack (spacing: 15) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.gray)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(place.name ?? "")
                                .font(.title3.bold())
                            
                            Text(place.locality ?? "")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        inputDestination = locationManager.pickedLocation?.coordinate
                        showMap.toggle()
                        showSheet.toggle()
                    } label: {
                        Text("Confirm Location")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.green)
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "arrow.right")
                                    .font(.title3.bold())
                                    .padding(.trailing)
                            }
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
            }
        }.overlay {
            VStack {
                HStack {
                    Button {
                        showMap.toggle()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("Back")
                            .font(.title2.bold())
                    }.tint(.blue)
                    Spacer()
                }
                Spacer()
            }.padding()
        }
        .onDisappear {
            locationManager.pickedLocation = nil
            locationManager.pickedPlaceMark = nil
            
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)
        }
    }
}

struct MapViewHelper: UIViewRepresentable {
    @EnvironmentObject var locationManager: LocationManager
    func makeUIView(context: Context) -> MKMapView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

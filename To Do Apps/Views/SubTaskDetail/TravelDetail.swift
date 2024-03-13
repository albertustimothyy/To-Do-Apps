//
//  TravelDetail.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 05/03/24.
//

import SwiftUI
import MapKit

struct TravelDetail: View {
    var travelToDo: TravelToDo
    @State var showMap: Bool = false
    
    var body: some View {
        
        HStack {
            Text("Destination")
            Spacer()
            Button {
                self.showMap.toggle()
            } label: {
                Text("Show in Map")
            }
            .sheet(isPresented: $showMap, content: {
                Map() {
                    Marker("destination", coordinate: CLLocationCoordinate2D(latitude: travelToDo.destination.latitude, longitude: travelToDo.destination.longitude))
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
            })
        }
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Travel'S Date:")
                    .font(.headline)
                Text("\(travelToDo.startDate.formatted(.dateTime.weekday().day().month().year())) - \(travelToDo.endDate.formatted(.dateTime.weekday().day().month().year()))")
                    .font(.callout)
            }
            Spacer()
        }
    }
    
}

//#Preview {
//    let todo: AnyToDo = ModelData().toDos[3]
//    
//    return Group {
//        if let travelToDo = todo.base as? TravelToDo {TravelDetail(travelToDo: travelToDo)}
//    }
//}

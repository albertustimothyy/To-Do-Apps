//
//  WorkDetail.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 05/03/24.
//

import SwiftUI

struct WorkDetail: View {
    var workToDo: WorkToDo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Project's Name:")
                    .font(.headline)
                Text(workToDo.project)
                    .font(.callout)
            }
            Spacer()
        }
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Hours Estimate:")
                    .font(.headline)
                Text("\(workToDo.hoursEstimate) Hours")
                    .font(.callout)
            }
            Spacer()
        }
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Deadline:")
                    .font(.headline)
                Text(workToDo.deadline.formatted(.dateTime.weekday().day().month().year()))
                    .font(.callout)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(backgroundType())
                    .clipShape(.capsule)
            }
            Spacer()
        }
    }
    
    func backgroundType() -> Color {
        let timeDifference = workToDo.deadline.timeIntervalSinceNow

        var backgroundColor: Color
        if timeDifference <= 86400 {
            backgroundColor = Color.red
        } else if timeDifference <= 259200 {
            backgroundColor = Color.yellow
        } else {
            backgroundColor = Color.green
        }
        return backgroundColor
    }
}

#Preview {
    let todo: AnyToDo = ModelData().toDos[2]
    
    return Group {
        if let workToDo = todo.base as? WorkToDo {WorkDetail(workToDo: workToDo)}
    }
}

//
//  DetailEditView.swift
//  Natalis
//
//  Created by Laura Edwards on 08/03/2023.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var data: DatesInfo.Data
    
    var body: some View {
        Form{
            Section(header: Text("Date Information")){
                
                //Event name
                TextField("Event name", text:$data.title)
                
                //Event date
                DatePicker(selection: $data.date, in: Date.now..., displayedComponents: .date) {
                    Text("Date of the event")
                }
                
                //Annually reccuring
                Toggle ("Annually reccuring", isOn: $data.reccuring)
                    .toggleStyle(SwitchToggleStyle(tint: data.theme))
            }
            
            Section(header: Text("Theme")){
                ZStack {
                    CustomColorPicker(selectedColor: $data.theme)
                        //.padding(.leading, 13.0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DatesInfo.sampleData[0].data))
    }
}

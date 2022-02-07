//
//  Home.swift
//  UI-451
//
//  Created by nyannyan0328 on 2022/02/06.
//

import SwiftUI

struct Home: View {
    
    @State var startAngle : Double = 0
    @State var toAngle : Double = 180
    
    @State var startProgress : CGFloat = 0
    @State var toProgress : CGFloat = 0.5
    
    var body: some View {
        VStack{
            
            
            HStack{
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Today")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                    
                    
                    Text("Good Morning")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.gray)
                    
                    
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                
                
                Button {
                    
                } label: {
                    
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }

                
            }
            
            
            sleepTimerSlider()
                .padding(.top,60)
            
            
            Button {
                
            } label: {
                
                Text("Start Sleep")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(Color("Blue"),in: RoundedRectangle(cornerRadius: 10))
                   
            }
            .padding(.top,60)
            
            
            
            HStack{
                
                let calendar = Calendar.current
                
                VStack(alignment:.leading,spacing: 10){
                    
                    Label {
                        
                        Text("BedTime")
                        
                    } icon: {
                        
                        Image(systemName: "moon.fill")
                    }
                    
                    Text(calendar.isDateInYesterday(getTime(angle: startAngle)) ? "YesterDay" : "Today")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    
                    Text(getTime(angle:startAngle).formatted(date: .omitted, time: .shortened))
                    
                    

                    
                    
                    
                }
                .frame(maxWidth: .infinity)
                
                
                
                VStack(alignment:.leading,spacing: 10){
                    
                    Label {
                        
                        Text("Wake Up")
                        
                    } icon: {
                        
                        Image(systemName: "alarm")
                    }
                    
                    Text(calendar.isDateInYesterday(getTime(angle: toAngle)) ? "Tomorrow" : "Today")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    
                    Text(getTime(angle:toAngle).formatted(date: .omitted, time: .shortened))
                    
                    
                    

                    
                    
                    
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
           
            .background(.gray.opacity(0.3),in: RoundedRectangle(cornerRadius: 10))
            .padding(.top,60)
            
            
            
            
            
            
            
            

                
            
            
        }
        .padding()
        .frame(maxHeight: .infinity,alignment: .top)
    }
    
    @ViewBuilder
    func sleepTimerSlider()->some View{
        
        
     
        GeometryReader{proxy in
            
            let size = proxy.size.width
            
            ZStack{
                
                
                
                ZStack{
                    
                    ForEach(1...60,id:\.self){index in
                        
                        
                        Rectangle()
                            .fill(index % 5 == 0 ? .black : .gray)
                            .frame(width: 3, height: index % 5 == 0 ? 15 : 2)
                            .offset(y: (size - 60) / 2)
                            .rotationEffect(.init(degrees: Double(index) * 6))
                        
                    }
                        
                        
                        let texs = [6,7,8,9,10,11,12,1,2,3,4,5]
                        
                        
                        ForEach(texs.indices,id:\.self){index in
                            
                            
                            Text("\(texs[index])")
                                .font(.caption.weight(.light))
                                .rotationEffect(.init(degrees: Double(index) * -30))
                                .offset(y: (size - 90) / 2)
                                .rotationEffect(.init(degrees: Double(index) * 30))
                            
                            
                            
                            
                        }
                   
                    
                    
                }
                
                
                Circle()
                    .stroke(.black.opacity(0.3),lineWidth: 40)
                
                
                let reveceRotation = (startProgress > toProgress) ? -Double((1 - startProgress) * 360) : 0
 
                Circle()
                    .trim(from: startProgress > toProgress ? 0 : startProgress, to: toProgress + (-reveceRotation / 360))
                    .stroke(Color("Blue"),style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reveceRotation))
                
                
                Image(systemName: "moon.fill")
                    .font(.callout)
                    .foregroundColor(Color("Blue"))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -startAngle))
                    .background(.white,in: Circle())
                    .offset(x: (size / 2))
                    .rotationEffect(.init(degrees: startAngle))
                    .gesture(
                    
                        DragGesture().onChanged({ value in
                            
                            onDrage(value: value, fromSlider: true)
                            
                        })
                    
                    
                    )
                    .rotationEffect(.init(degrees: -90))
                
                
                
                Image(systemName: "alarm")
                    .font(.callout)
                    .foregroundColor(Color("Blue"))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -toAngle))
                    .background(.white,in: Circle())
                    .offset(x: (size / 2))
                    .rotationEffect(.init(degrees: toAngle))
                    .gesture(
                    
                        DragGesture().onChanged({ value in
                            
                            onDrage(value: value)
                            
                        })
                    
                    
                    )
                    .rotationEffect(.init(degrees: -90))
                
                
                VStack(spacing:10){
                    
                    Text("\(getTimeDiffrence().0)H")
                        .font(.largeTitle.weight(.bold))

                    Text("\(getTimeDiffrence().1)min")
                        .foregroundColor(.gray)
                }
                .scaleEffect(1.1)//大きすぎると何かの関係でずれる
                    
                
                
                
                
            }
            
            
            
            
            
        }
        .frame(width: getRect().width / 1.6, height: getRect().width / 1.6)
        
        
    }
    
    func onDrage(value : DragGesture.Value,fromSlider : Bool = false){
        
        
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        let radius = atan2(vector.dy - 15, vector.dx - 15)
        
        
        var angle = radius * 180 / .pi
        
        
        if angle < 0 {angle = 360 + angle}
        
        
        let progress = angle / 360
        
        
        if fromSlider{
            
            
            self.startAngle = angle
            self.startProgress = progress
            
            
            
        }
        else{
            
            self.toAngle = angle
            self.toProgress = progress
            
            
            
            
        }
        
        
        
    }
    

    func getTime(angle : Double) -> Date{


        let progress = angle / 15


        let hour = Int(progress)


        let remainder = (progress.truncatingRemainder(dividingBy: 1) * 12).rounded()


        var minute = remainder * 5

        minute = (minute > 55 ? 55 : minute)


        let formatted = DateFormatter()

        formatted.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let calendar = Calendar.current

        let components  = calendar.dateComponents([.month,.day,.year], from: Date())

        let rawDay = (components.day ?? 0)

        var day : Int = 0


        if angle == toAngle{

            day = (hour == 24 ? rawDay + 1 : ((startAngle > toAngle) && (hour < 12 && calendar.isDateInToday(getTime(angle: startAngle))) ? rawDay + 1 : rawDay))


        }

        else{


            day = (startAngle > toAngle && hour > 12 && hour < 24) ? rawDay - 1 : rawDay
        }


        if let data = formatted.date(from: "\(components.year ?? 0)-\(components.month ?? 0)-\(day) \(hour == 24 ? 0 : hour):\(Int(minute)):00"){



            return data
        }

        return .init()








    }

    func getTimeDiffrence()-> (Int,Int){


        let calendar = Calendar.current

        let result = calendar.dateComponents([.hour,.minute], from: getTime(angle: startAngle),to: getTime(angle: toAngle))

        return (result.hour ?? 0,result.minute ?? 0)
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}

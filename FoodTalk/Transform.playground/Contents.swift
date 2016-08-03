//: Playground - noun: a place where people can play

var restaurant = ["One Tree Grill","Depot","Volare Restaurant","The Grove","Prego Restaurant","The French Cafe","Clooney","Taiko Restaurant","Ebisu","The Engine Room","Tides Restaurant & Cafe","Chand Indian Restaurant Torbay","Nite Spice Indian Restaurant","Khun Pun Thai Restaurant","Tony's Lord Nelson Restaurant","The Spice Rack Indian Kitchen","The Grill by Sean Connolly","Oh Calcutta","Tony's Original Steak & Seafood Restaurant","Vivace Restaurant","Al Forno Italian Restaurant"]

var restaurantPhoto = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]

var restaurantLocation = ["香港", "香港", "香港", "香港", "香港", "香港", "香港", "悉尼", "悉尼", "悉尼", "纽约", "纽约", "纽约", "纽约", "纽约", "纽约", "纽约", "伦敦", "伦敦", "伦敦", "伦敦"]

var restaurantType = ["咖啡 & 茶店","咖啡", "茶屋", "奥地利式 & 休闲饮料","法式", "面包房", "面包房", "巧克力", "咖啡", "美式 & 海鲜", "美式", "美式","早餐 & 早午餐", "法式 & 茶", "咖啡 & 茶", "拉丁美式", "西班牙式", "西班牙式", "西班牙式", "英式", "泰式"]

var restaurantVisited = [Bool](count:21, repeatedValue:false)

for i in 0..<restaurant.count {
    
    print("Restaurant(name: \"\(restaurant[i])\", type: \"\(restaurantType[i])\", location: \"\(restaurantLocation[i])\", image: \"\(restaurantPhoto[i])\", isVisited: \(restaurantVisited[i]))",",")
}


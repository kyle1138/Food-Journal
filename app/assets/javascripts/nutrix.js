
// var calorimeter = d3.select("#calorimeter");
// calorimeter.attr('width' ,  '50');
// calorimeter.attr('height' ,  totalPercent);
// calorimeter.attr('background' , "#21de21" );

var svg = d3.select('svg');
var body = document.querySelector("body");
var foodToFind = document.getElementById("foodToFind");
var get = document.getElementById("get");
var create = document.getElementById("create");
var menu = document.getElementById("menu");
var nInfo = document.getElementById("nutrionalInfo");
var foodReceived = document.getElementById("foodReceived");
var qtyBox = document.getElementById("qty");
var dateSpan = document.getElementById("dateSpan");



var foodName = "";
var cFat = 0;
var cCar = 0;
var cPro = 0;
var cTotal = 0;
var sizeInG = 0;
get.addEventListener("click" , function(){
  var xhr = new XMLHttpRequest;
  var item = encodeURI(foodToFind.value);
  // itemRequest["query"] = item;
  console.log(item);
  var railsUrl = "/food_journals/5?food=" + item;
  var url = urlOne + item + urlTwo;
  xhr.open("GET" , railsUrl);
  xhr.addEventListener("load" , function(){
    var menuCounter = 0;
    menu.innerHTML = "";
    nInfo.innerHTML = "";
    var res = JSON.parse(xhr.responseText);

    res["hits"].forEach(function(hit){
      if(hit["fields"]["nf_serving_weight_grams"]){

      console.log(hit["fields"]["item_name"]);
      var hitLi = document.createElement("li");
      hitLi.id = "menuItem" + menuCounter;
      hitLi.innerHTML = hit["fields"]["item_name"] + '<hr>';
      menu.appendChild(hitLi);
      hitEvent = document.getElementById("menuItem" + menuCounter);
      hitEvent.addEventListener("click" , function(){
        var fiber = hit["fields"]["nf_dietary_fiber"];
        cPro = parseFloat(hit["fields"]["nf_protein"]) * 4.0;
        cCar = (parseFloat(hit["fields"]["nf_total_carbohydrate"]) - fiber) * 4.0;
        cFat = parseFloat(hit["fields"]["nf_total_fat"]) * 8.9;
        cTotal = cPro + cCar + cFat;
        var cPerG = hit["fields"]["nf_calories"]/res["hits"][0]["fields"]["nf_serving_weight_grams"];
        foodName = hit["fields"]["item_name"]
        sizeInG = hit["fields"]["nf_serving_weight_grams"];
        nInfo.innerHTML = foodName + "<br>serving size in grams:" + sizeInG + "<br>Calories: " + hit["fields"]["nf_calories"] + "<br>Protein: " + hit["fields"]["nf_protein"]
        + "<br>Carbohydrates: " + hit["fields"]["nf_total_carbohydrate"] + "<br> Fat: " + hit["fields"]["nf_total_fat"];
        var pPer = cPro/cTotal;
        var cPer = cCar/cTotal;
        var fPer = cFat/cTotal;

        var per = cPer+pPer+fPer;
        calPie = [pPer, cPer, fPer];
        console.log(res);
        console.log(per);
        console.log(cPro);
        console.log(cCar);
        console.log(cFat);
        console.log(cTotal);
        console.log(cPer);
        console.log(pPer);
        console.log(fPer);
        console.log(cPerG);
        console.log(sizeInG);
        console.log(foodName);

        var arc = d3.svg.arc()
        .outerRadius(radius - 150)
        .innerRadius(radius - 200);

        var littlePie = d3.layout.pie()
        .value(function(d) { return d; });

        var svg = d3.select("svg").append("g")
        .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

        calPie.forEach(function(d) {
          d= +d;
        });

        var g = svg.selectAll(".arc")
        .data(pie(calPie))
        .enter().append("g")
        .attr("class", "arc");

        g.append("path")
        .attr("d", arc)
        .style("fill", function(d,i) { return color(i); });

        })
        // remove this line its for testing the api on do
        // nInfo.innerHTML = res;
        menuCounter = menuCounter + 1;
      }
      })

    })

  xhr.send();

})


var urlOne = "https://api.nutritionix.com/v1_1/search/";
var urlTwo = "?item_type=3&results=0%3A20&cal_min=0&cal_max=5000&fields=item_name%2Cnf_dietary_fiber%2Cbrand_name%2Cnf_calories%2Cnf_serving_size_qty%2Cnf_serving_size_unit%2Cnf_total_fat%2Cnf_total_carbohydrate%2Cnf_protein%2Cnf_serving_weight_grams%2Citem_id%2Cbrand_id&appId=bdcc47ce&appKey=e53cc81b43727bf30f6ffb0a54ab80a8"

width = 400,
height = 400,
radius = 200;
// appends the pie chart on load
var color = d3.scale.ordinal()
.range(["#98abc5", "#a05d56","#ff8c00" , "#aade99"]);

var arc = d3.svg.arc()
.outerRadius(radius - 60)
.innerRadius(radius - 120);

var pie = d3.layout.pie()
.value(function(d) { return d; });

var svg = d3.select("svg").append("g")
.attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

calPie.forEach(function(d) {
  d= +d;
});

var g = svg.selectAll(".arc")
.data(pie(calPie))
.enter().append("g")
.attr("class", "arc");

g.append("path")
.attr("d", arc)
.style("fill", function(d,i) { return color(i); });


create.addEventListener("click" , function(){
  var xhr = new XMLHttpRequest;
  var q = parseFloat(qtyBox.value) / sizeInG;
  // {body:{recipe: {name: r_name, ingredients: r_ingr, instructions: r_inst}}}
  var foodToSend = {food_journal :{food:foodName , qty:parseFloat(qtyBox.value) , cals: cTotal * q, fat: cFat*q, carbs: cCar * q , protein: cPro * q, user_id: user}};
  if(dateSpan){
  url = '/food_journals?date=' + dateSpan.innerText;
}else{
  url = '/food_journals'
};
  xhr.open("POST" , url);
  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  xhr.addEventListener("load" , function(){

    foodReceived.innerHTML = xhr.responseText;


  })
  console.log(url);
  xhr.send(JSON.stringify(foodToSend));

  var g = svg.selectAll(".arc")
  .data(pie(calPie))
  .enter().append("g")
  .attr("class", "arc");

  g.append("path")
  .attr("d", arc)
  .style("fill", function(d,i) { return color(i); });
})


var svg = d3.select('svg');
var body = document.querySelector("body");
var foodToFind = document.getElementById("foodToFind");
var get = document.getElementById("get");
var create = document.getElementById("create");
var menu = document.getElementById("menu");
var qtyBox = document.getElementById("qty");
var calPie = [33,33,34];
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
  var url = urlOne + item + urlTwo;
  xhr.open("GET" , url);
  xhr.addEventListener("load" , function(){
    var menuCounter = 0;
    var res = JSON.parse(xhr.responseText);
    var res["hits"].forEach(function(hit){
      var hitLi = document.createElement(li);
      hitLi.id = "menuItem" + menuCounter;
      hitLi.innertText = hit["fields"]["item_name"];
      menu.appendChild(hitLi);

    })
    var fiber = res["hits"][0]["fields"]["nf_dietary_fiber"];
    cPro = parseFloat(res["hits"][0]["fields"]["nf_protein"]) * 4.0;
    cCar = (parseFloat(res["hits"][0]["fields"]["nf_total_carbohydrate"]) - fiber) * 4.0;
    cFat = parseFloat(res["hits"][0]["fields"]["nf_total_fat"]) * 8.9;
    cTotal = cPro + cCar + cFat;
    var cPerG = res["hits"][0]["fields"]["nf_calories"]/res["hits"][0]["fields"]["nf_serving_weight_grams"];
    foodName = res["hits"][0]["fields"]["item_name"]
    sizeInG = res["hits"][0]["fields"]["nf_serving_weight_grams"];
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

    calPie.forEach(function(d) {


    g = g.data(pie(calPie))
    .enter().append("g")
    .attr("class" , "arc");

    pie = d3.layout.pie()
    .value(function(d) { return d; });

    g.append("path")
    .attr("d", arc)
    .style("fill", function(d,i) { return color(i); });


    });

    g.append("path")
    .attr("d", arc)
    .style("fill", function(d,i) { return color(i); });


  })

  xhr.send();


})


var urlOne = "https://api.nutritionix.com/v1_1/search/";
var urlTwo = "?item_type=3&results=0%3A20&cal_min=0&cal_max=50000&fields=item_name%2Cnf_dietary_fiber%2Cbrand_name%2Cnf_calories%2Cnf_serving_size_qty%2Cnf_serving_size_unit%2Cnf_total_fat%2Cnf_total_carbohydrate%2Cnf_protein%2Cnf_serving_weight_grams%2Citem_id%2Cbrand_id&appId=bdcc47ce&appKey=e53cc81b43727bf30f6ffb0a54ab80a8"

width = 600,
height = 500,
radius = 200;

var color = d3.scale.ordinal()
.range(["#98abc5", "#a05d56","#ff8c00" , "#21de21"]);

var arc = d3.svg.arc()
.outerRadius(radius - 50)
.innerRadius(0);

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



d3.select("button").on("click" , function(){
});

create.addEventListener("click" , function(){
  var xhr = new XMLHttpRequest;
  var q = parseFloat(qtyBox.value) / sizeInG;
  // {body:{recipe: {name: r_name, ingredients: r_ingr, instructions: r_inst}}}
  var foodToSend = {food_journal :{food:foodName , qty:q , cals: cTotal * q, fat: cFat*q, carbs: cCar * q , protein: cPro * q,user_id:user}};
  xhr.open("POST" , '/food_journals');
  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  console.log(foodToSend);
  xhr.send(JSON.stringify(foodToSend));
})

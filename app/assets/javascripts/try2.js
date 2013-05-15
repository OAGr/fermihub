var width = 960,
    height = 500;

var color = d3.scale.category20();

var force = d3.layout.force()
    .charge(-120)
    .linkDistance(30)
    .size([width, height]);

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);

d3.json("/nodes.json", function(error, nodes1) {
  nodes = nodes1;
  d3.json("/edges.json", function(error, edges1) {
    edges = edges1;
    alert(edges);
    alert("hi")
  });
});

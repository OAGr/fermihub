// set up SVG for D3
var width  = 550,
height = 500,
colors = d3.scale.category10();

var svg = d3.select('.graph')
.append('svg')
.attr('width', width)
.attr('height', height);

// set up initial nodes and links
//  - nodes are known by 'id', not by index in array.
//  - reflexive edges are indicated on the node (as a bold black circle).
//  - links are always source < target; edge directions are set by 'left' and 'right'.

d3.json("/nodes.json", function(error, json1) {
  lastNodeId = "2",
  nodes1 = json1;
  d3.json("/edges.json", function(error, json2) {
    links = json2,
    nodes = json1;
    console.log(nodes);
    console.log(nodes1);
    $.each(links, function(i,item){ 
      links[i].source = $.grep(nodes, function(e){ return e.id == links[i].source})[0];
      links[i].target = $.grep(nodes, function(e){ return e.id == links[i].target})[0];
    });

    // init D3 force layout
    var force = d3.layout.force()
    .nodes(nodes)
    .links(links)
    .size([width, height])
    .linkDistance(60)
    .charge(-500)
    .on('tick', tick)

    // define arrow markers for graph links
    svg.append('svg:defs').append('svg:marker')
    .attr('id', 'end-arrow')
    .attr('viewBox', '0 -5 10 10')
    .attr('refX', 14)
    .attr('markerWidth', 10)
    .attr('markerHeight', 10)
    .attr('orient', 'auto')
    .append('svg:path')
    .attr('d', 'M0,-5L10,0L0,5')
    .attr('fill', '#000');

    svg.append('svg:defs').append('svg:marker')
    .attr('id', 'start-arrow')
    .attr('viewBox', '0 -5 10 10')
    .attr('refX', 4)
    .attr('markerWidth', 3)
    .attr('markerHeight', 3)
    .attr('orient', 'auto')
    .append('svg:path')
    .attr('d', 'M10,-5L0,0L10,5')
    .attr('fill', '#000');

    // handles to link and node element groups
    var path = svg.append('svg:g').selectAll('path'),
    circle = svg.append('svg:g').selectAll('g');

    // mouse event vars
    var selected_node = null,
    selected_link = null,
    mouseup_node = null;


    // update force layout (called automatically each iteration)
    function tick() {
      // draw directed edges with proper padding from node centers
      path.attr('d', function(d) {
        var deltaX = d.target.x - d.source.x,
        deltaY = d.target.y - d.source.y,
        dist = Math.sqrt(deltaX * deltaX + deltaY * deltaY),
        normX = deltaX / dist,
        normY = deltaY / dist,
        sourcePadding = d.left ? 17 : 12,
        targetPadding = d.right ? 17 : 12,
        sourceX = d.source.x + (sourcePadding * normX),
        sourceY = d.source.y + (sourcePadding * normY),
        targetX = d.target.x - (targetPadding * normX),
        targetY = d.target.y - (targetPadding * normY);
        return 'M' + sourceX + ',' + sourceY + 'L' + targetX + ',' + targetY;
      });

      circle.attr('transform', function(d) {
        return 'translate(' + d.x + ',' + d.y + ')';
      });
    }

    // update graph (called when needed)
    function restart() {
      // path (link) group
      path = path.data(links);

      // update existing links
      path.classed('selected', function(d) { return d === selected_link; })
      .style('marker-start', function(d) { return d.left ? 'url(#start-arrow)' : ''; })
      .style('marker-end', function(d) { return d.right ? 'url(#end-arrow)' : ''; });


      // add new links
      path.enter().append('svg:path')
      .attr('class', 'link')
      .classed('selected', function(d) { return d === selected_link; })
      .style('marker-start', function(d) { return d.left ? 'url(#start-arrow)' : ''; })
      .style('marker-end', function(d) { return d.right ? 'url(#end-arrow)' : ''; })

      // remove old links
      path.exit().remove();


      // circle (node) group
      // NB: the function arg is crucial here! nodes are known by id, not by index!
      circle = circle.data(nodes, function(d) { return d.id; });

      // add new nodes
      var g = circle.enter().append('svg:g');

      g.append('svg:circle')
      .attr('class', 'node')
      .attr('r', function(d){
        if (d.klass === "O")
          {
            return "12"; 
          }

          else {
            return "23";
          }
      }
           )
      .style('fill', function(d) {
        if (d.type === "Dependent")
          {
            return"#f6f6f6" ;
          }
          else if (d.type === "Independent"){
            return "#e8f3ff"; 
          }
          else {
            return "#f77";
          }
      })
      .classed('reflexive', function(d) { return d.reflexive; })


      // show node IDs
      g.append('svg:text')
      .attr('x', 0)
      .attr('y', function(d){
        if (d.klass === "O")
          {
            return 4; 
          }

          else {
            return -2;
          }
      })
      .attr('class', 'id')
      .text(function(d) { return d.name; });
      g.append('svg:text')
      .attr('x', 0)
      .attr('y', 12)
      .attr('class', 'id')
      .text(function(d) { return d.mean; });


      // remove old nodes
      circle.exit().remove();

      // set the graph in motion
      force.start();
    }

    function spliceLinksForNode(node) {
      var toSplice = links.filter(function(l) {
        return (l.source === node || l.target === node);
      });
      toSplice.map(function(l) {
        links.splice(links.indexOf(l), 1);
      });
    }


    // app starts here
    d3.select(window)
    restart();

  });
});

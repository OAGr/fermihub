
  $.getJSON("/nodes.json").done(function(data){
     nodes = data;
  });

  $.getJSON("/edges.json").done(function(data){
     links = data;
  });

  var lastNodeId = 2;
  var links = [
    {source: nodes[0], target: nodes[1], left: false, right: true },
    {source: nodes[1], target: nodes[2], left: false, right: true }
  ];

$.getJSON("/nodes.json").done(function(data){
  nodes = data;
  $.getJSON("/edges.json").done(function(data){
    links = data;
    $.each(links, function(i,item){ 
      links[i].source = $.grep(nodes, function(e){ return e.id == links[i].source})[0];
      links[i].target = $.grep(nodes, function(e){ return e.id == links[i].target})[0];
    });
    nodes = [
      {id: 'supman', reflexive: false},
      {id: 1, reflexive: true },
      {id: 2, reflexive: false}
    ],
    lastNodeId = 2,
    links = [
      {source: nodes[0], target: nodes[1], left: false, right: true },
      {source: nodes[1], target: nodes[2], left: false, right: true }
    ];
    restart()
  });
});


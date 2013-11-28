var template;


var period_label = {"1": "< 1800",
"2":"1801-1850",
"3":"1851-1914",
"5": "1915-1939",
"6":"1940-1967",
"7":"1968-1975",
"8":"1976-1981",
"9":"1982-1989",
"10":"1990-1999",
"11": "2000 >=",
"0": "unknown"};

visualize_list_clusters = function(clusters){
  nb = Math.min(300, clusters.length);
  html ="";
  $("#clusters").empty();
  // 1 and not 0 , to remove the centroid
  for (var i  = 0 ; i < nb ; i++){
    cluster = clusters[i];
    console.log(cluster);
    cluster.id = i+1;
     html = _.template(template,{exp: experiment_name, cluster: cluster});
    $("#clusters").append(html);
  }
}





function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

$(function() {
  // load templates
  template = $("#list_cluster_template").html();

  experiment_name = getParameterByName('experiment');
   console.log(experiment_name);
  if (experiment_name == '') {
    experiment_name = 'exp1';
  }
  matching = experiment_name.match(/exp_one_vs_all_period(\d+)/);
  if (matching != null)
   given_period = period_label[matching[1]];
  else{
    given_period ='unknown';
  }
  $("#experiment_id").html("Experiment : "+experiment_name);
  $("#period_id").html(given_period);

  console.log(experiment_name);

  $.getJSON("../results/"+experiment_name+"/cooccurrence/clustering.json", function(_clusters) {
    clusters = _clusters;  
    visualize_list_clusters(clusters);
  });
});
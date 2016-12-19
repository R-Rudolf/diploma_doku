db.getCollection('links').aggregate([
//      //unwrap hop measurements and save hop number
//     {$unwind:{
//         path: "$links",
//         includeArrayIndex: "hop",
//     }},

//      //get only last hop measurement
    {$project:{last: {$slice:["$links", -1, 1]}}}, //count:30792
    {$unwind:"$last"},

//     {$project:{link_max_hop:{$size:"$links"}}}, // count: 34667
    
//      // Filter measurements with interval
//     {$match:{$and:[
//         {"links.rtt":{$gt:-0.01}}, 
//         {"links.rtt":{$lt:0.01}}
//     ]}},
//     {$match:{"links.rtt":0.0}},
    
//     {$sort: {"datetime":1}},
    
//      //Extract measurement results
//     {$project:{
//         rtt:"$last.rtt",
//         delay:"$last.delay",
//         jitter:"$last.jitter",
//     }},
    
//     {$limit: 5},
//     {$out:"to_export"},
    {$count: "count"}
])
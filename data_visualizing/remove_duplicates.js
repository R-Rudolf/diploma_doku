db.runCommand({
    aggregate: "links",
    pipeline: [
        //{ $limit : 5 },
        { $group : { _id : "$datetime", datetime: {$first: "$datetime"}, to: {$first: "$to"}, from: {$first: "$from"}, links: {$first: "$links"} }},
        { $out: "links1" }
    ],
    allowDiskUse: true
})
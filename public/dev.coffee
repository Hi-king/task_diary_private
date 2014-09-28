toYYMMDD = (date)->
    yy = "#{date.getFullYear()}"[-2..]
    mm = "00#{date.getMonth()+1}"[-2..]
    dd = "00#{date.getDay()+1}"[-2..]
    yy+mm+dd

$ ()->
    d3.tsv '/worklog.tsv', (error, data)->
        schedule_ary = {}
        data.map (item)->
            item.start = new Date(item.start)
            item.end = new Date(item.end)
        data.forEach (item)->
            schedule_ary[toYYMMDD(item.start)] = []
        data.forEach (item)->
            schedule_ary[toYYMMDD(item.start)].push(item)

        console.log schedule_ary
        rows = []
        for datestr, values of schedule_ary
            console.log datestr
            console.log values
            schedule = values.map (data)-> {
                start: data.start.toLocaleTimeString()[..5],
                end: data.end.toLocaleTimeString()[..5],
                text: data.event,
                data: {}
                }

            values.forEach (data) ->
                console.log "#{data.start.toLocaleTimeString()[..5]} - #{data.end.toLocaleTimeString()[..5]}"
            rows.push {
                title: datestr,
                schedule: schedule
                }
            console.log schedule

        $schedule = $("#schedule").timeSchedule({
            startTime: "10:00", # schedule start time(HH:ii)
            endTime: "24:00",   # schedule end time(HH:ii
            widthTime: 300,
            timeLineY: 60,
            verticalScrollbar: 20,
            timeLineBorder:2,   # border(top and bottom)
            debug:"#debug",     # debug string output elements
            rows : rows
        })

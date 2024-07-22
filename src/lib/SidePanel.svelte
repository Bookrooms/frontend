<script lang="ts">
    import RoomItem from '$lib/RoomItem.svelte'
    import TimePicker from '$lib/TimePicker.svelte'
    import DatePicker from '$lib/DatePicker.svelte'
    import filter_ico from '$assets/filter.png'
    import { onMount, beforeUpdate } from 'svelte';
    import { sel_building, sel_floor } from './stores';


    import { DateTime } from "luxon";

    function check_undefined(arr: Array<any>) {
        for (let i = 0; i < arr.length; i++) {
            if (typeof arr[i] == 'undefined')
                return false
        }
        return true
    }

    let rooms_cont: HTMLDivElement;
    let timeline_scroll = 0;

    let fetch_rooms_dep = 0;
    $: is_rooms_scrollable = is_scrollable(rooms_cont, fetch_rooms_dep)
    
    function is_scrollable(elem: HTMLDivElement, _deps?: any) {
        if (elem)
            return elem.scrollHeight > elem.clientHeight || elem.scrollWidth > elem.clientWidth;
        return false
    }

    async function fetch_room_types() {
        const rp = await fetch("https://bookrooms.gladov.ru/api/roomTypes", {
            method: 'GET'
        })
        return await rp.json()
    }

    let sel_date: DateTime // mandatory
    let sel_start_tm: DateTime // can be disabled
    let sel_end_tm: DateTime // can be disabled
    let sel_type: number // can be disabled (= -1)
    // sel_floor // can be disabled (= -1)
    // sel_building // can be disabled (= -1)

    let start_tm_enabled = true

    function convert_datetime(date: DateTime, time: DateTime) {
        if (!check_undefined([date, time])) return DateTime.now()
        return DateTime.fromObject({
            year: date.year,
            month: date.month,
            day: date.day,
            hour: time.hour,
            minute: time.minute,
            second: 0
        })
    }

    async function fetch_rooms(date: DateTime, start_time: DateTime, end_time: DateTime, 
                                type: number, floor: number, building: number, _deps?: any) {
        if (!check_undefined([date, start_time, end_time, type, floor, building])) return []

        let data = {
            userId: 1,
            mustBeAvailable: "false"
        }
        
        if (start_tm_enabled) {
            data.timeStart = convert_datetime(date, start_time).toISO()
            data.timeEnd = convert_datetime(date, end_time).toISO()
            data.mustBeAvailable = "true"
        }
        if (type != -1) data.roomTypeId = type
        
        if (building != -1) data.buildingId = building
        
        if (floor != -1) data.floor = floor
        
        console.log(data);
        
        const params = new URLSearchParams(data).toString();
        
        const rp = await fetch(`https://bookrooms.gladov.ru/api/rooms?${params}`, {
            method: 'GET',
        })
        const resp = await rp.json()
        console.log(resp);
        
        return resp
    }

</script>

<div class="cont">
    <h1 class="fondamento-regular logo-text">Bookrooms</h1>
    <div class="filter-cont inter-extra">
        <div class="filter-firstrow">
            <TimePicker bind:time={sel_start_tm} disableable={true} bind:enabled={start_tm_enabled} style="filter-extra"></TimePicker>
            <!-- <span>-</span> -->
            <DatePicker bind:date={sel_date} style="filter-extra"></DatePicker>
        </div>
        <div class="filter-row">
            <span class="inter-medium">Time until:</span>
            <TimePicker bind:time={sel_end_tm} style="filter-medium"></TimePicker>
        </div>
        <div class="filter-icon-wrapper">
            <div class="filter-row">
                <span class="inter-medium">Type:</span>
                <select bind:value={sel_type} class="inter-medium">
                    <option value="-1">Any</option>
                    {#await fetch_room_types() then room_types}
                    {#each room_types as type, i}
                        <option value="{type.id}">{type.name}</option>
                    {/each}
                    {/await}
                </select>
            </div>
            <img src="{filter_ico}" alt="filter">
        </div>
    </div>

    <!-- svelte-ignore a11y-no-static-element-interactions -->
    <div bind:this={rooms_cont} on:mousemove={() => {fetch_rooms_dep = fetch_rooms_dep + 1}} class="rooms-cont" class:is_rooms_scrollable>
        {#await fetch_rooms(sel_date, sel_start_tm, sel_end_tm, sel_type, $sel_floor, $sel_building, start_tm_enabled) then rooms}
        {#each rooms as r}
        <RoomItem bind:timeline_scroll auditorium={r.name.split(' ').at(-1)} capacity={r.capacity} id={r.id} floor={r.floor}/>
        {/each}
        {/await}
        <!-- <RoomItem bind:timeline_scroll 
            timeline_entries={[[DateTime.fromObject({ hour: 10, minute: 20}), DateTime.fromObject({ hour: 15})],
                                [DateTime.fromObject({ hour: 7, minute: 30}), DateTime.fromObject({ hour: 9})]
                            ]}
            on:click={() => console.log("clicked!")} 
            on:show3d={() => console.log("show3d!")} 
            />
        <RoomItem bind:timeline_scroll/>
        <RoomItem bind:timeline_scroll/>
        <RoomItem bind:timeline_scroll/>
        <RoomItem bind:timeline_scroll/>
        <RoomItem bind:timeline_scroll/>
        <RoomItem bind:timeline_scroll/>
        <RoomItem bind:timeline_scroll style="list-{is_rooms_scrollable ? 'mid' : 'last'}"/> -->
    </div>


</div>

<style>
.rooms-cont {
    margin-top: 3px;
    /* padding-bottom: 22px; */
    overflow-y: hidden;
    /* direction: rtl; */
}

.rooms-cont.is_rooms_scrollable:hover {
    overflow-y: auto;
    width: calc(100% + 5px);
}

.cont {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;

    width: 350px;
    margin: 24px;
    padding: 22px;

    overflow: hidden;
    padding-bottom: 0;


    background-color: var(--sec-container);
    border-radius: 35px; 

    display: flex;
    flex-direction: column;
}

.filter-icon-wrapper {
    display: flex;
    justify-content: space-between;
}

.filter-icon-wrapper > img {
    width: 1.2em;
    height: 1.2em;
    /* target color happends to be white, so we're good with that */
    filter: invert(100%);
}

.filter-row > span {
    color: var(--ter-fixed);
}

.filter-row > select {
    margin-left: -2px;
    border: 0;
    background: transparent;
    font-size: 20px;
    border-radius: 5px;
    color: var(--ter-on);
}

.filter-row > select:focus {
    outline: var(--ter-fixed) solid 1px;
    /* color: var(--ter-fixed); */
}
.filter-row > select > option {
    color: var(--ter);
}

.filter-firstrow > span {
    font-size: inherit;
    color: var(--ter-fixed);
    /* margin: 0 0.5em; */
}

.filter-firstrow {
    display: flex;
    justify-content: space-between;

    font-size: inherit;
    /* margin-bottom: 10px; */
}

.filter-cont {
    background-color: var(--ter);
    padding: 17px 30px;
    border-radius: 25px 25px 0 0;

    font-size: 20px;
}

.logo-text {
    font-size: 50px;
    color: var(--primary);
    text-align: center;
    transform: scale(1, 1);

    margin-top: 10px;
    margin-bottom: 30px;
}

</style>
  
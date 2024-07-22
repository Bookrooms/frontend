<script lang="ts">
    import Timeline from "$lib/Timeline.svelte";
    import people_ico from "$assets/people.png"
    import arrow_ico from "$assets/arrow.png"
    import { DateTime } from "luxon";
    import { createEventDispatcher } from 'svelte';
    import { showModel, camera, highlightQuadByName } from "$lib/main.js";


    const dispatch = createEventDispatcher();

    export let style = "list-mid"; // list-first, list-last
    export let timeline_scroll = 0;
    export let auditorium = "#329";
    export let capacity = "28";
    export let floor = 3;
    export let id = -1;
    export let datetime_start = DateTime.now()
    export let datetime_end = DateTime.now()

    function get_style(level: number, _deps?: any) {
        return style.split('-')[level]
    }

    async function fetch_bookings(room_id: number, time_start: DateTime, time_end: DateTime) {

        let data = {
            roomId: room_id,
            startTime: DateTime.fromObject({ 
                year: time_start.year,
                month: time_start.month,
                day: time_start.day,
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0
             }).toISO(),
            endTime: DateTime.fromObject({ 
                year: time_end.year,
                month: time_end.month,
                day: time_end.day,
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0
            }).toISO()
        }

        // console.log(data)
        const params = new URLSearchParams(data).toString();
        
        const rp = await fetch(`https://bookrooms.gladov.ru/api/bookings?${params}`, {
            method: 'GET',
        })
        const resp = await rp.json()

        let ret: Array<Array<DateTime>> = []
        resp.forEach(e => {
            ret.push([DateTime.fromISO(e.timeStart), DateTime.fromISO(e.timeEnd)])
        });
        if (ret.length) console.log(ret);
        return ret
    }

    function highlight3d() {
        let name = auditorium.substring(1)
        console.log('Room ' + name)
        show(floor)
        highlightQuadByName('Room ' + name)
    }

    function show(num: number) {
        showModel('Floor ' + num)

        switch (num) {
            case 1:
                camera.position.set(2.0066421131554453, 2.066118908736133, 4.416176082566819)
                break
            case 3:
                camera.position.set(-4.661618775199409, 2.494577540742692, 2.819960038265095)
                break
            case 4:
                camera.position.set(-5.765540196407432, 3.438185447925222, 6.858244247619766)
                break
        }
    }
</script>

<!-- svelte-ignore a11y-click-events-have-key-events -->
<!-- svelte-ignore a11y-no-static-element-interactions -->
<div on:click class="cont {get_style(1, style)}" >
    <div class="numbers">
        <span class="room-id inter-extra">{auditorium}</span>
        <div class="room-cap-cont">
            <!-- img already colored thanks to figma -->
            <img src="{people_ico}" alt="capacity">
            <span class="inter-semi">{capacity}</span>
        </div>
    </div>
    {#await fetch_bookings(id, datetime_start, datetime_end) then entries}
    <Timeline bind:scroll_pos={timeline_scroll} entries={entries} />
    {/await}
    <button on:click|stopPropagation={highlight3d} class="show-3d">
        <img src="{arrow_ico}" alt="arrow">
    </button>
</div>

<style>
    .room-id {
        color: var(--ter);
        font-size: 22px;
    }
    .room-cap-cont > span {
        color: var(--ter-fixed-dim);
        font-size: 16px;
    }
    .room-cap-cont > img {
        width: 1.3em;
        height: 1.3em;
        transform: translateY(0.25em);
        image-rendering: optimizeQuality;
    }
    .cont {
        display: flex;
        justify-content: space-between;
        align-items: normal;
        gap: 20px;

        border-color: transparent;

        background-color: var(--surface);
        height: 60px;
        padding: 17px 30px;

        margin-bottom: 3px;
        position: relative;
    }
    .show-3d {
        position: absolute;
        top: 0;
        right: 0;
        height: 100%;
        min-width: 22px;
        margin: 0;
        background-color: var(--surface-on-inv);
        border-radius: 25px 0 0 25px;
        border: 0;
        transition: opacity 100ms ease;
        opacity: 0;
    }
    .show-3d > img {
        width: 10px;
    }
    .show-3d:hover {
        background-color: var(--ter-fixed);
    }
    .show-3d:focus-visible {
        outline: 0;
    }
    .cont:hover > .show-3d {
        opacity: 1;
    }

    /* show time on borders of Timeline on hover with this hack */
    .cont:hover :global(.time-border) {
        display: flex;
        opacity: 1;
    }
    
    .cont.mid {
        border-radius: 0;
    }
    .cont.first {
        border-radius: 25px 25px 0 0;
    }
    .cont.last {
        border-radius: 0 0 25px 25px;
        margin-bottom: 0;
    }
</style>
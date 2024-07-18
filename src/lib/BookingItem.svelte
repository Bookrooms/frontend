<script lang="ts">
    import Timeline from "$lib/Timeline.svelte";
    import people_ico from "$assets/people.png"
    import arrow_ico from "$assets/arrow.png"
    import { DateTime } from "luxon";
    import { createEventDispatcher } from 'svelte';


    const dispatch = createEventDispatcher();

    export let auditorium = "#329";
    export let auditorium_type = "Lecture Room";
    export let booking_time = DateTime.now();
</script>

<!-- svelte-ignore a11y-click-events-have-key-events -->
<!-- svelte-ignore a11y-no-static-element-interactions -->
<div on:click class="cont" >
        <div class="first-row">
            <span class="room-id inter-extra">{auditorium}</span>
            <span class="time inter-bold">{booking_time.toFormat("HH:mm - LLL dd")}</span>
        </div>
        <div class="numbers">
            <span class="type inter-medium">{auditorium_type}</span>
        </div>
</div>

<style>
    .type {
        color: var(--ter-fixed-dim);
        font-size: 22px;
    }
    .time {
        display: block;
        margin: auto 0;
        color: var(--ter);
        font-size: 16px;
    }
    .first-row {
        margin-bottom: 3px;
    }
    .room-id {
        color: var(--ter);
        font-size: 22px;
    }
    .cont > div {
        display: flex;
        justify-content: space-between;
        align-items: normal;
    }
    .cont {
        direction: ltr;
        border-color: transparent;

        background-color: var(--surface);
        height: 60px;
        padding: 17px 30px;
        border-radius: 25px;

        margin-bottom: 5px;
        position: relative;
    }
</style>
<script lang="ts">
    import { onMount } from "svelte";
    import { DateTime } from "luxon";
    
    const hour_cell_width = 23 // body + borders

    export let scroll_pos = 0;
    export let entries: DateTime[][] = [];

    let viewport: HTMLDivElement;
    let hour_position = 0;

    $: viewport_len = Math.floor(viewport?.clientWidth / hour_cell_width) * hour_cell_width
    $: if (viewport) viewport.scroll(scroll_pos, viewport.scrollTop)

    function on_scroll(e: Event) {
        scroll_pos = (e.target as HTMLElement).scrollLeft
        hour_position = Math.round(scroll_pos / hour_cell_width)
    }
    function time_to_pos(d: DateTime, last: boolean = false) {
        if (last && d.hour == 0)
            return 24 * hour_cell_width
        return (d.hour + d.minute / 60) * hour_cell_width
    }
</script>
<div on:scroll={on_scroll} class="viewport" bind:this={viewport} style:max-width="{viewport_len}px">
    <div class="content">
        {#each { length: 24 } as _, i}
        <div class="hour-cell" class:hour-cell-first={i == 0}></div>
        {/each}
        {#each entries as e, i}
        <div class="entry" style:left="{time_to_pos(e[0])}px" style:min-width="{time_to_pos(e[1], true) - time_to_pos(e[0])}px"></div>
        {/each}
    </div>
    <div class="time-border inter-semi">
        <span>{hour_position}:00</span>
        <span>{(hour_position + Math.round(viewport_len / hour_cell_width)) % 24}:00</span>
    </div>
</div>

<style>
.entry {
    background-color: var(--ter-fixed-dim);
    position: absolute;
    top: 0;
    height: 19px;
    border-radius: 2px;
}

.viewport:hover > .time-border {
    display: flex;
    opacity: 1;
}
.time-border {
    color: var(--ter-fixed-dim);
    font-size: 13px;

    position: sticky;
    bottom: 0;
    left: 0;
    transition: opacity 100ms ease;
    opacity: 0;
    display: flex;
    justify-content: space-between;
}
.time-border > span {
    background-color: var(--surface);
    padding: 5px;
    padding-bottom: 0;
}

::-webkit-scrollbar {
    width: 0;
    height: 0px;
    /* height: 1px; */
}

::-webkit-scrollbar-thumb {
    background-color: var(--ter-container);
}

.viewport {
    position: relative;
    box-sizing: border-box;
    overflow-x: scroll;
    overflow-y: hidden;
    scroll-snap-type: x mandatory;
    border: 2px dashed var(--ter-container);
    border-top: 0;
    border-bottom: 0;
}
.content {
    display: flex;
    position: relative;
}
.hour-cell {
    display: inline-block;
    min-width: 22px;
    height: 57px;
    /* scroll-snap-align: start; */
    border-left: 1px dashed var(--ter-container);
}
.hour-cell-first {
    border-left: 0;
}
</style>
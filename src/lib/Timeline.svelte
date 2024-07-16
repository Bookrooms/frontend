<script lang="ts">
    import { onMount } from "svelte";
    
    let viewport_len = 999;
    let viewport: HTMLDivElement;

    $: if (viewport && (viewport.parentElement?.clientWidth || viewport.scrollLeft)) {
        if (viewport.clientWidth % 23 != 0) {
            viewport_len = Math.floor(viewport.clientWidth / 23) * 23
        }
    }
</script>

<div class="viewport" bind:this={viewport} style:max-width="{viewport_len}px">
    <div class="content">
        {#each { length: 24 } as _, i}
        <div class="hour-cell" class:hour-cell-first={i == 0}></div>
        {/each}
    </div>
</div>

<style>
::-webkit-scrollbar {
    width: 0;
    height: 0;
}

.viewport {
    box-sizing: border-box;
    overflow-x: scroll;
    overflow-y: hidden;
    scroll-snap-type: x mandatory;
    border: 0.15em dashed var(--ter-container);
    border-top: 0;
    border-bottom: 0;
}
.content {
    color: #000;
    display: flex;
}
.hour-cell {
    display: inline-block;
    min-width: 22px;
    height: 57px;
    border-left: 0.05em dashed var(--ter-container);
    scroll-snap-align: start;
}
.hour-cell-first {
    border-left: 0;
}
</style>
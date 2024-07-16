<script lang="ts">
    import Timeline from "$lib/Timeline.svelte";
    import people_ico from "$assets/people.png"

    export let style = "list-mid"; // list-first, list-last

    function get_style(level: number, _deps?: any) {
        return style.split('-')[level]
    }

</script>

<div class="cont {get_style(1, style)}" >
    <div class="numbers">
        <span class="room-id inter-extra">#329</span>
        <div class="room-cap-cont">
            <!-- img already colored thanks to figma -->
            <img src="{people_ico}" alt="capacity">
            <span class="inter-semi">328</span>
        </div>
    </div>
    <Timeline/>
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
        background-color: var(--surface);
        height: 60px;
        padding: 17px 30px;

        display: flex;
        justify-content: space-between;
        gap: 20px;

        margin-bottom: 3px;
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
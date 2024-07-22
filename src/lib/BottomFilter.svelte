<script lang="ts">
    import arrow_ico from "$assets/arrow.png"
    import arrow_gray_ico from "$assets/arrow_sec_fixed_dim.png"
    import { onMount } from "svelte";
    import { sel_building, sel_floor } from "$lib/stores";
    import { showModel, camera, highlightQuadByName } from "$lib/main.js";

    // export let data = [{ // fetch
    //     building: "University",
    //     floor_limits: [1, 3]
    // }];

    let data = {}
    let floor_dummy = {
        floor_no: 1
    }
    
    let floor_no = 1
    let building = 0;

    let floor_enabled = true
    let building_enabled = true

    $: sel_building.set(building_enabled ? building : -1)
    $: sel_floor.set(floor_enabled ? floor_no : -1)

    onMount(async () => {
        {
            const rp = await fetch("https://bookrooms.gladov.ru/api/buildings", {
                method: 'GET'
            })
            const d = await rp.json()
            d.forEach(b => {
                b.Floors.sort()
                b.Floors = [Math.min(...b.Floors), Math.max(...b.Floors)]
                data[b.id] = b
                data[b.id].floor_no = b.Floors[0]
            });
            
            building = Object.entries(data)[0][0]
            floor_no = Object.entries(data)[0][1].Floor[0]
        }
        setTimeout(() => show(floor_no), 3000);
    })

    function show(num: number) {
        if (!floor_enabled) return;
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

<div class="cont">
    <div class="select-cont">
        <select bind:value={building} class="building-sel inter-medium" class:disabled={!building_enabled}>
            {#each Object.entries(data) as [id, e]}
                <option value="{id}">{e.Name}</option>
            {/each}
        </select>
        <div class="arrow-hider"></div>

        <button on:click={() => { building_enabled = !building_enabled }}></button>
        <img src="{arrow_ico}" alt="arrow">
    </div>
    <div class="floor-cont">
        <button on:click={() => { floor_enabled = !floor_enabled; show(floor_no) }} class="floor-sign inter-medium" class:disabled={!floor_enabled}>Floor</button>
        <button on:click={() => {floor_no = Math.max(floor_no - 1, data[building].Floors[0]); show(floor_no)}}>
            <img class="rightwards" src="{arrow_ico}" alt="">
        </button>
        <span class="counter-sign inter-medium" class:disabled={!floor_enabled}>{floor_no}</span>
        <button on:click={() => {floor_no = Math.min(floor_no + 1, data[building].Floors[1]); show(floor_no)}}>
            <img src="{arrow_ico}" alt="">
        </button>
    </div>
</div>

<style>
.select-cont button {
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;

    right: 40px;
    background-color: transparent;
    border: 0;

}
img.rightwards {
    transform: rotateZ(180deg);
}
/* .floor-cont {
    text-align: center;
} */
.floor-cont > button > img {
    width: 10px;
    display: block;
}
.floor-cont > button {
    border: 0;
    background-color: transparent;
}
.floor-sign, .counter-sign {
    font-size: 20px;
    color: var(--sec);
    padding: 0;
}
.cont > div {
    background-color: var(--surface);
    border-radius: 25px;
    padding: 5px 15px;
}
.select-cont {
    overflow: hidden;
    position: relative;
}
.select-cont img {
    transform: rotateZ(90deg);
    transform-origin: center; 
    
    width: 10px;
    margin: 0.5em 20px;
    position: absolute;
    top: 0;
    right: 0;
    pointer-events: none;
}
.building-sel {
    border: 0;
    background-color: var(--surface);

    padding-right: 20px;
    font-size: 20px;
    color: var(--sec);
    outline: 0;
}
.disabled {
    color: var(--sec-fixed-dim);
}
.arrow-hider {
    background-color: var(--surface);
    /* background-color: red; */
    border-radius: 25px;

    position: absolute;
    width: 1em;
    height: 1em;
    top: 0;
    right: 0;

    /* half body & paddings  */
    margin: 0.5em 15px;

    pointer-events: none;
}
.cont {
    padding: 15px 25px;
    margin-bottom: 24px;
    background-color: var(--sec-container);
    border-radius: 25px;

    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);

    display: flex;
    justify-content: space-between;
    gap: 10px;
}
</style>
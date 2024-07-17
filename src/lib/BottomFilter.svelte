<script lang="ts">
    import arrow_ico from "$assets/arrow.png"
    import arrow_gray_ico from "$assets/arrow_sec_fixed_dim.png"

    export let data = [{
        building: "University",
        floor_limits: [1, 3]
    }];

    export let floor_no = 1;
    export let builing = 0; // index in data list

</script>

<div class="cont">
    <div class="select-cont">
        <select bind:value={builing} class="inter-medium">
            {#each data as e, i}
                <option value="{i}">{e.building}</option>
            {/each}
        </select>
        <div class="arrow-hider"></div>
        <img src="{arrow_ico}" alt="arrow">
    </div>
    <div class="floor-cont">
        <span class="sign inter-medium">Floor</span>
        <button on:click={() => floor_no = Math.max(floor_no - 1, data[builing].floor_limits[0])}>
            <img class="rightwards" src="{arrow_ico}" alt="">
        </button>
        <span class="sign inter-medium counter">{floor_no}</span>
        <button on:click={() => floor_no = Math.min(floor_no + 1, data[builing].floor_limits[1])}>
            <img src="{arrow_ico}" alt="">
        </button>
    </div>
</div>

<style>

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
.floor-cont > .sign {
    /* padding: 5px 15px; */
    font-size: 20px;
    color: var(--sec);
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
.select-cont select {
    border: 0;
    background-color: var(--surface);

    padding-right: 20px;
    font-size: 20px;
    color: var(--sec);
    outline: 0;
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
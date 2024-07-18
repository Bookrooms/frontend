<script lang="ts">
    import BookingItem from '$lib/BookingItem.svelte';
    import { createEventDispatcher } from 'svelte';


    const dispatch = createEventDispatcher();

    export let name = "Gilgamesh Shaboldiboldi";
    export let role = "Student";
</script>

<div class="cont">
    <div class="info-row">
        <div class="info-cont">
            <span class="inter-bold">{name}</span>
            <div class="info-sub-cont">
                <span class="inter-medium">{role}</span>
                <button on:click={() => dispatch('logout')} class="inter-medium">log out</button>
            </div>
        </div>
        <div class="img-cont">
            <!-- img -->
        </div>
    </div>
    <div class="bookings-cont">
        <BookingItem></BookingItem>
    </div>
</div>

<style>
.bookings-cont {
    margin-left: auto;

    /* 350+scrollbar */
    max-width: 355px;
    max-height: 50vh;

    overflow-x: hidden;
    overflow-y: scroll;
    direction: rtl;

    /* mask-image: linear-gradient(rgb(0 0 0 / 100%), transparent); */
    /* padding-top: 5px; */
    /* mask-image: linear-gradient(transparent, white 0.5%, white 99.5%, transparent 100%); */
}

.img-cont {
    min-width: 61px;
    height: 61px;
    overflow: hidden;
    background-color: var(--sec-on);
    border-radius: 40px;
}
    
.info-cont > span {
    font-size: 24px;
    color: var(--primary);
    display: inline-block;
    margin-bottom: 10px;
}
.info-sub-cont {
    display: flex;
    justify-content: space-between;
    gap: 10px;    
}
.info-sub-cont > button {
    border: 0;
    border-radius: 25px;
    background-color: var(--err-container);
    padding: 3px 10px;
    color: var(--sec);
}
.info-sub-cont > button:hover {
    /* background-color: var(--err); */
    color: var(--err);
}
.info-sub-cont > span {
    font-size: 16px;
    color: var(--sec);
}
.info-row {
    display: flex;
    justify-content: space-between;
    gap: 15px;

    margin-bottom: 15px;
    padding: 15px 25px;
    background-color: var(--sec-container);
    border-radius: 25px;
}
.cont {
    margin: 24px;
    position: absolute;
    top: 0;
    right: 0;
}
</style>
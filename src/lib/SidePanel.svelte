<script lang="ts">
    import RoomItem from './RoomItem.svelte'
    import TimePicker from './TimePicker.svelte'
    import DatePicker from './DatePicker.svelte'

    import filter_ico from '$assets/filter.png'

    let rooms_cont: HTMLDivElement;

    $: is_rooms_scrollable = is_scrollable(rooms_cont)

    function is_scrollable(elem: HTMLDivElement, _deps?: any) {
        if (elem)
            return elem.scrollHeight > elem.clientHeight || elem.scrollWidth > elem.clientWidth;
        return false
    }
</script>
  
<div class="cont">
    <h1 class="fondamento-regular logo-text">Bookrooms</h1>
    <div class="filter-cont inter-extra">
        <div class="filter-firstrow">
            <!-- <span class="inter-extra">At</span> -->
            <TimePicker style="filter-extra"></TimePicker>
            <!-- <span>-</span> -->
            <DatePicker style="filter-extra"></DatePicker>
        </div>
        <div class="filter-row">
            <span class="inter-medium">Time until:</span>
            <TimePicker style="filter-medium"></TimePicker>
        </div>
        <div class="filter-icon-wrapper">
            <div class="filter-row">
                <span class="inter-medium">Type:</span>
                <select class="inter-medium">
                    <option value="option0">Any</option>
                    <option value="option1">Lecture Room</option>
                    <option value="option2">Study Room</option>
                    <option value="option3">Meeting Room</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <img src="{filter_ico}" alt="fsdf">
        </div>
    </div>

    <div bind:this={rooms_cont} class="rooms-cont" class:is_rooms_scrollable>
        <RoomItem/>
        <RoomItem/>
        <RoomItem/>
        <RoomItem/>
        <RoomItem/>
        <RoomItem/>
        <RoomItem/>
        <RoomItem style="list-{is_rooms_scrollable ? 'mid' : 'last'}"/>
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
  
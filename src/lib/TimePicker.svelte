<script lang="ts">
    import { DateTime } from 'luxon';

    const now = DateTime.now()

    export let style = "filter-medium";
    export let time = now;
    export let disableable = false;
    export let enabled = true;

    function get_style(level: number) {
        return style.split('-')[level]
    }

    let time_fmt = time_to_fmt(time)

    $: if (time_fmt) {
        enabled = true;
        let ret = DateTime.fromISO(time_fmt)
        if (!ret.isValid) {
            console.error("update_time error!")
            time = now
        } else time = ret
        
        // step of 10 minutes, check that
        if (time.minute % 10 != 0) {
            time = time.set({ minute: Math.floor(time.minute / 10) * 10 % 60 })
            time_fmt = time_to_fmt(time)
        }
    }

    function time_to_fmt(d: DateTime) {
        return d.toFormat("HH:mm")
    }

    function switch_state() {
        enabled = !enabled;
        if (enabled) {
            time_fmt = time_to_fmt(time)
        } else {
            time_fmt = ""
        }
    }

</script>
  
<span>
    {#if disableable}
    <button on:click={switch_state} class="style-{get_style(0)} inter-{get_style(1)}" class:enabled>•</button>
    {/if}
    <input type="time" step="600" class="style-{get_style(0)} inter-{get_style(1)}" bind:value={time_fmt}>
</span>

<style>
button.style-filter {
    font-size: 20px;
    color: var(--ter-on);
}

/* button.style-filter:focus {
    outline: 1px solid var(--ter-on);
} */

input.style-filter {
    font-size: 20px;
    color: var(--ter-on);
}

input.style-filter:focus-visible {
    outline: 1px solid var(--ter-fixed);
}

input.style-filter::-webkit-datetime-edit-hour-field:focus,
input.style-filter::-webkit-datetime-edit-minute-field:focus,
input.style-filter::-webkit-datetime-edit-ampm-field:focus {
    color: var(--ter-fixed);
}

button.enabled {
    transform: scale(1.5) translateY(-0.05em);
}
button {
    transition: transform 30ms ease-in;
    transform: scale(1);
    /* display: none; */
    background-color: transparent;
    border-radius: 10px;
    border: 0;
    padding: 0;
}

input::-webkit-datetime-edit-hour-field:focus,
input::-webkit-datetime-edit-minute-field:focus,
input::-webkit-datetime-edit-ampm-field:focus {
    background: transparent;
}

button.style-filter:focus-visible {
    outline: 1px solid var(--ter-fixed);
}


input {
    /* to compensate outline */
    margin-left: -1px; 
    
    border: none;
    background: transparent;
    position: relative;
    
    border-radius: 5px;
}

input::-webkit-calendar-picker-indicator {
    display: block;
    top: 0;
    right: 0;
    height: 100%;
    width: 100%;
    position: absolute;
    background: none;
}
</style>

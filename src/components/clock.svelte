<script>
import { onMount } from "svelte";
let time = $state(new Date());
const dayNames = [
    'Sun', // Due to standard library
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];
let hours = $derived(time.getHours());
let minutes = $derived(('0' + time.getMinutes()).slice(-2));
let day = $derived(dayNames[time.getDay()])
let date = $derived(time.getDate())
let month = $derived(time.getMonth())

onMount(() => {
    const interval = setInterval(() => {
        time = new Date();
    }, 1000);

    return () => {
        clearInterval(interval);
    };
});
</script>
<div class="grid grid-cols-1 font-bold font-sans justify-items-center">
    <div class="clock flex text-8xl dark:text-color-sky-50">
        {hours}:{minutes}
    </div>
    <div class="calendar flex text-4xl dark:text-color-sky-50">
        <div id="day">{day}</div>
        <div class="flex px-2">
            <div id="date">{date}</div>
            <div id="seperator">/</div>
            <div id="month">{month}</div>
        </div>
    </div>
</div>

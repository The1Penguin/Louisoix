<script>
import { onMount } from "svelte";
let time = $state(new Date());
const dayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
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
    <div class="clock flex text-8xl">
        <div id="hour">{hours}</div>
        <div id="separator">:</div>
        <div id="minutes">{minutes}</div>
    </div>
    <div class="calendar flex text-4xl">
        <div id="day">{day}</div>
        <div class="flex px-2">
        <div id="date">{date}</div>
        <div id="seperator">/</div>
        <div id="month">{month}</div>
        </div>
    </div>
</div>

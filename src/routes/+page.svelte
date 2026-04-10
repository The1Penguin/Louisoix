<script lang="ts">
	import type { PageProps } from './$types';
    import Clock from "../components/clock.svelte";
    import Links from "../components/links.svelte";

	let { data }: PageProps = $props();
</script>


<div class="grid grid-cols-2 items-center justify-center h-screen dark:text-sky-50 ">
    <div class="flex justify-self-start m-auto">
        {#each data.config.categories as category }
            <div class="grid-flow-row gap-4 px-4">
                <Links category={category}/>
            </div>
        {/each}
    </div>
    <div class="flex flex-col items-center justify-self-end m-auto gap-10">
        <Clock />
        <p class="text-xl dark:text-color-sky-50">Welcome {data.config.name}</p>
        <img class="h-68 object-cover inline-block border-solid border-8 border-slate-600 dark:border-sky-100" src="profile.png" alt="Some form of profile pic chosen by the host">
    </div>
</div>

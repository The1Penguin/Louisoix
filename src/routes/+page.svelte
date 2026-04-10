<script lang="ts">
	import type { PageProps } from './$types';
    import Clock from "../components/clock.svelte";
    import Links from "../components/links.svelte";

	let { data }: PageProps = $props();
</script>


<div class="md:grid md:grid-cols-2 md:items-center md:justify-center h-screen dark:text-sky-50 max-md:flex max-md:flex-col-reverse overflow-auto">
    <div class="flex flex-row max-md:flex-col justify-self-start mx-auto mb-auto md:m-auto">
        {#each data.config.categories as category }
            <div class="my-1">
                <Links category={category}/>
            </div>
        {/each}
    </div>
    <div class="flex flex-col items-center justify-self-end mx-auto mt-5 mb-10 md:gap-10">
        <Clock />
        <p class="text-xl dark:text-color-sky-50">Welcome {data.config.name}</p>
        <img class="h-68 object-cover inline-block border-solid border-8 border-slate-600 dark:border-sky-100 max-md:hidden" src="profile.png" alt="Some form of profile pic chosen by the host">
    </div>
</div>

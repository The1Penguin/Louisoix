<script lang="ts">
	import type { PageProps } from './$types';
    import Clock from "../components/clock.svelte";
    import Links from "../components/links.svelte";

	let { data }: PageProps = $props();
</script>


<div class="grid grid-col-2 justify-center">
    <div class="flex content-start">
        {#each data.config.categories as category }
        <Links category={category}/>
        {/each}
    </div>
    <div class="flex content-end">
        <Clock />
    </div>
</div>

<script lang="ts">
 let { category } = $props()
</script>

<div class="flex flex-col items-center w-30">
    <p class="font-bold text-xl">{category.name}</p>
    <div class="flex flex-col items-center">
    {#each category.links as link}
        <a href={link.url} class="hover:text-violet-400 text-lg">{link.name}</a>
    {/each}
    </div>
</div>

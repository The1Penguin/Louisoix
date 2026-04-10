<script lang="ts">
 let { category } = $props()
</script>

<div class="flex flex-col items-center">
    <p>{category.name}</p>
    <div class="flex flex-col items-center">
    {#each category.links as link}
        <a href={link.url}>{link.name}</a>
    {/each}
    </div>
</div>

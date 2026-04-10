import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';

interface Link {
    name: string;
    url: url;
}

interface Category {
    name: string;
    links: [Link];
}

interface Config {
    name: string;
    categories: [Category];
}

export async function load({ fetch, params }): PageLoad {
    const config = await fetch("/config.json")
        .then(response => response.json() as Config)
    console.log(config)
    return { config }
};

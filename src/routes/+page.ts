import { fetchPrs } from '$lib/fetchers';

export async function load({ fetch, depends }) {
	depends('app:pr');
	try {
		return await fetchPrs(fetch);
	} catch (err) {
		return {
			prs: []
		};
	}
}

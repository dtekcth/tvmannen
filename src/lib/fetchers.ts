import { apiUrl, fileIdToUrl, query, type Fetch } from './client';
import type { Pr } from './types';

function parsePr(pr: Pr) {
	return {
		...pr,
		pr: fileIdToUrl(pr.pr)
	};
}

export async function fetchPrs(fetch: Fetch) {
	const resp = await fetch(
		`${apiUrl}/items/tvmannen${query({
			sort: ['-date_created']
		})}`
	);

	const { data } = (await resp.json()) as { data?: Pr[] };
	const parsed = (data ?? []).map(parsePr);
	const priority = parsed.filter((pr) => pr.priority);

	return {
		prs: priority.length === 0 ? parsed : priority
	};
}

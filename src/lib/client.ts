import { env } from '$env/dynamic/public';

export const apiUrl = env.PUBLIC_DIRECTUS_URL;

export function fileIdToUrl(id: string): string {
	return `${apiUrl}/assets/${id}`;
}
export type QueryValue = string | number;
export type QueryParams = Record<string, QueryValue | QueryValue[] | undefined>;
export type Fetch = typeof globalThis.fetch;

export function query(params?: QueryParams): string {
	if (params) {
		const p = new URLSearchParams();
		for (const [key, value] of Object.entries(params)) {
			if (Array.isArray(value)) {
				for (const v of value) {
					p.append(`${key}[]`, v.toString());
				}
			} else {
				value && p.append(key, value.toString());
			}
		}
		return '?' + p.toString();
	} else {
		return '';
	}
}

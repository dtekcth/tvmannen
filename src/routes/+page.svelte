<script lang="ts">
	import '../style.css';
	import { onMount } from 'svelte';
	import { invalidate } from '$app/navigation';
	import logo from '../assets/logo.svg';

	export let data;

	const prViewTime = 30 * 1000;
	const prRefreshTime = 120 * 1000;

	let current = 0;
	$: current %= data.prs.length;
	$: currentPr = data.prs[current];

	function onKeypress(event: KeyboardEvent) {
		if (event.key === ' ') {
			current += 1;
		} else if (event.key === 'r') {
			invalidate('app:pr');
		}
	}

	onMount(() => {
		const id = setInterval(() => {
			current += 1;
		}, prViewTime);

		return () => clearInterval(id);
	});

	onMount(() => {
		const id = setInterval(() => {
			invalidate('app:pr');
		}, prRefreshTime);

		return () => clearInterval(id);
	});
</script>

<svelte:head>
	<title>TV-Mannen</title>
</svelte:head>
<svelte:body on:keypress={onKeypress} />

{#if data.prs.length === 0}
	<div class="wrapper orange">
		<img src={logo} alt="Logo" />
		<p>Nothing going on right now</p>
	</div>
{:else}
	<div class="wrapper black">
		{#if currentPr.video}
			<video src={currentPr.pr} autoplay muted loop>
				<p>Could not play the video</p>
			</video>
		{:else}
			<img src={currentPr.pr} alt={currentPr.description} />
		{/if}
	</div>
{/if}

<style>
	.wrapper {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		height: 100vh;
	}

	.wrapper.black {
		background-color: black;
	}

	.wrapper.orange {
		background-color: var(--data-orange);
	}

	p {
		font-size: 2em;
		font-weight: bold;
	}

	img,
	video {
		margin-inline: auto;
		display: block;
		max-width: 100%;
		height: 100vh;
		object-fit: contain;
		object-position: 50% 50%;
	}
</style>

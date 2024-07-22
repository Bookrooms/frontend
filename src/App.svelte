<script lang="ts">
  import SidePanel from '$lib/SidePanel.svelte'
  import BottomFilter from '$lib/BottomFilter.svelte'
  import AccountPanel from '$lib/AccountPanel.svelte'
  import { init } from '$lib/main.js'

  
  init();

</script>

<main>
  <SidePanel></SidePanel>
  <BottomFilter></BottomFilter>
  <AccountPanel></AccountPanel>
</main>

<style>

</style>

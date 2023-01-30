<script>
	import { SendNUI } from '@utils/SendNUI'
    import { fly } from 'svelte/transition'
</script>

<div
class="absolute bg-[color:var(--grey)] left-10 bottom-[35rem] w-[35rem] h-[50rem] flex gap-2 flex-col items-center p-0 pb-5 justify-start"
in:fly={{ x: 50, duration: 150 }}
>
    <div class="w-full h-[5rem] grid place-items-center bg-[color:var(--yellow)]">
        <p class=" font-text font-bold text-[2rem]">Cart</p>
        <button class="absolute top-0 right-0 aspect-square h-[3rem] bg-[color:var(--red)] focus:outline-none text-[color:var(--white)] font-text text-center font-bold active:brightness-90 hover:brightness-110 grid place-items-center p-1"
        on:click={() => SendNUI('closeCart')}
        >
            <i class="fa-solid fa-times"></i>
        </button>
    </div>

    <div class="flex flex-col w-full h-full gap-2 px-5 py-3 overflow-x-hidden overflow-y-scroll scrollbar-hide">
        {#each {length: 50} as _, i}
        <div class="flex flex-row w-full min-h-[5rem] bg-[color:var(--white)] items-center p-5 gap-5">
            <button class="grid place-items-center bg-[color:var(--red)] active:brightness-90 hover:brightness-110 text-[color:var(--white)] w-[2rem] relative h-[2rem] aspect-square">
                <i class="fa-solid fa-times"></i>
            </button>
            <div class="flex flex-col w-1/2 h-full justify-center items-center">
                <p class="font-text font-bold text-[1.5rem] text-start w-full">Item</p>
            </div>
            <div class="flex flex-col w-1/2 h-full justify-center items-center">
                <p class="font-text font-bold text-[1.5rem] text-end w-full">$1000</p>
            </div>
        </div>
        {/each}
    </div>

    <div class="flex flex-row gap-2 w-full px-5">
        <button class="w-full bg-[color:var(--green)] text-[color:var(--white)] font-text font-bold active:brightness-90 hover:brightness-110"
        >
        Buy
        </button>
        <p class="w-full bg-[color:var(--white)] text-[color:var(--black)] text-end font-text font-bold text-[2rem] px-2">
            $0
        </p>
    </div>


</div>
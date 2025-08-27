<script setup>
import EmailHeader from "@/components/EmailHeader.vue";
import Badge from "@/components/Badge.vue";

defineProps({
  name: { type: String, default: "nomeCliente" },
});
</script>

<template>
  <div>
    <email-header>
      <div class="w-full">
        <h1 class="font-semibold text-lg text-off-white ml-2">
          Bem vindo, {{ name }}
        </h1>
        <p>Parabens, você está <badge active>Ativo</badge></p>
      </div>
    </email-header>
  </div>
</template>

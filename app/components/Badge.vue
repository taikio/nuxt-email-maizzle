<script setup>
import { computed } from "vue";

const props = defineProps({
  active: { type: Boolean, default: false },
});

const stateClasses = computed(() => {
  if (props.active) {
    return "text-off-white bg-green-400";
  }

  return "bg-gray-400 text-gray-600";
});
</script>

<template>
  <table>
    <tbody>
      <tr>
        <td class="p-2 text-sm" :class="stateClasses">
          <slot />
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script setup>
const props = defineProps({
  placeholder: {
    type: String,
    required: true,
  },
  size: {
    type: String,
    default: 'normal',
  },
})
</script>

<template>
  <v-text-field
    :class="['ipt', `ipt_${size}`]"
    :label="placeholder"
  ></v-text-field>
</template>

<style scoped>
@import 'VInput.scss';
</style>

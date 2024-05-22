<script setup>
const props = defineProps({
  size: {
    type: String,
    default: 'medium',
  },
  disabledOption: {
    type: String,
    required: true,
  },
  options: {
    type: Array,
    required: true,
  },
})
</script>

<template>
  <v-select
    :class="['select', `select_${size}`]"
    :items="options"
    item-title="title"
    item-value="value"
    :label="disabledOption"
  ></v-select>
</template>

<style scoped>
@import 'VSelect.scss';
</style>

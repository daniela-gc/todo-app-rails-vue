<template>
  <div class="flex flex-row items-center">
    <input type="checkbox" 
      @input="$emit('update:checked', $event.target.checked)"
      :checked="checked"
      :id="id"
      class="mr-2 h-5 w-5 bg-transparent text-indigo-400 border-2 border-indigo-400 cursor-pointer border-opacity-50 focus:ring-0 focus:ring-offset-current">
    <input type="text" :value="description" @input="$emit('update:description', $event.target.value)" :class="{ 'line-through': checked }" class="bg-transparent focus:ring-0 border-none w-full text-md text-gray-600 rounded-md py-2 pl-2">
  </div>
</template>

<script>
export default {
  name: "TaskItem",
  props: {
    id: Number,
    description: {
      type: String,
      required: true,
    },
    checked: Boolean
  },
};
</script>

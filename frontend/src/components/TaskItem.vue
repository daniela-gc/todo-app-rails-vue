<template>
  <div class="grid grid-rows-2 gird-cols-1">
    <div class="mb-1 place-self-end">
      <span class="text-sm font-normal text-gray-400 ">{{ createdDate }}</span>
    </div>
    
    <div class="flex items-center">
      <input type="checkbox" 
        :id="id"
        :checked="checked"
        @change="$emit('toggle-checked', id)"
        class="w-5 h-5 mr-2 text-yellow-500 bg-transparent border-2 border-yellow-500 cursor-pointer border-opacity-40 focus:ring-0 focus:ring-offset-current">
      <input type="text" :value="description" @input="$emit('update:description', $event.target.value, id)" :class="[{ 'line-through': checked }, checked ? 'text-gray-400' : 'text-gray-600']" class="w-full pl-2 bg-transparent border-none rounded-md focus:ring-0">
      <button @click.prevent="$emit('delete-task', id)">
        <svg class="w-6 h-6 text-gray-400 cursor-pointer hover:text-gray-600" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>
      </button>
    </div>
    
  </div>
</template>

<script>
export default {
  name: "TaskItem",
  emits: ['toggle-checked', 'update:description'],
  props: {
    id: Number,
    description: {
      type: String,
      required: true,
    },
    createdDate: {
      type: String, 
      required: true,
    },
    priority: {
      type: Number,
    },
    checked: Boolean,
  },
};
</script>

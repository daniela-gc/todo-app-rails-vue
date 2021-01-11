<template>
  <div class="container relative flex flex-col items-center justify-center max-w-3xl mx-auto overflow-hidden bg-white rounded-lg shadow-lg bg-opacity-90 top-20">
    <header class="flex justify-between w-full px-6 mt-6 mb-4 tracking-wider bg-opacity-80 font-headings">
      <h2 class="text-3xl text-center text-gray-600">To-Do List</h2>
      <h3 class="text-xl text-pink-800 text-opacity-50">{{ currentDate }}</h3>
    </header>
    <section class="w-full px-6 mb-3">
      <form name="todo-form" class="flex items-center" method="post" action="">
        <input v-model="newTask" class="w-full pl-0 mr-2 text-gray-700 placeholder-gray-400 bg-transparent border-0 border-b-2 border-transparent focus:ring-0 focus:border-pink-500 focus:border-opacity-20 text-md" type="text" aria-label="New task" placeholder="Write a new task" />
        <button @click.prevent="addTask" class="px-4 py-2 font-medium text-white bg-pink-700 rounded-md hover:bg-pink-800 hover:bg-opacity-60 hover:text-white bg-opacity-60 text-md">
          <svg class="text-white group-hover:text-indigo-500" width="12" height="20" fill="currentColor">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M6 5a1 1 0 011 1v3h3a1 1 0 110 2H7v3a1 1 0 11-2 0v-3H2a1 1 0 110-2h3V6a1 1 0 011-1z"/>
          </svg>
        </button>
      </form>
    </section>
    <section class="grid w-full grid-cols-1 px-6 divide-y divide-indigo-200">
      <task-item
        v-for="task in tasks"
        :key="task.id"
        :description="task.description"
        :id="task.id" 
        :checked="task.checked"
        v-model="task.checked"
      ></task-item>
    </section>
    <footer class="mt-4 mb-4">
      <button v-tooltip.top-center="'Github project'">
        <a href="https://github.com/daniela-gc/vue-cli-rails-template" target="_blank">
            <img src="~@/assets/github-logo.png" alt="Github" width="25" class="opacity-60">
        </a>
      </button>
    </footer>
  </div>
</template>

<script>
// @ is an alias to /src
import TaskItem from "@/components/TaskItem.vue";

export default {
  name: "Home",
  components: {
    "task-item": TaskItem,
  },
  data() {
    return {
      currentDate: new Date().toDateString(),
      newTask: '',
      tasks: [
        { id: 1, description: 'Make dinner', checked: false },
        { id: 2, description: 'Write down New Year resolutions', checked: false },
        { id: 3, description: 'Water the plants', checked: true },
      ]
    }
  },
  methods: {
    addTask() {
      this.tasks.push({id: Math.random(), description: this.newTask, checked: false});
      this.newTask = '';
    },
  },
};
</script>

<style>
.tooltip {
  display: block !important;
  z-index: 10000;
}

.tooltip .tooltip-inner {
  background: #818CF8;
  color: white;
  border-radius: 16px;
  padding: 5px 10px 4px;
  font-size: 0.9em;
}

.tooltip .tooltip-arrow {
  width: 0;
  height: 0;
  border-style: solid;
  position: absolute;
  margin: 5px;
  border-color: #818CF8;
  z-index: 1;
}

.tooltip[x-placement^="top"] {
  margin-bottom: 5px;
}

.tooltip[x-placement^="top"] .tooltip-arrow {
  border-width: 5px 5px 0 5px;
  border-left-color: transparent !important;
  border-right-color: transparent !important;
  border-bottom-color: transparent !important;
  bottom: -5px;
  left: calc(50% - 5px);
  margin-top: 0;
  margin-bottom: 0;
}

.tooltip[x-placement^="bottom"] {
  margin-top: 5px;
}

.tooltip[aria-hidden='true'] {
  visibility: hidden;
  opacity: 0;
  transition: opacity .15s, visibility .15s;
}

.tooltip[aria-hidden='false'] {
  visibility: visible;
  opacity: 1;
  transition: opacity .15s;
}
</style>

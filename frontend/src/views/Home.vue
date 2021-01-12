<template>
  <div class="container flex flex-col items-center justify-center mx-auto bg-white rounded-lg shadow-lg main-container md:max-w-4xl bg-opacity-95">
    <header class="flex justify-between w-full px-6 mt-6 mb-5 tracking-wider bg-opacity-80 font-headings">
      <div class="flex items-center">
        <svg class="w-8 h-8 mr-1 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
        </svg>
        <h2 class="text-3xl text-center text-gray-600">To-Do List</h2>
      </div>
      <h3 class="text-xl text-yellow-700 text-opacity-40">{{ currentDate }}</h3>
    </header>
    <section class="w-full px-6 mb-3">
      <form name="todo-form" class="flex items-center" method="post">
        <div class="w-full mr-3">
          <input v-model="newTask" class="flex-auto w-full pl-0 text-gray-500 placeholder-gray-400 bg-transparent border-0 border-b-2 border-transparent border-gray-500 border-opacity-10 focus:ring-0 focus:border-yellow-600 focus:border-opacity-20" type="text" aria-label="New task" placeholder="Write a new task" />
        </div>
        
        <div>
          <button @click.prevent="addTask" class="px-2 py-1 font-medium text-white bg-yellow-500 rounded-md shadow-md focus:outline-none hover:bg-yellow-600 hover:bg-opacity-80 hover:text-white bg-opacity-80 text-md">
            <svg class="w-7 h-7 text-white group-hover:text-red-500" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd"></path>
            </svg>
          </button>
        </div>
      </form>
    </section>
    <section class="grid w-full grid-cols-1 overflow-y-auto divide-y divide-red-100 px-7">
      <task-item
        v-for="task in tasks"
        :key="task.id"
        :id="task.id" 
        :createdDate="task.createdDate"
        :checked="task.checked"
        v-model:description="task.description"
        @update:description="updateDescription"
        @toggle-checked="toggleChecked"
        @delete-task="deleteTask"
      ></task-item>
    </section>
    <footer class="w-full px-6 pb-5 mt-8">
      <div class= "flex items-end justify-between">
        <div>
          <button @click.prevent="clearTasks" class="flex items-center px-3 py-2 text-gray-500 border border-gray-300 rounded-md shadow-md focus:outline-none focus:ring-opacity-10 focus:ring-0 hover:bg-gray-100 hover:text-gray-600">            
            <svg class="w-6 h-6 mr-1 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
            </svg> 
            Clear List
          </button>
        </div>
        <div>
          <button v-tooltip.top-center="'Github project'">
            <a href="https://github.com/daniela-gc/todo-app-rails-vue" target="_blank">
              <img src="~@/assets/github-logo.png" alt="Github" width="25" class="opacity-60">
            </a>
          </button>
        </div>
      </div>
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
      tasks: [],
      newTask: '',
      currentDate: new Date().toDateString(),
      priority: '',
    }
  },
  methods: {
    async addTask() {
      const new_item = { description: this.newTask }
      try {
        await this.axios.post('api/v1/task_items', { task_item: new_item })
        this.initialize();
        this.newTask = '';
      } catch (error) {
        console.log(error);
      }
    },
    async toggleChecked(id) {
      const task = this.tasks.find( task => task.id === id );
      try {
        await this.axios.put(`api/v1/task_items/${id}`, { id: id, checked: !task.checked });
        this.initialize();
      } catch (error) {
        console.log(error);
      }
    },
    async updateDescription(description, id) { 
      try {
        await this.axios.put(`api/v1/task_items/${id}`, { id: id, description: description });
      } catch (error) {
        console.log(error);
      }
    },
    async deleteTask(id) {
      const task = this.tasks.find( task => task.id === id );
      try {
        await this.axios.delete(`api/v1/task_items/${task.id}`);
        this.initialize();
      } catch (error) {
        console.log(error);
      }
    },
    clearTasks() {
      try {
        this.tasks.forEach(async (task) => {
          await this.axios.delete(`api/v1/task_items/${task.id}`)
          this.initialize();
        })
      } catch (error) {
        console.log(error);
      }
    },
    async initialize() {
      try {
        const response = await this.axios.get('api/v1/task_items');
        const tasks = response.data.data
        this.tasks = [];
        tasks.forEach( task => {
          const createdDate = new Date(task.attributes.created_at).toLocaleString()
          this.tasks.push({ id: parseInt(task.id), description: task.attributes.description, scheduled_date: task.attributes.scheduled_date, category: parseInt(task.attributes.category), checked: task.attributes.checked, createdDate: createdDate })
        });
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
    this.initialize();
  },
};
</script>

<style>
.main-container {
  max-height: 90vh;  
}

#deadline {
  width: 160px;
}

.tooltip {
  display: block !important;
  z-index: 10000;
}

.tooltip .tooltip-inner {
  background: #EF9D0B;
  color: white;
  border-radius: 16px;
  padding: 5px 10px 4px;
  font-size: 0.9em;
  opacity: 0.8;
}

.tooltip .tooltip-arrow {
  width: 0;
  height: 0;
  border-style: solid;
  position: absolute;
  margin: 5px;
  border-color: #EF9D0B;
  z-index: 1;
  opacity: 0.8;
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

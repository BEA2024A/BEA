<template>
    <plantilla-psico>
        
    <div class="form-container">
      <form @submit.prevent="submitForm">
        <div>
          <label for="idAlumno">ID de alumno:</label>
          <input id="idAlumno" v-model="evento.id_usuario" type="number" />
        </div>
        <div>
          <label for="titulo">Título del recordatorio:</label>
          <input id="titulo" v-model="evento.titulo" type="text" required />
        </div>
        <div>
          <label for="fecha">Fecha:</label>
          <input id="fecha" v-model="evento.fecha" type="date" required />
        </div>
        <div>
          <label for="hora">Hora:</label>
          <input id="hora" v-model="evento.hora" type="time" required />
        </div>
        <div>
          <label for="color">Color:</label>
          <input id="color" v-model="evento.color" type="color" required />
        </div>
        <button type="submit" :disabled="!formIsValid || isSubmitting">Guardar</button>
      </form>
    </div>
</plantilla-psico>
  </template>
  
  <script>
  import axios from 'axios';
  import plantillaPsico from './plantillaPsico.vue';
  
  export default {
    components: {
    plantillaPsico,
  },
    data() {
      return {
        evento: {
          id_usuario: '',
          titulo: '',
          fecha: '',
          hora: '',
          color: '#ff5900', 
          isSubmitting: false,
        },
      };
    },

    computed: {
    formIsValid() {
      return this.evento.id_usuario && this.evento.titulo && this.evento.fecha && this.evento.hora && this.evento.color;
    },
  },

    methods: {
       
      submitForm() {
        if(this.isSubmitting || !this.formIsValid) return;
        this.isSubmitting = true;
        axios.post('http://localhost/BEA/back/agregarEvento.php', this.evento)
          .then(response => {
            alert('Evento guardado con éxito');
          })
          .catch(error => {
            console.error('Hubo un error al guardar el evento:', error);
            alert('Error al guardar el evento');
          })

          .finally(() => {
          this.isSubmitting = false; 
        });

          
      },
    },
  };
  </script>
  
  <style scoped>


.form-container {
  max-width: 500px;
  margin: 0 auto;
  margin-top: 60px;
margin-bottom: 60px;
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
}

form div {
  margin-bottom: 20px;
}

label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}

input[type="number"],
input[type="text"],
input[type="date"],
input[type="time"],
input[type="color"] {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

input[type="color"] {
  padding: 0;
  border: none;
  height: 34px;
}

button {
  display: block;
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.2s;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

button:hover:not(:disabled) {
  background-color: #0056b3;
}
</style>

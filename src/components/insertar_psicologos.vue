<template>
    <PlantillaPsico>
    <div class="registro-container">
      <div class="registro-box">
        <h2>Registro de Psicólogos</h2>
        <form @submit.prevent="submitForm">
          <div class="input-group">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" v-model="psicologo.nombre" required>
          </div>
          <div class="input-group">
            <label for="tipo">Tipo:</label>
            <input type="text" id="tipo" v-model="psicologo.tipo" required>
          </div>
          <div class="input-group">
            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" v-model="psicologo.telefono" required>
          </div>
          <div class="input-group">
            <label for="especialidad">Especialidad:</label>
            <textarea id="especialidad" v-model="psicologo.especialidad" required></textarea>
          </div>
          <div class="input-group">
            <label for="direccion">Dirección:</label>
            <input type="text" id="direccion" v-model="psicologo.direccion" required>
          </div>
          <div class="input-group">
            <label for="poblacion">Población a atender:</label>
            <input type="text" id="poblacion" v-model="psicologo.poblacion" required>
          </div>
          <div class="input-group">
            <label for="formacion">Formación:</label>
            <textarea id="formacion" v-model="psicologo.formacion" required></textarea>
          </div>
          <div class="input-group">
            <label for="modalidad">Modalidad:</label>
            <input type="text" id="modalidad" v-model="psicologo.modalidad" required>
          </div>
          <div class="input-group">
            <label for="imagenes">Imágenes (URLs separadas por coma):</label>
            <input type="text" id="imagenes" v-model="psicologo.imagenes" required>
          </div>
          <button type="submit">Registrar Psicólogo</button>
        </form>
      </div>
    </div>
    </PlantillaPsico>
  </template>
  
  <script>
  import axios from 'axios';
import PlantillaPsico from './plantillaPsico.vue';
  
  export default {
    components: {
    PlantillaPsico,
  },
    data() {
      return {
        psicologo: {
          nombre: '',
          tipo: '',
          telefono: '',
          especialidad: '',
          direccion: '',
          poblacion: '',
          formacion: '',
          modalidad: '',
          imagenes: ''
        }
      };
    },
    methods: {
      submitForm() {
        const formData = new FormData();
        for (let key in this.psicologo) {
          formData.append(key.toUpperCase(), this.psicologo[key]);
        }
  
        axios.post('http://localhost/BEA/back/insertar_psicologos.php', formData)
          .then(response => {
            alert(response.data);
            // Aquí puedes redirigir o limpiar el formulario
          })
          .catch(error => {
            console.error('Hubo un error al insertar el psicólogo:', error);
          });
      }
    }
  };
  </script>
  
 
 
  <style scoped>
.registro-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-color: #adabab;
}

.registro-box {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  max-width: 500px;
  width: 100%;
  margin: 30px;
}

h2 {
  color: #333;
  margin-bottom: 20px;
}

.input-group {
  margin-bottom: 15px;
  display: flex;
  flex-direction: column;
}

.input-group label {
  font-size: 16px;
  margin-bottom: 5px;
  color: #666;
}

.input-group input,
.input-group textarea {
  padding: 10px;
  border-radius: 4px;
  border: 1px solid #ddd;
  font-size: 14px;
}

.input-group textarea {
  resize: vertical;
}

button {
  background-color: #ff4800;
  color: white;
  padding: 10px 15px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s ease;
}

button:hover {
  background-color: #ff4800;
}

</style>


  
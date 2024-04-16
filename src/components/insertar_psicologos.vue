<template>
  <PlantillaPsico>
    <div class="background-image"></div>
  <div class="form-container">
    
    <h1>Registrar nuevo psicólogo</h1>
    <form @submit.prevent="submitForm">
      <div class="form-group">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" v-model="psicologo.nombre" required>
      </div>
      <div class="form-group">
        <label for="tipo">Tipo de terapia:</label>
        <input type="text" id="tipo" v-model="psicologo.tipo" required>
      </div>
      <div class="form-group">
        <label for="telefono">Teléfono:</label>
        <input type="text" id="telefono" v-model="psicologo.telefono" required>
      </div>
      <div class="form-group">
        <label for="especialidad">Especialidad:</label>
        <textarea id="especialidad" v-model="psicologo.especialidad" required></textarea>
      </div>
      <div class="form-group">
        <label for="direccion">Dirección:</label>
        <input type="text" id="direccion" v-model="psicologo.direccion" required>
      </div>
      <div class="form-group">
        <label for="poblacion">Población atendida:</label>
        <input type="text" id="poblacion" v-model="psicologo.poblacion" required>
      </div>
      <div class="form-group">
        <label for="formacion">Formación:</label>
        <textarea id="formacion" v-model="psicologo.formacion" required></textarea>
      </div>
      <div class="form-group">
        <label for="modalidad">Modalidad:</label>
        <input type="text" id="modalidad" v-model="psicologo.modalidad" required>
      </div>
      <div class="form-group">
        <label for="imagen">Imagen del Psicólogo:</label>
        <input type="file" id="imagen" @change="handleFileUpload" required>
      </div>
      <button type="submit">Registrar Psicólogo</button>

      <div class="form-group">
      <label for="psicologoEliminar">Eliminar Psicólogo:</label>
      <select id="psicologoEliminar" class="eliminar-opciones" v-model="psicologoEliminar">
        <option value="" disabled>Seleccione un psicólogo</option>
        <option v-for="psicologo in psicologos" :key="psicologo.id" :value="psicologo.id">
          {{ psicologo.nombre }}
        </option>
      </select>
      <button @click="eliminarPsicologo">Eliminar</button>
    </div>
    </form>
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
        imagen: null,
      },
      psicologos: [],
      psicologoEliminar: ''
    };
  },
  methods: {
    handleFileUpload(event) {
      this.psicologo.imagen = event.target.files[0];  // Captura el archivo desde el input
    },
    submitForm() {
      const formData = new FormData();
      formData.append('nombre', this.psicologo.nombre);
      formData.append('tipo', this.psicologo.tipo);
      formData.append('telefono', this.psicologo.telefono);
      formData.append('especialidad', this.psicologo.especialidad);
      formData.append('direccion', this.psicologo.direccion);
      formData.append('poblacion', this.psicologo.poblacion);
      formData.append('formacion', this.psicologo.formacion);
      formData.append('modalidad', this.psicologo.modalidad);
      formData.append('imagen', this.psicologo.imagen);  // Asegúrate de enviar el archivo, no el nombre

      axios.post('http://localhost/bea/back/insertarPsicologo.php', formData, {
        headers: {
          'Content-Type': 'multipart/form-data'  // Asegura que el header esté configurado para manejo de form-data
        }
      })
      .then(response => {
        alert('Psicólogo registrado con éxito');
        console.log(response.data);
        window.location.reload();
        
      })
      .catch(error => {
        console.error('Ocurrió un error al registrar el psicólogo:', error);
        alert('Error al registrar el psicólogo.');
      });
    },

    cargarPsicologos() {
      axios.get('http://localhost/bea/back/obtenerPsicologos.php')
        .then(response => {
          this.psicologos = response.data;
        })
        .catch(error => {
          console.error('Error al cargar los psicólogos:', error);
        });
    },
    eliminarPsicologo() {
      if (!this.psicologoEliminar) {
        alert('Seleccione un psicólogo para eliminar');
        return;
      }
      axios.post('http://localhost/bea/back/eliminarPsicologo.php', {
        id: this.psicologoEliminar
      })
      .then(response => {
        alert('Psicólogo eliminado con éxito');
        this.cargarPsicologos(); 
      })
      .catch(error => {
        console.error('Error al eliminar el psicólogo:', error);
        alert('Error al eliminar el psicólogo.');
      });
    }


  },

  mounted() {
    this.cargarPsicologos();
  }

};
</script>


<style scoped>
.form-container {
  max-width: 500px;
  margin: auto;
  padding: 10px;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
  background-color: aliceblue;
  margin-top: 40px;
  margin-bottom: 40px;
}

.form-group {
  margin-bottom: 10px;
}

.form-group label {
  display:flex;
  margin-bottom: 5px;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
}

.background-image {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 120%;
      background-color: #ff5900;
      background-size: cover;
      z-index: -1;
    }

  .eliminar-opciones{
    margin-bottom: 20px;
  }


</style>

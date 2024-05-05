<template>
  <PlantillaPsico>
    <div class="container">
    <div class="login-container">
      <div class="login-box" @mouseover="changeCursor">
        <div class="content">
          <div class="contenido-izquierda">
          <h2 class="titulo">Registro de nuevo psicólogo</h2>
          <div class="input-group">
              <input type="text" v-model="psicologo.nombre" class="input-field" placeholder="Nombre del psicólogo" @input="validateName">
              <div class="input-line"></div>
            </div>
          <div class="input-group">
            <input type="text" v-model="psicologo.tipo" class="input-field" placeholder="Tipo de terapia" @focus="hideBottomBorder" @blur="showBottomBorder">
            <div class="input-line"></div>
          </div>
          <div class="input-group">
            <input type="text" v-model="psicologo.telefono" class="input-field" placeholder="Teléfono de contacto" @focus="hideBottomBorder" @blur="showBottomBorder">
            <div class="input-line"></div>
          </div>
          <div class="input-group">
            <input type="text" v-model="psicologo.especialidad" class="input-field" placeholder="Especialidad del psicólogo" @focus="hideBottomBorder" @blur="showBottomBorder">
            <div class="input-line"></div>
          </div>
          <div class="input-group">
            <input type="text" v-model="psicologo.direccion" class="input-field" placeholder="Dirección del consultorio" @focus="hideBottomBorder" @blur="showBottomBorder">
            <div class="input-line"></div>
          </div>
          <div class="input-group">
            <input type="text" v-model="psicologo.poblacion" class="input-field" placeholder="Población atendida" @focus="hideBottomBorder" @blur="showBottomBorder">
            <div class="input-line"></div>
          </div>
          <div class="input-group">
            <input type="text" v-model="psicologo.formacion" class="input-field" placeholder="Formación del psicólogo" @focus="hideBottomBorder" @blur="showBottomBorder">
            <div class="input-line"></div>
          </div>
          <div class="input-group">
            <input type="text" v-model="psicologo.modalidad" class="input-field" placeholder="Modalidad de consulta" @focus="hideBottomBorder" @blur="showBottomBorder">
            <div class="input-line"></div>
          </div>
          <div class="input-group">
            <input type="file" @change="handleFileUpload" class="input-field" required>
            <div class="input-line"></div>
          </div>
          <div class="input-group">
            <select v-model="psicologo.imagen_fondo" class="input-field" required>
              <option value="" disabled>Seleccione una imagen de fondo</option>
              <option value="http://localhost/BEA/back/uploads/uno.png">Fondo 1</option>
              <option value="http://localhost/BEA/back/uploads/dos.jpg">Fondo 2</option>
              <option value="http://localhost/BEA/back/uploads/tres.png">Fondo 3</option>
            </select>
            <div class="input-line"></div>
          </div>
          <div class="imagen-fondo-preview">
            <img :src="psicologo.imagen_fondo" alt="Vista previa de la imagen de fondo">
          </div>
        </div>
        <button @click="submitForm" class="submit-button">Registrar Psicólogo</button>
      </div>
    </div>
    <div class="contenido-derecha"> 
      <div class="form-container">
        <h2 class="titulo">Eliminar psicólogo</h2>
        <form @submit.prevent="eliminarPsicologo">
          <div class="input-group">
            <select v-model="psicologoEliminar" class="input-field" required>
              <option value="" disabled>Seleccione un psicólogo</option>
              <option v-for="psicologo in psicologos" :key="psicologo.id" :value="psicologo.id">
                {{ psicologo.nombre }}
              </option>
            </select>
          </div>
          <button type="submit" class="submit-button">Eliminar Psicólogo</button>
        </form>
      </div>
    </div>
    </div>
  </div>
  </PlantillaPsico>
</template>

<script>
import axios from 'axios';
import PlantillaPsico from './plantillaPsico.vue';
import Swal from 'sweetalert2';

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
        imagen_fondo: '',
      },
      psicologos: [],
      psicologoEliminar: ''
    };
  },
  methods: {
    handleFileUpload(event) {
      this.psicologo.imagen = event.target.files[0];
    },
    submitForm() {

      if (!this.validateForm()) {
        return;
      }

      const formData = new FormData();
      formData.append('nombre', this.psicologo.nombre);
      formData.append('tipo', this.psicologo.tipo);
      formData.append('telefono', this.psicologo.telefono);
      formData.append('especialidad', this.psicologo.especialidad);
      formData.append('direccion', this.psicologo.direccion);
      formData.append('poblacion', this.psicologo.poblacion);
      formData.append('formacion', this.psicologo.formacion);
      formData.append('modalidad', this.psicologo.modalidad);
      formData.append('imagen', this.psicologo.imagen);
      formData.append('imagen_fondo', this.psicologo.imagen_fondo);

      axios.post('http://localhost/bea/back/insertarPsicologo.php', formData, {
        headers: {
          'Content-Type': 'multipart/form-data'  
        }
      })
      .then(response => {
        Swal.fire({
  icon: 'success',
  title: 'Éxito',
  text: 'Psicólogo registrado con éxito',
  confirmButtonText: 'Aceptar'
}).then(() => {
  window.location.reload();
});
        
      })
      .catch(error => {
        console.error('Ocurrió un error al registrar el psicólogo:', error);
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'Error al registrar el psicólogo',
          confirmButtonText: 'Aceptar'
        });
      });
    },

    validateName() {
      this.psicologo.nombre = this.psicologo.nombre.replace(/[^a-zA-Z\s]/g, '');
    },
    validatePhone() {
      this.psicologo.telefono = this.psicologo.telefono.replace(/\D/g, '').slice(0, 10);
    },
    validateForm() {
      if (!/^[a-zA-Z\s]+$/.test(this.psicologo.nombre)) {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'El nombre solo puede contener letras y espacios',
          confirmButtonText: 'Aceptar'
        });
        return false;
      }
      if (this.psicologo.telefono.length !== 10) {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'El teléfono debe tener 10 dígitos',
          confirmButtonText: 'Aceptar'
        });
        return false;
      }
      // Agrega más validaciones según sea necesario
      return true;
    },

    cargarPsicologos() {
      axios.get('http://localhost/bea/back/obtenerPsicologos.php')
        .then(response => {
          this.psicologos = response.data;
        })
        .catch(error => {
          console.error('Error al cargar los psicólogos:', error);
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Error al cargar los psicólogos. Por favor, inténtalo de nuevo más tarde.',
            confirmButtonText: 'Aceptar'
          });
        });
    },
    eliminarPsicologo() {
      if (!this.psicologoEliminar) {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'Seleccione un psicólogo para eliminar',
          confirmButtonText: 'Aceptar'
        });
        return;
      }
      axios.post('http://localhost/bea/back/eliminarPsicologo.php', {
        id: this.psicologoEliminar
      })
      .then(response => {
        Swal.fire({
          icon: 'success',
          title: 'Éxito',
          text: 'Psicólogo eliminado con éxito',
          confirmButtonText: 'Aceptar'
        });
        this.cargarPsicologos(); 
      })
      .catch(error => {
        console.error('Error al eliminar el psicólogo:', error);
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'Error al eliminar el psicólogo',
          confirmButtonText: 'Aceptar'
        });
      });
    },
    hideBottomBorder() {
      this.$refs.emailInput.style.borderBottom = 'none';
    },
    showBottomBorder() {
      this.$refs.emailInput.style.borderBottom = '2px solid blue';
    },
    changeCursor() {
      this.$refs.emailInput.style.cursor = 'text';
    },
  },
  mounted() {
    this.cargarPsicologos();
  }
};
</script>

<style scoped>

.container {
  display: flex;
  justify-content: space-between;
  background-image: linear-gradient(to bottom, #ff5900, #c21c02);
  z-index: -9999;
}


.login-container {
  display: flex;
  justify-content: center;
  height: 100vh;
  margin-left: 150px;
  margin-bottom: 50px;
  margin-top: 50px;
}


.login-box {
  width: 400px;
  background-color: #f4f4f4;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  

 
}

.content {
  padding: 10px;
}

.titulo {
  padding: 5px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease-in-out; 
  margin-bottom: 10px;
}

.titulo:hover {
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
  transform: translateY(-5px); 
  border: 1px solid #ccc;
}

.titulo {
  margin: 0;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}

.input-group {
  margin-bottom: 15px;
  position: relative;
}

.input-field {
  width: calc(100% - 10px);
  padding: 10px;
  border: none;
  border-bottom: 1px solid #ccc;
  background-color: transparent;
  border-radius: 0;
}

.input-field:focus {
  outline: none;
}

.input-line {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 1px;
  background-color: #007bff;
  transition: all 0.3s ease;
}

.input-field:focus + .input-line {
  height: 2px;
}

.input-field::placeholder {
  color: #555;
}

.imagen-fondo-preview {
  margin-top: 20px;
  margin-bottom: 10px;
}

.imagen-fondo-preview img {
  width: 100%;
  max-width: 150px;
  height: auto;
}

.submit-button {
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  padding: 10px 20px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.submit-button:hover {
  background-color: #0056b3;
}

.form-container {
    width: 300px;
    margin: 0 20px; 
    background-color: #f4f4f4;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-top: 30px;
    padding-left: 40px;
    padding-right: 40px;
    margin-left: 250px;
  }
</style>
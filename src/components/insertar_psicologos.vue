<template>
  <PlantillaPsico>
    <div class="background-image"></div>
    <div>
      <div class="contenido">
        <div class="contenido-izquierda">
          <div class="form-container">
            <div >
              <h1 class="titulo">Registrar nuevo psicólogo</h1>
            </div>
            <form @submit.prevent="submitForm">
              <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" v-model="psicologo.nombre" placeholder="Nombre del psicólogo" required>
              </div>
              <div class="form-group">
                <label for="tipo">Tipo de terapia:</label>
                <input type="text" id="tipo" v-model="psicologo.tipo" placeholder="Tipo de terapia" required>
              </div>
              <div class="form-group">
                <label for="telefono">Teléfono:</label>
                <input type="text" id="telefono" v-model="psicologo.telefono" placeholder="Teléfono de contacto" required>
              </div>
              <div class="form-group">
                <label for="especialidad">Especialidad:</label>
                <textarea id="especialidad" v-model="psicologo.especialidad" placeholder="Especialidad del psicólogo" required></textarea>
              </div>
              <div class="form-group">
                <label for="direccion">Dirección:</label>
                <input type="text" id="direccion" v-model="psicologo.direccion" placeholder="Dirección del consultorio" required>
              </div>
              <div class="form-group">
                <label for="poblacion">Población atendida:</label>
                <input type="text" id="poblacion" v-model="psicologo.poblacion" placeholder="Población atendida" required>
              </div>
              <div class="form-group">
                <label for="formacion">Formación:</label>
                <textarea id="formacion" v-model="psicologo.formacion" placeholder="Formación del psicólogo" required></textarea>
              </div>
              <div class="form-group">
                <label for="modalidad">Modalidad:</label>
                <input type="text" id="modalidad" v-model="psicologo.modalidad" placeholder="Modalidad de consulta" required>
              </div>
              <div class="form-group">
                <label for="imagen">Imagen del Psicólogo:</label>
                <input type="file" id="imagen" @change="handleFileUpload" required>
              </div>
              <label for="imagen_fondo">Imagen de fondo:</label>
              <select id="imagen_fondo" v-model="psicologo.imagen_fondo" required>
                <option value="" disabled>Seleccione una imagen de fondo</option>
                <option value="http://localhost/BEA/back/uploads/uno.png">Fondo 1</option>
                <option value="http://localhost/BEA/back/uploads/dos.jpg">Fondo 2</option>
                <option value="http://localhost/BEA/back/uploads/tres.png">Fondo 3</option>
              </select>
              <div class="imagen-fondo-preview">
                <img :src="psicologo.imagen_fondo" alt="Vista previa de la imagen de fondo">
              </div>
              <button type="submit" class="titulo">Registrar Psicólogo</button>
            </form>
          </div>
        </div>

        <div class="contenido-derecha">
          <div class="form-container">
            <div >
              <h1 class="titulo">Eliminar psicólogo</h1>
            </div>
            <form @submit.prevent="eliminarPsicologo">
              <div class="form-group">
                <label for="psicologoEliminar">Seleccione un psicólogo:</label>
                <select id="psicologoEliminar" class="eliminar-opciones" v-model="psicologoEliminar" required>
                  <option value="" disabled>Seleccione un psicólogo</option>
                  <option v-for="psicologo in psicologos" :key="psicologo.id" :value="psicologo.id">
                    {{ psicologo.nombre }}
                  </option>
                </select>
              </div>
              <button type="submit" class="titulo">Eliminar Psicólogo</button>
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
      formData.append('imagen', this.psicologo.imagen);  // Imagen del psicólogo
      formData.append('imagen_fondo', this.psicologo.imagen_fondo);  // Imagen de fondo

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
    abrirEnlace(url) {
      window.location.href = url;
    },
    redirigirPerfil(perfil) {
      this.$router.push(perfil);
    },
  },
  mounted() {
    this.cargarPsicologos();
  }
};
</script>

<style scoped>
.background-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 120%;
  background-image: linear-gradient(to bottom, #ff5900, #c21c02);
  background-size: cover;
  z-index: -1;
}

.eliminar-opciones {
  margin-bottom: 20px;
}

.contenido {
  flex: 1;
  display: flex;
  background-image: linear-gradient(to bottom, #ff5900, #c21c02);
}

.contenido-derecha {
  flex: 50%;
  padding-left: 50px;
}

.contenido-izquierda {
  flex: 30%;
  padding-right: 60px;
  padding-left: 100px;
}

.form-container {
  max-width: 500px;
  margin: 40px auto;
  padding: 40px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  background-color: aliceblue;
  border-radius: 10px;
}

.imagen-fondo-preview {
  margin-top: 30px;
  margin-bottom: 30px;
  margin-left: 65px;
}

.imagen-fondo-preview img {
  width: 100%;
  max-width: 300px;
  height: auto;
  display: block;
  margin-top: 5px;
}

.form-group {
  margin-bottom: 10px;
}

.form-group label {
  display: block;
  font-weight: bold;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.form-group textarea {
  width: 100%;
  min-height: 100px;
  padding: 8px;
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 5px;
  resize: none;
}

.titulo {
  padding: 5px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease-in-out;
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
}

button {
  background-color: #fcfcfc;
  font-size: 18px;
  color: black;
}
</style>

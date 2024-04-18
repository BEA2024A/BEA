<template>
  <PlantillaPsico>
    <div class="background-image"></div>
    <div>
    <div class="contenido">
    <div class="contenido-derecha">
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
    </div>
    <div class="contenido-izquierda">
      <div class="fondo-psicologos">
      <section class="seccion-psicologos">
        <h1>Psicólogos Actuales</h1>
        <div class="profile-cards">
          <div v-for="(psicologo, index) in psicologos" :key="index" class="card" @mouseenter="psicologo.mostrarDescripcion = true" @mouseleave="psicologo.mostrarDescripcion = false">
            <img :src="psicologo.imagen" alt="Foto de perfil">
            <div class="descripcion-psicologo" :class="{ 'mostrar-descripcion': psicologo.mostrarDescripcion }">
              <h3>{{ psicologo.nombre }}</h3>
              <p class="title">{{ psicologo.puesto }}</p>
            </div>
          </div>
        </div>
      </section>
    </div>
    </div>
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
    },
    cargarPsicologos() {
      axios.get('http://localhost/bea/back/obtenerPsicologos.php')
        .then(response => {
          this.psicologos = response.data.map(psicologo => ({
            ...psicologo,
            perfil: `/ps1/${psicologo.id}` // Asigna un perfil dinámico basado en el ID
          }));
        })
        .catch(error => {
          console.error('Error al cargar los psicólogos:', error);
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

  .contenido {
      flex: 1;
      display: flex;
    }
    
    .contenido-derecha {
      flex: 40%;
      
    }
    
    .contenido-izquierda {
      flex: 60%;
      padding-right: 60px;
      padding-left: 100px;
    }


  .seccion-psicologos {
    margin: 30px;
    background-color:#ffffff ;
    border-radius: 10px;
    padding: 30px;
   
  }

  .seccion-psicologos h1 {
    font-size: 28px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    background-color: rgba(240, 248, 255, 0.788);
    padding: 20px;
    border-radius: 10px;
    margin-left: 10px;
    transition: font-size 0.3s;
  }
  .seccion-psicologos h1:hover {
    font-size: 32px; 
  }

  .profile-cards {
  background-color: rgb(255, 255, 255);
  display: flex;
  justify-content: space-around; 
  flex-wrap: wrap;
}

  .card {
    text-align: center;
    transition: transform 0.3s ease;
    position: relative;
  }
  .card:hover {
    transform: scale(1.02);
  }
  .card img {
  border-radius: 10px;
    box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
    width: 100%;
    height: 250px; 
    object-fit: cover; 
    animation: slideIn 1s ease forwards;
  }
  .descripcion-psicologo {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: rgba(19, 17, 17, 0.9);
    padding: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    text-align: center;
    transition: opacity 0.3s ease;
    opacity: 0;
    color :rgb(255, 255, 255);
  }
  .mostrar-descripcion {
    opacity: 1;
  }
  
  button {
    background-color: #fcfcfc;
    font-size: 18px;
    color:black;
  }

</style>

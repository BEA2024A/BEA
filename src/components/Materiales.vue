<template>
  <plantilla-psico>
    <div class="background-image"></div>
    <div>
      <div class="contenido">
        <div class="contenido-derecha">
          <div class="form-container">
            <h1 class="titulo">Registrar nuevo material</h1>
            <form @submit.prevent="submitForm">
              <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" v-model="material.nombre" placeholder="Nombre del material" required>
              </div>
              <div class="form-group">
                <label for="autor">Autor:</label>
                <input type="text" id="autor" v-model="material.autor" placeholder="Nombre del autor" required>
              </div>
              <div class="form-group">
                <label for="area">Área que ayuda:</label>
                <input type="text" id="area" v-model="material.area" placeholder="Área a la que pertenece el material" required>
              </div>
              <div class="form-group">
                <label for="tipo">Tipo de media:</label>
                <input type="text" id="tipo" v-model="material.tipo" placeholder="Tipo de material (video, libro o blog)" required>
              </div>
              <div class="form-group">
                <label for="link">Link del material:</label>
                <input type="text" id="link" v-model="material.link" placeholder="Enlace al material" required>
              </div>
              <div class="form-group">
                <label for="imagen">Imagen del Material:</label>
                <input type="file" id="imagen" @change="handleFileUpload" required>
              </div>
              <button type="submit" class="titulo">Registrar Material</button>
            </form>
          </div>
          
          <div class="form-container">
            <h1 class="titulo">Eliminar material</h1>
            <form @submit.prevent="eliminarMaterial">
              <div class="form-group">
                <label for="materialEliminar">Seleccione un material:</label>
                <select id="materialEliminar" class="eliminar-opciones" v-model="materialEliminar" required>
                  <option value="" disabled>Seleccione un material</option>
                  <option v-for="material in materiales" :key="material.id" :value="material.id">
                    {{ material.nombre }}
                  </option>
                </select>
              </div>
              <button type="submit" class="titulo">Eliminar</button>
            </form>
          </div>
        </div>

        
      </div>
    </div>
  </plantilla-psico>
</template>

<script>
import axios from 'axios';
import PlantillaPsico from './plantillaPsico.vue';
import Swal from 'sweetalert2';
import VueSweetalert2 from 'vue-sweetalert2';

export default {
  components: {
    PlantillaPsico,
  },
  data() {
    return {
      material: {
        nombre: '',
        autor: '',
        area: '',
        tipo: '',
        link: '',
        imagen: null,
      },
      materiales: [],
      materialEliminar: ''
    };
  },
  methods: {
    handleFileUpload(event) {
      this.material.imagen = event.target.files[0];
    },
    submitForm() {
      if (!["blog", "libro", "video"].includes(this.material.tipo.toLowerCase())) {
        Swal.fire('¡Error!', 'El tipo de media debe ser "blog", "libro" o "video"', 'error');
        return;
      }

      const formData = new FormData();
      formData.append('nombre', this.material.nombre);
      formData.append('autor', this.material.autor);
      formData.append('area', this.material.area);
      formData.append('tipo', this.material.tipo);
      formData.append('link', this.material.link);
      formData.append('imagen', this.material.imagen);

      axios.post('http://localhost/bea/back/insertarMaterial.php', formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(response => {
        Swal.fire('¡Éxito!', 'Material registrado con éxito', 'success');
        window.location.reload();
      })
      .catch(error => {
        console.error('Ocurrió un error al registrar el material:', error);
        Swal.fire('¡Error!', 'Error al registrar el material', 'error');
      });
    },
    eliminarMaterial() {
      if (!this.materialEliminar) {
        Swal.fire('¡Advertencia!', 'Seleccione un material para eliminar', 'warning');
        return;
      }
      axios.post('http://localhost/bea/back/eliminarMaterial.php', {
        id: this.materialEliminar
      })
      .then(response => {
        Swal.fire('¡Éxito!', 'Material eliminado con éxito', 'success');
        this.cargarMateriales(); 
      })
      .catch(error => {
        console.error('Error al eliminar el material:', error);
        Swal.fire('¡Error!', 'Error al eliminar el material', 'error');
      });
    },
    cargarMateriales() {
      axios.get('http://localhost/bea/back/obtenerMateriales.php')
        .then(response => {
          this.materiales = response.data.map(material => ({
            ...material,
            perfil: `/material/${material.id}`
          }));
        })
        .catch(error => {
          console.error('Error al cargar los materiales:', error);
        });
    },
  },
  mounted() {
    this.cargarMateriales();
  }
};
</script>

<style scoped>
.form-container {
  max-width: 500px; 
  margin: 40px auto;
  padding: 40px; 
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
  background-color: white; 
  border-radius: 10px; 
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
  margin-top: 20px;
  width: 100%;
  padding: 8px; 
  box-sizing: border-box;
  border: 1px solid #ccc; 
  border-radius: 5px; 
}

.form-group textarea {
  width: 100%;
  min-height:100px; 
  padding: 8px;
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 5px;
  resize: none; 
}

 .titulo{
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

.titulo{
  margin: 0;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}

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

  .eliminar-opciones{
    margin-bottom: 20px;
    display: flexbox;
  }

  .contenido {
      flex: 1;
      display: flex;
      background-image: linear-gradient(to bottom, #ff5900, #c21c02);
    }
    
    .contenido-derecha {
      flex: 40%;
      padding-left: 50px;
    }
    
    .contenido-izquierda {
      flex: 60%;
      padding-right: 60px;
      padding-left: 100px;
    }


    .contenido-izquierda .fondo-materiales {
  margin: 30px;
  background-color: #ffffff;
  border-radius: 10px;
  padding: 20px;
}

.contenido-izquierda .fondo-materiales .seccion-materiales h1 {
  font-size: 28px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  background-color: rgba(240, 248, 255, 0.788);
  padding: 20px;
  border-radius: 10px;
  margin-left: 10px;
  transition: font-size 0.3s;
}

.contenido-izquierda .fondo-materiales .seccion-materiales h1:hover {
  font-size: 32px;
}

.contenido-izquierda .fondo-materiales .material-cards {
  background-color: rgb(255, 255, 255);
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
}

.contenido-izquierda .fondo-materiales .material-cards .card {
  text-align: center;
  transition: transform 0.3s ease;
  position: relative;
}

.contenido-izquierda .fondo-materiales .material-cards .card:hover {
  transform: scale(1.02);
}

.contenido-izquierda .fondo-materiales .material-cards .card img {
  border-radius: 10px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  width: 100%;
  height: 250px;
  object-fit: cover;
  animation: slideIn 1s ease forwards;
}

.contenido-izquierda .fondo-materiales .material-cards .descripcion-material {
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
  color: rgb(255, 255, 255);
}

.contenido-izquierda .fondo-materiales .material-cards .mostrar-descripcion {
  opacity: 1;
}

.descripcion-material {
  display: none;
}

.mostrar-descripcion {
  display: block;
}


  
  button {
    background-color: #fcfcfc;
    font-size: 18px;
    color:black;
  }

</style>
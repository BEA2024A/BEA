<template>
  <plantilla-psico>
    <div class="contenido">
      <router-view></router-view>
      
      <div class="cabecera" v-if="loaded">
       
        <div class="info-izquierda" ref="infoIzquierda">
          <h1>{{ usuario.nombre }} {{usuario.a_paterno }} {{ usuario.a_materno }}</h1>

          <p>id: 00{{ usuario.id }}</p>
        </div>
     
        <div class="imagen-derecha" ref="imagenDerecha">
          <div class="circulo-con-sombra">
            <img :src="usuario.foto_perfil" alt="Imagen del psicoterapeuta">
          </div>
        </div>

       
        <button class="boton-scroll" @click="scrollDown">
          <img class="icono-scroll" src="https://cdn-icons-png.freepik.com/512/9923/9923629.png" alt="Icono de scroll-down">
        </button>
      </div>
      </div>
      <section class="seccion-alumnos">
        <h1>Alumnos</h1>
        <section class="seccion-busqueda">
        <h2>Buscar por:</h2>
        <select v-model="filtro.opcion" class="menu">
          <option value="nombre">Nombre</option>
          <option value="carrera">Carrera</option>
          <option value="ide">Id</option>
        </select>
        <input type="text" v-model="filtro.valor" placeholder="Buscar...">
        </section>
        <div class="profile-cards">
          <div v-for="(alumno, index) in alumnosFiltrados.slice(0, cantidadMostrada)" :key="index" class="card" v-on:mouseenter="mostrarDescripcion(alumno, true)" v-on:mouseleave="mostrarDescripcion(alumno, false)">
            <img v-bind:src="alumno.imagen" alt="Foto de perfil">
            <div class="descripcion-alumno" v-bind:class="{ 'mostrar-descripcion': alumno.mostrarDescripcion }">
              <h3>{{ alumno.nombre }}</h3>
              <p class="title">{{ alumno.carrera }}</p>
              <p>00{{ alumno.ide }}</p>
              <p><button v-on:click="redirigirPerfil(alumno.perfil)">Ir al perfil</button></p>
              <p><button v-on:click="redirigirPerfil(alumno.notas)">Notas</button></p>
            </div>
          </div>
        </div>
        <div class="botones-container">
          <button v-if="alumnosFiltrados.length> cantidadMostrada" @click="cargarMas" class="ver-mas-btn"> Ver más </button>
          <button v-if="alumnosFiltrados.length> cantidadMostrada" @click="cargarMenos" class="ver-menos-btn"> Ver menos </button>
          </div>
      </section>

      

  </plantilla-psico>
</template>
<script>
import PlantillaPsico from './plantillaPsico.vue';
import axios from 'axios';
import { mapGetters } from 'vuex';

export default {
  components: {
    PlantillaPsico,
  },
  data() {
    return {
      alumnos: [],
      
      filtro: {
        opcion: 'nombre',
        valor: ''
      },
      loaded: false,
      cantidadInicial: 8, 
      incrementoCarga: 4, 
      cantidadMostrada: 8, 
    };
  },

  computed: {
    alumnosFiltrados() {
      if (this.filtro.valor.trim() === '') return this.alumnos;
      return this.alumnos.filter(alumno => {
        if (this.filtro.opcion === 'nombre') {
          return alumno.nombre.toLowerCase().includes(this.filtro.valor.toLowerCase());
        } else if (this.filtro.opcion === 'carrera') {
          return alumno.carrera.toLowerCase().includes(this.filtro.valor.toLowerCase());
        } else if (this.filtro.opcion === 'ide') {
          return alumno.ide.toString().includes(this.filtro.valor);
        }
      });
    },
    ...mapGetters(['usuario']),
  },

  mounted() {
    setTimeout(() => {
      this.loaded = true;
    }, 5);
    this.cargarAlumnos();
  },

  methods: {
    cargarAlumnos() {
  if (this.usuario && this.usuario.id) {
    axios.get(`http://localhost/BEA/back/perfilesAlumnos.php?idPsicologo=${this.usuario.id}`)
      .then(response => {
        this.alumnos = response.data.map(alumno => ({
          ...alumno,
          perfil: `/perfil/${alumno.ide}`,
          notas: `/Notas/${alumno.ide}`,
          mostrarDescripcion: false,
        }));
        this.cantidadMostrada = this.cantidadInicial;
      })
      .catch(error => {
        console.error('Error al cargar los alumnos:', error);
      });
  }
},

    redirigirPerfil(perfil) {
      this.$router.push(perfil);
    },

    mostrarDescripcion(alumno, mostrar) {
      alumno.mostrarDescripcion = mostrar;
    },

    cargarMas() {
      this.cantidadMostrada += this.incrementoCarga;
    },
    cargarMenos() {
    this.cantidadMostrada -= this.incrementoCarga;
    if (this.cantidadMostrada < this.cantidadInicial) {
      this.cantidadMostrada = this.cantidadInicial;
    }
  },
    
  }
};
</script>

<style>
@keyframes fadeIn {
  from {
    opacity: 0; /* Opacidad inicial */
  }
  to {
    opacity: 1; /* Opacidad final */
  }
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-50px); 
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes bounce{
  0% {transform: translateY(0);}
  40%{transform: translateY(-20px);}
  60%{transform: translateY(-10px);}
  80%{transform: translateY(-20px);}
  100%{transform: translateY(0);}
}


.cabecera {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100vh; /* Ajusta la altura al 100% del viewport */
  
}

.cabecera::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url('https://8377358.fs1.hubspotusercontent-na1.net/hub/8377358/hubfs/custom-video-thumbnails/AOX%20-%20C%C3%A1psula%20de%20Oferta%20Educativa-thumb.jpeg?length=1920');
  background-size: cover;
  background-position: center;
  filter: brightness(0.5); /* Se aplica el filtro de oscuridad solo a la imagen de fondo */
}

/* Estilos para el contenido dentro de la cabecera */
.info-izquierda{
  z-index: 1;
  margin: 0 auto; 
  animation: slideIn 1s ease forwards; /* Animación de aparición */
}
.imagen-derecha {
  z-index: 1; 
  margin: 0 auto; 
  animation: slideIn 1s ease forwards;
}

.info-izquierda h1 {
  text-shadow: 0 0 20px rgba(0, 0, 0, 0.705); 
  color: aliceblue;
}

.info-izquierda h3 {
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); 
  background-color: rgba(240, 248, 255, 0.603);
  display: inline-block;
  padding: 10px 20px;
  border-radius: 5px;
  margin-left: 10px;
}
.info-izquierda p{
  color:aliceblue;
}


.imagen-derecha {
  margin-left: 20px;
}

.circulo-con-sombra {
  width: 350px; 
  height: 350px; 
  border-radius: 50%; 
  overflow: hidden; 
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); 
}

.circulo-con-sombra img {
  width: 100%;
  height: 100%;
  object-fit: cover; 
}

.boton-scroll {
  position: absolute;
  bottom: 120px; /* Distancia desde la parte inferior */
  left: 50%; /* Centrar horizontalmente */
  transform: translateX(-50%); /* Centrar horizontalmente */
  right: 50%; 
  transform: translateY(-50%); /* Centrar horizontalmente */
  background-color: rgba(240, 248, 255, 0.603); /* Color de fondo */
  border: none; /* Sin borde */
  border-radius: 50%; /* Botón circular */
  width: 60px; /* Ancho del botón */
  height: 60px; /* Altura del botón */
  font-size: 24px; /* Tamaño del ícono */
  color: #000; /* Color del ícono */
  cursor: pointer; /* Cursor de puntero al pasar sobre el botón */
  transition: background-color 0.3s; /* Transición suave al cambiar de color */
  transition: transform 0.3s;
  animation: fadeIn 5s ease forwards;
  animation: bounce 2s infinite;
}
.icono-scroll {
  margin-top: 3px;
  width: 40px; /* Tamaño del icono */
  height: 40px; /* Tamaño del icono */
  transition: transform 0.3s;
}

.icono-scroll:hover{
  transform: scale(1.2);
}

.boton-scroll:hover {
  background-color: rgba(200, 220, 255, 0.8); /* Color de fondo al pasar el cursor */
  transform: scale(1.2);
}

  .seccion-alumnos {
    text-align: center;
    margin-top: 100px;
    margin-bottom: 50px;
  }
  
  .seccion-alumnos h1 {
    font-size: xx-large;
  }
  
  .profile-cards {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    background-color: rgba(0, 0, 0, 0.089);
  }
  
  .card {
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
    width: 300px;
    height: 300px;
    margin: 25px;
    text-align: center;
    transition: transform 0.3s ease;
    position: relative;
  }
  
  .card:hover {
    transform: scale(1.02);
  }
  
  .card img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
  }
  
  .descripcion-alumno {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: rgba(255, 255, 255, 0.9);
    padding: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    text-align: center;
    transition: opacity 0.3s ease;
    opacity: 0;
  }
  
  .mostrar-descripcion {
    opacity: 1;
  }
  
  .title {
    color: grey;
    font-size: 18px;
  }
  
  button {
    border: none;
    outline: 0;
    display: inline-block;
    padding: 8px;
    color: white;
    background-color: #000000;
    text-align: center;
    cursor: pointer;
    width: 100%;
    font-size: 18px;
  }
  
  button:hover,
  a:hover {
    opacity: 0.7;
  }
  


  .perfil-header {
    margin-top: 0px;
    margin-bottom: 60px;
    background-color: #2e271f;
    height: 200px; 
    position: relative;
  }
  
  .barra-color {
    position: absolute;
    top: 0;
    right: 0;
    width: 20px; 
    height: 100%;
  }
  
  .circulo {
    width: 190px; 
    height: 190px; 
    background-color: #2e271f; 
    border-radius: 50%; 
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    right: 100px; 
    background-size: contain; 
    background-position: center; 
  }
  
  .titulo-psicoterapeuta {
    position: absolute;
    top: 0%;
    transform: translateY(-50%);
    color: white;
    font-weight: bold;
    left: 50px;
    top: 80px;
  }
  .campo-busqueda {
  margin: 20px auto; 
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 50px; 
  width: calc(100% - 20px);
  box-sizing: border-box;
  font-size: 16px;
}

.campo-busqueda:focus {
  outline: none;
  box-shadow: 0 0 3px 0 #6c63ff;
}

.seccion-busqueda {
    margin-bottom: 20px;
    padding: 10px;
    border-radius: 5px;
  }

  .seccion-busqueda h2 {
    margin-bottom: 10px;
    border-radius: 50px;
  }

  .seccion-busqueda select,
  .seccion-busqueda input[type="text"] {
    padding: 8px;
    margin-right: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    border-radius: 50px;
  }

  .seccion-busqueda button {
    padding: 8px 20px;
    border: none;
    border-radius: 5px;
    background-color: orangered;
    color: white;
    font-size: 16px;
    cursor: pointer;
    border-radius: 50px;
  }

  .seccion-busqueda button:hover {
    background-color: orange;
  }

  .menu {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
  }

  .menu:focus {
    outline: none;
  }

  .botones-container {
  display: flex; 
  justify-content: space-between;
}

.ver-mas-btn,
.ver-menos-btn {
  background-color: #ff7d37; 
  color: white; 
  padding: 10px 20px; 
  border: none;
  border-radius: 10px; 
  font-size: 16px; 
  cursor: pointer; 
  transition: background-color 0.3s ease; 
  margin-left: 20px;
  margin-right: 20px;
  margin-bottom: 20px;
}

.ver-mas-btn:hover,
.ver-menos-btn:hover {
  background-color: #ff5900; 
}


@media only screen and (max-width: 767px){


.info-izquierda h1 {
  transform: translate(47%, 90%);
}


.info-izquierda p{
  transform: translate(47%, 350%);
}


.imagen-derecha {
  margin-left: 200px;
}

.circulo-con-sombra {
  width: 250px; 
  height: 250px; 
  transform: translate(-130%, -50%);
}


.boton-scroll {
display: none;
}

}


@media only screen and (min-width: 768px) and (max-width: 991px){


.info-izquierda h1 {
  transform: translate(70%, 130%);
  font-size: 50px;
}


.info-izquierda p{
  transform: translate(70%, 500%);
  font-size: 25px;
}


.imagen-derecha {
  margin-left: 200px;
}

.circulo-con-sombra {
  width: 500px; 
  height: 500px; 
  transform: translate(-75%, -40%);
}


.boton-scroll {
display: none;
}

}

</style>
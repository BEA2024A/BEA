<template>
  <plantilla-psico>
    <div class="contenido">
      <router-view></router-view>
      <!-- Cabecera con animación de aparición -->
      <div class="cabecera" v-if="loaded">
        <!-- Lado izquierdo: Nombre y especialidad -->
        <div class="info-izquierda" ref="infoIzquierda">
          <h1>{{ usuario.nombre }} {{usuario.a_paterno }} {{ usuario.a_materno }}</h1>

          <p>id: 00{{ usuario.id }}</p>
        </div>
        <!-- Lado derecho: Imagen en círculo con sombra naranja -->
        <div class="imagen-derecha" ref="imagenDerecha">
          <div class="circulo-con-sombra">
            <img :src="imagenPsicologo[0]" alt="Imagen del psicoterapeuta">
          </div>
        </div>

        <!-- Botón de scroll-down con el icono proporcionado -->
        <button class="boton-scroll" @click="scrollDown">
          <img class="icono-scroll" src="https://cdn-icons-png.freepik.com/512/9923/9923629.png" alt="Icono de scroll-down">
        </button>
      </div>
      </div>
      <section class="seccion-alumnos">
        <h1>Alumnos</h1>
        <input type="text" v-model="filtro" placeholder="Buscar por nombre, ID o carrera" class="campo-busqueda">
        <div class="profile-cards">
          <div v-for="(alumno, index) in alumnosFiltrados" :key="index" class="card" v-on:mouseenter="mostrarDescripcion(alumno, true)" v-on:mouseleave="mostrarDescripcion(alumno, false)">
            <img v-bind:src="alumno.imagen" alt="Foto de perfil">
            <div class="descripcion-alumno" v-bind:class="{ 'mostrar-descripcion': alumno.mostrarDescripcion }">
              <h3>{{ alumno.nombre }}</h3>
              <p class="title">{{ alumno.carrera }}</p>
              <p>{{ alumno.ide }}</p>
              <p><button v-on:click="redirigirPerfil(alumno.perfil)">Perfil</button></p>
              <p><button v-on:click="redirigirPerfil(alumno.notas)">Notas</button></p>
            </div>
          </div>
        </div>
      </section>

  </plantilla-psico>
</template>

<script>
import PlantillaPsico from './plantillaPsico.vue';
import { mapGetters, mapActions } from 'vuex';
export default {
  components: {
    PlantillaPsico,
  },
  data() {
    return {
      filtro: '', 
      alumnos: [
  { nombre: 'Carlos González', carrera: 'Tecnologias de la Información', ide:456641, perfil: '/perfil', notas: '/Notas', imagen: 'https://i.postimg.cc/05WbLPJJ/Dise-o-sin-t-tulo.png', mostrarDescripcion: false },
  { nombre: 'Antonio Garcia', carrera: 'Tecnologias de la Información', ide: 456732, perfil: '/perfil', notas: '/Notas',imagen: 'https://i.postimg.cc/3NXPFHgV/Dise-o-sin-t-tulo-1.png', mostrarDescripcion: false },
  { nombre: 'Tadeo Martinez', carrera: 'Tecnologias de la Información', ide: 458931, perfil: '/perfil', notas: '/Notas', imagen: 'https://i.postimg.cc/d3wtzQ8g/Dise-o-sin-t-tulo-2.png', mostrarDescripcion: false },
  { nombre: 'Luisa Fernandez', carrera: 'Ingeniería Civil', ide: 134567, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Javier Martinez', carrera: 'Medicina', ide: 768593, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Sofia Lopez', carrera: 'Diseño Gráfico', ide: 245679, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Diego Ramirez', carrera: 'Arquitectura', ide: 978452, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Valentina Torres', carrera: 'Psicología', ide: 123456, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Mariano Fernandez', carrera: 'Biología', ide: 789012, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Carlos González', carrera: 'Contaduría', ide: 345678, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Luis Martinez', carrera: 'Derecho', ide: 890123, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Elena Rodriguez', carrera: 'Administración de Empresas', ide: 567890, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Juan Pablo Suarez', carrera: 'Tecnologias de la Información', ide: 234567, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Maria Rodriguez', carrera: 'Ingeniería Industrial', ide: 890123, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Nicolas Gonzalez', carrera: 'Tecnologias de la Información', ide: 345678, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Florencia Lopez', carrera: 'Medicina', ide: 678901, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Alejandro Martinez', carrera: 'Diseño Gráfico', ide: 456789, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Valeria Ramirez', carrera: 'Arquitectura', ide: 901234, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Manuel Suarez', carrera: 'Psicología', ide: 678901, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false },
  { nombre: 'Carla Fernandez', carrera: 'Biología', ide: 123456, perfil: '/perfil', notas: '/Notas', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', mostrarDescripcion: false }
      ],
      imagenPsicologo: [
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
      ],
      loaded: false,
    };
  },

  mounted() {
    setTimeout(() => {
      this.loaded = true;
    }, 500);
  },

  computed: {
    alumnosFiltrados() {
      const filtroLowerCase = this.filtro.toLowerCase();
      return this.alumnos.filter(alumno =>
        alumno.nombre.toLowerCase().includes(filtroLowerCase) ||
        String(alumno.ide).includes(this.filtro) ||
        alumno.carrera.toLowerCase().includes(filtroLowerCase)
      );
    },
    ...mapGetters(['usuario']),
  },
  methods: {
    redirigirPerfil(perfil) {
      this.$router.push(perfil);
    },
    mostrarDescripcion(alumno, mostrar) {
      alumno.mostrarDescripcion = mostrar;
    },
    scrollDown() {
      window.scrollBy({
        top: window.innerHeight, // Cantidad de desplazamiento (una ventana completa)
        behavior: 'smooth' // Efecto de desplazamiento suave
      });
    }
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
  margin-left: 200px;
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
    max-width: 300px;
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
  
  @media only screen and (max-width: 600px) {
    .card {
      max-width: calc(50% - 30px); 
      margin: 15px;
    }
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
  </style>
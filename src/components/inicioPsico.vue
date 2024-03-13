<template>
  <plantillaPsico>
    <div class="contenido">
      <router-view></router-view>
      <div class="perfil-header">
        <!-- Título del psicoterapeuta -->
        <h1 class="titulo-psicoterapeuta">PSICOTERAPEUTA</h1>
        <!-- Barra de color con círculo -->
        <div class="barra-color">
          <div class="circulo" :style="{ backgroundImage: 'url(' + imagenPsicologo[0] + ')' }"></div>
        </div>
      </div>
      <section class="seccion-alumnos">
        <h1>Alumnos</h1>
        <div class="profile-cards">
          <div v-for="(alumno, index) in alumnos" :key="index" class="card" @mouseenter="alumno.mostrarDescripcion = true" @mouseleave="alumno.mostrarDescripcion = false">
            <img :src="alumno.imagen" alt="Foto de perfil">
            <div class="descripcion-alumno" :class="{ 'mostrar-descripcion': alumno.mostrarDescripcion }">
              <h3>{{ alumno.nombre }}</h3>
              <p class="title">{{ alumno.carrera }}</p>
              <p>{{ alumno.edad }}</p>
              <p><button @click="redirigirPerfil(alumno.perfil)">Ir al perfil</button></p>
            </div>
          </div>
        </div>
      </section>
    </div>
  </plantillaPsico>
</template>

<script>
import plantillaPsico from './plantillaPsico.vue';

export default {
  components: {
    plantillaPsico,
  },
  data() {
    return {
      alumnos: [
        { nombre: 'Carlos Gonsalez', carrera: 'Tecnologias de la Información', edad: 23, perfil: '/perfil', imagen: 'https://i.postimg.cc/SRQkK6jX/MTRA-SYLVIA-GUTI-RREZ-CANDIANI.png' },
        { nombre: 'Carlos Gonzales', carrera: 'Medicina', edad: 23, perfil: '/perfil', imagen: 'https://i.postimg.cc/SRQkK6jX/MTRA-SYLVIA-GUTI-RREZ-CANDIANI.png' },
        { nombre: 'Carlos Gonzales', carrera: 'Administración', edad: 23, perfil: '/perfil', imagen: 'https://i.postimg.cc/SRQkK6jX/MTRA-SYLVIA-GUTI-RREZ-CANDIANI.png' }
      ],
      imagenPsicologo: [
        "https://i.postimg.cc/NFNY2Krd/DRA-ELVIRA-GOPAR-CANSECO.png"
      ]
    };
  },
  methods: {
    redirigirPerfil(perfil) {
      this.$router.push(perfil);
    }
  }
};
</script>
  
  <style>
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
  </style>
  
  
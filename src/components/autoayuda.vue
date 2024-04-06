<template>
  <plantilla>
    <!-- Contenido de la Página -->
    <div class="contenido-pagina">
      <router-view></router-view>
      
      <!-- Sección de Autoayuda -->
      <section class="banner-autoayuda">
        <div class="fondo-autoayuda">
          <img src="https://media.vogue.mx/photos/5dbc6b50b9285b0009b39d16/16:9/w_1920,h_1080,c_limit/Meditation004-vogueint-24oct19-GettyImages-.jpg" alt="Banner Autoayuda">
        </div>
        <div class="titulo-autoayuda">
          <h1>AUTOAYUDA</h1>
          <p>El cambio empieza por ti</p>
        </div>
        <!-- Botón de scroll-down -->
        <button class="boton-scroll" @click="scrollDown">
          <img class="icono-scroll" src="https://cdn-icons-png.freepik.com/512/9923/9923629.png" alt="Icono de scroll-down">
        </button>
      </section>

   <!-- Sección de Blog -->
   <section class="seccion-blog">
        <div class="titulo-blog">
          <h3>Descubre artículos y consejos para mejorar tu bienestar</h3>
        </div>
        <div class="contenedor-entradas">
          <div class="entrada-blog" v-for="(entrada, index) in entradasBlog" :key="index">
            <h3>{{ entrada.titulo }}</h3>
            <a :href="entrada.link" target="_blank">
              <img :src="entrada.imagen" alt="Imagen de entrada de blog">
            </a>
            <p>{{ entrada.contenido }}</p>
          </div>
        </div>
      </section>

    <!-- Sección de Videos de Meditación -->
<section class="seccion-videos">
  <div class="titulo-videos">
    <h2>Relájate con estos videos de meditación</h2>
    <div class="contenedor-videos">
      <div class="video" v-for="(video, index) in videos" :key="index">
        <div class="video-overlay-btn">
          <button class="open-video-btn" @click="openVideo(index)"></button>
        </div>
  <iframe width="430" height="300" :src="video.link" frameborder="0" allowfullscreen></iframe>
          </div>
        </div>
  </div>
</section>

<!-- Cuadro de superposición para el video -->
<div class="video-overlay" v-if="showVideo">
  <div class="video-container">
    <iframe width="800" height="500" :src="currentVideoLink" frameborder="0" allowfullscreen></iframe>
    <button class="close-video-btn" @click="closeVideo">
    <img class="icono-cerrar" src="https://cdn-icons-png.flaticon.com/512/1828/1828774.png">
    </button>
  </div>
</div>
  
<!-- Sección de Mensaje e Opciones -->
<section class="seccion-opciones">
  <div class="mensaje-importante">
    <h1>Recueda que trabajar contigo mismo es importante</h1>
    <p>en BEA nos queremos apoyarte a hacerlo</p>
  </div>
  <div class="opciones">
    <div class="opcion">
      <router-link to="/PrimeraCita">
        <button class="boton-opcion">Agenda tu primera cita</button>
      </router-link>
    </div>
    <div class="opcion">
      <router-link to="/Seguimiento">
        <button class="boton-opcion">Administra tu seguimiento</button>
      </router-link>
    </div>
  </div>
</section>

    </div>
  </plantilla>
</template>

<script>
import Plantilla from './plantilla.vue';

export default {
  components: {
    Plantilla,
  },
  data() {
    return {
      showVideo: false,
      currentVideoIndex: null,
      entradasBlog: [
        {
          titulo: 'Consejos para manejar el estrés diario',
          contenido: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis libero vel dolor dignissim scelerisque. Etiam vel odio in justo suscipit tristique. Nulla facilisi.',
          imagen: 'https://blogs.ucontinental.edu.pe/wp-content/uploads/2021/05/los-libros-de-autoayuda-realmente-nos-ayudan-especialista-responde-universidad-continental-2.jpg',
          link: 'https://medlineplus.gov/spanish/ency/article/001942.htm#:~:text=Pasar%20tiempo%20con%20familiares%20y,claridad%20y%20a%20tener%20m%C3%A1s%20energ%C3%ADa.'
        },
        {
          titulo: 'Cómo superar la ansiedad en tiempos difíciles',
          contenido: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis libero vel dolor dignissim scelerisque. Etiam vel odio in justo suscipit tristique. Nulla facilisi.',
          imagen: 'https://leccionamexico.b-cdn.net/wp-content/uploads/2022/03/cursos-de-autoayuda-y-superacion-personal.jpg',
          link: 'https://www.funespana.es/controlar-la-ansiedad/'
        },
        {
          titulo: 'Mejora tu bienestar emocional en 5 pasos',
          contenido: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis libero vel dolor dignissim scelerisque. Etiam vel odio in justo suscipit tristique. Nulla facilisi.',
          imagen: 'https://www.artiemhotels.com/uploads/c391546e-6280-4324-a195-e056a018e5eb/c391546e-6280-4324-a195-e056a018e5eb.png',
          link: 'https://terapygo.com/5-pasos-para-el-bienestar-mental/'
        },
        
        
      ],
      videos: [
        {
          titulo: 'Meditación para la calma interior',
          link: 'https://www.youtube.com/embed/SR5tBmzZoCY?si=vmANM3IEjoQlxvN8'
        },
        {
          titulo: 'Meditación guiada para reducir el estrés',
          link: 'https://www.youtube.com/embed/aBsnQjJ2_Nk?si=hGQTbWtlZiw8TAde'
        },
        {
          titulo: 'Meditación guiada para reducir el estrés',
          link: 'https://www.youtube.com/embed/FReFf1CLf-c?si=fx9loaMXf4z059R7'
        },
        

      ],

      
    };

    
  },
  methods: {
    scrollDown() {
      window.scrollBy({
        top: window.innerHeight, 
        behavior: 'smooth' // Efecto de desplazamiento suave
      });
    },
    openVideo(index) {
      // Muestra el cuadro de superposición y carga el enlace del video correspondiente
      this.showVideo = true;
      this.currentVideoIndex = index;
    },
    closeVideo() {
      // Oculta el cuadro de superposición
      this.showVideo = false;
      this.currentVideoIndex = null;
    },
    
  },
  computed: {
    currentVideoLink() {
      // Obtiene el enlace del video actualmente seleccionado
      if (this.currentVideoIndex !== null && this.videos[this.currentVideoIndex]) {
        return this.videos[this.currentVideoIndex].link;
      }
      return '';
    },
  },
};
</script>

<style scoped>



@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
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
/*BANNER*/
.banner-autoayuda {
  position: relative;
  height: 100vh; 
  margin-top: 0px;
}

.fondo-autoayuda {
  overflow: hidden;
}

.fondo-autoayuda img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  filter: brightness(50%);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.titulo-autoayuda {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: white;
  text-align: center;
  z-index: 1; 
}

.titulo-autoayuda h1 {
  font-size: 50px;
  margin: 0;
  opacity: 0;
  animation: fadeIn 1s ease forwards;
}
.titulo-autoayuda p {
  font-size: 18px;
  opacity: 0;
  animation: fadeIn 1s ease forwards 0.5s;
}

.boton-scroll {
  position: absolute;
  bottom: 120px; 
  left: 50%; 
  transform: translateX(-50%); 
  right: 50%; 
  transform: translateY(-50%); 
  background-color: rgba(240, 248, 255, 0.603); 
  border: none;
  border-radius: 50%; 
  width: 60px;
  height: 60px; 
  font-size: 24px; 
  color: #000; 
  cursor: pointer; 
  transition: background-color 0.3s; 
  transition: transform 0.3s;
  animation: bounce 2s infinite;
}
.icono-scroll {
  margin-top: 3px;
  width: 40px; 
  height: 40px; 
  transition: transform 0.3s;
}

.icono-scroll:hover{
  transform: scale(1.2);
}

.boton-scroll:hover {
  background-color: rgba(200, 220, 255, 0.8); 
  transform: scale(1.2);
}


/* BLOG */
.seccion-blog {
  margin-top: 150px;
  background-image: url("https://somospsicoterapia.es/images/blog/inconsciente.jpg");
  padding-top: 30px;
}

.titulo-blog {
  text-align: center;
  font-size:25px;
  border: 1px ; 
  border-radius: 10px; 
  padding: 2px;
  margin-left: 60px; 
  margin-right: 60px; 
  background-color: #ffffff;
  transition: transform 0.3s ease;
  
}
.titulo-blog:hover{
  transform: translateY(-5px);
}

.contenedor-entradas {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  animation: slideIn 4s ease forwards;
  padding-bottom: 20px;
}

.entrada-blog {
  width: 400px;
  margin: 20px;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 10px;
  transition: transform 0.3s ease;
  background-color: #ffffff;
  
}

.entrada-blog:hover {
  transform: translateY(-5px);
}

.entrada-blog h3 {
  margin-top: 0;
}

.entrada-blog img {
  width: 100%;
  height: 250px; 
  object-fit: cover; 
  border-radius: 10px;
  margin-bottom: 10px;
  
}

/* VIDEOS */
.seccion-videos {
  text-align: center;
  margin-top: 50px;
  padding-top: 20px;
}

.titulo-videos h2 {
  border: 1px ; 
  border-radius: 10px; 
  padding: 30px; 
  margin-left: 60px; 
  margin-right: 60px; 
  background-color: #ff5900;
  transition: transform 0.3s ease;
  color:aliceblue;
}

.titulo-videos h2:hover{
  transform: translateY(-5px);
}

.contenedor-videos {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;

}

.video {
  margin: 20px;
  border-radius: 10px;
  position: relative; 
  transition: transform 0.6s ease;
  padding-bottom: 20px;
}

.video:hover {
  transform: scale(1.1);
}


.video-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7); 
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999; 
}

.video-overlay-btn {
  position: absolute; 
  top: 0;
  left: 0;
  width: 100%; 
  height: 100%; 
}

.video-container {
  position: relative;
  width: 80%; 
  max-width: 1080px; 
}

.close-video-btn {
  position: absolute;
  bottom: 0%;
  left: 50%; 
  transform: translateX(-50%); 
  z-index: 10000; 
  margin-bottom: -100px;
  position: absolute;
  background-color: rgba(240, 248, 255, 0.603); 
  border-radius: 50%; 
  width: 60px; 
  height: 60px; 
  font-size: 24px; 
  color: #000; 
  cursor: pointer; 
  transition: background-color 0.3s; 
  transition: transform 0.3s; 
}


.icono-cerrar{
  margin-top: 7px;
  width: 30px; 
  height: 30px; 
  transition: transform 0.3s;
}

.icono-cerrar:hover{
  transform: scale(1.2);
}

.open-video-btn {
  width: 100%; 
  height: 100%;
  padding: 0;
  font-size: 16px;
  background-color: transparent; 
  border: none;
  color: white;
  cursor: pointer;
  z-index: 1; 
  opacity: 0.7; 
  transition: opacity 0.3s; 
}

.open-video-btn:hover {
  opacity: 1; 
}

/* MENSAJE */
.seccion-opciones {
  text-align: center;
  margin-top: 50px;
  margin-bottom: 50px;
 padding: 20px;
  animation: slideIn 4s ease forwards;
  background-image: url("https://somospsicoterapia.es/images/blog/inconsciente.jpg");
  color: rgb(0, 0, 0);
}




.mensaje-importante p {
  text-align: center;
  font-size:22px;
  
 
}

.opciones {
  display: flex;
  justify-content: center;
}

.opcion {
  margin:30px;
}

.boton-opcion {
  padding: 20px 20px;
  font-size: 18px;
  background-color: #3f271b;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: 0.3s ease;
}

@media (max-width: 639px) {

/*BANNER*/
.banner-autoayuda {
  position: relative;
  height: 30vh; 
  margin-top: 0px;
}
.titulo-autoayuda h1 {
  font-size: 30px;
}
.titulo-autoayuda p {
  font-size: 14px;
}
.boton-scroll {
  display:none;
}

/*BLOGS */

.seccion-blog {
  margin-top: 15px;
}

.titulo-blog {
  text-align: center;
  font-size:20px;
}


.entrada-blog img {
  width: 100%;
  height: 250px; 
  object-fit: cover; 
  border-radius: 10px;
  margin-bottom: 10px;
  
}

/* VIDEOS */
.seccion-videos {
  margin-top: 30px;
  padding-top: 20px;
}

.titulo-videos h2 {
  padding: 10px; 
  margin-left: 30px; 
  margin-right: 30px; 
}


.video {
  margin: 10px;
  border-radius: 10px;
  position: relative; 
  transition: transform 0.6s ease;
  padding-bottom: 20px;
}


.video-overlay-btn {
  display:none;
}

iframe{
  width: 350px;
  height: 200px;
}

/* MENSAJE */
.seccion-opciones {
  text-align: center;
  margin-top: 50px;
  margin-bottom: 50px;
 padding: 20px;
  animation: slideIn 4s ease forwards;
  background-image: url("https://somospsicoterapia.es/images/blog/inconsciente.jpg");
  color: rgb(0, 0, 0);
}




.mensaje-importante p {
  text-align: center;
  font-size:22px;
  
 
}

.opciones {
  display: flex;
  justify-content: center;
}

.opcion {
  margin:30px;
}

.boton-opcion {
  padding: 20px 20px;
  font-size: 18px;
  background-color: #3f271b;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: 0.3s ease;
}


}

</style>
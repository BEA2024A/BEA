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

      <!-- Sección de Blog con Carrusel -->
      <section class="seccion-blog">
        <div class="titulo-blog">
          <h3>Blogs de ayuda</h3>
        </div>
        <input type="text" v-model="busquedaBlogs" placeholder="Buscar blogs..." class="campo-busqueda">
        <div class="carrusel-blogs">
          <carousel :itemsToShow="3" class="blogs-carousel">
            <slide v-for="entrada in blogsFiltrados" :key="entrada.id">
              <div class="carousel__item">
                <p>{{ entrada.titulo }}</p>
                <img :src="entrada.imagen" alt="Imagen del blog" class="imagen-blog">
                <a :href="entrada.link" target="_blank" class="boton-leer">Leer más</a>
              </div>
            </slide>
            <template #addons>
              <navigation />
            </template>
          </carousel>
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

            <!-- Sección de Libro con Carrusel -->
            <section class="seccion-libro">
        <div class="titulo-libro">
          <h3>Libros que te pueden ayudar</h3>
        </div>
        <input type="text" v-model="busquedaLibros" placeholder="Buscar libros..." class="campo-busqueda">
        <div class="carrusel-libro">
          <carousel :itemsToShow="3" class="libro-carousel">
            <slide v-for="entrada in librosFiltrados" :key="entrada.id">
              <div class="carousel__item">
                <img :src="entrada.imagen" alt="Imagen del libro" class="imagen-libro">
                <a :href="entrada.link" target="_blank" class="boton-leer">Leer libro</a>
              </div>
            </slide>
            <template #addons>
              <navigation />
            </template>
          </carousel>
        </div>
      </section>
  
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
import { Carousel, Slide, Navigation } from 'vue3-carousel';
import 'vue3-carousel/dist/carousel.css';
import Plantilla from './plantilla.vue';

export default {
  components: {
    Plantilla,
    Carousel,
    Slide,
    Navigation,
  },
  data() {
    return {
      showVideo: false,
      currentVideoIndex: null,
      busquedaBlogs: '',
      busquedaLibros: '',
      blog: [
        {
          id: '1',
          titulo: 'Gestión del tiempo para controlar el estrés',
          autor: 'PSIQUION',
          imagen: 'https://i.postimg.cc/yxr2K5j0/estres-falta-tiempo-chica-liros.jpg',
          link: 'https://www.psiquion.com/blog/gestion-del-tiempo-controlar-estres',
          tipo: 'Estres',
        },
        {
          id: '2',
          titulo: 'Cómo superar el estrés',
          autor: 'SARA MONTEJANO',
          imagen: 'https://i.postimg.cc/hjY0tBF4/estres.jpg',
          link: 'https://www.psiquion.com/blog/como-superar-estres',
          tipo: 'Estres',
        },
        
        {
          id: '3',
          titulo: 'la ansiedad con la ayuda de un psicólogo',
          autor: 'Irene Garrido',
          imagen: 'https://blogs.ucontinental.edu.pe/wp-content/uploads/2021/05/los-libros-de-autoayuda-realmente-nos-ayudan-especialista-responde-universidad-continental-2.jpg',
          link: 'https://ailapsicologia.com/ansiedad/',
          tipo: 'Ansiedad',
        },
        
        {
          id: '4',
          titulo: 'Consejos para manejar el estrés diario',
          autor: 'Mark Greyson',
          imagen: 'https://blogs.ucontinental.edu.pe/wp-content/uploads/2021/05/los-libros-de-autoayuda-realmente-nos-ayudan-especialista-responde-universidad-continental-2.jpg',
          link: 'https://medlineplus.gov/spanish/ency/article/001942.htm#:~:text=Pasar%20tiempo%20con%20familiares%20y,claridad%20y%20a%20tener%20m%C3%A1s%20energ%C3%ADa.',
          tipo: '',
        }, 
      ],

      libro: [
        {
          id: '1',
          titulo: 'Lo bueno de tenr un mal día',
          autor: 'Anabel Gonzalez',
          imagen: 'https://i.postimg.cc/mrgtndZ3/7a97f58a-baa5-4078-b743-f2b7ea465acf.jpg',
          link: 'https://www.planetadelibros.com.mx/libro-lo-bueno-de-tener-un-mal-dia/339451',
          tipo: 'Estrés',
        },
        {
          id: '2',
          titulo: 'Terapia Conignitva sobre transtonos de Ansiedad',
          autor: 'David A. Clark',
          imagen: 'https://i.postimg.cc/MpKPpQW6/61a2ec68-882b-45a8-ac16-9ce05ddc484c.jpg',
          link: 'https://ww3.lectulandia.com/book/terapia-cognitiva-para-trastornos-de-ansiedad/',
          tipo: 'Ansiedad',
        },
        {
          id: '3',
          titulo: 'Eliminar el estrés',
          autor: 'Brian Weiss',
          imagen: 'https://i.postimg.cc/gJHMz5zn/319b2d47-6a5e-408e-b6c5-bd05128ea231.jpg',
          link: 'https://books.google.com.mx/books/about/Eliminar_el_estrés.html?id=qPY4AwAAQBAJ&redir_esc=y',
          tipo: 'meditacion',
        },
        {
          id: '4',
          titulo: 'Cómo superar la ansiedad',
          autor: ' Enrique Rojas',
          imagen: 'https://i.postimg.cc/d0xC8j54/16febb9e-6b9c-4b10-b588-cd8fb8889a3f.jpg',
          link: 'https://www.academia.edu/52549903/COMO_SUPERAR_LA_ANSIEDAD_ENRIQUE_ROJAS_Nn_Am',
          tipo: 'Ansiedad',
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
  computed: {
    librosFiltrados() {
      return this.libro.filter(entrada =>
        entrada.titulo.toLowerCase().includes(this.busquedaLibros.toLowerCase()) ||
        entrada.autor.toLowerCase().includes(this.busquedaLibros.toLowerCase()) ||
        entrada.tipo.toLowerCase().includes(this.busquedaLibros.toLowerCase())
      );
    },
    blogsFiltrados() {
      return this.blog.filter(entrada =>
        entrada.titulo.toLowerCase().includes(this.busquedaBlogs.toLowerCase()) ||
        entrada.autor.toLowerCase().includes(this.busquedaBlogs.toLowerCase()) ||
        entrada.tipo.toLowerCase().includes(this.busquedaBlogs.toLowerCase())
      );
    }
  },
  methods: {
    scrollDown() {
      window.scrollBy({
        top: window.innerHeight, 
        behavior: 'smooth' 
      });
    },
    openVideo(index) {
      // Muestra el cuadro de superposición y carga el enlace del video correspondiente
      this.showVideo = true;
      this.currentVideoIndex = index;
    },
    closeVideo() {
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
  text-align: center;
  margin: 40px 0;
  margin-top: 120px;
  padding: 20px;
  background-image: url('https://somospsicoterapia.es/images/blog/inconsciente.jpg');
  background-size: cover;
  background-position: center;
  color: white; 
}

.seccion-blog p{
  color:#000;
  font-size: 20px;
}


.titulo-blog {
  font-size: 24px;
  margin-bottom: 30px;
  background-color: rgba(0, 0, 0, 0.5); 
  display: inline-block;
  padding: 10px;
  border-radius: 5px;
}

/* Estilos para el carrusel */


.blogs-carousel .carousel__item {
  background-color: rgba(255, 255, 255, 0.8); 
  color: var(--vc-clr-white); 
  font-size: 20px; 
  border-radius: 20px; 
  justify-content: center; 
  align-items: center; 
  padding: 16px 24px; 
  margin: 0 10px 20px; 
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
}

.imagen-blog {
  width: 100%; 
  height: 200px; 
  object-fit: cover; 
  border-radius: 5px;
  margin-bottom: 15px;
  
}

.boton-leer {
  background-color: #3f271b;
  color: #ffffff;
  padding: 10px 15px;
  border-radius: 5px;
  text-decoration: none;
  align-self: center;
  margin-top: 15px;
}

.vue3-carousel-navigation-wrapper {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.vue3-carousel-navigation-button {
  background: none;
  border: none;
  cursor: pointer;
}

/* LIBRO */
.seccion-libro {
  text-align: center;
  margin: 40px 0;
  margin-top: 120px;
  padding: 20px;
  background-image: url('https://somospsicoterapia.es/images/blog/inconsciente.jpg');
  background-size: cover;
  background-position: center;
  color: white; 
}

.seccion-libro p{
  color:#000;
  font-size: 20px;
}


.titulo-libro {
  font-size: 24px;
  margin-bottom: 30px;
  background-color: rgba(0, 0, 0, 0.5); 
  display: inline-block;
  padding: 10px;
  border-radius: 5px;
}

/* Estilos para el carrusel */


.carrusel-libro .carousel__item {
  min-height: 300px; 
  width: 200px; 
  background-color: rgba(255, 255, 255, 0.8); 
  color: var(--vc-clr-white); 
  font-size: 20px; 
  border-radius: 20px; 
  justify-content: center; 
  align-items: center; 
  padding: 16px 24px; 
  margin: 0 10px 20px; 
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
}

.imagen-libro {
  width: 100%; 
  height: 200px; 
  object-fit: cover; 
  border-radius: 5px;
  margin-bottom: 15px;
  
}

.boton-leer {
  background-color: #3f271b;
  color: #ffffff;
  padding: 10px 15px;
  border-radius: 5px;
  text-decoration: none;
  align-self: center;
  margin-top: 15px;
}

.vue3-carousel-navigation-wrapper {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.vue3-carousel-navigation-button {
  background: none;
  border: none;
  cursor: pointer;
}

.campo-busqueda {
  margin: 20px auto;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 50px;
  width: calc(100% - 20px);
  box-sizing: border-box;
  font-size: 16px;
  margin-left: 24px;
  margin-right: 100px;
}

.campo-busqueda:focus {
  outline: none;
  box-shadow: 0 0 3px 0 #fc5e25;
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
  background-color:#ff5900;
  color:#ffffff;
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
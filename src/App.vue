<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
}
</script>

<style>



body {
  font-family: "Kumbh Sans", sans-serif;
  font-optical-sizing: auto;
  font-style: normal;
  font-variation-settings: "YOPQ" 300;
  margin: 0;
  padding: 0;
  background-color: aliceblue;
  overflow-x: hidden;
}

#app {
  max-width: auto;
  margin: 0 auto;
  text-align: center;
}

::-webkit-scrollbar {
  width: 2px; 
  transition: transform 1s;
}

::-webkit-scrollbar:hover{
  width: 10px;
}


::-webkit-scrollbar-track {
  background-color: transparent; 
}


::-webkit-scrollbar-thumb {
  background-color: transparent; 
  border-radius: 5px; 
}


::-webkit-scrollbar-thumb:hover {
  background-color:#c44501;
}
</style>

<template>
  <v-app>
    <v-toolbar app>
      <v-toolbar-title class="headline">
        <span>OCR-test</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn flat>
        <router-link to="/">Home</router-link>
      </v-btn>
      <v-btn flat>
        <router-link to="/ocr">OCR</router-link>
      </v-btn>
      <v-btn flat>
        <router-link to="/about">About</router-link>
      </v-btn>
    </v-toolbar>


    <v-content>
      <router-view></router-view>
    </v-content>

    <v-footer>
      footer test
    </v-footer>
  </v-app>
</template>

<script>
import HelloWorld from './components/HelloWorld';

export default {
  name: 'App',
  components: {
    HelloWorld,
  },
  data() {
    return {
      //
    };
  },
};
</script>

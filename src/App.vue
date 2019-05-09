<template>
  <v-app id="sandbox">
    <v-navigation-drawer v-model="drawer" app>
      <v-toolbar flat>
        <v-list>
          <v-list-tile>
            <v-list-tile-title class="title">
              Application
            </v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-toolbar>

      <v-divider></v-divider>

      <v-list>
        <v-list-tile v-for="page in pages" :key="page.name" :to="page.route">
          {{page.name}}
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>

    <v-toolbar app>
      <v-toolbar-side-icon
        @click.stop="drawer = !drawer"
      ></v-toolbar-side-icon>
      <v-toolbar-title>Vuetify</v-toolbar-title>
    </v-toolbar>
    
    <v-content>
      <v-container fluid>
        <router-view></router-view>
      </v-container>
    </v-content>

    <v-footer app>
      <span class="px-3">&copy; {{ new Date().getFullYear() }}</span>
    </v-footer>

  </v-app>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component({
  components: {
  },
})
export default class App extends Vue {
  private drawer: boolean = false;
  private pages: object[] = [
    {
      name: 'OCR',
      route: '/',
    },
  ];
}
</script>

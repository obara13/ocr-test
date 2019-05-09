<template>
  <v-layout row wrap>
    <!-- Tesseract language selector -->
    <v-flex xs4>
      Language: 
      <v-radio-group v-model="lang" row>
        <v-radio label="English" value="eng"></v-radio>
        <v-radio label="Japanese" value="jpn"></v-radio>
      </v-radio-group>
    </v-flex>

    <!-- Buttons (image upload, reset OCR data, other) -->
    <v-flex xs6>
      <v-btn @click="pickFile()">select file</v-btn>
      <input
        type="file"
        style="display: none"
        ref="upload"
        multiple
        @change="fileUploaded($event)"
			>
      <v-btn flat @click="onReset()">Reset</v-btn>
      <v-btn flat color="primary">工事中</v-btn>
    </v-flex>

    <!-- OCR progress view -->
    <v-flex xs2>
      Progress: 
      <input type="text" :value="fileName">
      <input type="text" :value="ocrProgress.progress">
    </v-flex>

    <!-- OCR result data view -->
    <v-flex xs12>
      <v-card>
        <v-card-title>
          OCR
          <v-spacer></v-spacer>
          <v-text-field
            v-model="search"
            append-icon="search"
            label="Search"
            single-line
            hide-details
          ></v-text-field>
        </v-card-title>
        <v-data-table
          :headers="headers"
          :items="items"
          :search="search"
        >
          <template v-slot:items="props">
            <td>{{props.item.filePath}} </td>
            <td>
              <v-img width="150px" :src="props.item.imageData"></v-img>
            </td>
            <td>{{props.item.textData}}</td>
          </template>
        </v-data-table>
      </v-card>
    </v-flex>

  </v-layout>
</template>

<script>
import Tesseract from 'tesseract.js/dist/tesseract.js';
// import Tesseract from 'tesseract.ts'

export default {
  name: 'OCR',
  props: {
  },

  data() {
    return {
      // for UI Progress View
      ocrProgress: '',
      fileName: '',

      // Tesseract Language selector
      lang: 'eng',

      // OCR data
      items: [],

      // v-data-table header
      headers: [
        {
          text: 'File',
          sortable: true,
          value: 'filePath',
        },
        {
          text: 'Image',
          sortable: false,
          value: 'imageData',
        },
        {
          text: 'Text',
          value: 'textData',
        },
      ],

      // v-data-table search
      search: '',
    };
  },

  methods: {
    pickFile() {
      this.$refs.upload.click();
    },

    fileUploaded(event) {
      for (const file of event.target.files) {
        const reader = new FileReader();

        reader.onload = (e) => {
          const image = e.target.result;
          // Tesseract recognization
          //   ※Tesseract.detect(image)で言語コードが入った
          //   　オブジェクトが返ってくるが使い方がよくわからん
          Tesseract.recognize(image, {lang: this.lang})
            .progress((progress) => {
              // for UI Progress View
              this.fileName = file.name;
              this.ocrProgress = progress;
            })
            // .catch(err => console.error(err))
            .then((result) => {
              this.items.push({
                filePath: file.path,
                imageData: image,
                textData: result.text,
              });
              // for reset UI Progress View
              this.fileName = '';
              this.ocrProgress = '';
            });
            // .finally(resultOrError => console.log(resultOrError))
        };
        reader.readAsDataURL(file);
      }
    },
    onReset() {
      // reset OCR data
      this.items = [];
    },
  },
};
</script>

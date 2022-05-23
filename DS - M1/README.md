![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

# Content-template

#### Template para la creación de contenido académico

A partir de este repositorio se puede crear un sitio web, generado automáticamente a partir del contenido de sus archivos markdown.

## Readme principal

Este archivo markdown principal utiliza el layout `intro` y no genera tabla de contenidos (índice), botón de feedback, de quizz ni de homework.

Generalmente contiene la introducción al contenido del repo.

## Data de la intro

Este archivo de intro va acompañado de otro con el mismo nombre pero extensión ***json***, donde incluimos la data correspondiente.

```json
{
  "permalink": "/index.html", // La ruta generada en el sitio estático para esta clase.
  "layout": "intro", // Acá seteamos que queremos usar el layout 'intro'.
  "eleventyNavigation": {
    "key": "Intro", // El nombre corto con que queremos que aparezca en la nav esta clase.
    "order": 0 // El nro de posición en el que queremos que aparezca esta clase en la nav.
  }
}
```

## Build

Ejecutar `npm i` y `npm start` para servir localmente el sitio. (default en puerto **8080**)

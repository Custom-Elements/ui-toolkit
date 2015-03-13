#ui-toolkit 

Polymer elements packed together for high speed reference, saves you
build time.

##Individual Components

You can pull in the whole ui-toolkit if you'd like, as shown in the
demo, or you can pull in individual components as needed.  Just be sure
that the component you're looking for is in the `package.json` else add
it and bump the version number.  The server will on-the-fly transpile
any coffeescript or less files into javascript and css for you.

Then you can simply reference the custom element's html file
directly as shown below.

```javascript
<link rel="import" href="https://services.glgresearch.com/ui-toolkit/node_modules/glg-nectar/src/glg-nectar.html">
```

[The Demo](https://services.glgresearch.com/ui-toolkit/demo.html)

##TL;DR:

```html
<!doctype html>

<html>
  <head>
    <!--
    Use this polymer, but if you already have one -- you can skip it!
    -->
    <link rel="import" href="https://services.glgresearch.com/ui-toolkit/polymer.html">
    <!--
    These are the widgets.
    -->
    <link rel="import" href="https://services.glgresearch.com/ui-toolkit/ui-toolkit.html">
  </head>
  <body>
    <ui-button>Hit me!</ui-button>
  </body>
</html>
```


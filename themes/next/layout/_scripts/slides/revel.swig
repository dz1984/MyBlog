{% set js_vendors = [
    'reveal/head.min.js',
    'reveal/reveal.min.js'
  ]
%}
{% for src_url in js_vendors %}
{% set internal_script = url_for(theme.vendors._internal) + '/' + src_url %}
<script type="text/javascript" src="{{ internal_script }}"></script>
{% endfor %}
<script>
{% set plugin_script = url_for(theme.vendors._internal) + '/reveal/plugin' %}
  // Full list of configuration options available here:
  // https://github.com/hakimel/reveal.js#configuration
  Reveal.initialize({
    controls: true,
    progress: true,
    history: true,
    center: true,

    theme: 'simple', // available themes are in /css/theme
    transition: Reveal.getQueryHash().transition || 'linear', // default/cube/page/concave/zoom/linear/fade/none

    // Optional libraries used to extend on reveal.js
    dependencies: [
      { src: '{{ plugin_script }}/classList.js', condition: function() { return !document.body.classList; } },
      { src: '{{ plugin_script }}/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
      { src: '{{ plugin_script }}/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
      { src: '{{ plugin_script }}/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
      { src: '{{ plugin_script }}/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
      { src: '{{ plugin_script }}/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } },
      { src: '{{ plugin_script }}/math/math.js', async: true }
    ]
  });

</script>

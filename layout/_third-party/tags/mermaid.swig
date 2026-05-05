{%- if theme.mermaid.enable %}
{%- set mermaid_uri = theme.vendors.mermaid or '//cdn.jsdelivr.net/npm/mermaid@8/dist/mermaid.min.js' %}
<script{{ pjax }}>
if (document.querySelectorAll('pre.mermaid').length) {
  NexT.utils.getScript('{{ mermaid_uri }}', () => {
    var darkMQ = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)');
    var mermaidTheme = (darkMQ && darkMQ.matches) ? 'dark' : '{{ theme.mermaid.theme }}';
    mermaid.initialize({
      startOnLoad: false,
      theme    : mermaidTheme,
      logLevel : 3,
      flowchart: { curve     : 'linear' },
      gantt    : { axisFormat: '%m/%d/%Y' },
      sequence : { actorMargin: 50 }
    });
    mermaid.run({ querySelector: 'pre.mermaid' });
  }, window.mermaid);
}
</script>
{%- endif %}

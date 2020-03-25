<h2>Quick</h2>
<p>
subsextract.sh is a simple script to extract subtitle tracks from an MKV, saving each separate subtitle in a single file 
</p>
<h2>Usage</h2>
<p>subsextract.sh <matroska.mkv> [ &lt;<i>output-dir</i>&gt; ]<br />
By default <i>output-dir</i> subs <br />
</p<p>
It's possible to proess whole folder with<br />
<code>find -maxdepth 1 -type f -regex .*mkv$ -exec {} \;</code>
</p>

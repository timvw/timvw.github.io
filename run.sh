rm $PWD/Gemfile.lock
#docker run -i -t --rm -v "$PWD:/srv/jekyll" -v "/tmp/jekyll:/usr/local/bundle" -p "4000:4000" jekyll/jekyll $@
#docker run -i -t --rm -v "$PWD:/srv/jekyll" -v "/tmp/jekyll:/usr/local/bundle" -p "4000:4000" jekyll/jekyll bundle install
docker run -i -t --rm -v "$PWD:/srv/jekyll" -v "/tmp/jekyll:/usr/local/bundle" -p "4000:4000" jekyll/jekyll jekyll build
docker run -i -t --rm -v "$PWD:/srv/jekyll" -v "/tmp/jekyll:/usr/local/bundle" -p "4000:4000" jekyll/jekyll jekyll serve --watch --force_polling --incremental -H 0.0.0.0 -P 4000

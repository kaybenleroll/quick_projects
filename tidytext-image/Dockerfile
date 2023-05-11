FROM rocker/verse:4.2.1

COPY build/docker_render_pdf.R /tmp
COPY build/test_report.Rmd /tmp

WORKDIR /tmp

RUN Rscript /tmp/docker_render_pdf.R \
  && rm -fv /tmp/docker_render_pdf.R


RUN git clone https://github.com/lindenb/makefile2graph.git \
  && cd makefile2graph \
  && make \
  && make install
  
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    byobu \
    clang \
    ditaa \
    graphviz \
    htop \
    less \
    libclang-dev \
    libglpk-dev \
    libgsl-dev \
    libnlopt-dev \
    p7zip-full \
    pbzip2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p $HOME/.R \
  && echo "" > $HOME/.R/Makevars \
  && echo "CXX=clang++"                                            >> $HOME/.R/Makevars \
  && echo "CXXFLAGS=-Os"                                           >> $HOME/.R/Makevars \
  && echo "CXXFLAGS+= -Wno-unused-variable -Wno-unused-function"   >> $HOME/.R/Makevars \
  && echo "CXXFLAGS+= -Wno-unknown-pragmas -Wno-macro-redefined"   >> $HOME/.R/Makevars \
  && echo ""                                                       >> $HOME/.R/Makevars \
  && echo "CXX14=clang++"                                          >> $HOME/.R/Makevars \
  && echo "CXX14FLAGS=-Os"                                         >> $HOME/.R/Makevars \
  && echo "CXX14FLAGS+= -Wno-unused-variable -Wno-unused-function" >> $HOME/.R/Makevars \
  && echo "CXX14FLAGS+= -Wno-unknown-pragmas -Wno-macro-redefined" >> $HOME/.R/Makevars \
  && echo ""                                                       >> $HOME/.R/Makevars \
  && install2.r --error \
    anytime \
    bindrcpp \
    bookdown \
    bslib \
    conflicted \
    corporaexplorer \
    cowplot \
    downlit \
    DataExplorer \
    fs \
    furrr \
    ggforce \
    ggraph \
    igraph \
    janeaustenr \
    mallet \
    markdown \
    Matrix \
    patchwork \
    pryr \
    qdap \
    quanteda \
    quarto \
    sessioninfo \
    snakecase \
    styler \
    text2vec \
    textdata \
    textplot \
    tictoc \
    tidytext \
    tm \
    topicmodels \
    udpipe \
    widyr \
    word2vec \
    wordcloud \
    vip \
    xml2 \
    XML


COPY build/docker_install_sys_rpkgs.R /tmp
RUN Rscript /tmp/docker_install_sys_rpkgs.R

RUN cp -r $HOME/.R /home/rstudio \
  && chown -R rstudio:rstudio /home/rstudio/.R


WORKDIR /home/rstudio
USER rstudio

COPY build/conffiles.7z /tmp
RUN 7z x /tmp/conffiles.7z       \
  && cp conffiles/.bash*     .   \
  && cp conffiles/.gitconfig .   \
  && cp conffiles/.Renviron  .   \
  && cp conffiles/.Rprofile  .   \
  && mkdir -p .config/rstudio    \
  && cp conffiles/rstudio-prefs.json .config/rstudio/  \
  && rm -rfv conffiles/ \
  && touch /home/rstudio/.bash_eternal_history

COPY build/docker_install_user_rpkgs.R /tmp
RUN Rscript /tmp/docker_install_user_rpkgs.R


USER root

RUN chown -R rstudio:rstudio /home/rstudio


FROM ruby:2.7
# rubyのイメージ

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-client vim
# Railsのインストール、MySQLへの接続に必要なパッケージをインストール

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt update \
  && apt install --no-install-recommends -y yarn
# yarnをインストール

RUN mkdir /study_app
# コンテナ内にstudy_appディレクトリを作成

WORKDIR /study_app
# コンテナ内の作業用ディレクトリを指定

COPY Gemfile /study_app/Gemfile
COPY Gemfile.lock /study_app/Gemfile.lock
# ローカルのGemfile,Gemfile.lockを、コンテナ内のstudy_app配下にコピー

RUN bundle install
# コンテナ内のbundle install

COPY . /study_app
# ローカルstudy_appを、コンテナ内のsyudy_appにコピー

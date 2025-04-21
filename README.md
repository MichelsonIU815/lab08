michel@MichelUbuntu:~$ export GITHUB_USERNAME=MichelsonIU815
michel@MichelUbuntu:~$ cd ${GITHUB_USERNAME}/workspace
michel@MichelUbuntu:~/MichelsonIU815/workspace$ pushd .
~/MichelsonIU815/workspace ~/MichelsonIU815/workspace
michel@MichelUbuntu:~/MichelsonIU815/workspace$ source scripts/activate
michel@MichelUbuntu:~/MichelsonIU815/workspace$ git clone https://github.com/${GITHUB_USERNAME}/lab07 lab08
Клонирование в «lab08»...
remote: Enumerating objects: 117, done.
remote: Counting objects: 100% (117/117), done.
remote: Compressing objects: 100% (99/99), done.
remote: Total 117 (delta 16), reused 0 (delta 0), pack-reused 0 (from 0)
Получение объектов: 100% (117/117), 788.90 КиБ | 3.17 МиБ/с, готово.
Определение изменений: 100% (16/16), готово.
michel@MichelUbuntu:~/MichelsonIU815/workspace$ cd lab08
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ git submodule update --init
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ git remote remove origin
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ git remote add origin https://github.com/${GITHUB_USERNAME}/lab08
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ cat > Dockerfile <<EOF
> FROM ubuntu:18.04
> EOF
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ cat >> Dockerfile <<EOF
> 
> RUN apt update
> RUN apt install -yy gcc g++ cmake
> EOF
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ cat >> Dockerfile <<EOF
> 
> COPY . print/
> WORKDIR print
> EOF
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ cat >> Dockerfile <<EOF
> 
> RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
> RUN cmake --build _build
> RUN cmake --build _build --target install
> EOF
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ cat >> Dockerfile <<EOF
> 
> ENV LOG_PATH /home/logs/log.txt
> EOF
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ cat >> Dockerfile <<EOF
> 
> VOLUME /home/logs
> EOF
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ cat >> Dockerfile <<EOF
> 
> WORKDIR _install/bin
> EOF
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ cat >> Dockerfile <<EOF
> 
> ENTRYPOINT ./demo
> EOF
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ docker build -t logger .
Команда «docker» не найдена, но может быть установлена с помощью:
sudo snap install docker         # version 27.5.1, or
sudo apt  install docker.io      # version 26.1.3-0ubuntu1~24.04.1
sudo apt  install podman-docker  # version 4.9.3+ds1-1ubuntu0.2
См. 'snap info docker', чтобы посмотреть дополнительные версии.
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo snap install docker
[sudo] пароль для michel: 
docker 27.5.1 от Canonical✓ installed
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ docker build -t logger .
ERROR: permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Head "http://%2Fvar%2Frun%2Fdocker.sock/_ping": dial unix /var/run/docker.sock: connect: permission denied
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo usermod -aG docker $USER
usermod: группа «docker» не существует
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ newgrp docker
newgrp: группа «docker» не существует
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ ls -l /var/run/docker.sock
srw-rw---- 1 root root 0 апр 21 15:30 /var/run/docker.sock
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo systemctl start docker
Failed to start docker.service: Unit docker.service not found.
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo apt-get remove docker docker-engine docker.io containerd runc
Чтение списков пакетов… Готово
Построение дерева зависимостей… Готово
Чтение информации о состоянии… Готово
Пакет «docker» не установлен, поэтому не может быть удалён
E: Невозможно найти пакет docker-engine
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo apt-get update
Сущ:1 http://security.ubuntu.com/ubuntu noble-security InRelease
Сущ:2 http://archive.ubuntu.com/ubuntu noble InRelease                         
Пол:3 http://archive.ubuntu.com/ubuntu noble-updates InRelease [126 kB]        
Сущ:4 http://archive.ubuntu.com/ubuntu noble-backports InRelease               
Сущ:5 https://ppa.launchpadcontent.net/rael-gc/rvm/ubuntu noble InRelease
Получено 126 kB за 1с (189 kB/s)          
Чтение списков пакетов… Готово
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo apt-get install \
>     apt-transport-https \
>     ca-certificates \
>     curl \
>     gnupg-agent \
>     software-properties-common
Чтение списков пакетов… Готово
Построение дерева зависимостей… Готово
Чтение информации о состоянии… Готово         
Уже установлен пакет ca-certificates самой новой версии (20240203).
ca-certificates помечен как установленный вручную.
Уже установлен пакет curl самой новой версии (8.5.0-2ubuntu10.6).
Будут установлены следующие дополнительные пакеты:
  dirmngr gnupg gnupg-l10n gnupg-utils gnupg2 gpg gpg-agent gpg-wks-client
  gpgconf gpgsm gpgv keyboxd python3-software-properties
  software-properties-gtk
Предлагаемые пакеты:
  tor parcimonie xloadimage gpg-wks-server scdaemon
Следующие НОВЫЕ пакеты будут установлены:
  apt-transport-https gnupg-agent
Следующие пакеты будут обновлены:
  dirmngr gnupg gnupg-l10n gnupg-utils gnupg2 gpg gpg-agent gpg-wks-client
  gpgconf gpgsm gpgv keyboxd python3-software-properties
  software-properties-common software-properties-gtk
Обновлено 15 пакетов, установлено 2 новых пакетов, для удаления отмечено 0 пакетов, и 147 пакетов не обновлено.
Необходимо скачать 2 432 kB архивов.
После данной операции объём занятого дискового пространства возрастёт на 68,6 kB.
Хотите продолжить? [Д/н] y
Пол:1 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 gpg-wks-client amd64 2.4.4-2ubuntu17.2 [70,9 kB]
Пол:2 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 dirmngr amd64 2.4.4-2ubuntu17.2 [323 kB]
Пол:3 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 gnupg-utils amd64 2.4.4-2ubuntu17.2 [109 kB]
Пол:4 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 gpgsm amd64 2.4.4-2ubuntu17.2 [232 kB]
Пол:5 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 gpg-agent amd64 2.4.4-2ubuntu17.2 [227 kB]
Пол:6 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 gpg amd64 2.4.4-2ubuntu17.2 [565 kB]
Пол:7 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 gpgconf amd64 2.4.4-2ubuntu17.2 [103 kB]
Пол:8 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 gnupg all 2.4.4-2ubuntu17.2 [359 kB]
Пол:9 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 keyboxd amd64 2.4.4-2ubuntu17.2 [78,3 kB]
Пол:10 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 gpgv amd64 2.4.4-2ubuntu17.2 [158 kB]
Пол:11 http://archive.ubuntu.com/ubuntu noble/universe amd64 apt-transport-https all 2.7.14build2 [3 974 B]
Пол:12 http://archive.ubuntu.com/ubuntu noble-updates/universe amd64 gnupg-agent all 2.4.4-2ubuntu17.2 [4 664 B]
Пол:13 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 gnupg-l10n all 2.4.4-2ubuntu17.2 [66,1 kB]
Пол:14 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 software-properties-common all 0.99.49.2 [14,4 kB]
Пол:15 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 software-properties-gtk all 0.99.49.2 [83,2 kB]
Пол:16 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 python3-software-properties all 0.99.49.2 [29,8 kB]
Пол:17 http://archive.ubuntu.com/ubuntu noble-updates/universe amd64 gnupg2 all 2.4.4-2ubuntu17.2 [4 750 B]
Получено 2 432 kB за 2с (1 301 kB/s)       
(Чтение базы данных … на данный момент установлено 227927 файлов и каталогов.)
Подготовка к распаковке …/0-gpg-wks-client_2.4.4-2ubuntu17.2_amd64.deb …
Распаковывается gpg-wks-client (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/1-dirmngr_2.4.4-2ubuntu17.2_amd64.deb …
Распаковывается dirmngr (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/2-gnupg-utils_2.4.4-2ubuntu17.2_amd64.deb …
Распаковывается gnupg-utils (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/3-gpgsm_2.4.4-2ubuntu17.2_amd64.deb …
Распаковывается gpgsm (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/4-gpg-agent_2.4.4-2ubuntu17.2_amd64.deb …
Распаковывается gpg-agent (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/5-gpg_2.4.4-2ubuntu17.2_amd64.deb …
Распаковывается gpg (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/6-gpgconf_2.4.4-2ubuntu17.2_amd64.deb …
Распаковывается gpgconf (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/7-gnupg_2.4.4-2ubuntu17.2_all.deb …
Распаковывается gnupg (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/8-keyboxd_2.4.4-2ubuntu17.2_amd64.deb …
Распаковывается keyboxd (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/9-gpgv_2.4.4-2ubuntu17.2_amd64.deb …
Распаковывается gpgv (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Настраивается пакет gpgv (2.4.4-2ubuntu17.2) …
Выбор ранее не выбранного пакета apt-transport-https.
(Чтение базы данных … на данный момент установлено 227927 файлов и каталогов.)
Подготовка к распаковке …/0-apt-transport-https_2.7.14build2_all.deb …
Распаковывается apt-transport-https (2.7.14build2) …
Выбор ранее не выбранного пакета gnupg-agent.
Подготовка к распаковке …/1-gnupg-agent_2.4.4-2ubuntu17.2_all.deb …
Распаковывается gnupg-agent (2.4.4-2ubuntu17.2) …
Подготовка к распаковке …/2-gnupg-l10n_2.4.4-2ubuntu17.2_all.deb …
Распаковывается gnupg-l10n (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Подготовка к распаковке …/3-software-properties-common_0.99.49.2_all.deb …
Распаковывается software-properties-common (0.99.49.2) на замену (0.99.49.1) …
Подготовка к распаковке …/4-software-properties-gtk_0.99.49.2_all.deb …
Распаковывается software-properties-gtk (0.99.49.2) на замену (0.99.49.1) …
Подготовка к распаковке …/5-python3-software-properties_0.99.49.2_all.deb …
Распаковывается python3-software-properties (0.99.49.2) на замену (0.99.49.1) …
Подготовка к распаковке …/6-gnupg2_2.4.4-2ubuntu17.2_all.deb …
Распаковывается gnupg2 (2.4.4-2ubuntu17.2) на замену (2.4.4-2ubuntu17) …
Настраивается пакет apt-transport-https (2.7.14build2) …
Настраивается пакет gnupg-l10n (2.4.4-2ubuntu17.2) …
Настраивается пакет gpgconf (2.4.4-2ubuntu17.2) …
Настраивается пакет gpg (2.4.4-2ubuntu17.2) …
Настраивается пакет gnupg-utils (2.4.4-2ubuntu17.2) …
Настраивается пакет gpg-agent (2.4.4-2ubuntu17.2) …
Настраивается пакет gpgsm (2.4.4-2ubuntu17.2) …
Настраивается пакет dirmngr (2.4.4-2ubuntu17.2) …
Настраивается пакет python3-software-properties (0.99.49.2) …
Настраивается пакет gnupg-agent (2.4.4-2ubuntu17.2) …
Настраивается пакет keyboxd (2.4.4-2ubuntu17.2) …
Настраивается пакет gnupg (2.4.4-2ubuntu17.2) …
Настраивается пакет gnupg2 (2.4.4-2ubuntu17.2) …
Настраивается пакет gpg-wks-client (2.4.4-2ubuntu17.2) …
Настраивается пакет software-properties-common (0.99.49.2) …
Настраивается пакет software-properties-gtk (0.99.49.2) …
Обрабатываются триггеры для libglib2.0-0t64:amd64 (2.80.0-6ubuntu3.2) …
Обрабатываются триггеры для dbus (1.14.10-4ubuntu4.1) …
Обрабатываются триггеры для shared-mime-info (2.4-4) …
Обрабатываются триггеры для install-info (7.1-3build2) …
Обрабатываются триггеры для mailcap (3.70+nmu1ubuntu1) …
Обрабатываются триггеры для desktop-file-utils (0.27-2build1) …
Обрабатываются триггеры для hicolor-icon-theme (0.17-2) …
Обрабатываются триггеры для gnome-menus (3.36.0-1.1ubuntu3) …
Обрабатываются триггеры для man-db (2.12.0-4build2) …
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
OK
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo add-apt-repository \
>    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
>    $(lsb_release -cs) \
>    stable"
Репозиторий: 'deb [arch=amd64] https://download.docker.com/linux/ubuntu noble stable'
Описание:
Archive for codename: noble components: stable
Дополнительные сведения: https://download.docker.com/linux/ubuntu
Добавление репозитория.
Нажмите [ENTER] для продолжения или Ctrl-C для отмены.
Добавление записи deb в /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-noble.list
Добавление отключенной записи deb-src в /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-noble.list
Сущ:1 http://archive.ubuntu.com/ubuntu noble InRelease
Сущ:2 http://archive.ubuntu.com/ubuntu noble-updates InRelease                 
Пол:3 https://download.docker.com/linux/ubuntu noble InRelease [48,8 kB]       
Сущ:4 http://archive.ubuntu.com/ubuntu noble-backports InRelease               
Сущ:5 http://security.ubuntu.com/ubuntu noble-security InRelease               
Сущ:6 https://ppa.launchpadcontent.net/rael-gc/rvm/ubuntu noble InRelease      
Пол:7 https://download.docker.com/linux/ubuntu noble/stable amd64 Packages [24,0 kB]
Получено 72,8 kB за 1с (123 kB/s)  
Чтение списков пакетов… Готово
W: https://download.docker.com/linux/ubuntu/dists/noble/InRelease: Ключ сохранён в устаревшей связке ключей trusted.gpg (/etc/apt/trusted.gpg), обратитесь к разделу DEPRECATION справочной страницы apt-key(8) для подробной информации.
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo apt-get update
Сущ:1 https://download.docker.com/linux/ubuntu noble InRelease
Сущ:2 http://security.ubuntu.com/ubuntu noble-security InRelease               
Сущ:3 http://archive.ubuntu.com/ubuntu noble InRelease                         
Сущ:4 http://archive.ubuntu.com/ubuntu noble-updates InRelease                 
Сущ:5 https://ppa.launchpadcontent.net/rael-gc/rvm/ubuntu noble InRelease      
Сущ:6 http://archive.ubuntu.com/ubuntu noble-backports InRelease
Чтение списков пакетов… Готово            
W: https://download.docker.com/linux/ubuntu/dists/noble/InRelease: Ключ сохранён в устаревшей связке ключей trusted.gpg (/etc/apt/trusted.gpg), обратитесь к разделу DEPRECATION справочной страницы apt-key(8) для подробной информации.
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo apt-get install docker-ce docker-ce-cli containerd.io
Чтение списков пакетов… Готово
Построение дерева зависимостей… Готово
Чтение информации о состоянии… Готово         
Будут установлены следующие дополнительные пакеты:
  docker-buildx-plugin docker-ce-rootless-extras docker-compose-plugin
  libslirp0 pigz slirp4netns
Предлагаемые пакеты:
  cgroupfs-mount | cgroup-lite
Следующие НОВЫЕ пакеты будут установлены:
  containerd.io docker-buildx-plugin docker-ce docker-ce-cli
  docker-ce-rootless-extras docker-compose-plugin libslirp0 pigz slirp4netns
Обновлено 0 пакетов, установлено 9 новых пакетов, для удаления отмечено 0 пакетов, и 147 пакетов не обновлено.
Необходимо скачать 120 MB архивов.
После данной операции объём занятого дискового пространства возрастёт на 439 MB.
Хотите продолжить? [Д/н] y
Пол:1 https://download.docker.com/linux/ubuntu noble/stable amd64 containerd.io amd64 1.7.27-1 [30,5 MB]
Пол:2 http://archive.ubuntu.com/ubuntu noble/universe amd64 pigz amd64 2.8-1 [65,6 kB]
Пол:3 http://archive.ubuntu.com/ubuntu noble/main amd64 libslirp0 amd64 4.7.0-1ubuntu3 [63,8 kB]
Пол:4 http://archive.ubuntu.com/ubuntu noble/universe amd64 slirp4netns amd64 1.2.1-1build2 [34,9 kB]
Пол:5 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-buildx-plugin amd64 0.23.0-1~ubuntu.24.04~noble [34,6 MB]
Пол:6 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-ce-cli amd64 5:28.1.1-1~ubuntu.24.04~noble [15,8 MB]
Пол:7 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-ce amd64 5:28.1.1-1~ubuntu.24.04~noble [19,2 MB]
Пол:8 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-ce-rootless-extras amd64 5:28.1.1-1~ubuntu.24.04~noble [6 092 kB]
Пол:9 https://download.docker.com/linux/ubuntu noble/stable amd64 docker-compose-plugin amd64 2.35.1-1~ubuntu.24.04~noble [13,8 MB]
Получено 120 MB за 26с (4 557 kB/s)                                            
Выбор ранее не выбранного пакета pigz.
(Чтение базы данных … на данный момент установлено 227935 файлов и каталогов.)
Подготовка к распаковке …/0-pigz_2.8-1_amd64.deb …
Распаковывается pigz (2.8-1) …
Выбор ранее не выбранного пакета containerd.io.
Подготовка к распаковке …/1-containerd.io_1.7.27-1_amd64.deb …
Распаковывается containerd.io (1.7.27-1) …
Выбор ранее не выбранного пакета docker-buildx-plugin.
Подготовка к распаковке …/2-docker-buildx-plugin_0.23.0-1~ubuntu.24.04~noble_amd64.deb …
Распаковывается docker-buildx-plugin (0.23.0-1~ubuntu.24.04~noble) …
Выбор ранее не выбранного пакета docker-ce-cli.
Подготовка к распаковке …/3-docker-ce-cli_5%3a28.1.1-1~ubuntu.24.04~noble_amd64.deb …
Распаковывается docker-ce-cli (5:28.1.1-1~ubuntu.24.04~noble) …
Выбор ранее не выбранного пакета docker-ce.
Подготовка к распаковке …/4-docker-ce_5%3a28.1.1-1~ubuntu.24.04~noble_amd64.deb …
Распаковывается docker-ce (5:28.1.1-1~ubuntu.24.04~noble) …
Выбор ранее не выбранного пакета docker-ce-rootless-extras.
Подготовка к распаковке …/5-docker-ce-rootless-extras_5%3a28.1.1-1~ubuntu.24.04~noble_amd64.deb …
Распаковывается docker-ce-rootless-extras (5:28.1.1-1~ubuntu.24.04~noble) …
Выбор ранее не выбранного пакета docker-compose-plugin.
Подготовка к распаковке …/6-docker-compose-plugin_2.35.1-1~ubuntu.24.04~noble_amd64.deb …
Распаковывается docker-compose-plugin (2.35.1-1~ubuntu.24.04~noble) …
Выбор ранее не выбранного пакета libslirp0:amd64.
Подготовка к распаковке …/7-libslirp0_4.7.0-1ubuntu3_amd64.deb …
Распаковывается libslirp0:amd64 (4.7.0-1ubuntu3) …
Выбор ранее не выбранного пакета slirp4netns.
Подготовка к распаковке …/8-slirp4netns_1.2.1-1build2_amd64.deb …
Распаковывается slirp4netns (1.2.1-1build2) …
Настраивается пакет docker-buildx-plugin (0.23.0-1~ubuntu.24.04~noble) …
Настраивается пакет containerd.io (1.7.27-1) …
Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service → /usr/lib/systemd/system/containerd.service.
Настраивается пакет docker-compose-plugin (2.35.1-1~ubuntu.24.04~noble) …
Настраивается пакет docker-ce-cli (5:28.1.1-1~ubuntu.24.04~noble) …
Настраивается пакет libslirp0:amd64 (4.7.0-1ubuntu3) …
Настраивается пакет pigz (2.8-1) …
Настраивается пакет docker-ce-rootless-extras (5:28.1.1-1~ubuntu.24.04~noble) …
Настраивается пакет slirp4netns (1.2.1-1build2) …
Настраивается пакет docker-ce (5:28.1.1-1~ubuntu.24.04~noble) …
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /usr/lib/systemd/system/docker.service.
Created symlink /etc/systemd/system/sockets.target.wants/docker.socket → /usr/lib/systemd/system/docker.socket.
Обрабатываются триггеры для man-db (2.12.0-4build2) …
Обрабатываются триггеры для libc-bin (2.39-0ubuntu8.4) …
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
e6590344b1a5: Pull complete 
Digest: sha256:c41088499908a59aae84b0a49c70e86f4731e588a737f1637e73c8c09d995654
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo groupadd docker
groupadd: группа «docker» уже существует
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo usermod -aG docker $USER
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ newgrp docker
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo systemctl enable docker
Synchronizing state of docker.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
Executing: /usr/lib/systemd/systemd-sysv-install enable docker
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo systemctl start docker
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sudo systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; preset: e>
     Active: active (running) since Mon 2025-04-21 15:38:50 MSK; 1min 2s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 941356 (dockerd)
      Tasks: 19
     Memory: 28.4M (peak: 30.0M)
        CPU: 555ms
     CGroup: /system.slice/docker.service
             └─941356 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/co>

апр 21 15:38:49 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:49.6051291>
апр 21 15:38:49 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:49.6692650>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.3336440>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.3482928>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.3483484>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.4457319>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.4554484>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.4555130>
апр 21 15:38:50 MichelUbuntu systemd[1]: Started docker.service - Docker Applic>
апр 21 15:38:59 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:59.7352016>
...skipping...

                   SUMMARY OF LESS COMMANDS

      Commands marked with * may be preceded by a number, N.
      Notes in parentheses indicate the behavior if N is given.
      A key preceded by a caret indicates the Ctrl key; thus ^K is ctrl-K.

  h  H                 Display this help.
  q  :q  Q  :Q  ZZ     Exit.
 ---------------------------------------------------------------------------

                           MOVING

  e  ^E  j  ^N  CR  *  Forward  one line   (or N lines).
  y  ^Y  k  ^K  ^P  *  Backward one line   (or N lines).
  f  ^F  ^V  SPACE  *  Forward  one window (or N lines).
  b  ^B  ESC-v      *  Backward one window (or N lines).
  z                 *  Forward  one window (and set window to N).
HELP -- Press RETURN for more, or q when done...skipping...
       Docs: https://docs.docker.com
   Main PID: 941356 (dockerd)
      Tasks: 19
     Memory: 28.4M (peak: 30.0M)
        CPU: 555ms
     CGroup: /system.slice/docker.service
             └─941356 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/co>

апр 21 15:38:49 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:49.6051291>
апр 21 15:38:49 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:49.6692650>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.3336440>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.3482928>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.3483484>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.4457319>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.4554484>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.4555130>
апр 21 15:38:50 MichelUbuntu systemd[1]: Started docker.service - Docker Applic>
апр 21 15:38:59 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:59.7352016>
...skipping...

                   SUMMARY OF LESS COMMANDS

      Commands marked with * may be preceded by a number, N.
      Notes in parentheses indicate the behavior if N is given.
      A key preceded by a caret indicates the Ctrl key; thus ^K is ctrl-K.

  h  H                 Display this help.
  q  :q  Q  :Q  ZZ     Exit.
 ---------------------------------------------------------------------------

                           MOVING

  e  ^E  j  ^N  CR  *  Forward  one line   (or N lines).
  y  ^Y  k  ^K  ^P  *  Backward one line   (or N lines).
  f  ^F  ^V  SPACE  *  Forward  one window (or N lines).
  b  ^B  ESC-v      *  Backward one window (or N lines).
  z                 *  Forward  one window (and set window to N).
...skipping...

                   SUMMARY OF LESS COMMANDS

      Commands marked with * may be preceded by a number, N.
      Notes in parentheses indicate the behavior if N is given.
      A key preceded by a caret indicates the Ctrl key; thus ^K is ctrl-K.

  h  H                 Display this help.
  q  :q  Q  :Q  ZZ     Exit.
 ---------------------------------------------------------------------------

                           MOVING

  e  ^E  j  ^N  CR  *  Forward  one line   (or N lines).
  y  ^Y  k  ^K  ^P  *  Backward one line   (or N lines).
  f  ^F  ^V  SPACE  *  Forward  one window (or N lines).
  b  ^B  ESC-v      *  Backward one window (or N lines).
  z                 *  Forward  one window (and set window to N).
...skipping...

                   SUMMARY OF LESS COMMANDS

      Commands marked with * may be preceded by a number, N.
      Notes in parentheses indicate the behavior if N is given.
      A key preceded by a caret indicates the Ctrl key; thus ^K is ctrl-K.

  h  H                 Display this help.
  q  :q  Q  :Q  ZZ     Exit.
 ---------------------------------------------------------------------------

                           MOVING

  e  ^E  j  ^N  CR  *  Forward  one line   (or N lines).
  y  ^Y  k  ^K  ^P  *  Backward one line   (or N lines).
  f  ^F  ^V  SPACE  *  Forward  one window (or N lines).
  b  ^B  ESC-v      *  Backward one window (or N lines).
  z                 *  Forward  one window (and set window to N).
  w                 *  Backward one window (and set window to N).
...skipping...
       Docs: https://docs.docker.com
   Main PID: 941356 (dockerd)
      Tasks: 19
     Memory: 28.4M (peak: 30.0M)
        CPU: 555ms
     CGroup: /system.slice/docker.service
             └─941356 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/co>

апр 21 15:38:49 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:49.6051291>
апр 21 15:38:49 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:49.6692650>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.3336440>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.3482928>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.3483484>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.4457319>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.4554484>
апр 21 15:38:50 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:50.4555130>
апр 21 15:38:50 MichelUbuntu systemd[1]: Started docker.service - Docker Applic>
апр 21 15:38:59 MichelUbuntu dockerd[941356]: time="2025-04-21T15:38:59.7352016>
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ $ docker build -t logger .
$: команда не найдена
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$  docker build -t logger .
[+] Building 84.8s (10/13)                                       docker:default
 => [internal] load build definition from Dockerfile                       0.1s
 => => transferring dockerfile: 379B                                       0.0s
 => [internal] load metadata for docker.io/library/ubuntu:18.04            2.4s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => [1/9] FROM docker.io/library/ubuntu:18.04@sha256:152dc042452c496007f  14.2s
 => => resolve docker.io/library/ubuntu:18.04@sha256:152dc042452c496007f0  0.0s
 => => sha256:152dc042452c496007f07ca9127571cb9c29697f42a 1.33kB / 1.33kB  0.0s
 => => sha256:dca176c9663a7ba4c1f0e710986f5a25e672842963d95b9 424B / 424B  0.0s
 => => sha256:f9a80a55f492e823bf5d51f1bd5f87ea3eed1cb3178 2.30kB / 2.30kB  0.0s
 => => sha256:7c457f213c7634afb95a0fb2410a74b7b5bc0ba5 25.69MB / 25.69MB  13.7s
 => => extracting sha256:7c457f213c7634afb95a0fb2410a74b7b5bc0ba527033362  0.3s
 => [internal] load build context                                          0.1s
 => => transferring context: 4.02MB                                        0.0s
 => [2/9] RUN apt update                                                  16.6s
 => [3/9] RUN apt install -yy gcc g++ cmake                               51.1s
 => [4/9] COPY . print/                                                    0.1s 
 => [5/9] WORKDIR print                                                    0.1s
 => ERROR [6/9] RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE  0.2s
------
 > [6/9] RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install:
0.186 CMake Error at CMakeLists.txt:1 (cmake_minimum_required):
0.186   CMake 3.14 or higher is required.  You are running version 3.10.2
0.186 
0.186 
0.186 -- Configuring incomplete, errors occurred!
------

 3 warnings found (use docker --debug to expand):
 - JSONArgsRecommended: JSON arguments recommended for ENTRYPOINT to prevent unintended behavior related to OS signals (line 19)
 - WorkdirRelativePath: Relative workdir "print" can have unexpected results if the base image changes (line 7)
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 13)
Dockerfile:9
--------------------
   7 |     WORKDIR print
   8 |     
   9 | >>> RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
  10 |     RUN cmake --build _build
  11 |     RUN cmake --build _build --target install
--------------------
ERROR: failed to solve: process "/bin/sh -c cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install" did not complete successfully: exit code: 1
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ $ docker build -t logger .
$: команда не найдена
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$  docker build -t logger .
[+] Building 54.9s (10/13)                                       docker:default
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 379B                                       0.0s
 => [internal] load metadata for docker.io/library/ubuntu:22.04            1.6s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => [1/9] FROM docker.io/library/ubuntu:22.04@sha256:d80997daaa3811b17511  4.8s
 => => resolve docker.io/library/ubuntu:22.04@sha256:d80997daaa3811b17511  0.0s
 => => sha256:d80997daaa3811b175119350d84305e1ec9129e1799 6.69kB / 6.69kB  0.0s
 => => sha256:a76d0e9d99f0e91640e35824a6259c93156f0f07b7778ba 424B / 424B  0.0s
 => => sha256:cc934a90cd99a939f3922f858ac8f055427300ee3ee 2.30kB / 2.30kB  0.0s
 => => sha256:30a9c22ae099393b0131322d7f50d8a9d7cd06c5e 29.53MB / 29.53MB  4.3s
 => => extracting sha256:30a9c22ae099393b0131322d7f50d8a9d7cd06c5e518cd27  0.4s
 => [internal] load build context                                          0.0s
 => => transferring context: 7.95kB                                        0.0s
 => [2/9] RUN apt update                                                   6.7s
 => [3/9] RUN apt install -yy gcc g++ cmake                               33.2s 
 => [4/9] COPY . print/                                                    0.1s 
 => [5/9] WORKDIR print                                                    0.1s
 => ERROR [6/9] RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE  8.3s
------
 > [6/9] RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install:
0.204 -- [hunter] Initializing Hunter workspace (572541b3a9e2c1ccb0c0e552f6dc12219c0d6a0b)
0.204 -- [hunter]   https://github.com/cpp-pm/hunter/archive/v0.23.314.tar.gz
0.204 -- [hunter]   -> /root/.hunter/_Base/Download/Hunter/0.23.314/572541b
8.234 CMake Error at Build/Hunter-prefix/src/Hunter-stamp/download-Hunter.cmake:170 (message):
8.234   Each download failed!
8.234 
8.234     
8.234     
8.234 
8.234 
8.237 gmake[2]: *** [CMakeFiles/Hunter.dir/build.make:98: Hunter-prefix/src/Hunter-stamp/Hunter-download] Error 1
8.237 gmake[1]: *** [CMakeFiles/Makefile2:83: CMakeFiles/Hunter.dir/all] Error 2
8.237 gmake: *** [Makefile:91: all] Error 2
8.239 
8.239 [hunter ** INTERNAL **] Build project failed
8.239 [hunter ** INTERNAL **] [Directory:/print]
8.239 
8.239 ------------------------------ ERROR ------------------------------
8.239     https://hunter.readthedocs.io/en/latest/reference/errors/error.internal.html
8.239 -------------------------------------------------------------------
8.239 
8.239 CMake Error at cmake/HunterGate.cmake:88 (message):
8.239 Call Stack (most recent call first):
8.239   cmake/HunterGate.cmake:98 (hunter_gate_error_page)
8.239   cmake/HunterGate.cmake:347 (hunter_gate_internal_error)
8.239   cmake/HunterGate.cmake:511 (hunter_gate_download)
8.239   CMakeLists.txt:4 (HunterGate)
8.239 
8.239 
8.239 -- Configuring incomplete, errors occurred!
------

 3 warnings found (use docker --debug to expand):
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 13)
 - JSONArgsRecommended: JSON arguments recommended for ENTRYPOINT to prevent unintended behavior related to OS signals (line 19)
 - WorkdirRelativePath: Relative workdir "print" can have unexpected results if the base image changes (line 7)
Dockerfile:9
--------------------
   7 |     WORKDIR print
   8 |     
   9 | >>> RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
  10 |     RUN cmake --build _build
  11 |     RUN cmake --build _build --target install
--------------------
ERROR: failed to solve: process "/bin/sh -c cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install" did not complete successfully: exit code: 1
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$  docker build -t logger .
[+] Building 104.6s (12/12) FINISHED                             docker:default
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 982B                                       0.0s
 => [internal] load metadata for docker.io/library/ubuntu:22.04            1.3s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => CACHED [1/7] FROM docker.io/library/ubuntu:22.04@sha256:d80997daaa381  0.0s
 => [internal] load build context                                          0.0s
 => => transferring context: 8.55kB                                        0.0s
 => [2/7] RUN apt-get update &&     apt-get install -yy     gcc     g++   78.4s
 => [3/7] RUN git clone https://github.com/cpp-pm/hunter /root/.hunter &&  5.2s 
 => [4/7] COPY . print/                                                    0.1s 
 => [5/7] WORKDIR print                                                    0.0s 
 => [6/7] RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INST  18.0s 
 => [7/7] WORKDIR _install/bin                                             0.1s 
 => exporting to image                                                     1.4s 
 => => exporting layers                                                    1.3s 
 => => writing image sha256:72d562289a04bb57c13ef2b86cea236fbb8f3b0c33837  0.0s 
 => => naming to docker.io/library/logger                                  0.0s

 1 warning found (use docker --debug to expand):
 - WorkdirRelativePath: Relative workdir "print" can have unexpected results if the base image changes (line 25)
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
logger        latest    72d562289a04   24 seconds ago   481MB
hello-world   latest    74cc54e27dc4   2 months ago     10.1kB
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ mkdir logs
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ docker run -it -v "$(pwd)/logs/:/home/logs/" logger
text1
text2
text3
<C-D>

docker inspect logger
EOF
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ docker run --init -it -v "$(pwd)/logs/:/home/logs/" loggerer
text1
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ docker run --init -it -v "$(pwd)/logs/:/home/logs/" logger
text1
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ docker inspect logger
[
    {
        "Id": "sha256:72d562289a04bb57c13ef2b86cea236fbb8f3b0c33837cc6348738c292a41261",
        "RepoTags": [
            "logger:latest"
        ],
        "RepoDigests": [],
        "Parent": "",
        "Comment": "buildkit.dockerfile.v0",
        "Created": "2025-04-21T15:49:28.102654175+03:00",
        "DockerVersion": "",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "HUNTER_ROOT=/root/.hunter",
                "LOG_PATH=/home/logs/log.txt"
            ],
            "Cmd": null,
            "Image": "",
            "Volumes": {
                "/home/logs": {}
            },
            "WorkingDir": "/print/_install/bin",
            "Entrypoint": [
                "./demo"
            ],
            "OnBuild": null,
            "Labels": {
                "org.opencontainers.image.ref.name": "ubuntu",
                "org.opencontainers.image.version": "22.04"
            }
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 480972755,
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/b734nihokvg4aldelndr7si3s/diff:/var/lib/docker/overlay2/qu4gjkgvs40zh6vs1eldbbadv/diff:/var/lib/docker/overlay2/bw0c08436u430yg314ojkc79x/diff:/var/lib/docker/overlay2/xm2dyh0l47tfo7lw8svx0w1kg/diff:/var/lib/docker/overlay2/37c177owq4aoo2at4cw8xye6l/diff:/var/lib/docker/overlay2/ca797952b026e3e4bd5f6e4e6960e2695310ead7c45859e3319a7237156b9121/diff",
                "MergedDir": "/var/lib/docker/overlay2/rsx0fjs8zc39cte8xjadb95gn/merged",
                "UpperDir": "/var/lib/docker/overlay2/rsx0fjs8zc39cte8xjadb95gn/diff",
                "WorkDir": "/var/lib/docker/overlay2/rsx0fjs8zc39cte8xjadb95gn/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:65c636ce09f299ba8ea7157c8d126dfd5b115fa7bbc5d634a91b34786958546e",
                "sha256:2739f32127ff1b1baa0bb294d7192dbfe83c083ed3244f8f3c642e90235eca52",
                "sha256:673d68915ee9c0569683aebda5445a863d56e64ce695d61e0dc2ebd38ad220e9",
                "sha256:b943d65f9139ce33794e84872d73d4b78c795a20255cb45ba3f72c8e138fde3e",
                "sha256:5f70bf18a086007016e948b04aed3b82103a36bea41755b6cddfaf10ace3c6ef",
                "sha256:df307e69b1a15eaef3c8757fab8c58673f08d2b9e6c320177177b45f411518e5",
                "sha256:5f70bf18a086007016e948b04aed3b82103a36bea41755b6cddfaf10ace3c6ef"
            ]
        },
        "Metadata": {
            "LastTagTime": "2025-04-21T15:49:29.464930448+03:00"
        }
    }
]
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$  cat logs/log.txt
text1
text2
text3
<C-D>
docker
inspect
logger
EOF
еtext1
text1
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ gsed -i 's/lab07/lab08/g' README.md
Команда «gsed» не найдена. Возможно, вы имели в виду:
  команда 'gsd' из deb-пакета python3-gsd (3.0.1-3build1)
  команда 'gted' из deb-пакета gnome-text-editor (46.3-0ubuntu2)
  команда 'ssed' из deb-пакета ssed (3.62-8)
  команда 'gsec' из deb-пакета firebird3.0-utils (3.0.11.33637.ds4-2ubuntu2)
  команда 'sed' из deb-пакета sed (4.9-2)
  команда 'gsnd' из deb-пакета ghostscript (10.02.1~dfsg1-0ubuntu7.5)
  команда 'gsad' из deb-пакета gsad (22.8.0-1)
  команда 'msed' из deb-пакета mblaze (1.1-1)
Попробуйте: sudo apt install <имя_deb-пакета>
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ sed -i 's/lab07/lab08/g' README.md
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ git add Dockerfile
michel@MichelUbuntu:~/MichelsonIU815/workspace/lab08$ git commit -m"adding Dockerfile"
[main 22de779] adding Dockerfile
 1 file changed, 36 insertions(+)
 create mode 100644 Dockerfile


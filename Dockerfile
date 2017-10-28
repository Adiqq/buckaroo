FROM base/archlinux

RUN echo -e "\nen_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen
RUN pacman -Syu
RUN pacman -S git bash ruby --noconfirm
RUN useradd -m -G wheel -s /bin/bash archie
COPY install.sh /home/archie/install.sh
RUN chmod +x /home/archie/install.sh

USER archie
RUN whoami
RUN git clone https://github.com/Linuxbrew/brew.git ~/.linuxbrew
ENV PATH="${PATH}:~/.linuxbrew/bin"
ENV MANPATH="$(brew --prefix)/share/man:$MANPATH"
ENV INFOPATH="$(brew --prefix)/share/info:$INFOPATH"

RUN bash ~/install.sh

CMD ["/bin/bash"]

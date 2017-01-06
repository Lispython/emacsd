# В образе установлено и собрано окружение для запуска
# необходимых emacs команд

FROM ubuntu:16.10

LABEL description="Ubuntu image configured for emacs commands"
LABEL version="1.0"


RUN apt-get update && apt-get install -y --no-install-recommends \
                pandoc \
                markdown \
                less \
                aptitude #\
                #&& rm -rf /var/lib/apt/lists/*

CMD ["echo", "emacsd docker work"]

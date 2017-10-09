FROM 780002858061.dkr.ecr.ap-southeast-1.amazonaws.com/base-image:erlang-18.3
#ARG ssh_prv_key
#ARG known_host

#RUN mkdir -p /root/.ssh && chmod 0700 /root/.ssh
#RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa
#RUN echo $known_host > /root/.ssh/known_hosts
#RUN chmod 600 /root/.ssh/id_rsa
#RUN cat /root/.ssh/id_rsa
#RUN cat /root/.ssh/known_hosts
COPY / /usr/src/app/
WORKDIR /usr/src/app/
RUN . /root/erlang-18.3/activate && ./rebar3 as prod release -n dockertest
RUN ls -al /usr/src/app/_build/

FROM 780002858061.dkr.ecr.ap-southeast-1.amazonaws.com/base-image:erlang-18.3
COPY --from=0 /usr/src/app/_build /usr/src/test/
WORKDIR /usr/src/test/
CMD  . /root/erlang-18.3/activate && prod/rel/dockertest/bin/dockertest foreground

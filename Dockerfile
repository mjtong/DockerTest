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
RUN . /root/erlang-18.3/activate && . /usr/src/app/rebar3 as prod release -n dockertest

FROM 780002858061.dkr.ecr.ap-southeast-1.amazonaws.com/base-image:erlang-18.3
COPY --from=0 /usr/src/app/_build /usr/src/test/
CMD  . /root/erlang-18.3/activate && /usr/src/test/prod/rel/dockertest/bin/dockertest foreground

FROM gitpod/workspace-postgres
USER gitpod

# Increment the value to bust the docker image cache
ENV INVALIDATE_CACHE=2

# Install the Ruby version specified in '.ruby-version'
COPY --chown=gitpod:gitpod .ruby-version /tmp
RUN echo "rvm_gems_path=/home/gitpod/.rvm" > ~/.rvmrc
RUN bash -lc "rvm install ruby-$(cat /tmp/.ruby-version) && rvm use ruby-$(cat /tmp/.ruby-version) --default"
RUN echo "rvm_gems_path=/workspace/.rvm" > ~/.rvmrc

# Logs
RUN sudo touch /var/log/workspace-init.log \
    && sudo chmod 666 /var/log/workspace-init.log

# Aliases
COPY --chown=gitpod:gitpod .gp/bash/.bash_aliases /home/gitpod

FROM ghcr.io/collectivexyz/foundry:latest

ENV USER=foundry
ENV PATH=${PATH}:/home/${USER}/.cargo/bin

USER foundry 

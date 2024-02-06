#!/bin/bash -e

#-------------------------------------------------------------------------------
# Set up Anaconda
#-------------------------------------------------------------------------------
CONDA_SRC="${HOME}/.local/miniconda3"
CONDA_BIN="${CONDA_SRC}/bin/conda"

if [[ "$(${CONDA_BIN} shell.zsh hook 2> /dev/null)" ]]; then
  eval "$(${CONDA_BIN} shell.zsh hook 2> /dev/null)"
else
  if [[ -f "${CONDA_SRC}/etc/profile.d/conda.sh" ]]; then
    source "${CONDA_SRC}/etc/profile.d/conda.sh"
  else
    export PATH="${PATH}:${CONDA_SRC}/bin"
  fi
fi

#-------------------------------------------------------------------------------
# Set up Anaconda environment
#-------------------------------------------------------------------------------
CONDA_ENV="pytorch"

[[ ! $(conda env list | grep "^[^#]" | grep "${CONDA_ENV}") ]] && yes | conda create --name="${CONDA_ENV}" python=3.11

#-------------------------------------------------------------------------------
# Install e3nn and auxiliary packages
#-------------------------------------------------------------------------------
conda activate "${CONDA_ENV}"

PKG="ipython"      && [[ ! $(conda list | grep "^[^#]" | grep -w "^${PKG}") ]] && yes | conda install -c default     "${PKG}" 
PKG="numpy"        && [[ ! $(conda list | grep "^[^#]" | grep -w "^${PKG}") ]] && yes | conda install -c default     "${PKG}" 
PKG="matplotlib"   && [[ ! $(conda list | grep "^[^#]" | grep -w "^${PKG}") ]] && yes | conda install -c default     "${PKG}" 
PKG="scipy"        && [[ ! $(conda list | grep "^[^#]" | grep -w "^${PKG}") ]] && yes | conda install -c default     "${PKG}" 
PKG="scikit-learn" && [[ ! $(conda list | grep "^[^#]" | grep -w "^${PKG}") ]] && yes | conda install -c default     "${PKG}" 
PKG="ipykernel"    && [[ ! $(conda list | grep "^[^#]" | grep -w "^${PKG}") ]] && yes | conda install -c conda-forge "${PKG}" 
PKG="pytorch"      && [[ ! $(conda list | grep "^[^#]" | grep -w "^${PKG}") ]] && yes | conda install -c pytorch     "${PKG}" 
PKG="torchvision"  && [[ ! $(conda list | grep "^[^#]" | grep -w "^${PKG}") ]] && yes | conda install -c pytorch     "${PKG}" 
PKG="torchaudio"   && [[ ! $(conda list | grep "^[^#]" | grep -w "^${PKG}") ]] && yes | conda install -c pytorch     "${PKG}" 

conda deactivate

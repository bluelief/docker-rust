## How to use

### Build image

```shell
$ git clone https://github.com/bluelief/docker-rust.git
$ cd docker-rust
$ docker build -t rust:latest .
```


### Usage

```bash
alias cargo='docker run --rm --user $(id -u):$(id -g) --env PATH=/home/rust/.cargo/bin:$PATH -v $HOME/.cargo/registry:/home/rust/.cargo/registry -v $HOME/.cargo/credentials:/home/rust/.cargo/credentials -v $PWD:/tmp/dev -w /tmp/dev rust:latest cargo'
alias rustc='docker run --rm --user $(id -u):$(id -g) --env PATH=/home/rust/.cargo/bin:$PATH -v $HOME/.cargo/registry:/home/rust/.cargo/registry -v $HOME/.cargo/credentials:/home/rust/.cargo/credentials -v $PWD:/tmp/dev -w /tmp/dev rust:latest rustc'

```

```bash
# Or just CARGO=cargo
CARGO=docker run --rm \
  --user $$(id -u):$$(id -g) \
  --env PATH=/home/rust/.cargo/bin:$$PATH \
  --env OPENSSL_LIB_DIR=/usr/local/musl/lib/ \
  --env OPENSSL_INCLUDE_DIR=/usr/local/musl/include \
  --env OPENSSL_STATIC=true \
  --env PKG_CONFIG_ALLOW_CROOSS=1 \
  -v $$PWD:/home/rust/dev \
  -v $$HOME/.cargo/registry:/home/rust/.cargo/registry \
  -w /home/rust/dev \
  rust:latest \
  cargo
```


### License

<sup>
Licensed under <a href="LICENSE">The Unlicense</a>.
</sup>

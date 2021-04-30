## How to use

### Build image

```shell
$ git clone https://github.com/bluelief/docker-rust.git
$ cd docker-rust
$ docker build -t rust:latest .
```


### Usage

```bash
alias cargo='docker run --rm --user $(id -u) --user $(id -g) --env PATH=/home/rust/.cargo/bin:$PATH -v "$PWD":/home/rust/dev -w /home/rust/dev rust:latest cargo'
alias rustc='docker run --rm --user $(id -u) --user $(id -g) --env PATH=/home/rust/.cargo/bin:$PATH -v "$PWD":/home/rust/dev -w /home/rust/dev rust:latest rustc'
```


## License

Licensed under [The Unlicense](LICENSE).


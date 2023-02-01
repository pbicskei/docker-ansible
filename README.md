# Ansible Docker Image

A Docker image for Ansible that allows you to run Ansible commands within a container.

## Introduction

Hi there! I am a DevOps engineer who loves to work with Ansible. I have found that working with Ansible in a containerized environment makes it easier to manage dependencies, isolate the environment, and avoid version conflicts. That's why I have created this Ansible Docker Image.

## Usage

To locally build this Docker image, you can use either `docker build` or `docker buildx`.

### Using docker build

```bash
docker build --build-arg TARGETPLATFORM=linux/amd64 -t ansible .
```

### Using docker buildx

```bash
docker buildx build --platform linux/amd64 --build-arg TARGETPLATFORM=linux/amd64 -t ansible .
```

Once the image is built, you can run Ansible commands within the container by using the following command:

```bash
docker run -v $PWD:/data ansible <ansible command>
```

For example, to run `ansible init`, use the following command:

```bash
docker run -v $PWD:/data ansible init
```

### Using the pre-built image

If you don't want to build the image yourself, you can use the pre-built image from the Docker registry. The image is available at the following location:

```bash
docker pull docker.io/pbicskei/ansible
```

To use the pre-built image, simply run the following command:

```bash
docker run -v $PWD:/data pbicskei/ansible <ansible command>
```

For example, to get the version, use the following command:

```bash
docker run -v $PWD:/data pbicskei/ansible ansible --version
```

### Setting up Secrets in GitHub

In order to build and push your own container, you'll need to set up a couple of secrets in your GitHub repository.

Here's how to do that:

1. Go to the main page of your forked repository in GitHub.
2. Click on the "Settings" tab.
3. In the left-hand menu, click on "Secrets".
4. Click on the "New repository secret" button.
5. Enter `DOCKERHUB_USERNAME` as the name of the secret, and your Docker Hub username as the value.
6. Click the "Add repository secret" button to save.
7. Create another secret, this time with the name `DOCKERHUB_PASSWORD` and your Docker Hub password as the value.
8. Click the "Add repository secret" button to save.

With these secrets set up, your GitHub Actions workflow will have the necessary credentials to build and push the container to Docker Hub. If you don't set these secrets, the automated build will not work.

## Run the Ansible Container

The following command will run the Ansible container, mounting your local `~/.ssh` directory to the container's `/root/.ssh` directory, allowing Ansible to use your SSH key for authentication:

```bash
docker run -v ~/.ssh:/root/.ssh -it pbicskei/ansible <ansible_command>
```

Replace pbicskei/ansible with the name of your Ansible image and <ansible_command> with the Ansible command you want to run, such as ansible-playbook.

### Run Ansible Playbook

To run an Ansible playbook, you can use the following command:

```bash
docker run -v ~/.ssh:/root/.ssh -v $(pwd):/data -it pbicskei/ansible ansible-playbook /data/<playbook_file>.yml
```

Replace pbicskei/ansible with the name of your Ansible image and <playbook_file>.yml with the name of your Ansible playbook file. The -v $(pwd):/data option mounts the current directory on the host to the /data directory in the container, allowing Ansible to access your playbook file.

### Pass Environment Variables

You can pass environment variables to the container using the -e flag. For example, to disable host key checking for SSH connections:

```bash
docker run -e ANSIBLE_HOST_KEY_CHECKING=False -v ~/.ssh:/root/.ssh -it pbicskei/ansible <ansible_command>
```

Replace pbicskei/ansible with the name of your Ansible image and <ansible_command> with the Ansible command you want to run.

### Run in Background

To run the container in the background, add the -d option:

```bash
docker run -d -v ~/.ssh:/root/.ssh -v $(pwd):/data -it pbicskei/ansible ansible-playbook /data/<playbook_file>.yml
```

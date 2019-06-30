## drone-ecr-pull

[![](https://images.microbadger.com/badges/image/kudato/drone-ecr-pull.svg)](https://microbadger.com/images/kudato/drone-ecr-pull "Get info on this image.")

### Why?

[Drone](https://drone.io/) cannot use [ECR](https://aws.amazon.com/ru/ecr/) private images for the build steps, this plugin solve this problem.

### Usage

```yaml
...

- name: Pull step
  image: kudato/drone-ecr-pull
  volumes:
  - name: docker
    path: /var/run/docker.sock
  settings:
    region: us-east-1
    access_key:
      from_secret: aws_access_key_id
    secret_key:
      from_secret: aws_secret_access_key
    images: [
      "012345678901.dkr.ecr.us-east-1.amazonaws.com/my-awesome-image:latest",
      "012345678901.dkr.ecr.us-east-1.amazonaws.com/my-other-image:latest"
    ]

...

volumes:
- name: docker
  host:
    path: /var/run/docker.sock
```

Downloaded images will be guaranteed available to other steps in the same pipeline.

# Parameter Reference

- **access_key:** your aws access key

- **secret_key:** your aws secret access key

- **region:** aws region where your registry is located, defaults is `us-east-1`

- **images:** list of download images


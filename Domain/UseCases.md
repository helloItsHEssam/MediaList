# UseCases

## Description
In the **"UseCases"** section, we determine how we interact with the **"Presentation"** module. It contains a protocol named **"MediaUseCase"** which has two functions:

```
func fetchMediaList() -> AnyPublisher<[Media], DomainError>
```

This function attempts to retrieve a list of data from the "Data" module. If an error occurs during retrieval, it sends an error to another layer.

<br>

```
func fetchImage(withImageUrl imageUrl: String) -> AnyPublisher<Image, DomainError>
```

 In this function, it first checks if the image exists locally. If the image is not found locally, a request is sent to the server to fetch it. After receiving the image, it stores it locally. If an error occurs during this process, it sends an error to another layer.

<br>

There is another function, `fetchMediaPreviewSize`, which is private and used to obtain the image size. If, for any reason, it's not possible to fetch the image size, a default size of **200x200** is used.

All these operations are implemented by the **"MediaUseCaseImpl"** class, which requires access to both the **"MediaRepository"** and **"ImageRepository"** to perform these tasks.
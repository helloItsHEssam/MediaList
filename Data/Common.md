# Common

## Description
There is a protocol named **"Mapper"** for converting **"Dto"** to **"Entity"** and vice versa. Any entity that needs to be a converter must implement this protocol. It contains two functions for one-to-one mapping and two functions for list mappings, which depend on the one-to-one mapping functions. This protocol is generic.

The **"PreviewMediaSizeDTO"** is responsible for storing information about the size of images from the server or local storage.

The **"PreviewMediaSizeMapper"** is responsible for converting the image size unit obtained from the server or local storage to an entity defined within the "Domain" module.

In this way, this section provides a way to handle data mapping and conversion between data transfer objects (Dto) and entities in a generic and organized manner.
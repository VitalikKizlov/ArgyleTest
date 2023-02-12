
## Project Architecture

MVVM, Clean Architecture. MVVM bindings is done with Combine. UI is done programmatically. 

In production, when we have more complex logic like pagination etc., I would rather move search logic to some `SearchService`, which in turn will use `SearchProvider`.

## Dependencies

CombineCocoa - publishers for common UIKit controls.
Kingfisher - for downloading and caching images.




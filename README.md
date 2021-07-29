# emocean

An application to journaling your emotion


## Folder Structure
```
app
├── Util
│   ├── Extensions                          # Foundation/SwiftUI Extensions Files
│   ├── Services                            # Creating service for a specific model (Could also act as networking)
│   │   ├──  MoodService.swift
│   │   ├──  PhotoService.swift
│   │   └──  ...
│   ├── Networking                          # Creating a request to server
│   ├── Error                               # Error Types
│   │   ├──  NetworkingError.swift
│   │   └──  ... 
│   ├── CacheManager                        # Data caching
│   │   ├──  PhotoCacheManager.swift
│   │   └──  ...
│   ├── ResultState                         # A state for a specific view
│   └── ...
├── Models                                  # Data Models
│   ├── Emotion.swift
│   └── ...
├── Cores                                   # Views and ViewModels for features and components
│   ├──  Components                         # Views and ViewModels that will used in more than 1 Views
│   │    ├── ImageLoader
│   │    │   └── ImageLoaderView.swift
│   │    │   └── ImageLoaderViewModel.swift
│   │    └── ...
│   ├──  Home                               # Views and ViewModels for a specific page/feature
│   │    ├── Views                    
│   │    │   ├── HomeView.swift
│   │    │   └── ...
│   │    └── ViewModels
│   │        ├── HomeViewModel.swift
│   │        └── ...
│   └── ...
├── Resources
│   ├──  Assets.xcassets 
│   │    ├── AppIcon
│   │    ├── ColorThemes
│   │    ├── AppIcons
│   │    └── ...
│   └── ...  
├── ProjectApp.swift
└── info.plist
```

## Our Team

- [@mughieams](github.com/mughieams)
- [@handharr](github.com/handharr)
- [@farrelnajib](github.com/farrelnajib)
- [@wilsonadrilia](github.com/wilsonadrilia)
- [@adiputrachristian](github.com/adiputrachristian)
- Nicholas Kusuma <nicholaskusuma05@gmail.com>
- Michele Julieta <michelejulieta11@gmail.com>

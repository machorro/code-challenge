import App
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func loadStories() {
    API.fetchStories { result in
        switch result {
        case .failure:
            print("nothing to see here yet")
        case let .success(stories):
            print(stories)
        }

        PlaygroundPage.current.finishExecution()
    }
}

loadStories()

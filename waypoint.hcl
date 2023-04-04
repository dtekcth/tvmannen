project = "tvmannen"
app "TV-Mannen" {
  build {
    use "docker" {
    }
    registry {
      use "docker" {
        image = "tvmannen"
        tag   = "latest"
        local = true
      }
    }
  }
  deploy {
    use "docker" {
    }
  }
}

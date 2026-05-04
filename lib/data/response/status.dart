// Defines the possible states of an asynchronous data request or process
enum Status {
  // The process has started but not yet finished (e.g., waiting for API response)
  loading,

  // The process finished successfully and the data is ready to be displayed
  completed,

  // The process failed due to an error (e.g., network timeout or invalid credentials)
  error,
}

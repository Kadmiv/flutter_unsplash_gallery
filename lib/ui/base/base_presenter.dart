class BasePresenter<IView> {
  IView mView;

  void attachView(IView view) {
    this.mView = view;
  }

  void detachView() {
    this.mView = null;
  }

  bool get isViewAttached {
    return mView != null;
  }

  void checkViewAttached() {
    if (mView == null) {
      throw new Exception("attached view is null!");
    }
  }

  IView getView() {
    return mView;
  }
}

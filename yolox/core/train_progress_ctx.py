
class TrainProgressContext:
    '''Dummy implementation of a training context'''

    def __init__(self):
        pass

    def start_epoch(self, epoch: int):
        pass

    def set_train_epoch_count(self, count: int):
        pass

    def set_train_dataset_size(self, size: int, batch_size: int):
        pass

    def set_validation_dataset_size(self, size: int, batch_size: int):
        pass

    def start_training(self):
        pass

    def update_train_progress(self, delta: int):
        pass

    def training_done(self):
        pass

    def training_finished(self):
        pass

    def update_train_ap(self, ap50_95: int, ap50: int):
        pass

    def start_evaluation(self):
        pass

    def update_evaluation_progress(self, delta: int):
        pass

    def evaluation_done(self):
        pass

    def update_checkpoint(self, model):
        pass

    def is_stopped(self):
        return False

    def is_interrupted(self):
        return False

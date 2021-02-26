import { unlink } from 'fs';

class DeleteFile {
  run({ path }) {
    unlink(path, () => {});
  }
}
export default new DeleteFile();

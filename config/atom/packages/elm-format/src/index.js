'use babel';

import { CompositeDisposable } from 'atom'; // eslint-disable-line
import path from 'path';
import childProcess from 'child_process';
import config from './settings';

export default {
  config,
  subscriptions: null,

  activate() {
    this.subscriptions = new CompositeDisposable();
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'elm-format:file': () => this.formatCurrentFile(),
    }));
    this.subscriptions.add(atom.workspace.observeTextEditors(e => this.handleEvents(e)));
  },

  handleEvents(editor) {
    editor.getBuffer().onWillSave(() => {
      if (atom.config.get('elm-format.formatOnSave') && this.isElmEditor(editor)) {
        this.format(editor);
      }
    });
  },

  deactivate() {
    this.subscriptions.dispose();
  },

  error(str) {
    if (atom.config.get('elm-format.showErrorNotifications')) {
      atom.notifications.addError(str);
    }
  },

  success(str) {
    if (atom.config.get('elm-format.showNotifications')) {
      atom.notifications.addSuccess(str);
    }
  },

  formatCurrentFile() {
    const editor = atom.workspace.getActiveTextEditor();
    if (!editor) {
      return;
    }
    if (this.isElmEditor(editor)) {
      this.format(editor);
    } else {
      atom.notifications.addInfo('Not an Elm file', {
        dismissable: false,
        detail: 'I only know how to format .elm-files, sorry!',
      });
    }
  },

  isElmEditor(editor) {
    return editor && editor.getPath && editor.getPath() &&
      path.extname(editor.getPath()) === '.elm';
  },

  format(editor) {
    try {
      const { status, stdout } = childProcess.spawnSync(
        atom.config.get('elm-format.binary'),
        ['--stdin'], { input: editor.getText() });
      switch (status) {
        case 0: {
          const cursorPosition = editor.getCursorScreenPosition();
          editor.buffer.setTextViaDiff(stdout.toString());
          editor.setCursorScreenPosition(cursorPosition);

          this.success('Formatted file');
          break;
        }
        case 1:
          this.error('Can\'t format, syntax error maybe?');
          break;
        case null:
          this.error('Can\'t find elm-format binary, check your settings');
          break;
        default:
          this.error(`elm-format exited with code ${status}.`);
      }
    } catch (exception) {
      this.error(`elm-format exception: ${exception}`);
    }
  },
};

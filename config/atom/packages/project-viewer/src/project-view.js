'use strict';

const map = require('./map');
const database = require('./database');
const statusBar = require('./status-bar');
const domBuilder = require('./dom-builder');
const colours = require('./colours');
const getSelectedProject = require('./common').getSelectedProject;
const getCurrentOpenedProject = require('./common').getCurrentOpenedProject;
const getModel = require('./common').getModel;
const getView = require('./common').getView;

const onClickEvent = function _onClickEvent (model) {
  if (!model) { return null; }
  this.openOnWorkspace();
};

const dragstart = function _dragstart (evt) {
  const view = getView(evt.target);
  view.classList.add('dragging');
  evt.dataTransfer.setData(
    'text/plain',
    getModel(evt.target).uuid
  );
  evt.stopPropagation();
};

const dragover = function _dragover (evt) {
  const view = getView(evt.target);
  const middle = view.clientHeight / 2;

  if (evt.target.offsetTop + middle > evt.layerY) {
    evt.target.classList.add('above');
    evt.target.classList.remove('below');
  }
  else {
    evt.target.classList.remove('above');
    evt.target.classList.add('below');
  }

  evt.preventDefault();
  evt.stopPropagation();
};

const dragleave = function _dragleave (evt) {
  evt.preventDefault();
  this.classList.remove('dropping', 'below', 'above');
};

const dragenter = function _dragenter (evt) {
  evt.preventDefault();
  const uuid = evt.dataTransfer.getData('text/plain');
  const draggedView = document.querySelector(
    `project-viewer li[data-project-viewer-uuid="${uuid}"]`
  );
  const view = getView(evt.target);
  if (view === draggedView) { return; }

  this.classList.add('dropping');
};

const dragend = function _dragend (evt) {
  const view = getView(evt.target);
  view.classList.remove('dragging');
  evt.stopPropagation();
};

const drop = function _drop (evt) {
  evt.stopPropagation();

  const uuid = evt.dataTransfer.getData('text/plain');

  const draggedView = document.querySelector(
    `project-viewer li[data-project-viewer-uuid="${uuid}"]`
  );
  const droppedView = getView(evt.target);

  if (droppedView === draggedView) { return; }

  const droppedModel = getModel(evt.target);
  const draggedModel = getModel(draggedView);

  // a bit hacky
  const insertBefore = droppedView.classList.contains('above');
  this.classList.remove('dropping', 'below', 'above');

  database.moveTo(draggedModel, droppedModel, insertBefore);
  database.save();
};

const attachedCallback = function _attachedCallback () {
  this.addEventListener('dragstart', dragstart, false);
  this.addEventListener('dragover', dragover, false);
  this.addEventListener('dragleave', dragleave, false);
  this.addEventListener('dragenter', dragenter, false);
  this.addEventListener('dragend', dragend, false);
  this.addEventListener('drop', drop, false);
};

const detachedCallback = function _detachedCallback () {
  this.removeEventListener('dragstart', dragstart, false);
  this.removeEventListener('dragover', dragover, false);
  this.removeEventListener('dragleave', dragleave, false);
  this.removeEventListener('dragenter', dragenter, false);
  this.removeEventListener('dragend', dragend, false);
  this.removeEventListener('drop', drop, false);
};

const initialize = function _initialize () {
  const model = map.get(this);

  if (!model) { return; }

  this.classList.add('list-item');

  this.setAttribute('data-project-viewer-uuid', model.uuid);
  this.setAttribute('draggable', 'true');

  this.addEventListener(
    'click',
    onClickEvent.bind(this, model)
  );
};

const render = function _render () {
  const model = map.get(this);

  if (!model) {
    return;
  }

  let spanNode = this.querySelector('span');
  let contentNode = this;

  if (!spanNode) {
    contentNode.textContent = '';
    spanNode = document.createElement('span');
    contentNode.appendChild(spanNode);
  }

  if (model.icon) {
    contentNode = spanNode;
    if (model.icon.startsWith('devicons-')) {
      contentNode.classList.add('devicons', model.icon);
    }
    else {
      contentNode.classList.add('icon', model.icon);
    }
  }
  else if (spanNode) {
    contentNode = spanNode;
  }

  if (model.name) {
    contentNode.textContent = model.name;
  }

  if (model.color) {
    colours.addRule(model.uuid, model.type, model.color);
  }

  this.classList.toggle('no-paths', model.paths.length === 0);

  const currentOpenedProject = getCurrentOpenedProject(model);

  this.classList.toggle(
    'selected',
    currentOpenedProject
  );

  if (currentOpenedProject) {
    statusBar.update(model.breadcrumb());
  }
};

const sorting = function _sorting () {
  const model = map.get(this);

  if (!model) {
    return;
  }
  return model.name;
};

const openOnWorkspace = function _openOnWorkspace (reverseOption) {
  const model = map.get(this);

  if (!model) { return false; }

  if (model.paths.length === 0) { return false; }

  const action = reverseOption ?
    !atom.config.get('project-viewer.openNewWindow') :
    atom.config.get('project-viewer.openNewWindow');

  if (action) {
    atom.open({
      pathsToOpen: model.paths,
      newWindow: true,
      devMode: model.devMode,
      safeMode: false
    });
    return false;
  }

  const currentOpenedProject = getCurrentOpenedProject(model);

  if (currentOpenedProject) { return false; }

  let selectedProject = getSelectedProject();

  if (selectedProject) {
    selectedProject.classList.remove('selected');
  }

  this.classList.add('selected');

  let projectSHA;
  let serialization;

  if (!atom.config.get('project-viewer.keepContext')) {
    projectSHA = atom.getStateKey(atom.project.getPaths());
    serialization = atom.serialize();
  }

  if (projectSHA && serialization) {
    atom.getStorageFolder().storeSync(projectSHA, serialization);
  }

  statusBar.update(model.breadcrumb());

  if (!atom.config.get('project-viewer.keepContext')) {
    projectSHA = atom.getStateKey(model.paths);
    serialization = atom.getStorageFolder().load(projectSHA);
  }

  if (!serialization) {
    database.pathsChangedBypass = true;
    atom.project.setPaths(model.paths);
    database.pathsChangedBypass = false;
  } else {
    atom.deserialize(serialization);
  }

  if (!atom.config.get('project-viewer.keepContext') && !serialization) {
    atom.workspace.destroyActivePane();
  }

  // hack to make linter update on project switching
  const linterPackage = atom.packages.getActivePackage('linter');
  if (linterPackage) {
    linterPackage.deactivate();
    linterPackage.activate();
  }

  return true;
};

const viewMethods = {
  attachedCallback,
  detachedCallback,
  initialize,
  render,
  sorting,
  openOnWorkspace
};

const createView = function _createView (model) {
  let options = {
    tagExtends: 'li',
    tagIs: 'project-viewer-project'
  };
  if (!model) {
    return;
  }
  return domBuilder.createView(options, viewMethods, model);
};

module.exports = {
  createView: createView
};

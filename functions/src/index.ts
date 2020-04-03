import * as admin from 'firebase-admin';
import Dependencies from './dependencies';
import creatChangeCategory from './changeCategory';
import createUpdate from './update';

admin.initializeApp();

const deps: Dependencies = {
    firestore: admin.firestore(),
    uid: 'EKDRNcDbDgUYbdGyFFUevSLBrW33'
};

export const changeCategory = creatChangeCategory(deps);
export const update = createUpdate(deps);


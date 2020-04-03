import * as admin from 'firebase-admin';
import Dependencies from './dependencies';
import creatChangeCategory from './changeCategory';
import createUpdate from './update';
import createResetCategories from './resetCategories';

admin.initializeApp();

const deps: Dependencies = {
    firestore: admin.firestore(),
    uid: 'EKDRNcDbDgUYbdGyFFUevSLBrW33'
};

export const changeCategory = creatChangeCategory(deps);
export const update = createUpdate(deps);
export const resetCategories = createResetCategories(deps);


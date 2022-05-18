import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as emails from '@sendgrid/mail';
import * as _ from 'lodash';
import { regionEur } from './config';

const authenticationCodeSettings = {
    url: 'https://lockieapp.com/secure-auth',
    iOS: {
      bundleId: 'com.nathanielxd.lockie'
    },
    android: {
      packageName: 'com.nathanielxd.lockie',
      installApp: true,
      minimumVersion: '19'
    },
    handleCodeInApp: true,
    dynamicLinkDomain: 'lockie.page.link',
};

export const onAccountCreate = functions.region(regionEur).auth
.user().onCreate(async (createdUser) => {
    // Abort and log error if created user does not have an email address.
    if(_.isNil(createdUser.email)) {
        functions.logger.error('Created user does not have an email. Function is aborted.');
        return;
    }

    try {
        // Create user profile document for the newly created user.
        await admin.firestore()
            .collection('users')
            .doc(createdUser.uid)
            .set({
                'email': createdUser.email,
                'emailVerified': createdUser.emailVerified,
                'lastActive': Date.now(),
                'emailPreferences': {
                    'lastRateInquiry': Date.now(),
                    'canReceiveRateInquiry': true
                }
            });

        functions.logger.log('Created user profile for user ' + createdUser.uid);

        // Send email confirmation email.
        //const emailConfirmationLink = await admin.auth().generateEmailVerificationLink(createdUser.email, authenticationCodeSettings);
        
        /*await emails.send({
            to: createdUser.email,
            from: template.sender,
            templateId: template.templateId,
            dynamicTemplateData: {
                link: emailConfirmationLink
            }
        });

        functions.logger.log('Send email confirmation to user ' + createdUser.uid + ' with email ' + createdUser.email);*/
    }
    catch(e) {
        functions.logger.error('Could not create a user profile document for the newly created user.');
    }
    return;
});

export const authenticateWithEmailLink = functions.region(regionEur).https.onCall(async (email) => {
    
    // Abort and log error if there is no email available.
    if(_.isNil(email)) {
        functions.logger.error('Function was used with the email argument empty.')
        return;
    }

    const emailMagicLink = await admin.auth().generateSignInWithEmailLink(email, authenticationCodeSettings);

    await emails.send({
        to: email,
        from: 'auth@lockieapp.com',
        templateId: 'd-271190bdd47b491c96ad17040d83ace0',
        dynamicTemplateData: {
            link: emailMagicLink
        }
    })
    .then(() => {
        functions.logger.log('Email confirmation sent to ' + email + ' successfully.');
    })
    .catch(() => {
        functions.logger.error('Could not send email confirmation.');
    });

    return;
});
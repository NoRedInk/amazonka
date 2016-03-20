{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.STS.Types.Product
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
module Network.AWS.STS.Types.Product where

import           Network.AWS.Lens
import           Network.AWS.Prelude
import           Network.AWS.STS.Types.Sum

-- | The identifiers for the temporary security credentials that the
-- operation returns.
--
-- /See:/ 'assumedRoleUser' smart constructor.
data AssumedRoleUser = AssumedRoleUser'
    { _aruAssumedRoleId :: !Text
    , _aruARN           :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'AssumedRoleUser' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'aruAssumedRoleId'
--
-- * 'aruARN'
assumedRoleUser
    :: Text -- ^ 'aruAssumedRoleId'
    -> Text -- ^ 'aruARN'
    -> AssumedRoleUser
assumedRoleUser pAssumedRoleId_ pARN_ =
    AssumedRoleUser'
    { _aruAssumedRoleId = pAssumedRoleId_
    , _aruARN = pARN_
    }

-- | A unique identifier that contains the role ID and the role session name
-- of the role that is being assumed. The role ID is generated by AWS when
-- the role is created.
aruAssumedRoleId :: Lens' AssumedRoleUser Text
aruAssumedRoleId = lens _aruAssumedRoleId (\ s a -> s{_aruAssumedRoleId = a});

-- | The ARN of the temporary security credentials that are returned from the
-- < AssumeRole> action. For more information about ARNs and how to use
-- them in policies, see
-- <http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html IAM Identifiers>
-- in /Using IAM/.
aruARN :: Lens' AssumedRoleUser Text
aruARN = lens _aruARN (\ s a -> s{_aruARN = a});

instance FromXML AssumedRoleUser where
        parseXML x
          = AssumedRoleUser' <$>
              (x .@ "AssumedRoleId") <*> (x .@ "Arn")

instance Hashable AssumedRoleUser

-- | AWS credentials for API authentication.
--
-- /See:/ 'credentials' smart constructor.
data Credentials = Credentials'
    { _cAccessKeyId     :: !Text
    , _cSecretAccessKey :: !Text
    , _cSessionToken    :: !Text
    , _cExpiration      :: !ISO8601
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'Credentials' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'cAccessKeyId'
--
-- * 'cSecretAccessKey'
--
-- * 'cSessionToken'
--
-- * 'cExpiration'
credentials
    :: Text -- ^ 'cAccessKeyId'
    -> Text -- ^ 'cSecretAccessKey'
    -> Text -- ^ 'cSessionToken'
    -> UTCTime -- ^ 'cExpiration'
    -> Credentials
credentials pAccessKeyId_ pSecretAccessKey_ pSessionToken_ pExpiration_ =
    Credentials'
    { _cAccessKeyId = pAccessKeyId_
    , _cSecretAccessKey = pSecretAccessKey_
    , _cSessionToken = pSessionToken_
    , _cExpiration = _Time # pExpiration_
    }

-- | The access key ID that identifies the temporary security credentials.
cAccessKeyId :: Lens' Credentials Text
cAccessKeyId = lens _cAccessKeyId (\ s a -> s{_cAccessKeyId = a});

-- | The secret access key that can be used to sign requests.
cSecretAccessKey :: Lens' Credentials Text
cSecretAccessKey = lens _cSecretAccessKey (\ s a -> s{_cSecretAccessKey = a});

-- | The token that users must pass to the service API to use the temporary
-- credentials.
cSessionToken :: Lens' Credentials Text
cSessionToken = lens _cSessionToken (\ s a -> s{_cSessionToken = a});

-- | The date on which the current credentials expire.
cExpiration :: Lens' Credentials UTCTime
cExpiration = lens _cExpiration (\ s a -> s{_cExpiration = a}) . _Time;

instance FromXML Credentials where
        parseXML x
          = Credentials' <$>
              (x .@ "AccessKeyId") <*> (x .@ "SecretAccessKey") <*>
                (x .@ "SessionToken")
                <*> (x .@ "Expiration")

instance Hashable Credentials

-- | Identifiers for the federated user that is associated with the
-- credentials.
--
-- /See:/ 'federatedUser' smart constructor.
data FederatedUser = FederatedUser'
    { _fuFederatedUserId :: !Text
    , _fuARN             :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'FederatedUser' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'fuFederatedUserId'
--
-- * 'fuARN'
federatedUser
    :: Text -- ^ 'fuFederatedUserId'
    -> Text -- ^ 'fuARN'
    -> FederatedUser
federatedUser pFederatedUserId_ pARN_ =
    FederatedUser'
    { _fuFederatedUserId = pFederatedUserId_
    , _fuARN = pARN_
    }

-- | The string that identifies the federated user associated with the
-- credentials, similar to the unique ID of an IAM user.
fuFederatedUserId :: Lens' FederatedUser Text
fuFederatedUserId = lens _fuFederatedUserId (\ s a -> s{_fuFederatedUserId = a});

-- | The ARN that specifies the federated user that is associated with the
-- credentials. For more information about ARNs and how to use them in
-- policies, see
-- <http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html IAM Identifiers>
-- in /Using IAM/.
fuARN :: Lens' FederatedUser Text
fuARN = lens _fuARN (\ s a -> s{_fuARN = a});

instance FromXML FederatedUser where
        parseXML x
          = FederatedUser' <$>
              (x .@ "FederatedUserId") <*> (x .@ "Arn")

instance Hashable FederatedUser

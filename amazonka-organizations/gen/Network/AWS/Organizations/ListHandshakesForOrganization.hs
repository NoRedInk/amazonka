{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.
-- |
-- Module      : Network.AWS.Organizations.ListHandshakesForOrganization
-- Copyright   : (c) 2013-2018 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+amazonka@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Lists the handshakes that are associated with the organization that the requesting user is part of. The @ListHandshakesForOrganization@ operation returns a list of handshake structures. Each structure contains details and status about a handshake.
--
--
-- Handshakes that are ACCEPTED, DECLINED, or CANCELED appear in the results of this API for only 30 days after changing to that state. After that they are deleted and no longer accessible.
--
-- This operation can be called only from the organization's master account.
--
--
-- This operation returns paginated results.
module Network.AWS.Organizations.ListHandshakesForOrganization
    -- * Creating a Request
  ( listHandshakesForOrganization
  , ListHandshakesForOrganization
    -- * Request Lenses
  , lhfoNextToken
  , lhfoFilter
  , lhfoMaxResults
    -- * Destructuring the Response
  , listHandshakesForOrganizationResponse
  , ListHandshakesForOrganizationResponse
    -- * Response Lenses
  , lhforsHandshakes
  , lhforsNextToken
  , lhforsResponseStatus
  ) where

import Network.AWS.Lens
import Network.AWS.Organizations.Types
import Network.AWS.Organizations.Types.Product
import Network.AWS.Pager
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | /See:/ 'listHandshakesForOrganization' smart constructor.
data ListHandshakesForOrganization =
  ListHandshakesForOrganization'
    { _lhfoNextToken :: !(Maybe Text)
    , _lhfoFilter :: !(Maybe HandshakeFilter)
    , _lhfoMaxResults :: !(Maybe Nat)
    }
  deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'ListHandshakesForOrganization' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'lhfoNextToken' - Use this parameter if you receive a @NextToken@ response in a previous request that indicates that there is more output available. Set it to the value of the previous call's @NextToken@ response to indicate where the output should continue from.
--
-- * 'lhfoFilter' - A filter of the handshakes that you want included in the response. The default is all types. Use the @ActionType@ element to limit the output to only a specified type, such as @INVITE@ , @ENABLE-ALL-FEATURES@ , or @APPROVE-ALL-FEATURES@ . Alternatively, for the @ENABLE-ALL-FEATURES@ handshake that generates a separate child handshake for each member account, you can specify the @ParentHandshakeId@ to see only the handshakes that were generated by that parent request.
--
-- * 'lhfoMaxResults' - (Optional) Use this to limit the number of results you want included in the response. If you do not include this parameter, it defaults to a value that is specific to the operation. If additional items exist beyond the maximum you specify, the @NextToken@ response element is present and has a value (is not null). Include that value as the @NextToken@ request parameter in the next call to the operation to get the next part of the results. Note that Organizations might return fewer results than the maximum even when there are more results available. You should check @NextToken@ after every operation to ensure that you receive all of the results.
listHandshakesForOrganization :: ListHandshakesForOrganization
listHandshakesForOrganization =
  ListHandshakesForOrganization'
    {_lhfoNextToken = Nothing, _lhfoFilter = Nothing, _lhfoMaxResults = Nothing}

-- | Use this parameter if you receive a @NextToken@ response in a previous request that indicates that there is more output available. Set it to the value of the previous call's @NextToken@ response to indicate where the output should continue from.
lhfoNextToken :: Lens' ListHandshakesForOrganization (Maybe Text)
lhfoNextToken = lens _lhfoNextToken (\s a -> s {_lhfoNextToken = a})

-- | A filter of the handshakes that you want included in the response. The default is all types. Use the @ActionType@ element to limit the output to only a specified type, such as @INVITE@ , @ENABLE-ALL-FEATURES@ , or @APPROVE-ALL-FEATURES@ . Alternatively, for the @ENABLE-ALL-FEATURES@ handshake that generates a separate child handshake for each member account, you can specify the @ParentHandshakeId@ to see only the handshakes that were generated by that parent request.
lhfoFilter :: Lens' ListHandshakesForOrganization (Maybe HandshakeFilter)
lhfoFilter = lens _lhfoFilter (\s a -> s {_lhfoFilter = a})

-- | (Optional) Use this to limit the number of results you want included in the response. If you do not include this parameter, it defaults to a value that is specific to the operation. If additional items exist beyond the maximum you specify, the @NextToken@ response element is present and has a value (is not null). Include that value as the @NextToken@ request parameter in the next call to the operation to get the next part of the results. Note that Organizations might return fewer results than the maximum even when there are more results available. You should check @NextToken@ after every operation to ensure that you receive all of the results.
lhfoMaxResults :: Lens' ListHandshakesForOrganization (Maybe Natural)
lhfoMaxResults =
  lens _lhfoMaxResults (\s a -> s {_lhfoMaxResults = a}) . mapping _Nat

instance AWSPager ListHandshakesForOrganization where
  page rq rs
    | stop (rs ^. lhforsNextToken) = Nothing
    | stop (rs ^. lhforsHandshakes) = Nothing
    | otherwise = Just $ rq & lhfoNextToken .~ rs ^. lhforsNextToken

instance AWSRequest ListHandshakesForOrganization where
  type Rs ListHandshakesForOrganization = ListHandshakesForOrganizationResponse
  request = postJSON organizations
  response =
    receiveJSON
      (\s h x ->
         ListHandshakesForOrganizationResponse' <$>
         (x .?> "Handshakes" .!@ mempty) <*>
         (x .?> "NextToken") <*>
         (pure (fromEnum s)))

instance Hashable ListHandshakesForOrganization

instance NFData ListHandshakesForOrganization

instance ToHeaders ListHandshakesForOrganization where
  toHeaders =
    const
      (mconcat
         [ "X-Amz-Target" =#
           ("AWSOrganizationsV20161128.ListHandshakesForOrganization" :: ByteString)
         , "Content-Type" =# ("application/x-amz-json-1.1" :: ByteString)
         ])

instance ToJSON ListHandshakesForOrganization where
  toJSON ListHandshakesForOrganization' {..} =
    object
      (catMaybes
         [ ("NextToken" .=) <$> _lhfoNextToken
         , ("Filter" .=) <$> _lhfoFilter
         , ("MaxResults" .=) <$> _lhfoMaxResults
         ])

instance ToPath ListHandshakesForOrganization where
  toPath = const "/"

instance ToQuery ListHandshakesForOrganization where
  toQuery = const mempty

-- | /See:/ 'listHandshakesForOrganizationResponse' smart constructor.
data ListHandshakesForOrganizationResponse =
  ListHandshakesForOrganizationResponse'
    { _lhforsHandshakes :: !(Maybe [Handshake])
    , _lhforsNextToken :: !(Maybe Text)
    , _lhforsResponseStatus :: !Int
    }
  deriving (Eq, Show, Data, Typeable, Generic)

-- | Creates a value of 'ListHandshakesForOrganizationResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'lhforsHandshakes' - A list of 'Handshake' objects with details about each of the handshakes that are associated with an organization.
--
-- * 'lhforsNextToken' - If present, this value indicates that there is more output available than is included in the current response. Use this value in the @NextToken@ request parameter in a subsequent call to the operation to get the next part of the output. You should repeat this until the @NextToken@ response element comes back as @null@ .
--
-- * 'lhforsResponseStatus' - -- | The response status code.
listHandshakesForOrganizationResponse ::
     Int -- ^ 'lhforsResponseStatus'
  -> ListHandshakesForOrganizationResponse
listHandshakesForOrganizationResponse pResponseStatus_ =
  ListHandshakesForOrganizationResponse'
    { _lhforsHandshakes = Nothing
    , _lhforsNextToken = Nothing
    , _lhforsResponseStatus = pResponseStatus_
    }

-- | A list of 'Handshake' objects with details about each of the handshakes that are associated with an organization.
lhforsHandshakes :: Lens' ListHandshakesForOrganizationResponse [Handshake]
lhforsHandshakes =
  lens _lhforsHandshakes (\s a -> s {_lhforsHandshakes = a}) .
  _Default . _Coerce

-- | If present, this value indicates that there is more output available than is included in the current response. Use this value in the @NextToken@ request parameter in a subsequent call to the operation to get the next part of the output. You should repeat this until the @NextToken@ response element comes back as @null@ .
lhforsNextToken :: Lens' ListHandshakesForOrganizationResponse (Maybe Text)
lhforsNextToken = lens _lhforsNextToken (\s a -> s {_lhforsNextToken = a})

-- | -- | The response status code.
lhforsResponseStatus :: Lens' ListHandshakesForOrganizationResponse Int
lhforsResponseStatus =
  lens _lhforsResponseStatus (\s a -> s {_lhforsResponseStatus = a})

instance NFData ListHandshakesForOrganizationResponse

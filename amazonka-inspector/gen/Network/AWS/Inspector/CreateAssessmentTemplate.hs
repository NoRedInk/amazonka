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
-- Module      : Network.AWS.Inspector.CreateAssessmentTemplate
-- Copyright   : (c) 2013-2018 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+amazonka@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Creates an assessment template for the assessment target that is specified by the ARN of the assessment target. If the <https://docs.aws.amazon.com/inspector/latest/userguide/inspector_slr.html service-linked role> isn’t already registered, also creates and registers a service-linked role to grant Amazon Inspector access to AWS Services needed to perform security assessments.
--
--
module Network.AWS.Inspector.CreateAssessmentTemplate
    -- * Creating a Request
  ( createAssessmentTemplate
  , CreateAssessmentTemplate
    -- * Request Lenses
  , catUserAttributesForFindings
  , catAssessmentTargetARN
  , catAssessmentTemplateName
  , catDurationInSeconds
  , catRulesPackageARNs
    -- * Destructuring the Response
  , createAssessmentTemplateResponse
  , CreateAssessmentTemplateResponse
    -- * Response Lenses
  , crsResponseStatus
  , crsAssessmentTemplateARN
  ) where

import Network.AWS.Inspector.Types
import Network.AWS.Inspector.Types.Product
import Network.AWS.Lens
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | /See:/ 'createAssessmentTemplate' smart constructor.
data CreateAssessmentTemplate =
  CreateAssessmentTemplate'
    { _catUserAttributesForFindings :: !(Maybe [Attribute])
    , _catAssessmentTargetARN :: !Text
    , _catAssessmentTemplateName :: !Text
    , _catDurationInSeconds :: !Nat
    , _catRulesPackageARNs :: ![Text]
    }
  deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'CreateAssessmentTemplate' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'catUserAttributesForFindings' - The user-defined attributes that are assigned to every finding that is generated by the assessment run that uses this assessment template. An attribute is a key and value pair (an 'Attribute' object). Within an assessment template, each key must be unique.
--
-- * 'catAssessmentTargetARN' - The ARN that specifies the assessment target for which you want to create the assessment template.
--
-- * 'catAssessmentTemplateName' - The user-defined name that identifies the assessment template that you want to create. You can create several assessment templates for an assessment target. The names of the assessment templates that correspond to a particular assessment target must be unique.
--
-- * 'catDurationInSeconds' - The duration of the assessment run in seconds. The default value is 3600 seconds (one hour).
--
-- * 'catRulesPackageARNs' - The ARNs that specify the rules packages that you want to attach to the assessment template.
createAssessmentTemplate ::
     Text -- ^ 'catAssessmentTargetARN'
  -> Text -- ^ 'catAssessmentTemplateName'
  -> Natural -- ^ 'catDurationInSeconds'
  -> CreateAssessmentTemplate
createAssessmentTemplate pAssessmentTargetARN_ pAssessmentTemplateName_ pDurationInSeconds_ =
  CreateAssessmentTemplate'
    { _catUserAttributesForFindings = Nothing
    , _catAssessmentTargetARN = pAssessmentTargetARN_
    , _catAssessmentTemplateName = pAssessmentTemplateName_
    , _catDurationInSeconds = _Nat # pDurationInSeconds_
    , _catRulesPackageARNs = mempty
    }

-- | The user-defined attributes that are assigned to every finding that is generated by the assessment run that uses this assessment template. An attribute is a key and value pair (an 'Attribute' object). Within an assessment template, each key must be unique.
catUserAttributesForFindings :: Lens' CreateAssessmentTemplate [Attribute]
catUserAttributesForFindings =
  lens
    _catUserAttributesForFindings
    (\s a -> s {_catUserAttributesForFindings = a}) .
  _Default . _Coerce

-- | The ARN that specifies the assessment target for which you want to create the assessment template.
catAssessmentTargetARN :: Lens' CreateAssessmentTemplate Text
catAssessmentTargetARN =
  lens _catAssessmentTargetARN (\s a -> s {_catAssessmentTargetARN = a})

-- | The user-defined name that identifies the assessment template that you want to create. You can create several assessment templates for an assessment target. The names of the assessment templates that correspond to a particular assessment target must be unique.
catAssessmentTemplateName :: Lens' CreateAssessmentTemplate Text
catAssessmentTemplateName =
  lens _catAssessmentTemplateName (\s a -> s {_catAssessmentTemplateName = a})

-- | The duration of the assessment run in seconds. The default value is 3600 seconds (one hour).
catDurationInSeconds :: Lens' CreateAssessmentTemplate Natural
catDurationInSeconds =
  lens _catDurationInSeconds (\s a -> s {_catDurationInSeconds = a}) . _Nat

-- | The ARNs that specify the rules packages that you want to attach to the assessment template.
catRulesPackageARNs :: Lens' CreateAssessmentTemplate [Text]
catRulesPackageARNs =
  lens _catRulesPackageARNs (\s a -> s {_catRulesPackageARNs = a}) . _Coerce

instance AWSRequest CreateAssessmentTemplate where
  type Rs CreateAssessmentTemplate = CreateAssessmentTemplateResponse
  request = postJSON inspector
  response =
    receiveJSON
      (\s h x ->
         CreateAssessmentTemplateResponse' <$> (pure (fromEnum s)) <*>
         (x .:> "assessmentTemplateArn"))

instance Hashable CreateAssessmentTemplate

instance NFData CreateAssessmentTemplate

instance ToHeaders CreateAssessmentTemplate where
  toHeaders =
    const
      (mconcat
         [ "X-Amz-Target" =#
           ("InspectorService.CreateAssessmentTemplate" :: ByteString)
         , "Content-Type" =# ("application/x-amz-json-1.1" :: ByteString)
         ])

instance ToJSON CreateAssessmentTemplate where
  toJSON CreateAssessmentTemplate' {..} =
    object
      (catMaybes
         [ ("userAttributesForFindings" .=) <$> _catUserAttributesForFindings
         , Just ("assessmentTargetArn" .= _catAssessmentTargetARN)
         , Just ("assessmentTemplateName" .= _catAssessmentTemplateName)
         , Just ("durationInSeconds" .= _catDurationInSeconds)
         , Just ("rulesPackageArns" .= _catRulesPackageARNs)
         ])

instance ToPath CreateAssessmentTemplate where
  toPath = const "/"

instance ToQuery CreateAssessmentTemplate where
  toQuery = const mempty

-- | /See:/ 'createAssessmentTemplateResponse' smart constructor.
data CreateAssessmentTemplateResponse =
  CreateAssessmentTemplateResponse'
    { _crsResponseStatus :: !Int
    , _crsAssessmentTemplateARN :: !Text
    }
  deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'CreateAssessmentTemplateResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'crsResponseStatus' - -- | The response status code.
--
-- * 'crsAssessmentTemplateARN' - The ARN that specifies the assessment template that is created.
createAssessmentTemplateResponse ::
     Int -- ^ 'crsResponseStatus'
  -> Text -- ^ 'crsAssessmentTemplateARN'
  -> CreateAssessmentTemplateResponse
createAssessmentTemplateResponse pResponseStatus_ pAssessmentTemplateARN_ =
  CreateAssessmentTemplateResponse'
    { _crsResponseStatus = pResponseStatus_
    , _crsAssessmentTemplateARN = pAssessmentTemplateARN_
    }

-- | -- | The response status code.
crsResponseStatus :: Lens' CreateAssessmentTemplateResponse Int
crsResponseStatus = lens _crsResponseStatus (\s a -> s {_crsResponseStatus = a})

-- | The ARN that specifies the assessment template that is created.
crsAssessmentTemplateARN :: Lens' CreateAssessmentTemplateResponse Text
crsAssessmentTemplateARN =
  lens _crsAssessmentTemplateARN (\s a -> s {_crsAssessmentTemplateARN = a})

instance NFData CreateAssessmentTemplateResponse

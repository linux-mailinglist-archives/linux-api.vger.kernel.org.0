Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A834735E19
	for <lists+linux-api@lfdr.de>; Mon, 19 Jun 2023 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjFSUCe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Jun 2023 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFSUCd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Jun 2023 16:02:33 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E18E71
        for <linux-api@vger.kernel.org>; Mon, 19 Jun 2023 13:02:31 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1a98a7fde3eso3421370fac.2
        for <linux-api@vger.kernel.org>; Mon, 19 Jun 2023 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687204951; x=1689796951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+G0fcPAE3L0k+TSYVrkjAY3Nac6G4KG4HwEow/M6nfM=;
        b=MxTzKEpPsN8E1NeSqfonHti4awTgTuvYy/mjO/bv/gu0ZMswT+k+ao1q6z9qPCW3cM
         WJpRDOV7jEzMIa0r4uhzpy/DMPB1zGlduIulz1ULfbZHPRsgpcGJntCIh68zl1788SGC
         qiAIo2P7Ur3swlE7KWCdMSObPW8t8yt3WzFzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204951; x=1689796951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G0fcPAE3L0k+TSYVrkjAY3Nac6G4KG4HwEow/M6nfM=;
        b=YqYImJc2ag2Hga8ROtpB2pDyO37jTC11up55TGeZYhNGxu7oYbfGdNa6dKSGmBHAAX
         SRHkJW2AlrCq1LUlMQyJ3OZstcxQVQ+MXimOu/9SCChERvg09ko3gOA/rUPxiF2RQ1OR
         W/6HyH94sGxkwS5xl14wVO/Mx5eaHEiEnYaxzTUmJepXIAi1mISrldmemmhdJlyVA38Z
         T3uxsFHZO7yeioAj0kYo+W0PfijwrGedl3R5rPS0jhW0Ksx2dLg1ihu9SWbdSK1sv/zB
         gDWSrnOjQz4qaGRQBtcz0kHErN4lzM7OYlfgVmmhDoU2RKmzqpADuJQ+bY8ECsfmuq5s
         DuyA==
X-Gm-Message-State: AC+VfDxQuehY6tbeDGHAWAz6cu1Kq5Ap9WoHpP1tTQ5+VIDHIhmZlz8i
        IFArQevBvxJpZK/M0IHsxEiYPg==
X-Google-Smtp-Source: ACHHUZ4ZoxYuE6uFoU/9PanoiRvxpOUmQpxKPvt3v0x/+zQ3f49YW8hcYed3sSmYg5qTbN8rRKCtIg==
X-Received: by 2002:aca:220d:0:b0:39a:afc3:bdf1 with SMTP id b13-20020aca220d000000b0039aafc3bdf1mr11532542oic.48.1687204950862;
        Mon, 19 Jun 2023 13:02:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o2-20020a63e342000000b0053fb37fb626sm88386pgj.43.2023.06.19.13.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:02:30 -0700 (PDT)
Date:   Mon, 19 Jun 2023 13:02:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v11 07/11] LSM: Helpers for attribute names and filling
 lsm_ctx
Message-ID: <202306191302.94F212CD@keescook>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
 <20230616165055.4705-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616165055.4705-8-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 16, 2023 at 09:50:51AM -0700, Casey Schaufler wrote:
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
> 
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value.
> 
> All are used in module specific components of LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

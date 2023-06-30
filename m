Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194F074329D
	for <lists+linux-api@lfdr.de>; Fri, 30 Jun 2023 04:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjF3CPH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jun 2023 22:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjF3CPC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Jun 2023 22:15:02 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F7D3AA4
        for <linux-api@vger.kernel.org>; Thu, 29 Jun 2023 19:14:44 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-635d9e0aa6dso10091766d6.1
        for <linux-api@vger.kernel.org>; Thu, 29 Jun 2023 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688091284; x=1690683284;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o+KGax9Prrl1aK209DwaJqb3NAowYrI4dDxErwwgPnk=;
        b=C2ts+DNrL1pQiS6JNzSxtLrzLQgwS4NaOS/YnhlmW81by+di/BvhE8arb4BA27x8I9
         7RPiRL//DKgH00EWeUlk5nGnq47qPNg0L0YQOoRH1h54u2xxWKO86Xvv9Rkk+c2eDKHt
         O1QfWsUjjmbF8QQNVeIczz6ooIRZKDX315WMqWw1qkQ83MSnyUdIBgepvnm6VVd8ElDu
         vAA6b7QH2tyRze/wcGKp7SgR1fT2JVAF2IUpQNsWJqAGycMfgoNaxs6iVUjHBMXHEC6T
         ZJc+PuSXkrXJY82Z44ZETTdS+Bry/TBqKQ5TAUq/ajgrFtq9MJeNcTxjIOKw1x37s4JV
         lXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688091284; x=1690683284;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+KGax9Prrl1aK209DwaJqb3NAowYrI4dDxErwwgPnk=;
        b=X0AqDK0NXzMJ/9+mmMXVIgtjnEh376RUam2JYbwqgH/luiqxP7Y0j1tM/88FK6QCXc
         9K5cxFosh/5mgDWHGb3X7dYgI5Z1xanmVEzNHpcp0CWJyhy7QXl6Mi/qG9GeUm5zfb85
         9h1z7Ir9TNedX/0opKgRHD8+ic4dDhco3fs2Yp9gJlloI2NnApTeyg7OF/ur6AXzZb5t
         DVFTxhNnMtpsiTHTZTszpqlOAnXRjXUBNzN04fB0Ysr/6aXeTQ4z/DnZzMcrtbbRkPBn
         JUssvhQfS2kiGd7qAylDyYOB4Ohoq5EanIdIQpBrWYFMe8iEGfkEIkluk3o8dadB17qq
         d4QA==
X-Gm-Message-State: ABy/qLZ22iAIBn86YAqoBok8s8hVBGMx9j3OR5jPFeppdT0QRD1Ms2iS
        wzlas4Nub0VaQR/K3xyYrYdM
X-Google-Smtp-Source: APBJJlH5EBMN8EeWHXhbgDOC/3nssmzHrLsINxD4+rvpHzaF785iwnCjOWgfV1Q24nc5i03ReoYVGA==
X-Received: by 2002:ad4:5ce2:0:b0:634:7c34:6c6f with SMTP id iv2-20020ad45ce2000000b006347c346c6fmr2074259qvb.13.1688091283768;
        Thu, 29 Jun 2023 19:14:43 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ea19-20020ad458b3000000b0062626bd3683sm7564128qvb.59.2023.06.29.19.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 19:14:43 -0700 (PDT)
Date:   Thu, 29 Jun 2023 22:14:42 -0400
Message-ID: <f43449f878f629805d5de7fd06306741.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        john.johansen@canonical.com, mic@digikod.net
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v12 0/11] LSM: Three basic syscalls
References: <20230629195535.2590-1-casey@schaufler-ca.com>
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Jun 29, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add three system calls for the Linux Security Module ABI ...

I saw two small things (see patches 7/11 and 8/11) when looking at the
patchset today, but otherwise it looks pretty good to me.  However,
before I can merge this, at a minimum I would like to get an ACK from
John on the AppArmor patch; an ACK or a Reviewed-by on the rest of the
patchset would be great too.  I know Mickaël has reviewed and commented
on this patchset before, it would be nice if we could get his
ACK/Reviewed-by too.  Of course reviews and comments are always welcome
from anyone who has looked over the code; this is an important patchset
so the more eyes the better.

Assuming no one catches anything further, I think we can get this into
the lsm/next branch as soon as the merge window closes.

Thanks for all your work on this Casey.

--
paul-moore.com
